/*
 * https://www.w3.org/TR/xmlschema11-2/#integer
 * https://www.w3.org/TR/xpath-functions/#casting-to-integer
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "call.h"
#include "try-catch.h"
#include "cast/cast.h"


PG_FUNCTION_INFO_V1(cast_as_integer_from_float);
Datum cast_as_integer_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);

    if(isnan(value) || isinf(value))
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(float4_numeric, Float4GetDatum(truncf(value)));
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_integer_from_double);
Datum cast_as_integer_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);

    if(isnan(value) || isinf(value))
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(float8_numeric, Float8GetDatum(trunc(value)));
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_integer_from_decimal);
Datum cast_as_integer_from_decimal(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    Numeric result = DatumGetNumeric(DirectFunctionCall2(numeric_trunc, NumericGetDatum(value), Int32GetDatum(0)));
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_integer_from_string);
Datum cast_as_integer_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    char *cstring = text_to_cstring(value);
    bool isnull = false;
    Datum result;

    PG_TRY_EX();
    {
        for(char *c = cstring; *c != '\0'; c++)
            if(*c != ' ' && *c != '+' && *c != '-' && (*c < '0' || *c > '9'))
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION)));

        result = DirectFunctionCall3(numeric_in, CStringGetDatum(cstring), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION)
            PG_RE_THROW_EX();

        isnull = true;
    }
    PG_END_TRY_EX();


    PG_FREE_IF_COPY(value, 0);
    pfree(cstring);

    if(isnull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_integer_from_rdfbox);
Datum cast_as_integer_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isnull = false };

    switch(box->type)
    {
        case XSD_BOOLEAN:
            result = NullableFunctionCall1(cast_as_decimal_from_boolean, BoolGetDatum(((RdfBoxBoolean *) box)->value));
            break;

        case XSD_SHORT:
            result = NullableFunctionCall1(cast_as_decimal_from_short, Int16GetDatum(((RdfBoxShort *) box)->value));
            break;

        case XSD_INT:
            result = NullableFunctionCall1(cast_as_decimal_from_int, Int32GetDatum(((RdfBoxInt *) box)->value));
            break;

        case XSD_LONG:
            result = NullableFunctionCall1(cast_as_decimal_from_long, Int64GetDatum(((RdfBoxLong *) box)->value));
            break;

        case XSD_FLOAT:
            result = NullableFunctionCall1(cast_as_integer_from_float, Float4GetDatum(((RdfBoxFloat *) box)->value));
            break;

        case XSD_DOUBLE:
            result = NullableFunctionCall1(cast_as_integer_from_double, Float8GetDatum(((RdfBoxDouble *) box)->value));
            break;

        case XSD_INTEGER:
            {
                Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
                size_t length = VARSIZE(value);

                Numeric copy = palloc(length);
                memcpy(copy, value, length);
                result.value = NumericGetDatum(copy);
            }
            break;

        case XSD_DECIMAL:
            {
                Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
                result.value = DirectFunctionCall2(numeric_trunc, NumericGetDatum(value), Int32GetDatum(0));
            }
            break;

        case XSD_STRING:
            result = NullableFunctionCall1(cast_as_integer_from_string, PointerGetDatum(((RdfBoxString *) box)->value));
            break;

        default:
            result.isnull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isnull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.value);
}
