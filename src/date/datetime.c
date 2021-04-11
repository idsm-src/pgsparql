#include <postgres.h>
#include <miscadmin.h>
#include <utils/datetime.h>
#include <utils/builtins.h>
#include "pgsparql.h"
#include "datetime.h"
#include "timezone.h"


static void read_input_digits(char **input, int requiredLength, bool exactLength, bool openingZero)
{
    char *str = *input;

    while(*str >= '0' && *str <= '9')
        str++;

    if(str - *input < requiredLength || exactLength && str - *input > requiredLength)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddatetime literal")));

    if(openingZero && str - *input > requiredLength && **input == '0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddatetime literal")));

    *input = str;
}


static void read_input_char(char **input, char requiredChar)
{
    if(**input != requiredChar)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddatetime literal")));

    (*input)++;
}


PG_FUNCTION_INFO_V1(zoneddatetime_input);
Datum zoneddatetime_input(PG_FUNCTION_ARGS)
{
    char *value = PG_GETARG_CSTRING(0);


    /* parse input */
    char *input = value;

    while(*input == ' ')
        input++;

    char *begin = input;

    if(*input == '-')
        input++;

    char *date = input;

    read_input_digits(&input, 4, false, true);
    read_input_char(&input, '-');
    read_input_digits(&input, 2, true, true);
    read_input_char(&input, '-');
    read_input_digits(&input, 2, true, true);
    read_input_char(&input, 'T');

    char *time = input;

    read_input_digits(&input, 2, true, true);
    read_input_char(&input, ':');
    read_input_digits(&input, 2, true, true);
    read_input_char(&input, ':');
    read_input_digits(&input, 2, true, true);

    if(*input == '.')
    {
        input++;
        read_input_digits(&input, 1, false, false);

        if(input[-1] == '0')
            elog(ERROR, "unexpected");
    }

    char *zone = input;

    if(*input == 'Z')
    {
        input++;
    }
    else if(*input == '+' || *input == '-')
    {
        input++;

        read_input_digits(&input, 2, true, true);
        read_input_char(&input, ':');
        read_input_digits(&input, 2, true, true);
    }

    char *end = input;

    while(*input == ' ')
        input++;

    read_input_char(&input, '\0');


    /* truncate the date string to ensure that the year field will not overflow in DecodeDateTime */
    int maxDateLength = sizeof("999999999-xx-xx") - 1;
    int dateLenght = time - date - 1;
    bool yearOverflow = false;

    if(dateLenght > maxDateLength)
    {
        date += dateLenght - maxDateLength;
        yearOverflow = true;
    }


    /* convert input */
    bool hasZone = *zone != '\0' && *zone != ' ';

    char *field[4];
    int ftype[4];

    field[0] = pnstrdup(date, time - date - 1);
    ftype[0] = DTK_DATE;

    field[1] = pnstrdup(time, Min(zone - time, 15));   // use limit 15 to truncate field to microseconds
    ftype[1] = DTK_TIME;

    field[2] = (!hasZone || *zone == 'Z') ? "z" : pnstrdup(zone, end - zone);
    ftype[2] = (!hasZone || *zone == 'Z') ? DTK_STRING : DTK_TZ;

    field[3] = begin != date ? "bc" : "ad";
    ftype[3] = DTK_STRING;


    /* encode date */
    int dtype;
    struct pg_tm tm;
    fsec_t fsec;
    int tz;

    int derr = DecodeDateTime(field, ftype, 4, &dtype, &tm, &fsec, &tz);

    PG_FREE_IF_COPY(value, 0);
    pfree(field[0]);
    pfree(field[1]);

    if(*field[2] != 'z')
        pfree(field[2]);


    if(derr != 0 || dtype != DTK_DATE)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddatetime literal")));

    if(hasZone && (tz % SECS_PER_MINUTE || tz > ZONE_MAX * SECS_PER_MINUTE || tz < ZONE_MIN * SECS_PER_MINUTE))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddatetime literal")));

    ZonedDateTime *result = palloc0(sizeof(ZonedDateTime));

    // err:FODT0001, Overflow/underflow in date/time operation
    if(yearOverflow || tm2timestamp(&tm, fsec, &tz, &result->value) != 0 || !IS_VALID_TIMESTAMP(result->value))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddatetime literal out of range")));

    result->zone = hasZone ? -tz : ZONE_UNSPECIFIED;

    PG_RETURN_ZONEDDATETIME_P(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_output);
Datum zoneddatetime_output(PG_FUNCTION_ARGS)
{
    ZonedDateTime *date = PG_GETARG_ZONEDDATETIME_P(0);

    // the exception should be never thrown unless there is some bug in the code
    if(!IS_VALID_TIMESTAMP(date->value) || !IS_VALID_TIMEZONE(date->zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddatetime out of range")));


    fsec_t fsec;
    struct pg_tm tm;
    int tz;
    const char *tzn;

    pg_tz *timezone = pg_tzset_offset(date->zone != ZONE_UNSPECIFIED ? -date->zone : 0);

    if(timestamp2tm(date->value, &tz, &tm, &fsec, &tzn, timezone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddatetime out of range")));


    char data[MAXDATELEN + 1];
    char *str = data;

    if(tm.tm_year <= 0)
        *str++ = '-';

    str = pg_ultostr_zeropad(str, (tm.tm_year > 0) ? tm.tm_year : -(tm.tm_year - 1), 4);
    *str++ = '-';
    str = pg_ultostr_zeropad(str, tm.tm_mon, 2);
    *str++ = '-';
    str = pg_ultostr_zeropad(str, tm.tm_mday, 2);
    *str++ = 'T';
    str = pg_ultostr_zeropad(str, tm.tm_hour, 2);
    *str++ = ':';
    str = pg_ultostr_zeropad(str, tm.tm_min, 2);
    *str++ = ':';
    str = pg_ultostr_zeropad(str, tm.tm_sec, 2);

    if(fsec)
    {
        *str++ = '.';
        int length = MAX_TIMESTAMP_PRECISION;

        while(fsec % 10 == 0)
        {
            fsec /= 10;
            length--;
        }

        str = pg_ultostr_zeropad(str, fsec, length);
    }

    if(date->zone != ZONE_UNSPECIFIED)
    {
        if(date->zone != 0)
        {
            int value = abs(tz) / SECS_PER_MINUTE;
            int hours = value / MINS_PER_HOUR;
            int minutes = value - hours * MINS_PER_HOUR;

            *str++ = (tz <= 0 ? '+' : '-');
            str = pg_ultostr_zeropad(str, hours, 2);
            *str++ = ':';
            str = pg_ultostr_zeropad(str, minutes, 2);
        }
        else
        {
            *str++ = 'Z';
        }
    }

    *str = '\0';

    PG_RETURN_CSTRING(pstrdup(data));
}


PG_FUNCTION_INFO_V1(zoneddatetime_create);
Datum zoneddatetime_create(PG_FUNCTION_ARGS)
{
    TimestampTz value = PG_GETARG_TIMESTAMPTZ(0);
    int32 zone = PG_GETARG_INT32(1);

    ZonedDateTime *result = palloc0(sizeof(ZonedDateTime));
    result->value = value;
    result->zone = zone;

    PG_RETURN_ZONEDDATETIME_P(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_datetime);
Datum zoneddatetime_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime *date = PG_GETARG_ZONEDDATETIME_P(0);
    PG_RETURN_TIMESTAMPTZ(date->value);
}


PG_FUNCTION_INFO_V1(zoneddatetime_zone);
Datum zoneddatetime_zone(PG_FUNCTION_ARGS)
{
    ZonedDateTime *date = PG_GETARG_ZONEDDATETIME_P(0);
    PG_RETURN_INT32(date->zone);
}


static Timestamp get_time_value(ZonedDateTime *arg)
{
    if(arg->zone != ZONE_UNSPECIFIED)
        return arg->value;

    return arg->value - implicit_timezone;
}


PG_FUNCTION_INFO_V1(zoneddatetime_same);
Datum zoneddatetime_same(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = left->value == right->value && left->zone == right->zone;
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_equal);
Datum zoneddatetime_equal(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) == get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_not_equal);
Datum zoneddatetime_not_equal(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) != get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_less_than);
Datum zoneddatetime_less_than(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) < get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_greater_than);
Datum zoneddatetime_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) > get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_not_less_than);
Datum zoneddatetime_not_less_than(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) >= get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_not_greater_than);
Datum zoneddatetime_not_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) <= get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_compare);
Datum zoneddatetime_compare(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    int64 l = get_time_value(left);
    int64 r = get_time_value(right);

    if(l < r)
        PG_RETURN_INT32(-1);
    else if(l > r)
        PG_RETURN_INT32(1);
    else
        PG_RETURN_INT32(0);
}
