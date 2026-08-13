#include <postgres.h>
#include <fmgr.h>
#include <utils/datetime.h>
#include "pgsparql.h"
#include "types/datetime.h"
#include "types/parser.h"
#include "types/timezone.h"


static void read_input_digits(char *data, int size, int *pos, int required_length, bool exact_length, bool opening_zero)
{
    int tmp = *pos;

    while(tmp < size && xsd_isdigit(data[tmp]))
        tmp++;

    if(tmp - *pos < required_length || (exact_length && tmp - *pos > required_length))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dateTime literal")));

    if(opening_zero && tmp - *pos > required_length && data[*pos] == '0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dateTime literal")));

    *pos = tmp;
}


static void read_input_char(char *data, int size, int *pos, char required_char)
{
    if(*pos == size || data[*pos] != required_char)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dateTime literal")));

    (*pos)++;
}


static char *move_bc_year(char *data, int size)
{
    char *input = pnstrdup(data, size);

    errno = 0;
    char *endptr;

    int64 year = strtol(input, &endptr, 10);

    if(input == endptr || errno != 0) // should never happen
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dateTime literal")));

    return psprintf("%04li%.*s", year + 1, size - (int) (endptr - input), endptr);
}


ZonedDateTime *datetime_parse(char *data, int size)
{
    /* parse input */
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    int begin = pos;

    if(pos < size && data[pos] == '-')
        pos++;

    int date = pos;

    read_input_digits(data, size, &pos, 4, false, true);
    read_input_char(data, size, &pos, '-');
    read_input_digits(data, size, &pos, 2, true, true);
    read_input_char(data, size, &pos, '-');
    read_input_digits(data, size, &pos, 2, true, true);
    read_input_char(data, size, &pos, 'T');

    int time = pos;

    read_input_digits(data, size, &pos, 2, true, true);
    read_input_char(data, size, &pos, ':');
    read_input_digits(data, size, &pos, 2, true, true);
    read_input_char(data, size, &pos, ':');
    read_input_digits(data, size, &pos, 2, true, true);

    if(pos < size && data[pos] == '.')
    {
        pos++;
        read_input_digits(data, size, &pos, 1, false, false);
    }

    int zone = pos;

    if(pos < size && data[pos] == 'Z')
    {
        pos++;
    }
    else if(pos < size && (data[pos] == '+' || data[pos] == '-'))
    {
        pos++;

        read_input_digits(data, size, &pos, 2, true, true);
        read_input_char(data, size, &pos, ':');
        read_input_digits(data, size, &pos, 2, true, true);
    }

    int end = pos;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dateTime literal")));


    /* truncate the date string to ensure that the year field will not overflow in DecodeDateTime */
    int max_date_length = sizeof("999999999-xx-xx") - 1;
    int date_length = time - date - 1;
    bool year_overflow = false;

    if(date_length > max_date_length)
    {
        date += date_length - max_date_length;
        year_overflow = true;
    }


    /* convert input */
    bool has_zone = zone != end;
    bool ad = begin == date && strncmp(data + begin, "0000", 4);

    char *field[4];
    int ftype[4];

    field[0] = ad ? pnstrdup(data + date, time - date - 1) : move_bc_year(data + date, time - date - 1);
    ftype[0] = DTK_DATE;

    field[1] = pnstrdup(data + time, Min(zone - time, 15));   // use limit 15 to truncate field to microseconds
    ftype[1] = DTK_TIME;

    field[2] = (!has_zone || data[zone] == 'Z') ? "z" : pnstrdup(data + zone, end - zone);
    ftype[2] = (!has_zone || data[zone] == 'Z') ? DTK_STRING : DTK_TZ;

    field[3] = ad ? "ad" : "bc";
    ftype[3] = DTK_STRING;


    /* encode date */
    int dtype;
    struct pg_tm tm;
    fsec_t fsec;
    int tz;

    #if PG_VERSION_NUM >= 160000
    DateTimeErrorExtra extra;
    int derr = DecodeDateTime(field, ftype, 4, &dtype, &tm, &fsec, &tz, &extra);
    #else
    int derr = DecodeDateTime(field, ftype, 4, &dtype, &tm, &fsec, &tz);
    #endif

    if(derr != 0 || dtype != DTK_DATE)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dateTime literal")));

    if(has_zone && (tz % SECS_PER_MINUTE || tz > ZONE_MAX || tz < ZONE_MIN))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dateTime literal")));

    ZonedDateTime *result = palloc0(sizeof(ZonedDateTime));

    // err:FODT0001, Overflow/underflow in date/time operation
    if(year_overflow || tm2timestamp(&tm, fsec, &tz, &result->value) != 0 || !IS_VALID_TIMESTAMP(result->value))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dateTime out of range")));

    result->zone = has_zone ? -tz : ZONE_UNSPECIFIED;

    return result;
}


int datetime_print(ZonedDateTime *date, char *buffer)
{
    // the exception should be never thrown unless there is some bug in the code
    if(!IS_VALID_TIMESTAMP(date->value) || !IS_VALID_TIMEZONE(date->zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dateTime out of range")));


    fsec_t fsec;
    struct pg_tm tm;
    int tz;
    const char *tzn;

    pg_tz *timezone = pg_tzset_offset(date->zone != ZONE_UNSPECIFIED ? -date->zone : 0);

    if(timestamp2tm(date->value, &tz, &tm, &fsec, &tzn, timezone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dateTime out of range")));


    char *str = buffer;

    if(tm.tm_year < 0)
        *str++ = '-';

    str = pg_ultostr_zeropad(str, (tm.tm_year > 0) ? tm.tm_year : -tm.tm_year, 4);
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

    return str - buffer;
}


PG_FUNCTION_INFO_V1(zoneddatetime_input);
Datum zoneddatetime_input(PG_FUNCTION_ARGS)
{
    char *data = PG_GETARG_CSTRING(0);
    PG_RETURN_ZONEDDATETIME_P(datetime_parse(data, strlen(data)));
}


PG_FUNCTION_INFO_V1(zoneddatetime_output);
Datum zoneddatetime_output(PG_FUNCTION_ARGS)
{
    ZonedDateTime *date = PG_GETARG_ZONEDDATETIME_P(0);

    char buffer[DATETIME_MAXLEN];
    int size = datetime_print(date, buffer);

    PG_RETURN_CSTRING(pnstrdup(buffer, size));
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


PG_FUNCTION_INFO_V1(zoneddatetime_get_value);
Datum zoneddatetime_get_value(PG_FUNCTION_ARGS)
{
    ZonedDateTime *date = PG_GETARG_ZONEDDATETIME_P(0);
    PG_RETURN_TIMESTAMPTZ(date->value);
}


PG_FUNCTION_INFO_V1(zoneddatetime_get_value_of_zone);
Datum zoneddatetime_get_value_of_zone(PG_FUNCTION_ARGS)
{
    ZonedDateTime *date = PG_GETARG_ZONEDDATETIME_P(0);
    int32 zone = PG_GETARG_INT32(1);

    if(date->zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_TIMESTAMPTZ(date->value);
}


PG_FUNCTION_INFO_V1(zoneddatetime_get_zone);
Datum zoneddatetime_get_zone(PG_FUNCTION_ARGS)
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


PG_FUNCTION_INFO_V1(zoneddatetime_is_same_as);
Datum zoneddatetime_is_same_as(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = left->value == right->value && left->zone == right->zone;
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_is_equal_to);
Datum zoneddatetime_is_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) == get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_is_not_equal_to);
Datum zoneddatetime_is_not_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) != get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_is_less_than);
Datum zoneddatetime_is_less_than(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) < get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_is_greater_than);
Datum zoneddatetime_is_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) > get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_is_not_less_than);
Datum zoneddatetime_is_not_less_than(PG_FUNCTION_ARGS)
{
    ZonedDateTime *left = PG_GETARG_ZONEDDATETIME_P(0);
    ZonedDateTime *right = PG_GETARG_ZONEDDATETIME_P(1);

    bool result = get_time_value(left) >= get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddatetime_is_not_greater_than);
Datum zoneddatetime_is_not_greater_than(PG_FUNCTION_ARGS)
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
