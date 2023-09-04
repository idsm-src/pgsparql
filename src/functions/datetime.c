#include <postgres.h>
#include <utils/builtins.h>
#include <utils/datetime.h>
#include "pgsparql.h"
#include "call.h"
#include "types/date.h"
#include "types/datetime.h"
#include "types/timezone.h"
#include "rdfbox/rdfbox.h"


static void datetime_decompose(ZonedDateTime *date, struct pg_tm *tm, fsec_t *fsec)
{
    // the exception should be never thrown unless there is some bug in the code
    if(!IS_VALID_TIMESTAMP(date->value) || !IS_VALID_TIMEZONE(date->zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddatetime out of range")));

    pg_tz *timezone = pg_tzset_offset(date->zone != ZONE_UNSPECIFIED ? -date->zone : 0);

    int tz;
    const char *tzn;

    if(timestamp2tm(date->value, &tz, tm, fsec, &tzn, timezone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddatetime out of range")));
}


static void date_decompose(ZonedDate *date, struct pg_tm *tm)
{
    // the exception should be never thrown unless there is some bug in the code
    if(!IS_VALID_DATE(date->value) || !IS_VALID_TIMEZONE(date->zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddate out of range")));

    j2date(date->value + POSTGRES_EPOCH_JDATE, &(tm->tm_year), &(tm->tm_mon), &(tm->tm_mday));
}


static text *timezone_to_text(int64 zone)
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


PG_FUNCTION_INFO_V1(year_datetime);
Datum year_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_year)));
}


PG_FUNCTION_INFO_V1(year_date);
Datum year_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    struct pg_tm tm;
    date_decompose(&date, &tm);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_year)));
}


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


PG_FUNCTION_INFO_V1(month_datetime);
Datum month_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_mon)));
}


PG_FUNCTION_INFO_V1(month_date);
Datum month_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    struct pg_tm tm;
    date_decompose(&date, &tm);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_mon)));
}


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


PG_FUNCTION_INFO_V1(day_datetime);
Datum day_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_mday)));
}


PG_FUNCTION_INFO_V1(day_date);
Datum day_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    struct pg_tm tm;
    date_decompose(&date, &tm);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_mday)));
}


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


PG_FUNCTION_INFO_V1(hours_datetime);
Datum hours_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_hour)));
}


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


PG_FUNCTION_INFO_V1(minutes_datetime);
Datum minutes_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(int4_numeric, Int32GetDatum(tm.tm_min)));
}


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


PG_FUNCTION_INFO_V1(seconds_datetime);
Datum seconds_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    struct pg_tm tm;
    fsec_t fsec;
    datetime_decompose(&date, &tm, &fsec);
    PG_RETURN_DATUM(DirectFunctionCall1(float8_numeric, Float8GetDatum(tm.tm_sec + (double) fsec / USECS_PER_SEC)));
}


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


PG_FUNCTION_INFO_V1(timezone_datetime);
Datum timezone_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();

    if(date.zone == ZONE_UNSPECIFIED)
        PG_RETURN_NULL();

    PG_RETURN_INT64((int64) date.zone * USECS_PER_SEC);
}


PG_FUNCTION_INFO_V1(timezone_date);
Datum timezone_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();

    if(date.zone == ZONE_UNSPECIFIED)
        PG_RETURN_NULL();

    PG_RETURN_INT64((int64) date.zone * USECS_PER_SEC);
}


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


PG_FUNCTION_INFO_V1(tz_datetime);
Datum tz_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_GETARG_DATETIME();
    PG_RETURN_TEXT_P(timezone_to_text(date.zone));
}


PG_FUNCTION_INFO_V1(tz_date);
Datum tz_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    PG_RETURN_TEXT_P(timezone_to_text(date.zone));
}


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
