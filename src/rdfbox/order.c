#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <math.h>
#include "compare.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/order.h"
#include "rdfbox/promotion.h"


/*
 * The operators @=, @<>, @<, @>, @<= and @>= together with rdfbox_order_compare() define a total order of RDF
 * terms, which is used by the default B-tree operator class (ORDER BY, DISTINCT, GROUP BY, merge joins, indexes)
 * and by the min/max aggregates. The order has the following properties:
 *
 *   - blank nodes precede IRIs and IRIs precede literals,
 *
 *   - the order extends the operator <: whenever x < y holds, x @< y holds as well,
 *
 *   - @= is the identity of terms: the types, the values and the stored lexical forms must all be the same;
 *     in particular, numbers of different types are never @= even if they are =.
 *
 * Numbers of different types are compared by their exact mathematical values, not by values promoted to a
 * common type as the operator < does. The promoted comparison depends on the pair of types involved and is not
 * transitive (for example, integer 16777217 = float 16777216 < double 16777216.5 < integer 16777217), so it
 * cannot be a part of a total order. Because all promotions are monotonic, the exact comparison agrees with <
 * and > whenever they hold. Only if the exact values are equal, the types are compared (short < int < long <
 * integer < decimal < float < double). NaN is greater than any other number and equal to another NaN.
 *
 * User literals are compared by their boxed values with the total order of ubox (which orders values of
 * different PostgreSQL types by the OID of the type) and then by the IRIs of their datatypes. The operator @<
 * therefore extends < here as well, as far as < is defined at all: < only compares user literals of the same
 * datatype IRI and is based on the same comparison function of the boxed type.
 *
 * Terms of the same type are compared by their values first, then by the presence of a stored lexical form
 * (the terms in the canonical form come first) and finally by the lexical forms themselves. The values are
 * compared as they are presented by the canonical lexical forms: xsd:decimal values 1.0 and 1.00 are equal,
 * while xsd:double values -0.0 and 0.0 are not.
 */


static inline bool rdfbox_is_integral(RdfBox *box)
{
    return box->type >= XSD_SHORT && box->type <= XSD_LONG;
}


static inline bool rdfbox_is_floating(RdfBox *box)
{
    return box->type == XSD_FLOAT || box->type == XSD_DOUBLE;
}


static inline float8 rdfbox_get_floating_as_double(RdfBox *box)
{
    return box->type == XSD_FLOAT ? (float8) RdfBoxGetFloat4(box) : RdfBoxGetFloat8(box);
}


static inline int numeric_compare(Numeric left, Numeric right)
{
    return DatumGetInt32(DirectFunctionCall2(numeric_cmp, NumericGetDatum(left), NumericGetDatum(right)));
}


static inline Numeric numeric_multiply(Numeric left, Numeric right)
{
    return DatumGetNumeric(DirectFunctionCall2(numeric_mul, NumericGetDatum(left), NumericGetDatum(right)));
}


static inline Numeric numeric_from_int64(int64 value)
{
    return DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(value)));
}


static inline Numeric numeric_from_string(const char *string)
{
    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(string), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}


static Numeric get_numeric_power(int base, int exponent)
{
    Numeric result = numeric_from_int64(1);
    Numeric power = numeric_from_int64(base);

    while(exponent > 0)
    {
        if(exponent & 1)
        {
            Numeric product = numeric_multiply(result, power);
            pfree(result);
            result = product;
        }

        exponent >>= 1;

        if(exponent > 0)
        {
            Numeric square = numeric_multiply(power, power);
            pfree(power);
            power = square;
        }
    }

    pfree(power);
    return result;
}


/*
 * Exact comparison of a finite double with a numeric value. The double is decomposed into mantissa * 2^exponent;
 * for a negative exponent, mantissa * 5^(-exponent) is compared with right * 10^(-exponent), so that no numeric
 * value with a huge scale has to be constructed.
 */
static int compare_double_with_numeric_exactly(float8 left, Numeric right)
{
    int exponent;
    int64 mantissa = (int64) ldexp(frexp(left, &exponent), 53);
    exponent -= 53;

    while(mantissa != 0 && mantissa % 2 == 0)
    {
        mantissa /= 2;
        exponent++;
    }

    Numeric scaled_left = numeric_from_int64(mantissa);
    Numeric scaled_right = right;

    if(mantissa != 0 && exponent > 0)
    {
        Numeric power = get_numeric_power(2, exponent);
        Numeric product = numeric_multiply(scaled_left, power);

        pfree(scaled_left);
        pfree(power);

        scaled_left = product;
    }
    else if(mantissa != 0 && exponent < 0)
    {
        Numeric power = get_numeric_power(5, -exponent);
        Numeric product = numeric_multiply(scaled_left, power);

        pfree(scaled_left);
        pfree(power);

        scaled_left = product;

        char *scale_string = psprintf("1e%d", -exponent);
        Numeric scale = numeric_from_string(scale_string);

        scaled_right = numeric_multiply(right, scale);

        pfree(scale_string);
        pfree(scale);
    }

    int result = numeric_compare(scaled_left, scaled_right);

    pfree(scaled_left);

    if(scaled_right != right)
        pfree(scaled_right);

    return result;
}


static int compare_double_values(float8 left, float8 right)
{
    /* NaN is greater than any other value and equal to NaN, -0.0 and 0.0 are equal */

    if(isnan(left))
        return isnan(right) ? 0 : 1;

    if(isnan(right))
        return -1;

    return compare(left, right);
}


static int compare_double_with_integral(float8 left, int64 right)
{
    if(isnan(left) || left >= 9223372036854775808.0)
        return 1;

    if(left < -9223372036854775808.0)
        return -1;

    int64 whole = (int64) left;

    if(whole != right)
        return compare(whole, right);

    /* sign of the fractional part */
    return compare(left, (float8) whole);
}


static int compare_double_with_numeric(float8 left, Numeric right)
{
    float8 approx = numeric_get_as_double(right);

    if(isnan(left))
        return isnan(approx) ? 0 : 1;

    if(isnan(approx))
        return -1;

    /* the rounding is monotonic, so the inequality of the rounded values decides */
    if(left != approx)
        return compare(left, approx);

    if(isinf(left))
        return numeric_is_inf(right) ? 0 : (left > 0 ? 1 : -1);

    return compare_double_with_numeric_exactly(left, right);
}


static int compare_integral_with_numeric(int64 left, Numeric right)
{
    Numeric value = numeric_from_int64(left);
    int result = numeric_compare(value, right);
    pfree(value);

    return result;
}


static int compare_numeric_values(RdfBox *left, RdfBox *right)
{
    if(rdfbox_is_floating(left))
    {
        float8 value = rdfbox_get_floating_as_double(left);

        if(rdfbox_is_floating(right))
            return compare_double_values(value, rdfbox_get_floating_as_double(right));
        else if(rdfbox_is_integral(right))
            return compare_double_with_integral(value, rdfbox_get_numeric_as_long(right));
        else
            return compare_double_with_numeric(value, RdfBoxGetNumeric(right));
    }
    else if(rdfbox_is_floating(right))
    {
        return -compare_numeric_values(right, left);
    }
    else if(rdfbox_is_integral(left))
    {
        int64 value = rdfbox_get_numeric_as_long(left);

        if(rdfbox_is_integral(right))
            return compare(value, rdfbox_get_numeric_as_long(right));
        else
            return compare_integral_with_numeric(value, RdfBoxGetNumeric(right));
    }
    else if(rdfbox_is_integral(right))
    {
        return -compare_numeric_values(right, left);
    }
    else
    {
        return numeric_compare(RdfBoxGetNumeric(left), RdfBoxGetNumeric(right));
    }
}


static int compare_double_terms(float8 left, float8 right)
{
    /* the same as compare_double_values(), but -0.0 precedes 0.0 */

    int result = compare_double_values(left, right);

    if(result != 0 || left != 0)
        return result;

    return compare(signbit(right) != 0, signbit(left) != 0);
}


static int compare_values_of_same_type(RdfBox *left, RdfBox *right)
{
    switch(left->type)
    {
        case XSD_BOOLEAN:
            return compare(RdfBoxGetBool(left), RdfBoxGetBool(right));

        case XSD_SHORT:
            return compare(RdfBoxGetInt16(left), RdfBoxGetInt16(right));

        case XSD_INT:
            return compare(RdfBoxGetInt32(left), RdfBoxGetInt32(right));

        case XSD_LONG:
        case XSD_DAYTIMEDURATION:
        case IBLANKNODE:
            return compare(RdfBoxGetInt64(left), RdfBoxGetInt64(right));

        case XSD_INTEGER:
        case XSD_DECIMAL:
            return numeric_compare(RdfBoxGetNumeric(left), RdfBoxGetNumeric(right));

        case XSD_FLOAT:
            return compare_double_terms(RdfBoxGetFloat4(left), RdfBoxGetFloat4(right));

        case XSD_DOUBLE:
            return compare_double_terms(RdfBoxGetFloat8(left), RdfBoxGetFloat8(right));

        case XSD_DATETIME:
            return datetime_order_compare(RdfBoxGetZonedDateTime(left), RdfBoxGetZonedDateTime(right));

        case XSD_DATE:
            return date_order_compare(RdfBoxGetZonedDate(left), RdfBoxGetZonedDate(right));

        case XSD_STRING:
        case IRI:
        case SBLANKNODE:
            return varchar_cmp(RdfBoxGetVarChar(left), RdfBoxGetVarChar(right));

        case RDF_LANGSTRING:
        case TYPED_LITERAL:
        {
            int result = varchar_cmp(RdfBoxGetVarChar(left), RdfBoxGetVarChar(right));

            if(result != 0)
                return result;

            return varchar_cmp(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right));
        }

        case USER_LITERAL:
        {
            int result = ubox_order(NULL, RdfBoxGetUBox(left), RdfBoxGetUBox(right));

            if(result != 0)
                return result;

            return varchar_cmp(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right));
        }

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}


static int compare_lexicals(RdfBox *left, RdfBox *right)
{
    /* terms without a stored lexical form precede terms with one */

    if(left->lexical != right->lexical)
        return left->lexical ? 1 : -1;

    if(!left->lexical)
        return 0;

    return varchar_cmp(RdfBoxGetLexical(left), RdfBoxGetLexical(right));
}


static int compare_terms_of_same_type(RdfBox *left, RdfBox *right)
{
    int result = compare_values_of_same_type(left, right);

    if(result != 0)
        return result;

    return compare_lexicals(left, right);
}


int rdfbox_compare_terms(RdfBox *left, RdfBox *right)
{
    if(left->type == right->type)
        return compare_terms_of_same_type(left, right);

    if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        int result = compare_numeric_values(left, right);

        if(result != 0)
            return result;

        return compare(left->type, right->type);
    }

    /* blank nodes, then IRIs, then literals */
    return compare(right->type, left->type);
}


bool rdfbox_same_terms(RdfBox *left, RdfBox *right)
{
    /* the same as rdfbox_compare_terms(...) == 0, but without any conversion of the values */

    if(left->type != right->type || left->lexical != right->lexical)
        return false;

    if(VARSIZE(left) == VARSIZE(right) && memcmp(left, right, VARSIZE(left)) == 0)
        return true;

    return compare_terms_of_same_type(left, right) == 0;
}


PG_FUNCTION_INFO_V1(rdfbox_order_compare);
Datum rdfbox_order_compare(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    int result = rdfbox_compare_terms(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_INT32(result);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_equal_to);
Datum rdfbox_order_is_equal_to(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    bool result = rdfbox_same_terms(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_not_equal_to);
Datum rdfbox_order_is_not_equal_to(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    bool result = rdfbox_same_terms(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_BOOL(!result);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_less_than);
Datum rdfbox_order_is_less_than(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    int result = rdfbox_compare_terms(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_BOOL(result < 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_greater_than);
Datum rdfbox_order_is_greater_than(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    int result = rdfbox_compare_terms(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_BOOL(result > 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_not_less_than);
Datum rdfbox_order_is_not_less_than(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    int result = rdfbox_compare_terms(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_BOOL(result >= 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_not_greater_than);
Datum rdfbox_order_is_not_greater_than(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    int result = rdfbox_compare_terms(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_BOOL(result <= 0);
}

