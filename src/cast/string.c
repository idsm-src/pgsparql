/*
 * https://www.w3.org/TR/xmlschema11-2/#string
 * https://www.w3.org/TR/xpath-functions/#casting-to-string
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"


PG_FUNCTION_INFO_V1(cast_as_string_from_boolean);
Datum cast_as_string_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    char *string = value ? "true" : "false";
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_short);
Datum cast_as_string_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    char *string = DatumGetCString(DirectFunctionCall1(int2out, Int16GetDatum(value)));
    Datum result = CStringGetTextDatum(string);
    pfree(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_int);
Datum cast_as_string_from_int(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    char *string = DatumGetCString(DirectFunctionCall1(int4out, Int32GetDatum(value)));
    Datum result = CStringGetTextDatum(string);
    pfree(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_long);
Datum cast_as_string_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    char *string = DatumGetCString(DirectFunctionCall1(int8out, Int64GetDatum(value)));
    Datum result = CStringGetTextDatum(string);
    pfree(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_float);
Datum cast_as_string_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);
    char *string = DatumGetCString(DirectFunctionCall1(float4out, Float4GetDatum(value)));
    Datum result = CStringGetTextDatum(string);
    pfree(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_double);
Datum cast_as_string_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);
    char *string = DatumGetCString(DirectFunctionCall1(float8out, Float8GetDatum(value)));
    Datum result = CStringGetTextDatum(string);
    pfree(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_integer);
Datum cast_as_string_from_integer(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    char *string = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(value)));
    Datum result = CStringGetTextDatum(string);
    pfree(string);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_decimal);
Datum cast_as_string_from_decimal(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    char *string = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(value)));
    Datum result = CStringGetTextDatum(string);
    pfree(string);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_rdfbox);
Datum cast_as_string_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_BOOLEAN:
            result = DirectFunctionCall1(cast_as_string_from_boolean, BoolGetDatum(((RdfBoxBoolean *) box)->value));
            break;

        case XSD_SHORT:
            result = DirectFunctionCall1(cast_as_string_from_short, Int16GetDatum(((RdfBoxShort *) box)->value));
            break;

        case XSD_INT:
            result = DirectFunctionCall1(cast_as_string_from_int, Int32GetDatum(((RdfBoxInt *) box)->value));
            break;

        case XSD_LONG:
            result = DirectFunctionCall1(cast_as_string_from_long, Int64GetDatum(((RdfBoxLong *) box)->value));
            break;

        case XSD_FLOAT:
            result = DirectFunctionCall1(cast_as_string_from_float, Float4GetDatum(((RdfBoxFloat *) box)->value));
            break;

        case XSD_DOUBLE:
            result = DirectFunctionCall1(cast_as_string_from_double, Float8GetDatum(((RdfBoxDouble *) box)->value));
            break;

        case XSD_INTEGER:
            result = DirectFunctionCall1(cast_as_string_from_integer, NumericGetDatum(((RdfBoxInteger *) box)->value));
            break;

        case XSD_DECIMAL:
            result = DirectFunctionCall1(cast_as_string_from_decimal, NumericGetDatum(((RdfBoxDecinal *) box)->value));
            break;

        case XSD_STRING:
        {
            VarChar *value = (VarChar *) ((RdfBoxString *) box)->value;
            size_t length = VARSIZE(value);

            VarChar *copy = palloc(length);
            memcpy(copy, value, length);
            result = PointerGetDatum(copy);
        }
        break;
            break;

        default:
            isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}