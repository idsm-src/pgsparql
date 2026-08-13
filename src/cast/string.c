/*
 * https://www.w3.org/TR/xmlschema11-2/#string
 * https://www.w3.org/TR/xpath-functions/#casting-to-string
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
#include "rdfbox/rdfbox.h"


PG_FUNCTION_INFO_V1(cast_as_string_from_boolean);
Datum cast_as_string_from_boolean(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(boolean_as_varchar(PG_GETARG_BOOL(0)));
}


PG_FUNCTION_INFO_V1(cast_as_string_from_short);
Datum cast_as_string_from_short(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(short_as_varchar(PG_GETARG_INT16(0)));
}


PG_FUNCTION_INFO_V1(cast_as_string_from_int);
Datum cast_as_string_from_int(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(int_as_varchar(PG_GETARG_INT32(0)));
}


PG_FUNCTION_INFO_V1(cast_as_string_from_long);
Datum cast_as_string_from_long(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(long_as_varchar(PG_GETARG_INT64(0)));
}


PG_FUNCTION_INFO_V1(cast_as_string_from_decimal);
Datum cast_as_string_from_decimal(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(cstring_to_text(numeric_normalize(PG_GETARG_NUMERIC(0))));
}


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


PG_FUNCTION_INFO_V1(cast_as_string_from_datetime);
Datum cast_as_string_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime value = PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) : (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) };
    PG_RETURN_VARCHAR_P(datetime_as_varchar(&value));
}


PG_FUNCTION_INFO_V1(cast_as_string_from_date);
Datum cast_as_string_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate value = PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) : (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) };
    PG_RETURN_VARCHAR_P(date_as_varchar(value));
}


PG_FUNCTION_INFO_V1(cast_as_string_from_daytimeduration);
Datum cast_as_string_from_daytimeduration(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(daytimeduration_as_varchar(PG_GETARG_INT64(0)));
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
