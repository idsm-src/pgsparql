/**
 * @file
 * The comparison operators of SPARQL 1.2 on rdfbox: sameTerm(), the value comparisons `=`, `!=`, `<`, `<=`, `>=` and
 * `>` of the operator mapping, and sameValue().
 *
 * A NULL result stands for an error of the comparison, a pair of terms that the operator cannot compare. The total
 * order of ORDER BY and of the operator classes is implemented in rdfbox/order.c.
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <math.h>
#include "compare.h"
#include "call.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/order.h"
#include "rdfbox/promotion.h"


Datum rdfbox_is_equal_to(PG_FUNCTION_ARGS);


/**
 * Tests whether a box is an xsd:float or xsd:double NaN.
 *
 * @param box the box
 * @return true if the box is a NaN of xsd:float or xsd:double
 */
static inline bool rdfbox_is_nan(RdfBox *box)
{
    return (box->type == XSD_FLOAT && isnan(RdfBoxGetFloat4(box))) || (box->type == XSD_DOUBLE && isnan(RdfBoxGetFloat8(box)));
}


/**
 * The function sameValue() of SPARQL 1.2 (section 17.4.2.2) as the section defines it.
 *
 * It is behind rdfbox_is_same_value_as() only: the operator `=` of this file does not use it, because the operator
 * mapping covers every pair of terms the function would decide differently.
 *
 * On IRIs, blank nodes and literals it agrees with the operator `=` except for NaN: two NaN values, of xsd:float or
 * xsd:double in any combination, are the same value, whereas op:numeric-equal never holds for a NaN. Two triple terms
 * are compared component by component, and an error (NULL) of any component is an error of the whole, whereas the
 * operator `=` on two triple terms follows the operator mapping, see tripleterm_is_equal_to().
 *
 * @param left the left term
 * @param right the right term
 * @return true if the terms are the same value, false if they are not, null if they cannot be compared
 */
static NullableDatum same_value(RdfBox *left, RdfBox *right)
{
    if(rdfbox_same_terms(left, right))
        return NULLABLE_DATUM(BoolGetDatum(true));

    if(left->type == TRIPLE_TERM && right->type == TRIPLE_TERM)
    {
        NullableDatum subject = same_value(RdfBoxGetTripleTermSubject(left), RdfBoxGetTripleTermSubject(right));
        NullableDatum object = same_value(RdfBoxGetTripleTermObject(left), RdfBoxGetTripleTermObject(right));

        if(subject.isnull || object.isnull)
            return NULL_DATUM;

        bool predicate = varchar_eq(RdfBoxGetTripleTermPredicate(left), RdfBoxGetTripleTermPredicate(right));

        return NULLABLE_DATUM(BoolGetDatum(DatumGetBool(subject.value) && predicate && DatumGetBool(object.value)));
    }

    if(rdfbox_is_nan(left) && rdfbox_is_nan(right))
        return NULLABLE_DATUM(BoolGetDatum(true));

    return NullableFunctionCall2(rdfbox_is_equal_to, RdfBoxGetDatum(left), RdfBoxGetDatum(right));
}


/**
 * The operator `=` on two triple terms as the operator mapping of SPARQL 1.2 defines it:
 * `(A.subject = B.subject) && (A.predicate = B.predicate) && (A.object = B.object)`, with the three-valued `&&` of
 * SPARQL.
 *
 * A component that differs decides even when another one cannot be compared, otherwise an error (NULL) of a component
 * is an error of the whole. The components are compared by the operator `=` itself, so two NaN objects are not equal,
 * unlike in sameValue().
 *
 * @param left the left triple term
 * @param right the right triple term
 * @return true if the triple terms are equal, false if they are not, null if that cannot be decided
 */
static NullableDatum tripleterm_is_equal_to(RdfBox *left, RdfBox *right)
{
    NullableDatum subject = NullableFunctionCall2(rdfbox_is_equal_to, RdfBoxGetDatum(RdfBoxGetTripleTermSubject(left)), RdfBoxGetDatum(RdfBoxGetTripleTermSubject(right)));
    NullableDatum object = NullableFunctionCall2(rdfbox_is_equal_to, RdfBoxGetDatum(RdfBoxGetTripleTermObject(left)), RdfBoxGetDatum(RdfBoxGetTripleTermObject(right)));
    bool predicate = varchar_eq(RdfBoxGetTripleTermPredicate(left), RdfBoxGetTripleTermPredicate(right));

    if(!predicate || (!subject.isnull && !DatumGetBool(subject.value)) || (!object.isnull && !DatumGetBool(object.value)))
        return NULLABLE_DATUM(BoolGetDatum(false));

    if(subject.isnull || object.isnull)
        return NULL_DATUM;

    return NULLABLE_DATUM(BoolGetDatum(true));
}


/**
 * The function sameTerm() of SPARQL: whether two boxes hold the same RDF term; bound to the SQL operator
 * `rdfbox === rdfbox`.
 *
 * A literal that keeps a non-canonical lexical form is another term than the literal of the same value in the canonical
 * form.
 *
 * @param fcinfo the left and the right rdfbox
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(rdfbox_is_same_as);
Datum rdfbox_is_same_as(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    bool result = rdfbox_same_terms(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_BOOL(result);
}


/**
 * The function sameValue() of SPARQL 1.2 on two boxes, see same_value().
 *
 * The translator does not use it, the operator `=` covers the comparisons it needs.
 *
 * @param fcinfo the left and the right rdfbox
 * @return the bool result, NULL if the terms cannot be compared
 */
PG_FUNCTION_INFO_V1(rdfbox_is_same_value_as);
Datum rdfbox_is_same_value_as(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    NullableDatum result = same_value(left, right);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN(result);
}


/**
 * The operator `=` of SPARQL 1.2 on rdfbox; bound to the SQL operator `rdfbox = rdfbox`.
 *
 * The operator `=` (and `!=` as its negation) follows the rows of the operator mapping for the pairs of types they
 * cover, including two triple terms (see tripleterm_is_equal_to()), and sameValue() for the other pairs.
 *
 * Two literals of different datatypes handled here are different values, whereas a typed literal, whose datatype is not
 * handled here or whose lexical form is invalid, equals the same term only and cannot be compared (NULL) with any other
 * literal. Unlike sameValue(), op:numeric-equal never holds for a NaN.
 *
 * Numbers are compared in their promoted type, date-times and dates by their instants (a value without a time zone
 * taken in the implicit time zone), strings, IRIs and blank nodes by their bytes, language-tagged strings together with
 * their tags, and user literals of the same datatype IRI by the equality operator of the SQL type of their values.
 *
 * @param fcinfo the left and the right rdfbox
 * @return the bool result, NULL if the terms cannot be compared: a typed literal and another literal, two user literals
 *         of the same datatype IRI whose values are of different SQL types or of a type without an equality operator,
 *         or two triple terms whose comparison is an error
 */
PG_FUNCTION_INFO_V1(rdfbox_is_equal_to);
Datum rdfbox_is_equal_to(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        PG_RETURN_BOOL(RdfBoxGetBool(left) == RdfBoxGetBool(right));
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = rdfbox_get_numeric_as_double(left);
            float8 r = rdfbox_get_numeric_as_double(right);
            PG_RETURN_BOOL(l == r);
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = rdfbox_get_numeric_as_float(left);
            float4 r = rdfbox_get_numeric_as_float(right);
            PG_RETURN_BOOL(l == r);
        }
        else if(!rdfbox_fits_in_long(left) || !rdfbox_fits_in_long(right))
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_eq, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(!rdfbox_fits_in_int(left) || !rdfbox_fits_in_int(right))
        {
            int64 l = rdfbox_get_numeric_as_long(left);
            int64 r = rdfbox_get_numeric_as_long(right);
            PG_RETURN_BOOL(l == r);
        }
        else
        {
            int32 l = rdfbox_get_numeric_as_int(left);
            int32 r = rdfbox_get_numeric_as_int(right);
            PG_RETURN_BOOL(l == r);
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = RdfBoxGetZonedDateTime(left);
        ZonedDateTime *r = RdfBoxGetZonedDateTime(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddatetime_is_equal_to, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r)));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = RdfBoxGetZonedDate(left);
        ZonedDate r = RdfBoxGetZonedDate(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddate_is_equal_to, ZonedDateGetDatum(l), ZonedDateGetDatum(r)));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        PG_RETURN_BOOL(l == r);
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == RDF_LANGSTRING && right->type == RDF_LANGSTRING)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == RDF_LTR_LANGSTRING && right->type == RDF_LTR_LANGSTRING)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == RDF_RTL_LANGSTRING && right->type == RDF_RTL_LANGSTRING)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == USER_LITERAL && right->type == USER_LITERAL)
    {
        bool equal;

        if(!varchar_eq(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right)))
            PG_RETURN_BOOL(false);

        if(!ubox_equals(NULL, RdfBoxGetUBox(left), RdfBoxGetUBox(right), &equal))
            PG_RETURN_NULL();

        PG_RETURN_BOOL(equal);
    }
    else if(left->type == TYPED_LITERAL && right->type == TYPED_LITERAL)
    {
        if(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0)
            PG_RETURN_BOOL(true);
        else
            PG_RETURN_NULL();
    }
    else if(rdfbox_is_literal(left) && rdfbox_is_literal(right))
    {
        /* a typed literal has no known value: its datatype is not handled here, or its lexical form is invalid */
        if(left->type == TYPED_LITERAL || right->type == TYPED_LITERAL)
            PG_RETURN_NULL();

        /* literals of two different handled datatypes are different values */
        PG_RETURN_BOOL(false);
    }
    else if(left->type == IRI && right->type == IRI)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == IBLANKNODE && right->type == IBLANKNODE)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        PG_RETURN_BOOL(l == r);
    }
    else if(left->type == SBLANKNODE && right->type == SBLANKNODE)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == TRIPLE_TERM && right->type == TRIPLE_TERM)
    {
        PG_RETURN(tripleterm_is_equal_to(left, right));
    }
    else
    {
        PG_RETURN_BOOL(false);
    }
}


/**
 * The operator `!=` of SPARQL 1.2, the negation of rdfbox_is_equal_to(); bound to the SQL operator `rdfbox != rdfbox`.
 *
 * @param fcinfo the left and the right rdfbox
 * @return the bool result, NULL exactly when rdfbox_is_equal_to() is NULL
 */
PG_FUNCTION_INFO_V1(rdfbox_is_not_equal_to);
Datum rdfbox_is_not_equal_to(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        PG_RETURN_BOOL(RdfBoxGetBool(left) != RdfBoxGetBool(right));
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = rdfbox_get_numeric_as_double(left);
            float8 r = rdfbox_get_numeric_as_double(right);
            PG_RETURN_BOOL(l != r);
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = rdfbox_get_numeric_as_float(left);
            float4 r = rdfbox_get_numeric_as_float(right);
            PG_RETURN_BOOL(l != r);
        }
        else if(!rdfbox_fits_in_long(left) || !rdfbox_fits_in_long(right))
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_ne, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(!rdfbox_fits_in_int(left) || !rdfbox_fits_in_int(right))
        {
            int64 l = rdfbox_get_numeric_as_long(left);
            int64 r = rdfbox_get_numeric_as_long(right);
            PG_RETURN_BOOL(l != r);
        }
        else
        {
            int32 l = rdfbox_get_numeric_as_int(left);
            int32 r = rdfbox_get_numeric_as_int(right);
            PG_RETURN_BOOL(l != r);
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = RdfBoxGetZonedDateTime(left);
        ZonedDateTime *r = RdfBoxGetZonedDateTime(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddatetime_is_not_equal_to, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r)));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = RdfBoxGetZonedDate(left);
        ZonedDate r = RdfBoxGetZonedDate(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddate_is_not_equal_to, ZonedDateGetDatum(l), ZonedDateGetDatum(r)));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        PG_RETURN_BOOL(l != r);
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) != 0);
    }
    else if(left->type == RDF_LANGSTRING && right->type == RDF_LANGSTRING)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) != 0);
    }
    else if(left->type == RDF_LTR_LANGSTRING && right->type == RDF_LTR_LANGSTRING)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) != 0);
    }
    else if(left->type == RDF_RTL_LANGSTRING && right->type == RDF_RTL_LANGSTRING)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) != 0);
    }
    else if(left->type == USER_LITERAL && right->type == USER_LITERAL)
    {
        bool equal;

        if(!varchar_eq(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right)))
            PG_RETURN_BOOL(true);

        if(!ubox_equals(NULL, RdfBoxGetUBox(left), RdfBoxGetUBox(right), &equal))
            PG_RETURN_NULL();

        PG_RETURN_BOOL(!equal);
    }
    else if(left->type == TYPED_LITERAL && right->type == TYPED_LITERAL)
    {
        if(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0)
            PG_RETURN_BOOL(false);
        else
            PG_RETURN_NULL();
    }
    else if(rdfbox_is_literal(left) && rdfbox_is_literal(right))
    {
        /* a typed literal has no known value: its datatype is not handled here, or its lexical form is invalid */
        if(left->type == TYPED_LITERAL || right->type == TYPED_LITERAL)
            PG_RETURN_NULL();

        /* literals of two different handled datatypes are different values */
        PG_RETURN_BOOL(true);
    }
    else if(left->type == IRI && right->type == IRI)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) != 0);
    }
    else if(left->type == IBLANKNODE && right->type == IBLANKNODE)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        PG_RETURN_BOOL(l != r);
    }
    else if(left->type == SBLANKNODE && right->type == SBLANKNODE)
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) != 0);
    }
    else if(left->type == TRIPLE_TERM && right->type == TRIPLE_TERM)
    {
        NullableDatum result = tripleterm_is_equal_to(left, right);

        if(result.isnull)
            PG_RETURN_NULL();

        PG_RETURN_BOOL(!DatumGetBool(result.value));
    }
    else
    {
        PG_RETURN_BOOL(true);
    }
}


/**
 * The operator `<` of SPARQL on rdfbox; bound to the SQL operator `rdfbox < rdfbox`.
 *
 * Defined on two booleans, two numbers (compared in their promoted type), two xsd:dateTime, two xsd:date, two
 * xsd:dayTimeDuration, two xsd:string (compared by code points) and two user literals of the same datatype IRI
 * (compared by the B-tree comparison of the SQL type of their values); any other pair, language-tagged strings
 * included, is a type error.
 *
 * @param fcinfo the left and the right rdfbox
 * @return true if the left term is less than the right one, false if not, NULL for a pair of terms the operator is not
 *         defined on or for two user literals whose values cannot be compared
 */
PG_FUNCTION_INFO_V1(rdfbox_is_less_than);
Datum rdfbox_is_less_than(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        PG_RETURN_BOOL(RdfBoxGetBool(left) < RdfBoxGetBool(right));
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = rdfbox_get_numeric_as_double(left);
            float8 r = rdfbox_get_numeric_as_double(right);
            PG_RETURN_BOOL(l < r);
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = rdfbox_get_numeric_as_float(left);
            float4 r = rdfbox_get_numeric_as_float(right);
            PG_RETURN_BOOL(l < r);
        }
        else if(!rdfbox_fits_in_long(left) || !rdfbox_fits_in_long(right))
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_lt, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(!rdfbox_fits_in_int(left) || !rdfbox_fits_in_int(right))
        {
            int64 l = rdfbox_get_numeric_as_long(left);
            int64 r = rdfbox_get_numeric_as_long(right);
            PG_RETURN_BOOL(l < r);
        }
        else
        {
            int32 l = rdfbox_get_numeric_as_int(left);
            int32 r = rdfbox_get_numeric_as_int(right);
            PG_RETURN_BOOL(l < r);
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = RdfBoxGetZonedDateTime(left);
        ZonedDateTime *r = RdfBoxGetZonedDateTime(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddatetime_is_less_than, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r)));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = RdfBoxGetZonedDate(left);
        ZonedDate r = RdfBoxGetZonedDate(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddate_is_less_than, ZonedDateGetDatum(l), ZonedDateGetDatum(r)));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        PG_RETURN_BOOL(l < r);
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);
        PG_RETURN_BOOL(varchar_cmp(l, r) < 0);
    }
    else if(left->type == USER_LITERAL && right->type == USER_LITERAL)
    {
        int cmp;

        if(!varchar_eq(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right)))
            PG_RETURN_NULL();

        if(!ubox_compare(NULL, RdfBoxGetUBox(left), RdfBoxGetUBox(right), &cmp))
            PG_RETURN_NULL();

        PG_RETURN_BOOL(cmp < 0);
    }
    else
    {
        PG_RETURN_NULL();
    }
}


/**
 * The operator `<=` of SPARQL on rdfbox; bound to the SQL operator `rdfbox <= rdfbox`.
 *
 * Defined on two booleans, two numbers (compared in their promoted type), two xsd:dateTime, two xsd:date, two
 * xsd:dayTimeDuration, two xsd:string (compared by code points) and two user literals of the same datatype IRI
 * (compared by the B-tree comparison of the SQL type of their values); any other pair, language-tagged strings
 * included, is a type error.
 *
 * @param fcinfo the left and the right rdfbox
 * @return true if the left term is less than or equal to the right one, false if not, NULL for a pair of terms the
 *         operator is not defined on or for two user literals whose values cannot be compared
 */
PG_FUNCTION_INFO_V1(rdfbox_is_not_greater_than);
Datum rdfbox_is_not_greater_than(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        PG_RETURN_BOOL(RdfBoxGetBool(left) <= RdfBoxGetBool(right));
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = rdfbox_get_numeric_as_double(left);
            float8 r = rdfbox_get_numeric_as_double(right);
            PG_RETURN_BOOL(l <= r);
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = rdfbox_get_numeric_as_float(left);
            float4 r = rdfbox_get_numeric_as_float(right);
            PG_RETURN_BOOL(l <= r);
        }
        else if(!rdfbox_fits_in_long(left) || !rdfbox_fits_in_long(right))
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_le, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(!rdfbox_fits_in_int(left) || !rdfbox_fits_in_int(right))
        {
            int64 l = rdfbox_get_numeric_as_long(left);
            int64 r = rdfbox_get_numeric_as_long(right);
            PG_RETURN_BOOL(l <= r);
        }
        else
        {
            int32 l = rdfbox_get_numeric_as_int(left);
            int32 r = rdfbox_get_numeric_as_int(right);
            PG_RETURN_BOOL(l <= r);
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = RdfBoxGetZonedDateTime(left);
        ZonedDateTime *r = RdfBoxGetZonedDateTime(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddatetime_is_not_greater_than, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r)));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = RdfBoxGetZonedDate(left);
        ZonedDate r = RdfBoxGetZonedDate(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddate_is_not_greater_than, ZonedDateGetDatum(l), ZonedDateGetDatum(r)));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        PG_RETURN_BOOL(l <= r);
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);
        PG_RETURN_BOOL(varchar_cmp(l, r) <= 0);
    }
    else if(left->type == USER_LITERAL && right->type == USER_LITERAL)
    {
        int cmp;

        if(!varchar_eq(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right)))
            PG_RETURN_NULL();

        if(!ubox_compare(NULL, RdfBoxGetUBox(left), RdfBoxGetUBox(right), &cmp))
            PG_RETURN_NULL();

        PG_RETURN_BOOL(cmp <= 0);
    }
    else
    {
        PG_RETURN_NULL();
    }
}


/**
 * The operator `>=` of SPARQL on rdfbox; bound to the SQL operator `rdfbox >= rdfbox`.
 *
 * Defined on two booleans, two numbers (compared in their promoted type), two xsd:dateTime, two xsd:date, two
 * xsd:dayTimeDuration, two xsd:string (compared by code points) and two user literals of the same datatype IRI
 * (compared by the B-tree comparison of the SQL type of their values); any other pair, language-tagged strings
 * included, is a type error.
 *
 * @param fcinfo the left and the right rdfbox
 * @return true if the left term is greater than or equal to the right one, false if not, NULL for a pair of terms the
 *         operator is not defined on or for two user literals whose values cannot be compared
 */
PG_FUNCTION_INFO_V1(rdfbox_is_not_less_than);
Datum rdfbox_is_not_less_than(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        PG_RETURN_BOOL(RdfBoxGetBool(left) >= RdfBoxGetBool(right));
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = rdfbox_get_numeric_as_double(left);
            float8 r = rdfbox_get_numeric_as_double(right);
            PG_RETURN_BOOL(l >= r);
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = rdfbox_get_numeric_as_float(left);
            float4 r = rdfbox_get_numeric_as_float(right);
            PG_RETURN_BOOL(l >= r);
        }
        else if(!rdfbox_fits_in_long(left) || !rdfbox_fits_in_long(right))
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_ge, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(!rdfbox_fits_in_int(left) || !rdfbox_fits_in_int(right))
        {
            int64 l = rdfbox_get_numeric_as_long(left);
            int64 r = rdfbox_get_numeric_as_long(right);
            PG_RETURN_BOOL(l >= r);
        }
        else
        {
            int32 l = rdfbox_get_numeric_as_int(left);
            int32 r = rdfbox_get_numeric_as_int(right);
            PG_RETURN_BOOL(l >= r);
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = RdfBoxGetZonedDateTime(left);
        ZonedDateTime *r = RdfBoxGetZonedDateTime(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddatetime_is_not_less_than, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r)));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = RdfBoxGetZonedDate(left);
        ZonedDate r = RdfBoxGetZonedDate(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddate_is_not_less_than, ZonedDateGetDatum(l), ZonedDateGetDatum(r)));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        PG_RETURN_BOOL(l >= r);
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);
        PG_RETURN_BOOL(varchar_cmp(l, r) >= 0);
    }
    else if(left->type == USER_LITERAL && right->type == USER_LITERAL)
    {
        int cmp;

        if(!varchar_eq(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right)))
            PG_RETURN_NULL();

        if(!ubox_compare(NULL, RdfBoxGetUBox(left), RdfBoxGetUBox(right), &cmp))
            PG_RETURN_NULL();

        PG_RETURN_BOOL(cmp >= 0);
    }
    else
    {
        PG_RETURN_NULL();
    }
}


/**
 * The operator `>` of SPARQL on rdfbox; bound to the SQL operator `rdfbox > rdfbox`.
 *
 * Defined on two booleans, two numbers (compared in their promoted type), two xsd:dateTime, two xsd:date, two
 * xsd:dayTimeDuration, two xsd:string (compared by code points) and two user literals of the same datatype IRI
 * (compared by the B-tree comparison of the SQL type of their values); any other pair, language-tagged strings
 * included, is a type error.
 *
 * @param fcinfo the left and the right rdfbox
 * @return true if the left term is greater than the right one, false if not, NULL for a pair of terms the operator is
 *         not defined on or for two user literals whose values cannot be compared
 */
PG_FUNCTION_INFO_V1(rdfbox_is_greater_than);
Datum rdfbox_is_greater_than(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        PG_RETURN_BOOL(RdfBoxGetBool(left) > RdfBoxGetBool(right));
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = rdfbox_get_numeric_as_double(left);
            float8 r = rdfbox_get_numeric_as_double(right);
            PG_RETURN_BOOL(l > r);
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = rdfbox_get_numeric_as_float(left);
            float4 r = rdfbox_get_numeric_as_float(right);
            PG_RETURN_BOOL(l > r);
        }
        else if(!rdfbox_fits_in_long(left) || !rdfbox_fits_in_long(right))
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_gt, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(!rdfbox_fits_in_int(left) || !rdfbox_fits_in_int(right))
        {
            int64 l = rdfbox_get_numeric_as_long(left);
            int64 r = rdfbox_get_numeric_as_long(right);
            PG_RETURN_BOOL(l > r);
        }
        else
        {
            int32 l = rdfbox_get_numeric_as_int(left);
            int32 r = rdfbox_get_numeric_as_int(right);
            PG_RETURN_BOOL(l > r);
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = RdfBoxGetZonedDateTime(left);
        ZonedDateTime *r = RdfBoxGetZonedDateTime(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddatetime_is_greater_than, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r)));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = RdfBoxGetZonedDate(left);
        ZonedDate r = RdfBoxGetZonedDate(right);
        PG_RETURN_DATUM(DirectFunctionCall2(zoneddate_is_greater_than, ZonedDateGetDatum(l), ZonedDateGetDatum(r)));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        PG_RETURN_BOOL(l > r);
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);
        PG_RETURN_BOOL(varchar_cmp(l, r) > 0);
    }
    else if(left->type == USER_LITERAL && right->type == USER_LITERAL)
    {
        int cmp;

        if(!varchar_eq(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right)))
            PG_RETURN_NULL();

        if(!ubox_compare(NULL, RdfBoxGetUBox(left), RdfBoxGetUBox(right), &cmp))
            PG_RETURN_NULL();

        PG_RETURN_BOOL(cmp > 0);
    }
    else
    {
        PG_RETURN_NULL();
    }
}
