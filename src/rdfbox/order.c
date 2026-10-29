/**
 * @file
 * The total order of RDF terms, which the operators `@=`, `@<>`, `@<`, `@>`, `@<=` and `@>=` and
 * rdfbox_order_compare() implement.
 *
 * The order is used by the default B-tree operator class of rdfbox (ORDER BY, DISTINCT, GROUP BY, merge joins,
 * indexes) and by the min/max aggregates. It has the following properties:
 *
 *   - blank nodes precede IRIs, IRIs precede literals and literals precede triple terms,
 *
 *   - the order extends the operator `<`: whenever `x < y` holds, `x @< y` holds as well,
 *
 *   - `@=` is the identity of terms: the types, the values and the stored lexical forms must all be the same;
 *     in particular, numbers of different types are never `@=` even if they are `=`.
 *
 * Numbers of different types are compared by their exact mathematical values, not by values promoted to a
 * common type as the operator `<` does. The promoted comparison depends on the pair of types involved and is not
 * transitive (for example, integer 16777217 = float 16777216 < double 16777216.5 < integer 16777217), so it
 * cannot be a part of a total order. Because all promotions are monotonic, the exact comparison agrees with `<`
 * and `>` whenever they hold. Only if the exact values are equal, the types are compared in the order of the ::RdfType
 * enumeration (byte < unsignedByte < short < unsignedShort < int < unsignedInt < long < unsignedLong < integer <
 * nonPositiveInteger < negativeInteger < nonNegativeInteger < positiveInteger < decimal < float < double). NaN is
 * greater than any other number and equal to another NaN.
 *
 * User literals are compared by their boxed values with the total order of ubox (which orders values of
 * different PostgreSQL types by the OID of the type) and then by the IRIs of their datatypes. The operator `@<`
 * therefore extends `<` here as well, as far as `<` is defined at all: `<` only compares user literals of the same
 * datatype IRI and is based on the same comparison function of the boxed type.
 *
 * Terms of the same type are compared by their values first, then by the presence of a stored lexical form
 * (the terms in the canonical form come first) and finally by the lexical forms themselves. The values are
 * compared as they are presented by the canonical lexical forms: xsd:decimal values 1.0 and 1.00 are equal,
 * while xsd:double values -0.0 and 0.0 are not.
 *
 * Triple terms are compared by their subjects, then by their predicates and then by their objects, each with
 * this very order. SPARQL leaves the relative order of two triple terms undefined and allows an implementation to
 * define it, which is what the operator class needs anyway.
 *
 * The terms that `@=` takes as identical are also built identically (see rdfbox/rdfbox.h): a box keeps the value of an
 * xsd:integer or of an xsd:decimal with the least scale that holds it and every NaN in a single form, so that the
 * xsd:decimal values 1.0 and 1.00 make the same box. The B-tree operator class therefore declares by btequalimage()
 * that its equality implies equal images, which lets PostgreSQL deduplicate the keys of B-tree indexes. User literals
 * whose values their boxed type takes as equal are identical even if the type prints the values differently, as
 * numeric prints 1.0 and 1.00, so an index-only scan of a deduplicated index may return one of them for the other; the
 * equality of a type that holds the values of user literals should tell apart all the values that it prints
 * differently.
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <math.h>
#include "compare.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/order.h"
#include "rdfbox/promotion.h"
#include "types/decimal.h"
#include "types/unsignedlong.h"


/* the numbers held in an int64, in a uint64 and in a double; the others are held in a numeric */


/**
 * Tests whether a numeric box holds its value in an integer of at most 64 bits.
 *
 * @param box the numeric box
 * @return true for the types from #XSD_BYTE to #XSD_LONG
 */
static inline bool rdfbox_is_integral(RdfBox *box)
{
    return box->type >= XSD_BYTE && box->type <= XSD_LONG;
}


/**
 * Tests whether a numeric box is an xsd:unsignedLong, whose value is held in a uint64.
 *
 * @param box the numeric box
 * @return true for #XSD_UNSIGNEDLONG
 */
static inline bool rdfbox_is_unsigned_long(RdfBox *box)
{
    return box->type == XSD_UNSIGNEDLONG;
}


/**
 * Tests whether a numeric box is an xsd:float or an xsd:double.
 *
 * @param box the numeric box
 * @return true for #XSD_FLOAT and #XSD_DOUBLE
 */
static inline bool rdfbox_is_floating(RdfBox *box)
{
    return box->type == XSD_FLOAT || box->type == XSD_DOUBLE;
}


/**
 * Returns the value of an xsd:float or an xsd:double box as a double, which holds both exactly.
 *
 * @param box the box of type #XSD_FLOAT or #XSD_DOUBLE
 * @return the value
 */
static inline float8 rdfbox_get_floating_as_double(RdfBox *box)
{
    return box->type == XSD_FLOAT ? (float8) RdfBoxGetFloat4(box) : RdfBoxGetFloat8(box);
}


/**
 * Compares two numerics by their values, regardless of their scales.
 *
 * @param left the left numeric
 * @param right the right numeric
 * @return a negative number, zero or a positive number if @a left is less than, equal to or greater than @a right
 */
static inline int numeric_compare(Numeric left, Numeric right)
{
    return DatumGetInt32(DirectFunctionCall2(numeric_cmp, NumericGetDatum(left), NumericGetDatum(right)));
}


/**
 * Exact comparison of a finite double with a numeric value. The double is decomposed into mantissa * 2^exponent;
 * for a negative exponent, mantissa * 5^(-exponent) is compared with right * 10^(-exponent), so that no numeric
 * value with a huge scale has to be constructed.
 *
 * @param left the finite double
 * @param right the finite numeric
 * @return a negative number, zero or a positive number if @a left is less than, equal to or greater than @a right
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


/**
 * Compares two doubles by their values: NaN is greater than any other value and equal to NaN, -0.0 and 0.0 are
 * equal.
 *
 * @param left the left double
 * @param right the right double
 * @return -1, 0 or 1 if @a left is less than, equal to or greater than @a right
 */
static int compare_double_values(float8 left, float8 right)
{
    /* NaN is greater than any other value and equal to NaN, -0.0 and 0.0 are equal */

    if(isnan(left))
        return isnan(right) ? 0 : 1;

    if(isnan(right))
        return -1;

    return compare(left, right);
}


/**
 * Compares a double with an int64 exactly; NaN is greater than any integer.
 *
 * @param left the double
 * @param right the integer
 * @return -1, 0 or 1 if @a left is less than, equal to or greater than @a right
 */
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


/**
 * Compares a double with a uint64 exactly; NaN is greater than any integer.
 *
 * @param left the double
 * @param right the unsigned integer
 * @return -1, 0 or 1 if @a left is less than, equal to or greater than @a right
 */
static int compare_double_with_unsigned_long(float8 left, uint64 right)
{
    if(isnan(left) || left >= 18446744073709551616.0)
        return 1;

    if(left < 0)
        return -1;

    uint64 whole = (uint64) left;

    if(whole != right)
        return compare(whole, right);

    /* sign of the fractional part */
    return compare(left, (float8) whole);
}


/**
 * Compares a double with a numeric exactly. The double nearest to the numeric decides if it differs from @a left,
 * an infinity is equal only to the infinity of the same sign, and otherwise the values are compared exactly by
 * compare_double_with_numeric_exactly(). NaN is greater than any other value and equal to a numeric NaN.
 *
 * @param left the double
 * @param right the numeric
 * @return a negative number, zero or a positive number if @a left is less than, equal to or greater than @a right
 */
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


/**
 * Compares an int64 with a uint64 exactly.
 *
 * @param left the signed integer
 * @param right the unsigned integer
 * @return -1, 0 or 1 if @a left is less than, equal to or greater than @a right
 */
static int compare_integral_with_unsigned_long(int64 left, uint64 right)
{
    if(left < 0)
        return -1;

    return compare((uint64) left, right);
}


/**
 * Compares an int64 with a numeric exactly.
 *
 * @param left the integer
 * @param right the numeric
 * @return a negative number, zero or a positive number if @a left is less than, equal to or greater than @a right
 */
static int compare_integral_with_numeric(int64 left, Numeric right)
{
    Numeric value = numeric_from_int64(left);
    int result = numeric_compare(value, right);
    pfree(value);

    return result;
}


/**
 * Compares a uint64 with a numeric exactly.
 *
 * @param left the unsigned integer
 * @param right the numeric
 * @return a negative number, zero or a positive number if @a left is less than, equal to or greater than @a right
 */
static int compare_unsigned_long_with_numeric(uint64 left, Numeric right)
{
    Numeric value = unsignedlong_as_numeric(left);
    int result = numeric_compare(value, right);
    pfree(value);

    return result;
}


/**
 * Compares the exact mathematical values of two numeric boxes of any numeric types; NaN is greater than any other
 * number and equal to another NaN, -0.0 and 0.0 are equal.
 *
 * @param left the left numeric box
 * @param right the right numeric box
 * @return a negative number, zero or a positive number if @a left is less than, equal to or greater than @a right
 */
static int compare_numeric_values(RdfBox *left, RdfBox *right)
{
    if(rdfbox_is_floating(left))
    {
        float8 value = rdfbox_get_floating_as_double(left);

        if(rdfbox_is_floating(right))
            return compare_double_values(value, rdfbox_get_floating_as_double(right));
        else if(rdfbox_is_integral(right))
            return compare_double_with_integral(value, rdfbox_get_numeric_as_long(right));
        else if(rdfbox_is_unsigned_long(right))
            return compare_double_with_unsigned_long(value, RdfBoxGetUInt64(right));
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
        else if(rdfbox_is_unsigned_long(right))
            return compare_integral_with_unsigned_long(value, RdfBoxGetUInt64(right));
        else
            return compare_integral_with_numeric(value, RdfBoxGetNumeric(right));
    }
    else if(rdfbox_is_integral(right))
    {
        return -compare_numeric_values(right, left);
    }
    else if(rdfbox_is_unsigned_long(left))
    {
        uint64 value = RdfBoxGetUInt64(left);

        if(rdfbox_is_unsigned_long(right))
            return compare(value, RdfBoxGetUInt64(right));
        else
            return compare_unsigned_long_with_numeric(value, RdfBoxGetNumeric(right));
    }
    else if(rdfbox_is_unsigned_long(right))
    {
        return -compare_numeric_values(right, left);
    }
    else
    {
        return numeric_compare(RdfBoxGetNumeric(left), RdfBoxGetNumeric(right));
    }
}


/**
 * Compares two doubles as the values of two terms of the same type: as compare_double_values() does, but -0.0
 * precedes 0.0.
 *
 * @param left the left double
 * @param right the right double
 * @return -1, 0 or 1 if @a left precedes, is equal to or follows @a right
 */
static int compare_double_terms(float8 left, float8 right)
{
    /* the same as compare_double_values(), but -0.0 precedes 0.0 */

    int result = compare_double_values(left, right);

    if(result != 0 || left != 0)
        return result;

    return compare(signbit(right) != 0, signbit(left) != 0);
}


/**
 * Compares the values of two terms of the same type, ignoring their stored lexical forms.
 *
 * Booleans, numbers, durations and integer blank nodes are compared by their values (-0.0 preceding 0.0), dates
 * and dateTimes by date_order_compare() and datetime_order_compare(), strings, IRIs and string blank nodes
 * byte-wise, language-tagged strings and literals of unknown datatypes by the value and then by the language tag
 * or the datatype IRI, user literals by ubox_order() and then by the datatype IRI, and triple terms by
 * rdfbox_compare_terms() of the subjects, the predicates and the objects.
 *
 * @param left the left term
 * @param right the right term of the same type
 * @return a negative number, zero or a positive number if @a left precedes, is equal to or follows @a right
 */
static int compare_values_of_same_type(RdfBox *left, RdfBox *right)
{
    switch(left->type)
    {
        case XSD_BOOLEAN:
            return compare(RdfBoxGetBool(left), RdfBoxGetBool(right));

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            return compare(RdfBoxGetInt16(left), RdfBoxGetInt16(right));

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            return compare(RdfBoxGetInt32(left), RdfBoxGetInt32(right));

        case XSD_UNSIGNEDINT:
            return compare(RdfBoxGetUInt32(left), RdfBoxGetUInt32(right));

        case XSD_LONG:
        case XSD_DAYTIMEDURATION:
        case IBLANKNODE:
            return compare(RdfBoxGetInt64(left), RdfBoxGetInt64(right));

        case XSD_UNSIGNEDLONG:
            return compare(RdfBoxGetUInt64(left), RdfBoxGetUInt64(right));

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
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
        case RDF_LTR_LANGSTRING:
        case RDF_RTL_LANGSTRING:
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

        case TRIPLE_TERM:
        {
            int result = rdfbox_compare_terms(RdfBoxGetTripleTermSubject(left), RdfBoxGetTripleTermSubject(right));

            if(result != 0)
                return result;

            result = varchar_cmp(RdfBoxGetTripleTermPredicate(left), RdfBoxGetTripleTermPredicate(right));

            if(result != 0)
                return result;

            return rdfbox_compare_terms(RdfBoxGetTripleTermObject(left), RdfBoxGetTripleTermObject(right));
        }

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}


/**
 * Compares the stored lexical forms of two terms: a term without one precedes a term with one, and two stored
 * lexical forms are compared byte-wise.
 *
 * @param left the left term
 * @param right the right term of the same type
 * @return a negative number, zero or a positive number if @a left precedes, is equal to or follows @a right
 */
static int compare_lexicals(RdfBox *left, RdfBox *right)
{
    /* terms without a stored lexical form precede terms with one */

    if(left->lexical != right->lexical)
        return left->lexical ? 1 : -1;

    if(!left->lexical)
        return 0;

    return varchar_cmp(RdfBoxGetLexical(left), RdfBoxGetLexical(right));
}


/**
 * Compares two terms of the same type by their values and then by their stored lexical forms.
 *
 * @param left the left term
 * @param right the right term of the same type
 * @return a negative number, zero or a positive number if @a left precedes, is equal to or follows @a right
 */
static int compare_terms_of_same_type(RdfBox *left, RdfBox *right)
{
    int result = compare_values_of_same_type(left, right);

    if(result != 0)
        return result;

    return compare_lexicals(left, right);
}


/**
 * Compares two RDF terms in the total order of rdfbox.
 *
 * Terms of the same type are compared by compare_terms_of_same_type(), two numbers of different types by their
 * exact values and then by their types, and the other terms by the reversed order of their types: string blank
 * nodes, integer blank nodes, IRIs, literals of unknown datatypes or with invalid lexical forms, user literals,
 * language-tagged strings with the base direction rtl, those with ltr, those without a base direction, strings,
 * dayTimeDurations, dates, dateTimes, numbers, booleans and triple terms.
 *
 * @param left the left term
 * @param right the right term
 * @return a negative number, zero or a positive number if @a left precedes, is equal to or follows @a right
 */
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

    /* blank nodes, then IRIs, then literals, then triple terms */
    return compare(right->type, left->type);
}


/**
 * Tests whether two terms are identical, that is, whether rdfbox_compare_terms() gives 0 for them, without
 * converting their values: the terms must have the same type, the same values and the same stored lexical forms.
 *
 * @param left the left term
 * @param right the right term
 * @return true if the terms are identical
 */
bool rdfbox_same_terms(RdfBox *left, RdfBox *right)
{
    /* the same as rdfbox_compare_terms(...) == 0, but without any conversion of the values */

    if(left->type != right->type || left->lexical != right->lexical)
        return false;

    if(VARSIZE(left) == VARSIZE(right) && memcmp(left, right, VARSIZE(left)) == 0)
        return true;

    return compare_terms_of_same_type(left, right) == 0;
}


/**
 * Compares two RDF terms in the total order of rdfbox; the B-tree support function 1 of the default operator class
 * of rdfbox.
 *
 * @param fcinfo the two rdfboxes
 * @return the int4 -1, 0 or 1 if the first term precedes, is equal to or follows the second one
 */
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


/**
 * Tests whether two RDF terms are identical in the total order, the operator `@=` of the B-tree and hash operator
 * classes of rdfbox.
 *
 * @param fcinfo the two rdfboxes
 * @return the bool true if the terms have the same type, value and stored lexical form
 */
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


/**
 * Tests whether two RDF terms are not identical in the total order, the operator `@<>`.
 *
 * @param fcinfo the two rdfboxes
 * @return the bool true if the terms differ in the type, the value or the stored lexical form
 */
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


/**
 * Tests whether an RDF term precedes another one in the total order, the operator `@<`.
 *
 * @param fcinfo the two rdfboxes
 * @return the bool true if the first term precedes the second one
 */
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


/**
 * Tests whether an RDF term follows another one in the total order, the operator `@>`.
 *
 * @param fcinfo the two rdfboxes
 * @return the bool true if the first term follows the second one
 */
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


/**
 * Tests whether an RDF term does not precede another one in the total order, the operator `@>=`.
 *
 * @param fcinfo the two rdfboxes
 * @return the bool true if the first term follows the second one or is identical to it
 */
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


/**
 * Tests whether an RDF term does not follow another one in the total order, the operator `@<=`.
 *
 * @param fcinfo the two rdfboxes
 * @return the bool true if the first term precedes the second one or is identical to it
 */
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

