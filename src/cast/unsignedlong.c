/*
 * https://www.w3.org/TR/xmlschema11-2/#unsignedLong
 * https://www.w3.org/TR/xpath-functions/#casting-to-integer
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "call.h"
#include "try-catch.h"
#include "constants.h"
#include "types/integer.h"
#include "types/unsignedlong.h"
#include "rdfbox/rdfbox.h"


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_boolean);
Datum cast_as_unsignedlong_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    Datum result = DirectFunctionCall1(int4_numeric, Int32GetDatum(value ? 1 : 0));
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_short);
Datum cast_as_unsignedlong_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);

    if(value < 0)
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(int2_numeric, Int16GetDatum(value));
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_int);
Datum cast_as_unsignedlong_from_int(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);

    if(value < 0)
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(int4_numeric, Int32GetDatum(value));
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_long);
Datum cast_as_unsignedlong_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);

    if(value < 0)
        PG_RETURN_NULL();

    Datum result = DirectFunctionCall1(int8_numeric, Int64GetDatum(value));
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_integer);
Datum cast_as_unsignedlong_from_integer(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);

    if(numeric_is_nan(value) || numeric_is_inf(value) || integer_sign(value) < 0)
        PG_RETURN_NULL();

    if(DatumGetInt32(DirectFunctionCall2(numeric_cmp, NumericGetDatum(value), NumericGetDatum(get_unsignedlong_max()))) > 0)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(value);
}


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_decimal);
Datum cast_as_unsignedlong_from_decimal(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    Numeric truncated = DatumGetNumeric(DirectFunctionCall2(numeric_trunc, value, Int32GetDatum(0)));

    if(numeric_is_nan(truncated) || numeric_is_inf(truncated) || integer_sign(truncated) < 0)
        PG_RETURN_NULL();

    if(DatumGetInt32(DirectFunctionCall2(numeric_cmp, NumericGetDatum(truncated), NumericGetDatum(get_unsignedlong_max()))) > 0)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(truncated);
}


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_float);
Datum cast_as_unsignedlong_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);

    /*
     * Converting a floating point value to an integer is undefined for NaN and
     * for anything outside the range of the target type, so the range has to be
     * checked before the conversion and not after it.  PG_UINT64_MAX is not
     * representable as a double, hence the strict comparison against 2^64; NaN
     * fails the test as well, every comparison with NaN being false.
     */
    if(!(value >= 0.0 && value < 18446744073709551616.0))
        PG_RETURN_NULL();

    if((uint64) value != truncf(value))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(unsignedlong_as_numeric((uint64) value));
}


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_double);
Datum cast_as_unsignedlong_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);

    /*
     * Converting a floating point value to an integer is undefined for NaN and
     * for anything outside the range of the target type, so the range has to be
     * checked before the conversion and not after it.  PG_UINT64_MAX is not
     * representable as a double, hence the strict comparison against 2^64; NaN
     * fails the test as well, every comparison with NaN being false.
     */
    if(!(value >= 0.0 && value < 18446744073709551616.0))
        PG_RETURN_NULL();

    if((uint64) value != trunc(value))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(unsignedlong_as_numeric((uint64) value));
}


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_string);
Datum cast_as_unsignedlong_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NULLABLE_DATUM(NumericGetDatum(unsignedlong_as_numeric(unsignedlong_parse(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)))));
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


PG_FUNCTION_INFO_V1(cast_as_unsignedlong_from_rdfbox);
Datum cast_as_unsignedlong_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_boolean, BoolGetDatum(RdfBoxGetBool(box))));

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_int, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_UNSIGNEDINT:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_long, Int64GetDatum(RdfBoxGetUInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_UNSIGNEDLONG:
            PG_RETURN_NUMERIC(unsignedlong_as_numeric(RdfBoxGetUInt64(box)));

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_integer, NumericGetDatum(RdfBoxGetNumeric(box))));

        case XSD_DECIMAL:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_decimal, NumericGetDatum(RdfBoxGetNumeric(box))));

        case XSD_FLOAT:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_float, Float4GetDatum(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_double, Float8GetDatum(RdfBoxGetFloat8(box))));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_unsignedlong_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}
