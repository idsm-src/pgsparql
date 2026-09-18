/*
 * https://www.w3.org/TR/xmlschema11-2/#int
 * https://www.w3.org/TR/xpath-functions/#casting-to-integer
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "call.h"
#include "try-catch.h"
#include "types/int.h"
#include "rdfbox/rdfbox.h"


PG_FUNCTION_INFO_V1(cast_as_int_from_boolean);
Datum cast_as_int_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    PG_RETURN_INT32(value ? 1 : 0);
}


PG_FUNCTION_INFO_V1(cast_as_int_from_short);
Datum cast_as_int_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    PG_RETURN_INT32(value);
}


/* xsd:unsignedShort is represented by int4, so its values are kept as they are */
PG_FUNCTION_INFO_V1(cast_as_int_from_unsignedshort);
Datum cast_as_int_from_unsignedshort(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    PG_RETURN_INT32(value);
}


PG_FUNCTION_INFO_V1(cast_as_int_from_long);
Datum cast_as_int_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);

    if((int32) value != value)
        PG_RETURN_NULL();

    PG_RETURN_INT32((int32) value);
}


PG_FUNCTION_INFO_V1(cast_as_int_from_integer);
Datum cast_as_int_from_integer(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall1(numeric_int4, value);
    }
    PG_CATCH_EX();
    {
        //NOTE: proper SPARQL to SQL translation should never cause the ERRCODE_FEATURE_NOT_SUPPORTED exception

        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE && sqlerrcode != ERRCODE_FEATURE_NOT_SUPPORTED)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


PG_FUNCTION_INFO_V1(cast_as_int_from_decimal);
Datum cast_as_int_from_decimal(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    NullableDatum result = NULL_DATUM;

    Datum truncated = DirectFunctionCall2(numeric_trunc, value, Int32GetDatum(0));

    PG_TRY_EX();
    {
        result = NullableFunctionCall1(numeric_int4, truncated);
    }
    PG_CATCH_EX();
    {
        //NOTE: proper SPARQL to SQL translation should never cause the ERRCODE_FEATURE_NOT_SUPPORTED exception

        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE && sqlerrcode != ERRCODE_FEATURE_NOT_SUPPORTED)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


PG_FUNCTION_INFO_V1(cast_as_int_from_float);
Datum cast_as_int_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);

    /*
     * Converting a floating point value to an integer is undefined for NaN and
     * for anything outside the range of the target type, so the range has to be
     * checked before the conversion and not after it.  Both bounds are exactly
     * representable as a double, so the test is exact; NaN fails it as well,
     * every comparison with NaN being false.
     */
    if(!(value >= -2147483648.0 && value <= 2147483647.0))
        PG_RETURN_NULL();

    if((int32) value != truncf(value))
        PG_RETURN_NULL();

    PG_RETURN_INT32((int32) value);
}


PG_FUNCTION_INFO_V1(cast_as_int_from_double);
Datum cast_as_int_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);

    /*
     * Converting a floating point value to an integer is undefined for NaN and
     * for anything outside the range of the target type, so the range has to be
     * checked before the conversion and not after it.  Both bounds are exactly
     * representable as a double, so the test is exact; NaN fails it as well,
     * every comparison with NaN being false.
     */
    if(!(value >= -2147483648.0 && value <= 2147483647.0))
        PG_RETURN_NULL();

    if((int32) value != trunc(value))
        PG_RETURN_NULL();

    PG_RETURN_INT32((int32) value);
}


PG_FUNCTION_INFO_V1(cast_as_int_from_string);
Datum cast_as_int_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NULLABLE_DATUM(Int32GetDatum(int_parse(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value))));
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


PG_FUNCTION_INFO_V1(cast_as_int_from_rdfbox);
Datum cast_as_int_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_boolean, BoolGetDatum(RdfBoxGetBool(box))));

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            PG_RETURN_INT32(RdfBoxGetInt32(box));

        case XSD_UNSIGNEDINT:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_long, Int64GetDatum(RdfBoxGetUInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_UNSIGNEDLONG:
        {
            uint64 value = RdfBoxGetUInt64(box);

            if(value > PG_INT32_MAX)
                PG_RETURN_NULL();

            PG_RETURN_INT32((int32) value);
        }

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_integer, NumericGetDatum(RdfBoxGetNumeric(box))));

        case XSD_DECIMAL:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_decimal, NumericGetDatum(RdfBoxGetNumeric(box))));

        case XSD_FLOAT:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_float, Float4GetDatum(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_double, Float8GetDatum(RdfBoxGetFloat8(box))));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_int_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}
