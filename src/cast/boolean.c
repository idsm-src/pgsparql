/*
 * https://www.w3.org/TR/xmlschema11-2/#boolean
 * https://www.w3.org/TR/xpath-functions/#casting-boolean
 */
#include <postgres.h>
#include <utils/builtins.h>
#include "call.h"
#include "constants.h"
#include "rdfbox/rdfbox.h"


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


PG_FUNCTION_INFO_V1(cast_as_boolean_from_decimal);
Datum cast_as_boolean_from_decimal(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    Datum result = DirectFunctionCall2(numeric_ne, value, NumericGetDatum(get_zero()));
    PG_RETURN_DATUM(result);
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


PG_FUNCTION_INFO_V1(cast_as_boolean_from_string);
Datum cast_as_boolean_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);

    char *data = VARDATA_ANY(value);
    int length = VARSIZE_ANY_EXHDR(value);

    while(length > 0 && isspace((unsigned char) *data))
        length--, data++;

    while(length > 0 && isspace((unsigned char) data[length - 1]))
        length--;

    if((length == 4 && strncmp(data, "true", length) == 0) || (length == 1 && data[0] == '1'))
        PG_RETURN_BOOL(true);
    else if((length == 5 && strncmp(data, "false", length) == 0) || (length == 1 && data[0] == '0'))
        PG_RETURN_BOOL(false);
    else
        PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(cast_as_boolean_from_rdfbox);
Datum cast_as_boolean_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN_BOOL(RdfBoxGetBool(box));

        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_boolean_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_INT:
            PG_RETURN(NullableFunctionCall1(cast_as_boolean_from_int, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_boolean_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_INTEGER:
        case XSD_DECIMAL:
            PG_RETURN(NullableFunctionCall1(cast_as_boolean_from_decimal, NumericGetDatum(RdfBoxGetNumeric(box))));

        case XSD_FLOAT:
            PG_RETURN(NullableFunctionCall1(cast_as_boolean_from_float, Float4GetDatum(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN(NullableFunctionCall1(cast_as_boolean_from_double, Float8GetDatum(RdfBoxGetFloat8(box))));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_boolean_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}
