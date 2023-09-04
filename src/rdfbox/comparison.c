#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "compare.h"
#include "call.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


PG_FUNCTION_INFO_V1(rdfbox_is_same_as);
Datum rdfbox_is_same_as(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(left->type == XSD_DOUBLE && right->type == XSD_DOUBLE)
    {
        float8 l = RdfBoxGetFloat8(left);
        float8 r = RdfBoxGetFloat8(right);

        PG_RETURN_BOOL(l == r || (isnan(l) && isnan(r)));
    }
    else if(left->type == XSD_FLOAT && right->type == XSD_FLOAT)
    {
        float4 l = RdfBoxGetFloat4(left);
        float4 r = RdfBoxGetFloat4(right);

        PG_RETURN_BOOL(l == r || (isnan(l) && isnan(r)));
    }
    else if((left->type == XSD_DECIMAL && right->type == XSD_DECIMAL) || (left->type == XSD_INTEGER && right->type == XSD_INTEGER))
    {
        Numeric l = RdfBoxGetNumeric(left);
        Numeric r = RdfBoxGetNumeric(right);
        PG_RETURN_DATUM(DirectFunctionCall2(numeric_eq, NumericGetDatum(l), NumericGetDatum(r)));
    }
    else
    {
        PG_RETURN_BOOL(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
}


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
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_eq, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
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
    else if(left->type == TYPED_LITERAL && right->type == TYPED_LITERAL)
    {
        if(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0)
            PG_RETURN_BOOL(true);
        else
            PG_RETURN_NULL();
    }
    else if(rdfbox_is_literal(left) && rdfbox_is_literal(right))
    {
        PG_RETURN_NULL();
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
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_ne, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
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
    else if(left->type == TYPED_LITERAL && right->type == TYPED_LITERAL)
    {
        if(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0)
            PG_RETURN_BOOL(false);
        else
            PG_RETURN_NULL();
    }
    else if(rdfbox_is_literal(left) && rdfbox_is_literal(right))
    {
        PG_RETURN_NULL();
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
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_lt, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
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
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_le, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
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
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_ge, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
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
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_gt, NumericGetDatum(l), NumericGetDatum(r)));
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
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
    else
    {
        PG_RETURN_NULL();
    }
}
