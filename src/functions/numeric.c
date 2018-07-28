#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "cast/cast.h"


PG_FUNCTION_INFO_V1(abs_float);
Datum abs_float(PG_FUNCTION_ARGS)
{
    float4 arg = PG_GETARG_FLOAT4(0);
    PG_RETURN_FLOAT4(fabsf(arg));
}


PG_FUNCTION_INFO_V1(abs_double);
Datum abs_double(PG_FUNCTION_ARGS)
{
    float8 arg = PG_GETARG_FLOAT8(0);
    PG_RETURN_FLOAT8(fabs(arg));
}


PG_FUNCTION_INFO_V1(abs_decimal);
Datum abs_decimal(PG_FUNCTION_ARGS)
{
    Numeric arg = PG_GETARG_NUMERIC(0);
    Datum result = DirectFunctionCall1(numeric_abs, NumericGetDatum(arg));
    PG_FREE_IF_COPY(arg, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(abs_rdfbox);
Datum abs_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_SHORT:
        {
            int32 value = ((RdfBoxShort *) box)->value;
            Numeric res = DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(abs(value))));
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(res));
            pfree(res);
            break;
        }

        case XSD_INT:
        {
            int64 value = ((RdfBoxInt *) box)->value;
            Numeric res = DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(labs(value))));
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(res));
            pfree(res);
            break;
        }

        case XSD_LONG:
        {
            int64 value = ((RdfBoxLong *) box)->value;
            Numeric res;

            if(value == INT64_MIN)
            {
                Numeric num = DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(value)));
                res = DatumGetNumeric(DirectFunctionCall1(numeric_abs, NumericGetDatum(num)));
                pfree(num);
            }
            else
            {
                res = DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(labs(value))));
            }

            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(res));
            pfree(res);
            break;
        }

        case XSD_FLOAT:
            result = DirectFunctionCall1(cast_as_rdfbox_from_float, Float4GetDatum(fabsf(((RdfBoxFloat *) box)->value)));
            break;

        case XSD_DOUBLE:
            result = DirectFunctionCall1(cast_as_rdfbox_from_double, Float8GetDatum(fabs(((RdfBoxDouble *) box)->value)));
            break;

        case XSD_INTEGER:
        {
            Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_abs, NumericGetDatum(value)));
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(res));
            pfree(res);
            break;
        }

        case XSD_DECIMAL:
        {
            Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_abs, NumericGetDatum(value)));
            result = DirectFunctionCall1(cast_as_rdfbox_from_decimal, NumericGetDatum(res));
            pfree(res);
            break;
        }

        default:
            isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(round_float);
Datum round_float(PG_FUNCTION_ARGS)
{
    float4 arg = PG_GETARG_FLOAT4(0);
    PG_RETURN_FLOAT4(roundf(arg));
}


PG_FUNCTION_INFO_V1(round_double);
Datum round_double(PG_FUNCTION_ARGS)
{
    float8 arg = PG_GETARG_FLOAT8(0);
    PG_RETURN_FLOAT8(round(arg));
}


PG_FUNCTION_INFO_V1(round_decimal);
Datum round_decimal(PG_FUNCTION_ARGS)
{
    Numeric arg = PG_GETARG_NUMERIC(0);
    Datum result = DirectFunctionCall2(numeric_round, NumericGetDatum(arg), Int32GetDatum(0));
    PG_FREE_IF_COPY(arg, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(round_rdfbox);
Datum round_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_SHORT:
        case XSD_INT:
        case XSD_LONG:
        {
            Numeric res = DatumGetNumeric(DirectFunctionCall1(cast_as_integer_from_rdfbox, RdfBoxGetDatum(box)));
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(res));
            pfree(res);
            break;
        }

        case XSD_FLOAT:
            result = DirectFunctionCall1(cast_as_rdfbox_from_float, Float4GetDatum(roundf(((RdfBoxFloat *) box)->value)));
            break;

        case XSD_DOUBLE:
            result = DirectFunctionCall1(cast_as_rdfbox_from_double, Float8GetDatum(round(((RdfBoxDouble *) box)->value)));
            break;

        case XSD_INTEGER:
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum((Numeric) ((RdfBoxDecinal *) box)->value));
            break;

        case XSD_DECIMAL:
        {
            Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
            Numeric res = DatumGetNumeric(DirectFunctionCall2(numeric_round, NumericGetDatum(value), Int32GetDatum(0)));
            result = DirectFunctionCall1(cast_as_rdfbox_from_decimal, NumericGetDatum(res));
            pfree(res);
            break;
        }

        default:
            isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(ceil_float);
Datum ceil_float(PG_FUNCTION_ARGS)
{
    float4 arg = PG_GETARG_FLOAT4(0);
    PG_RETURN_FLOAT4(ceilf(arg));
}


PG_FUNCTION_INFO_V1(ceil_double);
Datum ceil_double(PG_FUNCTION_ARGS)
{
    float8 arg = PG_GETARG_FLOAT8(0);
    PG_RETURN_FLOAT8(ceil(arg));
}


PG_FUNCTION_INFO_V1(ceil_decimal);
Datum ceil_decimal(PG_FUNCTION_ARGS)
{
    Numeric arg = PG_GETARG_NUMERIC(0);
    Datum result = DirectFunctionCall1(numeric_ceil, NumericGetDatum(arg));
    PG_FREE_IF_COPY(arg, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(ceil_rdfbox);
Datum ceil_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_SHORT:
        case XSD_INT:
        case XSD_LONG:
        {
            Numeric res = DatumGetNumeric(DirectFunctionCall1(cast_as_integer_from_rdfbox, RdfBoxGetDatum(box)));
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(res));
            pfree(res);
            break;
        }

        case XSD_FLOAT:
            result = DirectFunctionCall1(cast_as_rdfbox_from_float, Float4GetDatum(ceilf(((RdfBoxFloat *) box)->value)));
            break;

        case XSD_DOUBLE:
            result = DirectFunctionCall1(cast_as_rdfbox_from_double, Float8GetDatum(ceil(((RdfBoxDouble *) box)->value)));
            break;

        case XSD_INTEGER:
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum((Numeric) ((RdfBoxDecinal *) box)->value));
            break;

        case XSD_DECIMAL:
        {
            Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_ceil, NumericGetDatum(value)));
            result = DirectFunctionCall1(cast_as_rdfbox_from_decimal, NumericGetDatum(res));
            pfree(res);
            break;
        }

        default:
            isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(floor_float);
Datum floor_float(PG_FUNCTION_ARGS)
{
    float4 arg = PG_GETARG_FLOAT4(0);
    PG_RETURN_FLOAT4(floorf(arg));
}


PG_FUNCTION_INFO_V1(floor_double);
Datum floor_double(PG_FUNCTION_ARGS)
{
    float8 arg = PG_GETARG_FLOAT8(0);
    PG_RETURN_FLOAT8(floor(arg));
}


PG_FUNCTION_INFO_V1(floor_decimal);
Datum floor_decimal(PG_FUNCTION_ARGS)
{
    Numeric arg = PG_GETARG_NUMERIC(0);
    Datum result = DirectFunctionCall1(numeric_floor, NumericGetDatum(arg));
    PG_FREE_IF_COPY(arg, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(floor_rdfbox);
Datum floor_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_SHORT:
        case XSD_INT:
        case XSD_LONG:
        {
            Numeric res = DatumGetNumeric(DirectFunctionCall1(cast_as_integer_from_rdfbox, RdfBoxGetDatum(box)));
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(res));
            pfree(res);
            break;
        }

        case XSD_FLOAT:
            result = DirectFunctionCall1(cast_as_rdfbox_from_float, Float4GetDatum(floorf(((RdfBoxFloat *) box)->value)));
            break;

        case XSD_DOUBLE:
            result = DirectFunctionCall1(cast_as_rdfbox_from_double, Float8GetDatum(floor(((RdfBoxDouble *) box)->value)));
            break;

        case XSD_INTEGER:
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum((Numeric) ((RdfBoxDecinal *) box)->value));
            break;

        case XSD_DECIMAL:
        {
            Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_floor, NumericGetDatum(value)));
            result = DirectFunctionCall1(cast_as_rdfbox_from_decimal, NumericGetDatum(res));
            pfree(res);
            break;
        }

        default:
            isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}
