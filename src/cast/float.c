/**
 * @file
 * The casts to xsd:float, whose values are held by a float4.
 *
 * A malformed lexical form gives NULL; the other values can always be cast, those beyond the range of xsd:float
 * becoming infinities.
 *
 * @see https://www.w3.org/TR/xmlschema11-2/#float
 * @see https://www.w3.org/TR/xpath-functions/#casting-to-float
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "call.h"
#include "try-catch.h"
#include "types/float.h"
#include "rdfbox/rdfbox.h"


/**
 * Casts an xsd:boolean to xsd:float.
 *
 * @param fcinfo the bool to cast
 * @return the float4 1 for true and 0 for false
 */
PG_FUNCTION_INFO_V1(cast_as_float_from_boolean);
Datum cast_as_float_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    PG_RETURN_FLOAT4(value ? 1.0f : 0.0f);
}


/**
 * Casts an xsd:short to xsd:float; also bound to @c cast_as_float_from_byte(int2) and
 * @c cast_as_float_from_unsignedbyte(int2).
 *
 * @param fcinfo the int2 to cast
 * @return the float4
 */
PG_FUNCTION_INFO_V1(cast_as_float_from_short);
Datum cast_as_float_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    PG_RETURN_FLOAT4(value);
}


/**
 * Casts an xsd:int to xsd:float; also bound to @c cast_as_float_from_unsignedshort(int4).
 *
 * @param fcinfo the int4 to cast
 * @return the float4, rounded to the nearest float
 */
PG_FUNCTION_INFO_V1(cast_as_float_from_int);
Datum cast_as_float_from_int(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    PG_RETURN_FLOAT4(value);
}


/**
 * Casts an xsd:long to xsd:float; also bound to @c cast_as_float_from_unsignedint(int8).
 *
 * @param fcinfo the int8 to cast
 * @return the float4, rounded to the nearest float
 */
PG_FUNCTION_INFO_V1(cast_as_float_from_long);
Datum cast_as_float_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    PG_RETURN_FLOAT4(value);
}


/**
 * Casts an xsd:decimal to xsd:float; also bound to @c cast_as_float_from_unsignedlong(decimal) and to the casts from
 * xsd:integer and its subtypes.
 *
 * @param fcinfo the numeric to cast
 * @return the float4 nearest to the value, an infinity if the value is beyond the range of xsd:float
 */
PG_FUNCTION_INFO_V1(cast_as_float_from_decimal);
Datum cast_as_float_from_decimal(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    char *string = DatumGetCString(DirectFunctionCall1(numeric_out, value));
    float4 result = strtof(string, NULL);
    PG_RETURN_FLOAT4(result);
}


/**
 * Casts an xsd:double to xsd:float.
 *
 * @param fcinfo the float8 to cast
 * @return the float4 nearest to the value, an infinity if the value is beyond the range of xsd:float; NaN and the
 *         infinities are kept
 */
PG_FUNCTION_INFO_V1(cast_as_float_from_double);
Datum cast_as_float_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);
    PG_RETURN_FLOAT4(value);
}


/**
 * Casts an xsd:string to xsd:float by parsing it as a lexical form of xsd:float, which includes `NaN`, `INF`, `+INF`
 * and `-INF`.
 *
 * @param fcinfo the varchar to cast
 * @return the float4, NULL if the string is not a lexical form of xsd:float
 */
PG_FUNCTION_INFO_V1(cast_as_float_from_string);
Datum cast_as_float_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NULLABLE_DATUM(Float4GetDatum(float_parse(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value))));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


/**
 * Casts an RDF term to xsd:float, the SPARQL function `xsd:float()`.
 *
 * @param fcinfo the rdfbox to cast
 * @return the float4, NULL if the term is not an xsd:boolean, a numeric literal or an xsd:string, or if the string is
 *         not a lexical form of xsd:float
 */
PG_FUNCTION_INFO_V1(cast_as_float_from_rdfbox);
Datum cast_as_float_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN(NullableFunctionCall1(cast_as_float_from_boolean, BoolGetDatum(RdfBoxGetBool(box))));

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_float_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            PG_RETURN(NullableFunctionCall1(cast_as_float_from_int, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_UNSIGNEDINT:
            PG_RETURN(NullableFunctionCall1(cast_as_float_from_long, Int64GetDatum(RdfBoxGetUInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_float_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_UNSIGNEDLONG:
            PG_RETURN_FLOAT4((float4) RdfBoxGetUInt64(box));

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        case XSD_DECIMAL:
            PG_RETURN(NullableFunctionCall1(cast_as_float_from_decimal, NumericGetDatum(RdfBoxGetNumeric(box))));

        case XSD_FLOAT:
            PG_RETURN_FLOAT4(RdfBoxGetFloat4(box));

        case XSD_DOUBLE:
            PG_RETURN(NullableFunctionCall1(cast_as_float_from_double, Float8GetDatum(RdfBoxGetFloat8(box))));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_float_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}
