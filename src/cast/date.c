/*
 * https://www.w3.org/TR/xmlschema11-2/#date
 * https://www.w3.org/TR/xpath-functions/#casting-to-datetimes
 */
#include <postgres.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include "call.h"
#include "try-catch.h"
#include "rdfbox/rdfbox.h"
#include "types/date.h"
#include "types/datetime.h"
#include "types/timezone.h"


PG_FUNCTION_INFO_V1(cast_as_date_from_datetime);
Datum cast_as_date_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime datetime = PG_GETARG_DATETIME();
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        TimestampTz value = datetime.value;

        if(datetime.zone != ZONE_UNSPECIFIED)
        {
            value += datetime.zone * USECS_PER_SEC;

            if((datetime.value > 0 && datetime.zone > 0 && value < 0) || (datetime.value < 0 && datetime.zone < 0 && value > 0))
                ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)));
        }

        DateADT date = DatumGetDateADT(DirectFunctionCall1(timestamp_date, TimestampTzGetDatum(value)));
        result.value = ZonedDateGetDatum((ZonedDate) { .value = date, .zone = datetime.zone });
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result.isnull = true;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


PG_FUNCTION_INFO_V1(cast_as_date_from_string);
Datum cast_as_date_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_PP(0);
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        result = NullableFunctionCall1(zoneddate_input, CStringGetDatum(text_to_cstring(value)));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result.isnull = true;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


PG_FUNCTION_INFO_V1(cast_as_date_from_rdfbox);
Datum cast_as_date_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(cast_as_date_from_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN_ZONEDDATE(RdfBoxGetZonedDate(box));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_date_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(cast_as_plain_date_from_datetime);
Datum cast_as_plain_date_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime datetime = PG_GETARG_DATETIME();
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        TimestampTz value = datetime.value;

        if(datetime.zone != ZONE_UNSPECIFIED)
        {
            value += datetime.zone * USECS_PER_SEC;

            if((datetime.value > 0 && datetime.zone > 0 && value < 0) || (datetime.value < 0 && datetime.zone < 0 && value > 0))
                ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)));
        }

        result.value = DirectFunctionCall1(timestamp_date, TimestampTzGetDatum(value));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result.isnull = true;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


PG_FUNCTION_INFO_V1(cast_as_plain_date_from_rdfbox);
Datum cast_as_plain_date_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(cast_as_plain_date_from_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN_DATEADT(RdfBoxGetZonedDate(box).value);

        default:
            PG_RETURN_NULL();
    }
}
