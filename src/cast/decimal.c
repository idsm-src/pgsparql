/*
 * https://www.w3.org/TR/xmlschema11-2/#decimal
 * https://www.w3.org/TR/xpath-functions/#casting-to-decimal
 */
#include <postgres.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "call.h"
#include "try-catch.h"
#include "rdfbox/rdfbox.h"


PG_FUNCTION_INFO_V1(cast_as_decimal_from_boolean);
Datum cast_as_decimal_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    Datum result = DirectFunctionCall1(int4_numeric, Int32GetDatum(value ? 1 : 0));
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_short);
Datum cast_as_decimal_from_short(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    Datum result = DirectFunctionCall1(int2_numeric, value);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_int);
Datum cast_as_decimal_from_int(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    Datum result = DirectFunctionCall1(int4_numeric, value);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_long);
Datum cast_as_decimal_from_long(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    Datum result = DirectFunctionCall1(int8_numeric, value);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_integer);
Datum cast_as_decimal_from_integer(PG_FUNCTION_ARGS)
{
    Numeric result = PG_GETARG_NUMERIC(0);
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_float);
Datum cast_as_decimal_from_float(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);

    if(!isfinite(DatumGetFloat4(value)))
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(float4_numeric, value);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_double);
Datum cast_as_decimal_from_double(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);

    if(!isfinite(DatumGetFloat8(value)))
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(float8_numeric, value);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_string);
Datum cast_as_decimal_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_PP(0);
    NullableDatum result = { .isnull = false };

    char *cstring = text_to_cstring(value);

    PG_TRY_EX();
    {
        for(char *c = cstring; *c != '\0'; c++)
            if(!isspace((unsigned char) *c) && !isdigit((unsigned char) *c) && *c != '+' && *c != '-' && *c != '.')
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION)));

        result = NullableFunctionCall3(numeric_in, CStringGetDatum(cstring), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION)
            PG_RE_THROW_EX();

        result.isnull = true;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_rdfbox);
Datum cast_as_decimal_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_boolean, BoolGetDatum(RdfBoxGetBool(box))));

        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_INT:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_int, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_INTEGER:
        case XSD_DECIMAL:
            PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));

        case XSD_FLOAT:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_float, Float4GetDatum(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_double, Float8GetDatum(RdfBoxGetFloat8(box))));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}
