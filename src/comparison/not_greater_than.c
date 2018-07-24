#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "cast/cast.h"


PG_FUNCTION_INFO_V1(not_greater_than_rdfbox);
Datum not_greater_than_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    bool isNull = false;
    Datum result;

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        result = BoolGetDatum(((RdfBoxBoolean *) left)->value <= ((RdfBoxBoolean *) right)->value);
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(left)));
            float8 r = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l <= r);
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(left)));
            float4 r = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l <= r);
        }
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(left)));
            Numeric r = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(right)));
            result = DirectFunctionCall2(numeric_le, NumericGetDatum(l), NumericGetDatum(r));

            pfree(l);
            pfree(r);
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
        {
            int64 l = DatumGetInt64(DirectFunctionCall1(cast_as_long_from_rdfbox, RdfBoxGetDatum(left)));
            int64 r = DatumGetInt64(DirectFunctionCall1(cast_as_long_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l <= r);
        }
        else if(left->type == XSD_INT || right->type == XSD_INT)
        {
            int32 l = DatumGetInt32(DirectFunctionCall1(cast_as_int_from_rdfbox, RdfBoxGetDatum(left)));
            int32 r = DatumGetInt32(DirectFunctionCall1(cast_as_int_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l <= r);
        }
        else //if(left->type == XSD_SHORT || right->type == XSD_SHORT)
        {
            int16 l = DatumGetInt16(DirectFunctionCall1(cast_as_short_from_rdfbox, RdfBoxGetDatum(left)));
            int16 r = DatumGetInt16(DirectFunctionCall1(cast_as_short_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l <= r);
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = &((RdfBoxDateTime *) left)->value;
        ZonedDateTime *r = &((RdfBoxDateTime *) right)->value;
        result = DirectFunctionCall2(zoneddatetime_not_greater_than, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = ((RdfBoxDate *) left)->value;
        ZonedDate r = ((RdfBoxDate *) right)->value;
        result = DirectFunctionCall2(zoneddate_not_greater_than, ZonedDateGetDatum(l), ZonedDateGetDatum(r));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = ((RdfBoxDayTimeDuration *) left)->value;
        int64 r = ((RdfBoxDayTimeDuration *) right)->value;
        result = BoolGetDatum(l <= r);
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        VarChar *l = (VarChar *) ((RdfBoxString *) left)->value;
        VarChar *r = (VarChar *) ((RdfBoxString *) right)->value;

        int v = memcmp(VARDATA(l), VARDATA(r), Min(VARSIZE(l), VARSIZE(r)) - VARHDRSZ);

        if((v == 0) && (VARSIZE(l) <= VARSIZE(r)))
            v = -1;

        result = BoolGetDatum(v < 0);
    }
    else
    {
        isNull = true;
    }

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}
