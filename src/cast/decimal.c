/*
 * https://www.w3.org/TR/xmlschema11-2/#decimal
 * https://www.w3.org/TR/xpath-functions/#casting-to-decimal
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "try-catch.h"


PG_FUNCTION_INFO_V1(cast_as_decimal_from_boolean);
Datum cast_as_decimal_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    Datum result = DirectFunctionCall1(int4_numeric, Int32GetDatum(value ? 1 : 0));
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_short);
Datum cast_as_decimal_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    Datum result = DirectFunctionCall1(int2_numeric, Int32GetDatum(value));
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_int);
Datum cast_as_decimal_from_int(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    Datum result = DirectFunctionCall1(int4_numeric, Int32GetDatum(value));
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_long);
Datum cast_as_decimal_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    Datum result = DirectFunctionCall1(int8_numeric, Int64GetDatum(value));
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_float);
Datum cast_as_decimal_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);

    if(isnan(value) || isinf(value))
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(float4_numeric, Float4GetDatum(value));
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_double);
Datum cast_as_decimal_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);

    if(isnan(value) || isinf(value))
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(float8_numeric, Float8GetDatum(value));
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_integer);
Datum cast_as_decimal_from_integer(PG_FUNCTION_ARGS)
{
    Numeric result = PG_GETARG_NUMERIC_COPY(0);
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_string);
Datum cast_as_decimal_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    char *cstring = text_to_cstring(value);
    bool isNull = false;
    Numeric result;

    PG_TRY_EX();
    {
        for(char *c = cstring; *c != '\0'; c++)
            if(*c != ' ' && *c != '+' && *c != '-' && *c != '.' && (*c < '0' || *c > '9'))
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION)));

        result = DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(cstring), ObjectIdGetDatum(InvalidOid),
                Int32GetDatum(-1)));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION)
            PG_RE_THROW_EX();

        isNull = true;
    }
    PG_END_TRY_EX();


    PG_FREE_IF_COPY(value, 0);
    pfree(cstring);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_rdfbox);
Datum cast_as_decimal_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_BOOLEAN:
            result = DirectFunctionCall1(cast_as_decimal_from_boolean, BoolGetDatum(((RdfBoxBoolean *) box)->value));
            break;

        case XSD_SHORT:
            result = DirectFunctionCall1(cast_as_decimal_from_short, Int16GetDatum(((RdfBoxShort *) box)->value));
            break;

        case XSD_INT:
            result = DirectFunctionCall1(cast_as_decimal_from_int, Int32GetDatum(((RdfBoxInt *) box)->value));
            break;

        case XSD_LONG:
            result = DirectFunctionCall1(cast_as_decimal_from_long, Int64GetDatum(((RdfBoxLong *) box)->value));
            break;

        case XSD_FLOAT:
            result = DirectFunctionCall1(cast_as_decimal_from_float, Float4GetDatum(((RdfBoxFloat *) box)->value));
            break;

        case XSD_DOUBLE:
            result = DirectFunctionCall1(cast_as_decimal_from_double, Float8GetDatum(((RdfBoxDouble *) box)->value));
            break;

        case XSD_INTEGER:
            {
                Numeric value = (Numeric) ((RdfBoxInteger *) box)->value;
                size_t length = VARSIZE(value);

                Numeric copy = palloc(length);
                memcpy(copy, value, length);
                result = NumericGetDatum(copy);
            }
            break;

        case XSD_DECIMAL:
            {
                Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
                size_t length = VARSIZE(value);

                Numeric copy = palloc(length);
                memcpy(copy, value, length);
                result = NumericGetDatum(copy);
            }
            break;

        case XSD_STRING:
            result = DirectFunctionCall1(cast_as_decimal_from_string, PointerGetDatum(((RdfBoxString *) box)->value));
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
