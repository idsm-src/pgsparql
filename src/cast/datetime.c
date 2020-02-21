/*
 * https://www.w3.org/TR/xmlschema11-2/#dateTime
 * https://www.w3.org/TR/xpath-functions/#casting-to-datetimes
 */
#include <postgres.h>
#include <utils/builtins.h>
#include "date/datetime.h"
#include "date/date.h"
#include "date/timezone.h"
#include "rdfbox.h"
#include "call.h"
#include "try-catch.h"


PG_FUNCTION_INFO_V1(cast_as_datetime_from_date);
Datum cast_as_datetime_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) :
            (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) };

    // err:FODT0001, Overflow/underflow in date/time operation
    if(date.value < MIN_TIMESTAMP / USECS_PER_DAY || date.value >= END_TIMESTAMP / USECS_PER_DAY)
        PG_RETURN_NULL();

    TimestampTz value = (TimestampTz) date.value * USECS_PER_DAY;

    if(date.zone != ZONE_UNSPECIFIED)
        value -= date.zone * USECS_PER_SEC;

    // err:FODT0001, Overflow/underflow in date/time operation
    if(!IS_VALID_TIMESTAMP(value))
        PG_RETURN_NULL();

    ZonedDateTime *result = palloc0(sizeof(ZonedDateTime));
    result->value = value;
    result->zone = date.zone;

    PG_RETURN_ZONEDDATETIME_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_plain_datetime_from_date);
Datum cast_as_plain_datetime_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) :
            (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) };

    // err:FODT0001, Overflow/underflow in date/time operation
    if(date.value < MIN_TIMESTAMP / USECS_PER_DAY || date.value >= END_TIMESTAMP / USECS_PER_DAY)
        PG_RETURN_NULL();

    TimestampTz value = (TimestampTz) date.value * USECS_PER_DAY;

    if(date.zone != ZONE_UNSPECIFIED)
        value -= date.zone * USECS_PER_SEC;

    // err:FODT0001, Overflow/underflow in date/time operation
    if(!IS_VALID_TIMESTAMP(value))
        PG_RETURN_NULL();

    PG_RETURN_TIMESTAMPTZ(value);
}


PG_FUNCTION_INFO_V1(cast_as_datetime_from_string);
Datum cast_as_datetime_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    bool isnull = false;
    Datum result;

    char *cstring = text_to_cstring(value);

    PG_TRY_EX();
    {
        result = DirectFunctionCall1(zoneddatetime_input, CStringGetDatum(cstring));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        isnull = true;
    }
    PG_END_TRY_EX();

    pfree(cstring);
    PG_FREE_IF_COPY(value, 0);

    if(isnull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_datetime_from_rdfbox);
Datum cast_as_datetime_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isnull = false };

    switch(box->type)
    {
        case XSD_DATETIME:
        {
            ZonedDateTime *copy = palloc0(sizeof(ZonedDateTime));
            *copy = ((RdfBoxDateTime *) box)->value;
            result.value = ZonedDateTimeGetDatum(copy);
        }
        break;

        case XSD_DATE:
            result = NullableFunctionCall1(cast_as_datetime_from_date, ZonedDateGetDatum(((RdfBoxDate *) box)->value));
            break;

        case XSD_STRING:
            result = NullableFunctionCall1(cast_as_datetime_from_string, PointerGetDatum(((RdfBoxString *) box)->value));
            break;

        default:
            result.isnull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isnull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.value);
}


PG_FUNCTION_INFO_V1(cast_as_plain_datetime_from_rdfbox);
Datum cast_as_plain_datetime_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isnull = false };

    switch(box->type)
    {
        case XSD_DATETIME:
            result.value = TimestampTzGetDatum(((RdfBoxDateTime *) box)->value.value);
            break;

        case XSD_DATE:
            result = NullableFunctionCall1(cast_as_plain_datetime_from_date, ZonedDateGetDatum(((RdfBoxDate *) box)->value));
            break;

        default:
            result.isnull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isnull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.value);
}
