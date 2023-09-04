/*
 * https://www.w3.org/TR/xmlschema11-2/#string
 * https://www.w3.org/TR/xpath-functions/#casting-to-string
 */
#include <postgres.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "call.h"
#include "types/float.h"
#include "types/double.h"
#include "types/daytimeduration.h"
#include "rdfbox/rdfbox.h"


PG_FUNCTION_INFO_V1(cast_as_string_from_boolean);
Datum cast_as_string_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    char *string = value ? "true" : "false";
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_short);
Datum cast_as_string_from_short(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    char *string = DatumGetCString(DirectFunctionCall1(int2out, value));
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_int);
Datum cast_as_string_from_int(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    char *string = DatumGetCString(DirectFunctionCall1(int4out, value));
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_long);
Datum cast_as_string_from_long(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    char *string = DatumGetCString(DirectFunctionCall1(int8out, value));
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_decimal);
Datum cast_as_string_from_decimal(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    char *string = numeric_normalize(value);
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_float);
Datum cast_as_string_from_float(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    char *string = DatumGetCString(DirectFunctionCall1(float_output, value));
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_double);
Datum cast_as_string_from_double(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    char *string = DatumGetCString(DirectFunctionCall1(double_output, value));
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_datetime);
Datum cast_as_string_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime value = PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) :
            (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) };
    char *string = DatumGetCString(DirectFunctionCall1(zoneddatetime_output, ZonedDateTimeGetDatum(&value)));
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_date);
Datum cast_as_string_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate value = PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) :
            (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) };
    char *string = DatumGetCString(DirectFunctionCall1(zoneddate_output, ZonedDateGetDatum(value)));
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_daytimeduration);
Datum cast_as_string_from_daytimeduration(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    char *string = DatumGetCString(DirectFunctionCall1(daytimeduration_output, value));
    Datum result = CStringGetTextDatum(string);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_string_from_rdfbox);
Datum cast_as_string_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_boolean, BoolGetDatum(RdfBoxGetBool(box))));

        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_INT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_int, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_INTEGER:
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
