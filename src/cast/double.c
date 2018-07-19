/*
 * https://www.w3.org/TR/xmlschema11-2/#double
 * https://www.w3.org/TR/xpath-functions/#casting-to-double
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "call.h"
#include "try-catch.h"


PG_FUNCTION_INFO_V1(cast_as_double_from_boolean);
Datum cast_as_double_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    PG_RETURN_FLOAT8(value ? 1.0 : 0.0);
}


PG_FUNCTION_INFO_V1(cast_as_double_from_short);
Datum cast_as_double_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    PG_RETURN_FLOAT8(value);
}


PG_FUNCTION_INFO_V1(cast_as_double_from_int);
Datum cast_as_double_from_int(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    PG_RETURN_FLOAT8(value);
}


PG_FUNCTION_INFO_V1(cast_as_double_from_long);
Datum cast_as_double_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    PG_RETURN_FLOAT8(value);
}


PG_FUNCTION_INFO_V1(cast_as_double_from_float);
Datum cast_as_double_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);
    PG_RETURN_FLOAT8(value);
}


PG_FUNCTION_INFO_V1(cast_as_double_from_decimal);
Datum cast_as_double_from_decimal(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    char *string = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(value)));

    errno = 0;
    float8 result = strtod(string, NULL);

    if(errno == ERANGE && result != 0.0)
        result *= HUGE_VAL;

    pfree(string);
    PG_FREE_IF_COPY(value, 0);

    PG_RETURN_FLOAT8(result);
}


PG_FUNCTION_INFO_V1(cast_as_double_from_string);
Datum cast_as_double_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    bool isNull = false;
    Datum result;

    char *cstring = text_to_cstring(value);

    PG_TRY_EX();
    {
        result = DirectFunctionCall1(float8in, CStringGetDatum(cstring));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        isNull = true;
    }
    PG_END_TRY_EX();

    pfree(cstring);
    PG_FREE_IF_COPY(value, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_double_from_rdfbox);
Datum cast_as_double_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isNull = false };

    switch(box->type)
    {
        case XSD_BOOLEAN:
            result = NullableFunctionCall1(cast_as_double_from_boolean, BoolGetDatum(((RdfBoxBoolean *) box)->value));
            break;

        case XSD_SHORT:
            result = NullableFunctionCall1(cast_as_double_from_short, Int16GetDatum(((RdfBoxShort *) box)->value));
            break;

        case XSD_INT:
            result = NullableFunctionCall1(cast_as_double_from_int, Int32GetDatum(((RdfBoxInt *) box)->value));
            break;

        case XSD_LONG:
            result = NullableFunctionCall1(cast_as_double_from_long, Int64GetDatum(((RdfBoxLong *) box)->value));
            break;

        case XSD_FLOAT:
            result = NullableFunctionCall1(cast_as_double_from_float, Float4GetDatum(((RdfBoxFloat *) box)->value));
            break;

        case XSD_DOUBLE:
            result.datum = Float8GetDatum(((RdfBoxDouble *) box)->value);
            break;

        case XSD_INTEGER:
        case XSD_DECIMAL:
            result = NullableFunctionCall1(cast_as_double_from_decimal, NumericGetDatum(((RdfBoxDecinal *) box)->value));
            break;

        case XSD_STRING:
            result = NullableFunctionCall1(cast_as_double_from_string, PointerGetDatum(((RdfBoxString *) box)->value));
            break;

        default:
            result.isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}
