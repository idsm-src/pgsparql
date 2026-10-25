/**
 * @file
 * The SPARQL functions on dates and times: YEAR, MONTH, DAY, HOURS, MINUTES, SECONDS, TIMEZONE and TZ.
 *
 * A function with the argument kind `datetime` takes a zoneddatetime, or a timestamptz and an int4 time zone offset,
 * the kind `date` a zoneddate, or a date and an int4 time zone offset (see PG_GETARG_DATETIME() and
 * PG_GETARG_DATE()), and the kind `rdfbox` any RDF term, giving NULL for a term of another datatype. The fields are
 * those of the local time of the value, in its own time zone.
 *
 * @see https://www.w3.org/TR/sparql12-query/#func-date-time
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/datetime.h>
#include "pgsparql.h"
#include "call.h"
#include "types/date.h"
#include "types/datetime.h"
#include "types/timezone.h"
#include "rdfbox/rdfbox.h"


/**
 * Splits an xsd:dateTime into the fields of its local time: in its own time zone, or as it is if it has none.
 *
 * @param date the value
 * @param tm receives the fields
 * @param fsec receives the fraction of the second in microseconds
 */
static void datetime_decompose(ZonedDateTime *date, struct pg_tm *tm, fsec_t *fsec)
{
    // the exception should be never thrown unless there is some bug in the code
    if(!IS_VALID_TIMESTAMP(date->value) || !IS_VALID_TIMEZONE(date->zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dateTime out of range")));

    pg_tz *timezone = pg_tzset_offset(date->zone != ZONE_UNSPECIFIED ? -date->zone : 0);

    int tz;
    const char *tzn;

    if(timestamp2tm(date->value, &tz, tm, fsec, &tzn, timezone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dateTime out of range")));
}


/**
 * Splits an xsd:date into its year, month and day.
 *
 * @param date the value
 * @param tm receives the year, the month and the day; the other fields are not set
 */
static void date_decompose(ZonedDate *date, struct pg_tm *tm)
{
    // the exception should be never thrown unless there is some bug in the code
    if(!IS_VALID_DATE(date->value) || !IS_VALID_TIMEZONE(date->zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:date out of range")));

    j2date(date->value + POSTGRES_EPOCH_JDATE, &(tm->tm_year), &(tm->tm_mon), &(tm->tm_mday));
}


/**
 * Prints a time zone offset as the SPARQL function TZ does: `Z` for UTC, `+hh:mm` or `-hh:mm` for another offset
 * and the empty string for no time zone.
 *
 * @param zone the offset in seconds east of UTC, or #ZONE_UNSPECIFIED
 * @return the palloc'd text
 */
static text *timezone_to_text(int32 zone)
{
    char data[MAXDATELEN + 1];
    char *str = data;

    if(zone == 0)
    {
        *str++ = 'Z';
    }
    else if(zone != ZONE_UNSPECIFIED)
    {
        int value = abs(zone) / SECS_PER_MINUTE;
        int hours = value / MINS_PER_HOUR;
        int minutes = value - hours * MINS_PER_HOUR;

        *str++ = (zone >= 0 ? '+' : '-');
        str = pg_ultostr_zeropad(str, hours, 2);
        *str++ = ':';
        str = pg_ultostr_zeropad(str, minutes, 2);
    }

    *str = '\0';

    return cstring_to_text(data);
}


/**
 * The SPARQL function YEAR of an xsd:dateTime.
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the year as a decimal
 */
PG_FUNCTION_INFO_V1(year_datetime);
Datum year_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_year)));
}


/**
 * The SPARQL function YEAR of an xsd:date.
 *
 * @param fcinfo the zoneddate, or the date and the int4 time zone offset
 * @return the year as a decimal
 */
PG_FUNCTION_INFO_V1(year_date);
Datum year_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    struct pg_tm tm;
    date_decompose(&date, &tm);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_year)));
}


/**
 * The SPARQL function YEAR of an RDF term.
 *
 * @param fcinfo the rdfbox term
 * @return the year as a decimal, NULL if the term is neither an xsd:dateTime nor an xsd:date
 */
PG_FUNCTION_INFO_V1(year_rdfbox);
Datum year_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(year_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(year_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function MONTH of an xsd:dateTime.
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the month, from 1 to 12 as a decimal
 */
PG_FUNCTION_INFO_V1(month_datetime);
Datum month_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_mon)));
}


/**
 * The SPARQL function MONTH of an xsd:date.
 *
 * @param fcinfo the zoneddate, or the date and the int4 time zone offset
 * @return the month, from 1 to 12 as a decimal
 */
PG_FUNCTION_INFO_V1(month_date);
Datum month_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    struct pg_tm tm;
    date_decompose(&date, &tm);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_mon)));
}


/**
 * The SPARQL function MONTH of an RDF term.
 *
 * @param fcinfo the rdfbox term
 * @return the month as a decimal, NULL if the term is neither an xsd:dateTime nor an xsd:date
 */
PG_FUNCTION_INFO_V1(month_rdfbox);
Datum month_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(month_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(month_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function DAY of an xsd:dateTime.
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the day of the month as a decimal
 */
PG_FUNCTION_INFO_V1(day_datetime);
Datum day_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_mday)));
}


/**
 * The SPARQL function DAY of an xsd:date.
 *
 * @param fcinfo the zoneddate, or the date and the int4 time zone offset
 * @return the day of the month as a decimal
 */
PG_FUNCTION_INFO_V1(day_date);
Datum day_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    struct pg_tm tm;
    date_decompose(&date, &tm);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_mday)));
}


/**
 * The SPARQL function DAY of an RDF term.
 *
 * @param fcinfo the rdfbox term
 * @return the day of the month as a decimal, NULL if the term is neither an xsd:dateTime nor an xsd:date
 */
PG_FUNCTION_INFO_V1(day_rdfbox);
Datum day_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(day_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(day_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function HOURS of an xsd:dateTime.
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the hours, from 0 to 23 as a decimal
 */
PG_FUNCTION_INFO_V1(hours_datetime);
Datum hours_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_hour)));
}


/**
 * The SPARQL function HOURS of an RDF term.
 *
 * @param fcinfo the rdfbox term
 * @return the hours as a decimal, NULL if the term is not an xsd:dateTime
 */
PG_FUNCTION_INFO_V1(hours_rdfbox);
Datum hours_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(hours_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function MINUTES of an xsd:dateTime.
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the minutes as a decimal
 */
PG_FUNCTION_INFO_V1(minutes_datetime);
Datum minutes_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_min)));
}


/**
 * The SPARQL function MINUTES of an RDF term.
 *
 * @param fcinfo the rdfbox term
 * @return the minutes as a decimal, NULL if the term is not an xsd:dateTime
 */
PG_FUNCTION_INFO_V1(minutes_rdfbox);
Datum minutes_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(minutes_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function SECONDS of an xsd:dateTime.
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the seconds with their fraction as a decimal
 */
PG_FUNCTION_INFO_V1(seconds_datetime);
Datum seconds_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(float8_numeric, Float8GetDatum(tm.tm_sec + (double) fsec / USECS_PER_SEC)));
}


/**
 * The SPARQL function SECONDS of an RDF term.
 *
 * @param fcinfo the rdfbox term
 * @return the seconds with their fraction as a decimal, NULL if the term is not an xsd:dateTime
 */
PG_FUNCTION_INFO_V1(seconds_rdfbox);
Datum seconds_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(seconds_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function TIMEZONE of an xsd:dateTime.
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the time zone offset as an int8 xsd:dayTimeDuration in microseconds, NULL if the value has no time zone
 */
PG_FUNCTION_INFO_V1(timezone_datetime);
Datum timezone_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();

    if(date.zone == ZONE_UNSPECIFIED)
        PG_RETURN_NULL();

    PG_RETURN_INT64((int64) date.zone * USECS_PER_SEC);
}


/**
 * The SPARQL function TIMEZONE of an xsd:date.
 *
 * @param fcinfo the zoneddate, or the date and the int4 time zone offset
 * @return the time zone offset as an int8 xsd:dayTimeDuration in microseconds, NULL if the value has no time zone
 */
PG_FUNCTION_INFO_V1(timezone_date);
Datum timezone_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();

    if(date.zone == ZONE_UNSPECIFIED)
        PG_RETURN_NULL();

    PG_RETURN_INT64((int64) date.zone * USECS_PER_SEC);
}


/**
 * The SPARQL function TIMEZONE of an RDF term.
 *
 * @param fcinfo the rdfbox term
 * @return the time zone offset as an int8 xsd:dayTimeDuration in microseconds, NULL if the term is neither an
 *         xsd:dateTime nor an xsd:date or if it has no time zone
 */
PG_FUNCTION_INFO_V1(timezone_rdfbox);
Datum timezone_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(timezone_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(timezone_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function TZ of an xsd:dateTime, see timezone_to_text().
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the varchar time zone, the empty string if the value has none
 */
PG_FUNCTION_INFO_V1(tz_datetime);
Datum tz_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    PG_RETURN_TEXT_P(timezone_to_text(date.zone));
}


/**
 * The SPARQL function TZ of an xsd:date, see timezone_to_text().
 *
 * @param fcinfo the zoneddate, or the date and the int4 time zone offset
 * @return the varchar time zone, the empty string if the value has none
 */
PG_FUNCTION_INFO_V1(tz_date);
Datum tz_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    PG_RETURN_TEXT_P(timezone_to_text(date.zone));
}


/**
 * The SPARQL function TZ of an RDF term, see timezone_to_text().
 *
 * @param fcinfo the rdfbox term
 * @return the varchar time zone, the empty string if the value has none, NULL if the term is neither an
 *         xsd:dateTime nor an xsd:date
 */
PG_FUNCTION_INFO_V1(tz_rdfbox);
Datum tz_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(tz_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(tz_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        default:
            PG_RETURN_NULL();
    }
}
