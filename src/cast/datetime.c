/*
 * https://www.w3.org/TR/xmlschema11-2/#dateTime
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


PG_FUNCTION_INFO_V1(cast_as_datetime_from_date);
Datum cast_as_datetime_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        TimestampTz timestamp = DatumGetTimestampTz(DirectFunctionCall1(date_timestamptz, DateADTGetDatum(date.value)));

        ZonedDateTime *datetime = palloc0(sizeof(ZonedDateTime));
        datetime->value = timestamp;
        datetime->zone = date.zone;

        if(date.zone != ZONE_UNSPECIFIED)
        {
            datetime->value -= date.zone * USECS_PER_SEC;

            if((timestamp > 0 && date.zone < 0 && datetime->value < 0) || (timestamp < 0 && date.zone > 0 && datetime->value > 0))
                ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)));
        }

        result.value = ZonedDateTimeGetDatum(datetime);
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


PG_FUNCTION_INFO_V1(cast_as_datetime_from_string);
Datum cast_as_datetime_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_PP(0);
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        result = NullableFunctionCall1(zoneddatetime_input, CStringGetDatum(text_to_cstring(value)));
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


PG_FUNCTION_INFO_V1(cast_as_datetime_from_rdfbox);
Datum cast_as_datetime_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN_ZONEDDATETIME_P(RdfBoxGetZonedDateTime(box));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(cast_as_datetime_from_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_datetime_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(cast_as_plain_datetime_from_date);
Datum cast_as_plain_datetime_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        TimestampTz timestamp = DatumGetTimestampTz(DirectFunctionCall1(date_timestamptz, DateADTGetDatum(date.value)));

        TimestampTz datetime = timestamp;

        if(date.zone != ZONE_UNSPECIFIED)
        {
            datetime -= date.zone * USECS_PER_SEC;

            if((timestamp > 0 && date.zone < 0 && datetime < 0) || (timestamp < 0 && date.zone > 0 && datetime > 0))
                ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)));
        }

        result.value = TimestampTzGetDatum(datetime);
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


PG_FUNCTION_INFO_V1(cast_as_plain_datetime_from_rdfbox);
Datum cast_as_plain_datetime_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN_TIMESTAMPTZ(RdfBoxGetZonedDateTime(box)->value);

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(cast_as_plain_datetime_from_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        default:
            PG_RETURN_NULL();
    }
}
