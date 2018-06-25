/*
 * https://www.w3.org/TR/xmlschema11-2/#boolean
 * https://www.w3.org/TR/xpath-functions/#casting-boolean
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"


PG_FUNCTION_INFO_V1(cast_as_boolean_from_short);
Datum cast_as_boolean_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    PG_RETURN_BOOL(value != 0);
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_int);
Datum cast_as_boolean_from_int(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    PG_RETURN_BOOL(value != 0);
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_long);
Datum cast_as_boolean_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    PG_RETURN_BOOL(value != 0);
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_float);
Datum cast_as_boolean_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);
    PG_RETURN_BOOL(value != 0 && !isnan(value));
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_double);
Datum cast_as_boolean_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);
    PG_RETURN_BOOL(value != 0 && !isnan(value));
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_integer);
Datum cast_as_boolean_from_integer(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    Numeric zero = DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(0)));

    bool isNonZero = DatumGetBool(DirectFunctionCall2(numeric_ne, NumericGetDatum(value), NumericGetDatum(zero)));
    bool isNan = numeric_is_nan(value);

    pfree(zero);
    PG_FREE_IF_COPY(value, 0);

    PG_RETURN_BOOL(isNonZero && !isNan);
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_decimal);
Datum cast_as_boolean_from_decimal(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    Numeric zero = DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(0)));

    bool isNonZero = DatumGetBool(DirectFunctionCall2(numeric_ne, NumericGetDatum(value), NumericGetDatum(zero)));
    bool isNan = numeric_is_nan(value);

    pfree(zero);
    PG_FREE_IF_COPY(value, 0);

    PG_RETURN_BOOL(isNonZero && !isNan);
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_string);
Datum cast_as_boolean_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);

    size_t length = VARSIZE(value) - VARHDRSZ;
    char *data = VARDATA(value);

    while(length > 0 && *data == ' ')
    {
        data++;
        length--;
    }

    while(length > 0 && data[length - 1] == ' ')
        length--;

    bool isNull = false;
    bool result;

    if((length == 4 && strncmp(data, "true", length) == 0) || (length == 1 && data[0] == '1'))
        result = true;
    else if((length == 5 && strncmp(data, "false", length) == 0) || (length == 1 && data[0] == '0'))
        result = false;
    else
        isNull = true;

    PG_FREE_IF_COPY(value, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_rdfbox);
Datum cast_as_boolean_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_BOOLEAN:
            result = BoolGetDatum(((RdfBoxBoolean *) box)->value);
            break;

        case XSD_SHORT:
            result = DirectFunctionCall1(cast_as_boolean_from_short, Int16GetDatum(((RdfBoxShort *) box)->value));
            break;

        case XSD_INT:
            result = DirectFunctionCall1(cast_as_boolean_from_int, Int32GetDatum(((RdfBoxInt *) box)->value));
            break;

        case XSD_LONG:
            result = DirectFunctionCall1(cast_as_boolean_from_long, Int64GetDatum(((RdfBoxLong *) box)->value));
            break;

        case XSD_FLOAT:
            result = DirectFunctionCall1(cast_as_boolean_from_float, Float4GetDatum(((RdfBoxFloat *) box)->value));
            break;

        case XSD_DOUBLE:
            result = DirectFunctionCall1(cast_as_boolean_from_double, Float8GetDatum(((RdfBoxDouble *) box)->value));
            break;

        case XSD_INTEGER:
            result = DirectFunctionCall1(cast_as_boolean_from_integer, NumericGetDatum(((RdfBoxInteger *) box)->value));
            break;

        case XSD_DECIMAL:
            result = DirectFunctionCall1(cast_as_boolean_from_decimal, NumericGetDatum(((RdfBoxDecinal *) box)->value));
            break;

        case XSD_STRING:
            result = DirectFunctionCall1(cast_as_boolean_from_string, PointerGetDatum(((RdfBoxString *) box)->value));
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
