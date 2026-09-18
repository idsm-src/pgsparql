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
#include "types/float.h"
#include "types/double.h"
#include "types/decimal.h"
#include "types/unsignedlong.h"
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
    float4 value = PG_GETARG_FLOAT4(0);

    if(!isfinite(value))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(float_as_numeric(value));
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_double);
Datum cast_as_decimal_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);

    if(!isfinite(value))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(double_as_numeric(value));
}


PG_FUNCTION_INFO_V1(cast_as_decimal_from_string);
Datum cast_as_decimal_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NULLABLE_DATUM(NumericGetDatum(decimal_parse(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value))));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
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

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_int, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_UNSIGNEDINT:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_long, Int64GetDatum(RdfBoxGetUInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_decimal_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_UNSIGNEDLONG:
            PG_RETURN_NUMERIC(unsignedlong_as_numeric(RdfBoxGetUInt64(box)));

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
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
