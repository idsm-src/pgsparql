/**
 * @file
 * The casts to xsd:string, which print a value in the form that XPath prescribes for the cast, mostly the canonical
 * lexical form of its datatype.
 *
 * @see https://www.w3.org/TR/xmlschema11-2/#string
 * @see https://www.w3.org/TR/xpath-functions/#casting-to-string
 */
#include <postgres.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "ryu/ryu.h"
#include "call.h"
#include "types/boolean.h"
#include "types/short.h"
#include "types/int.h"
#include "types/long.h"
#include "types/float.h"
#include "types/double.h"
#include "types/daytimeduration.h"
#include "types/unsignedlong.h"
#include "rdfbox/rdfbox.h"


/**
 * Casts an xsd:boolean to xsd:string.
 *
 * @param fcinfo the bool to cast
 * @return the varchar `true` or `false`
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_boolean);
Datum cast_as_string_from_boolean(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(boolean_as_varchar(PG_GETARG_BOOL(0)));
}


/**
 * Casts an xsd:short to xsd:string; also bound to @c cast_as_string_from_byte(int2) and
 * @c cast_as_string_from_unsignedbyte(int2).
 *
 * @param fcinfo the int2 to cast
 * @return the canonical lexical form of the value as a varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_short);
Datum cast_as_string_from_short(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(short_as_varchar(PG_GETARG_INT16(0)));
}


/**
 * Casts an xsd:int to xsd:string; also bound to @c cast_as_string_from_unsignedshort(int4).
 *
 * @param fcinfo the int4 to cast
 * @return the canonical lexical form of the value as a varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_int);
Datum cast_as_string_from_int(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(int_as_varchar(PG_GETARG_INT32(0)));
}


/**
 * Casts an xsd:long to xsd:string; also bound to @c cast_as_string_from_unsignedint(int8).
 *
 * @param fcinfo the int8 to cast
 * @return the canonical lexical form of the value as a varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_long);
Datum cast_as_string_from_long(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(long_as_varchar(PG_GETARG_INT64(0)));
}


/**
 * Casts an xsd:decimal to xsd:string; also bound to the casts from xsd:unsignedLong, xsd:integer and the subtypes of
 * xsd:integer.
 *
 * The trailing zeros of the fraction are dropped and an integral value is printed without a decimal point, as XPath
 * prescribes.
 *
 * @param fcinfo the numeric to cast
 * @return the varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_decimal);
Datum cast_as_string_from_decimal(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(cstring_to_text(numeric_normalize(PG_GETARG_NUMERIC(0))));
}


/**
 * Casts an xsd:float to xsd:string.
 *
 * The value is printed in the shortest form that reads back exactly, in the decimal notation if it is zero or its
 * absolute value is at least 0.000001 and less than 1000000, in the scientific notation otherwise, as XPath
 * prescribes; the special values are printed as `NaN`, `INF` and `-INF`.
 *
 * @param fcinfo the float4 to cast
 * @return the varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_float);
Datum cast_as_string_from_float(PG_FUNCTION_ARGS)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + FLOAT_MAXLEN);
    float4 value = PG_GETARG_FLOAT4(0);
    float4 abs = fabsf(value);

    int size = f2s_buffered_n(value, VARDATA(result), abs != 0 && (abs < 0.000001f || abs >= 1000000.0f));
    SET_VARSIZE(result, VARHDRSZ + size);
    PG_RETURN_VARCHAR_P(result);
}


/**
 * Casts an xsd:double to xsd:string.
 *
 * The value is printed in the shortest form that reads back exactly, in the decimal notation if it is zero or its
 * absolute value is at least 0.000001 and less than 1000000, in the scientific notation otherwise, as XPath
 * prescribes; the special values are printed as `NaN`, `INF` and `-INF`.
 *
 * @param fcinfo the float8 to cast
 * @return the varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_double);
Datum cast_as_string_from_double(PG_FUNCTION_ARGS)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + DOUBLE_MAXLEN);
    float8 value = PG_GETARG_FLOAT8(0);
    float8 abs = fabs(value);

    int size = d2s_buffered_n(value, VARDATA(result), abs != 0 && (abs < 0.000001 || abs >= 1000000.0));
    SET_VARSIZE(result, VARHDRSZ + size);
    PG_RETURN_VARCHAR_P(result);
}


/**
 * Casts an xsd:dateTime to xsd:string.
 *
 * @param fcinfo either the zoneddatetime to cast, or its timestamptz and its time zone as an int4 offset in seconds
 *               (#ZONE_UNSPECIFIED for none); both overloads of @c cast_as_string_from_datetime are bound here
 * @return the lexical form of the value in its own time zone as a varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_datetime);
Datum cast_as_string_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime value = PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) : (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) };
    PG_RETURN_VARCHAR_P(datetime_as_varchar(&value));
}


/**
 * Casts an xsd:date to xsd:string.
 *
 * @param fcinfo either the zoneddate to cast, or its date and its time zone as an int4 offset in seconds
 *               (#ZONE_UNSPECIFIED for none); both overloads of @c cast_as_string_from_date are bound here
 * @return the lexical form of the value as a varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_date);
Datum cast_as_string_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate value = PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) : (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) };
    PG_RETURN_VARCHAR_P(date_as_varchar(value));
}


/**
 * Casts an xsd:dayTimeDuration to xsd:string.
 *
 * @param fcinfo the int8 duration in microseconds
 * @return the canonical lexical form of the duration as a varchar
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_daytimeduration);
Datum cast_as_string_from_daytimeduration(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(daytimeduration_as_varchar(PG_GETARG_INT64(0)));
}


/**
 * Casts an RDF term to xsd:string, the SPARQL function `xsd:string()`.
 *
 * A literal of a handled datatype is printed from its value as the cast from that datatype does, so a non-canonical
 * lexical form kept in the box is not used; an xsd:string and an IRI give their text.
 *
 * @param fcinfo the rdfbox to cast
 * @return the varchar, NULL for a language-tagged string, a user literal, a literal of an unsupported datatype, a blank
 *         node or a triple term
 */
PG_FUNCTION_INFO_V1(cast_as_string_from_rdfbox);
Datum cast_as_string_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_boolean, BoolGetDatum(RdfBoxGetBool(box))));

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_int, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_UNSIGNEDINT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_long, Int64GetDatum(RdfBoxGetUInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_UNSIGNEDLONG:
            PG_RETURN_VARCHAR_P(unsignedlong_as_varchar(RdfBoxGetUInt64(box)));

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        case XSD_DECIMAL:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_decimal, NumericGetDatum(RdfBoxGetNumeric(box))));

        case XSD_FLOAT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_float, Float4GetDatum(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_double, Float8GetDatum(RdfBoxGetFloat8(box))));

        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        case XSD_DAYTIMEDURATION:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_daytimeduration, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_STRING:
        case IRI:
            PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));

        default:
            PG_RETURN_NULL();
    }
}
