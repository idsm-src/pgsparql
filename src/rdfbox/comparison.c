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


static inline bool rdfbox_is_nan(RdfBox *box)
{
    return (box->type == XSD_FLOAT && isnan(RdfBoxGetFloat4(box))) || (box->type == XSD_DOUBLE && isnan(RdfBoxGetFloat8(box)));
}


/*
 * The function sameValue() of SPARQL 1.2 (section 17.4.2.2) as the section defines it, behind rdfbox_is_same_value_as()
 * only: the operator = of this file does not use it, because the operator mapping covers every pair of terms the
 * function would decide differently. On IRIs, blank nodes and literals it agrees with the operator = except for NaN:
 * two NaN values, of xsd:float or xsd:double in any combination, are the same value, whereas op:numeric-equal never
 * holds for a NaN. Two triple terms are compared component by component, and an error (NULL) of any component is an
 * error of the whole, whereas the operator = on two triple terms follows the operator mapping, see tripleterm_is_equal_to().
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


/*
 * The operator = on two triple terms as the operator mapping of SPARQL 1.2 defines it: (A.subject = B.subject) &&
 * (A.predicate = B.predicate) && (A.object = B.object), with the three-valued && of SPARQL: a component that differs
 * decides even when another one cannot be compared, otherwise an error (NULL) of a component is an error of the whole.
 * The components are compared by the operator = itself, so two NaN objects are not equal, unlike in sameValue().
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


/*
 * The operator = of SPARQL 1.2 (and != as its negation): the rows of the operator mapping for the pairs of types they
 * cover, including two triple terms (see tripleterm_is_equal_to()), sameValue() for the other pairs. Two literals of
 * different datatypes handled here are different values, whereas a typed literal, whose datatype is not handled here
 * or whose lexical form is invalid, equals the same term only and cannot be compared (NULL) with any other literal.
 * Unlike sameValue(), op:numeric-equal never holds for a NaN.
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
