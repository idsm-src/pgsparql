#include <postgres.h>
#include <miscadmin.h>
#include <utils/datetime.h>
#include <utils/builtins.h>
#include "pgsparql.h"
#include "date.h"
#include "timezone.h"


static void read_input_digits(char **input, int requiredLength, bool exactLength, bool openingZero)
{
    char *str = *input;

    while(*str >= '0' && *str <= '9')
        str++;

    if(str - *input < requiredLength || exactLength && str - *input > requiredLength)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddate literal")));

    if(openingZero && str - *input > requiredLength && **input == '0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddate literal")));

    *input = str;
}


static void read_input_char(char **input, char requiredChar)
{
    if(**input != requiredChar)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddate literal")));

    (*input)++;
}


PG_FUNCTION_INFO_V1(zoneddate_input);
Datum zoneddate_input(PG_FUNCTION_ARGS)
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
    int dateLenght = zone - date;
    bool yearOverflow = false;

    if(dateLenght > maxDateLength)
    {
        date += dateLenght - maxDateLength;
        yearOverflow = true;
    }


    /* convert input */
    bool hasZone = *zone != '\0' && *zone != ' ';

    char *field[3];
    int ftype[3];

    field[0] = pnstrdup(date, zone - date);
    ftype[0] = DTK_DATE;

    field[1] = (!hasZone || *zone == 'Z') ? "z" : pnstrdup(zone, end - zone);
    ftype[1] = (!hasZone || *zone == 'Z') ? DTK_STRING : DTK_TZ;

    field[2] = begin != date ? "bc" : "ad";
    ftype[2] = DTK_STRING;


    /* encode date */
    int dtype;
    struct pg_tm tm;
    fsec_t fsec;
    int tz;

    int derr = DecodeDateTime(field, ftype, 3, &dtype, &tm, &fsec, &tz);

    PG_FREE_IF_COPY(value, 0);
    pfree(field[0]);

    if(*field[1] != 'z')
        pfree(field[1]);


    if(derr != 0 || dtype != DTK_DATE)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddate literal")));

    if(hasZone && (tz % SECS_PER_MINUTE || tz > ZONE_MAX * SECS_PER_MINUTE || tz < ZONE_MIN * SECS_PER_MINUTE))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed zoneddate literal")));

    ZonedDate result;

    // err:FODT0001, Overflow/underflow in date/time operation
    if(yearOverflow || !IS_VALID_JULIAN(tm.tm_year, tm.tm_mon, tm.tm_mday))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddate literal out of range")));

    result.value = date2j(tm.tm_year, tm.tm_mon, tm.tm_mday) - POSTGRES_EPOCH_JDATE;

    // err:FODT0001, Overflow/underflow in date/time operation
    if(!IS_VALID_DATE(result.value))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddate literal out of range")));

    result.zone = hasZone ? -tz : ZONE_UNSPECIFIED;

    PG_RETURN_ZONEDDATE(result);
}


PG_FUNCTION_INFO_V1(zoneddate_output);
Datum zoneddate_output(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);

    // the exception should be never thrown unless there is some bug in the code
    if(!IS_VALID_DATE(date.value) || !IS_VALID_TIMEZONE(date.zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("zoneddate out of range")));


    struct pg_tm tm;
    j2date(date.value + POSTGRES_EPOCH_JDATE, &(tm.tm_year), &(tm.tm_mon), &(tm.tm_mday));


    char data[MAXDATELEN + 1];
    char *str = data;

    if(tm.tm_year <= 0)
        *str++ = '-';

    str = pg_ultostr_zeropad(str, (tm.tm_year > 0) ? tm.tm_year : -(tm.tm_year - 1), 4);
    *str++ = '-';
    str = pg_ultostr_zeropad(str, tm.tm_mon, 2);
    *str++ = '-';
    str = pg_ultostr_zeropad(str, tm.tm_mday, 2);

    if(date.zone != ZONE_UNSPECIFIED)
    {
        if(date.zone != 0)
        {
            int value = abs(date.zone) / SECS_PER_MINUTE;
            int hours = value / MINS_PER_HOUR;
            int minutes = value - hours * MINS_PER_HOUR;

            *str++ = (date.zone >= 0 ? '+' : '-');
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


PG_FUNCTION_INFO_V1(zoneddate_create);
Datum zoneddate_create(PG_FUNCTION_ARGS)
{
    DateADT value = PG_GETARG_DATEADT(0);
    int32 zone = PG_GETARG_INT32(1);
    ZonedDate result = { .value = value, .zone = zone };
    PG_RETURN_ZONEDDATE(result);
}


PG_FUNCTION_INFO_V1(zoneddate_date);
Datum zoneddate_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    PG_RETURN_DATEADT(date.value);
}


PG_FUNCTION_INFO_V1(zoneddate_zone);
Datum zoneddate_zone(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    PG_RETURN_INT32(date.zone);
}


static int64 get_time_value(ZonedDate arg)
{
    int16 timezone = arg.zone == ZONE_UNSPECIFIED ? implicit_timezone : arg.zone;

    return (int64) arg.value * HOURS_PER_DAY * MINS_PER_HOUR * SECS_PER_MINUTE - timezone;
}


PG_FUNCTION_INFO_V1(zoneddate_same);
Datum zoneddate_same(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = left.value == right.value && left.zone == right.zone;
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_equal);
Datum zoneddate_equal(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) == get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_not_equal);
Datum zoneddate_not_equal(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) != get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_less_than);
Datum zoneddate_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) < get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_greater_than);
Datum zoneddate_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) > get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_not_less_than);
Datum zoneddate_not_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) >= get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_not_greater_than);
Datum zoneddate_not_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) <= get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_compare);
Datum zoneddate_compare(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    int64 l = get_time_value(left);
    int64 r = get_time_value(right);

    if(l < r)
        PG_RETURN_INT32(-1);
    else if(l > r)
        PG_RETURN_INT32(1);
    else
        PG_RETURN_INT32(0);
}
