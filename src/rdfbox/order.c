#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <math.h>
#include "call.h"
#include "compare.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


PG_FUNCTION_INFO_V1(rdfbox_order_compare);
Datum rdfbox_order_compare(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    Datum result;

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        result = Int32GetDatum(compare(RdfBoxGetBool(left), RdfBoxGetBool(right)));
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = rdfbox_get_numeric_as_double(left);
            float8 r = rdfbox_get_numeric_as_double(right);

            if(isnan(l) && isnan(r))
                result = Int32GetDatum(compare(left->type, right->type));
            else if(isnan(l))
                result = Int32GetDatum(1);
            else if(isnan(r))
                result = Int32GetDatum(-1);
            else if(l == r)
                result = Int32GetDatum(compare(left->type, right->type));
            else
                result = Int32GetDatum(compare(l, r));
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = rdfbox_get_numeric_as_float(left);
            float4 r = rdfbox_get_numeric_as_float(right);

            if(isnan(l) && isnan(r))
                result = Int32GetDatum(compare(left->type, right->type));
            else if(isnan(l))
                result = Int32GetDatum(1);
            else if(isnan(r))
                result = Int32GetDatum(-1);
            else if(l == r)
                result = Int32GetDatum(compare(left->type, right->type));
            else
                result = Int32GetDatum(compare(l, r));
        }
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = rdfbox_get_numeric_as_decimal(left);
            Numeric r = rdfbox_get_numeric_as_decimal(right);
            result = DirectFunctionCall2(numeric_cmp, NumericGetDatum(l), NumericGetDatum(r));

            if(DatumGetInt32(result) == 0)
                result = Int32GetDatum(compare(left->type, right->type));

            if(left->type != XSD_INTEGER && left->type != XSD_DECIMAL)
                pfree(l);

            if(right->type != XSD_INTEGER && right->type != XSD_DECIMAL)
                pfree(r);
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
        {
            int64 l = rdfbox_get_numeric_as_long(left);
            int64 r = rdfbox_get_numeric_as_long(right);

            if(l == r)
                result = Int32GetDatum(compare(left->type, right->type));
            else
                result = Int32GetDatum(compare(l, r));
        }
        else
        {
            int32 l = rdfbox_get_numeric_as_int(left);
            int32 r = rdfbox_get_numeric_as_int(right);
            result = Int32GetDatum(compare(l, r));

            if(l == r)
                result = Int32GetDatum(compare(left->type, right->type));
            else
                result = Int32GetDatum(compare(l, r));
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = RdfBoxGetZonedDateTime(left);
        ZonedDateTime *r = RdfBoxGetZonedDateTime(right);
        result = DirectFunctionCall2(zoneddatetime_compare, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r));

        if(DatumGetInt32(result) == 0)
            result = Int32GetDatum(compare(l->zone, r->zone));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = RdfBoxGetZonedDate(left);
        ZonedDate r = RdfBoxGetZonedDate(right);
        result = DirectFunctionCall2(zoneddate_compare, ZonedDateGetDatum(l), ZonedDateGetDatum(r));

        if(DatumGetInt32(result) == 0)
            result = Int32GetDatum(compare(l.zone, r.zone));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);
        result = Int32GetDatum(compare(l, r));
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);

        result = Int32GetDatum(varchar_cmp(l, r));
    }
    else if(left->type == RDF_LANGSTRING && right->type == RDF_LANGSTRING)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);
        result = Int32GetDatum(varchar_cmp(l, r));

        if(DatumGetInt32(result) == 0)
            result = Int32GetDatum(varchar_cmp(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right)));
    }
    else if(left->type == TYPED_LITERAL && right->type == TYPED_LITERAL)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);
        result = Int32GetDatum(varchar_cmp(l, r));

        if(DatumGetInt32(result) == 0)
            result = Int32GetDatum(varchar_cmp(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right)));
    }
    else if(left->type == IRI && right->type == IRI)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);

        result = Int32GetDatum(varchar_cmp(l, r));
    }
    else if(left->type == IBLANKNODE && right->type == IBLANKNODE)
    {
        int64 l = RdfBoxGetInt64(left);
        int64 r = RdfBoxGetInt64(right);

        result = Int32GetDatum(compare(l, r));
    }
    else if(left->type == SBLANKNODE && right->type == SBLANKNODE)
    {
        VarChar *l = RdfBoxGetVarChar(left);
        VarChar *r = RdfBoxGetVarChar(right);

        result = Int32GetDatum(varchar_cmp(l, r));
    }
    else
    {
        result = Int32GetDatum(compare(right->type, left->type));
    }

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_equal_to);
Datum rdfbox_order_is_equal_to(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result == 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_not_equal_to);
Datum rdfbox_order_is_not_equal_to(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result != 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_less_than);
Datum rdfbox_order_is_less_than(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result < 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_greater_than);
Datum rdfbox_order_is_greater_than(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result > 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_not_less_than);
Datum rdfbox_order_is_not_less_than(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result >= 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_is_not_greater_than);
Datum rdfbox_order_is_not_greater_than(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result <= 0);
}
