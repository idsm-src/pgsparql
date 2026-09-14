#include <postgres.h>
#include <fmgr.h>
#include <utils/datetime.h>
#include <libpq/pqformat.h>
#include <utils/fmgrprotos.h>
#include "pgsparql.h"
#include "types/date.h"
#include "types/parser.h"
#include "types/timezone.h"


static void read_input_digits(char *data, int size, int *pos, int required_length, bool exact_length, bool opening_zero)
{
    int tmp = *pos;

    while(tmp < size && xsd_isdigit(data[tmp]))
        tmp++;

    if(tmp - *pos < required_length || (exact_length && tmp - *pos > required_length))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));

    if(opening_zero && tmp - *pos > required_length && data[*pos] == '0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));

    *pos = tmp;
}


static void read_input_char(char *data, int size, int *pos, char required_char)
{
    if(*pos == size || data[*pos] != required_char)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));

    (*pos)++;
}


static char *move_bc_year(char *data, int size)
{
    char *input = pnstrdup(data, size);

    errno = 0;
    char *endptr;

    int64 year = strtol(input, &endptr, 10);

    if(input == endptr || errno != 0) // should never happen
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));

    return psprintf("%04li%.*s", year + 1, size - (int) (endptr - input), endptr);
}


ZonedDate date_parse(char *data, int size)
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
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));


    /* truncate the date string to ensure that the year field will not overflow in DecodeDateTime */
    int max_date_length = sizeof("999999999-xx-xx") - 1;
    int date_length = zone - date;
    bool year_overflow = false;

    if(date_length > max_date_length)
    {
        date += date_length - max_date_length;
        year_overflow = true;
    }


    /* convert input */
    bool has_zone = zone != end;
    bool ad = begin == date && strncmp(data + begin, "0000", 4);

    char *field[3];
    int ftype[3];

    field[0] = ad ? pnstrdup(data + date, zone - date) : move_bc_year(data + date, zone - date);
    ftype[0] = DTK_DATE;

    field[1] = (!has_zone || data[zone] == 'Z') ? "z" : pnstrdup(data + zone, end - zone);
    ftype[1] = (!has_zone || data[zone] == 'Z') ? DTK_STRING : DTK_TZ;

    field[2] = ad ? "ad" : "bc";
    ftype[2] = DTK_STRING;


    /* encode date */
    int dtype;
    struct pg_tm tm;
    fsec_t fsec;
    int tz;

    #if PG_VERSION_NUM >= 160000
    DateTimeErrorExtra extra;
    int derr = DecodeDateTime(field, ftype, 3, &dtype, &tm, &fsec, &tz, &extra);
    #else
    int derr = DecodeDateTime(field, ftype, 3, &dtype, &tm, &fsec, &tz);
    #endif

    if(derr != 0 || dtype != DTK_DATE)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));

    if(has_zone && (tz % SECS_PER_MINUTE || tz > ZONE_MAX || tz < ZONE_MIN))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));

    ZonedDate result;

    // err:FODT0001, Overflow/underflow in date/time operation
    if(year_overflow || !IS_VALID_JULIAN(tm.tm_year, tm.tm_mon, tm.tm_mday))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:date out of range")));

    result.value = date2j(tm.tm_year, tm.tm_mon, tm.tm_mday) - POSTGRES_EPOCH_JDATE;

    // err:FODT0001, Overflow/underflow in date/time operation
    if(!IS_VALID_DATE(result.value))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:date out of range")));

    result.zone = has_zone ? -tz : ZONE_UNSPECIFIED;

    return result;
}


int date_print(ZonedDate date, char *buffer)
{
    // the exception should be never thrown unless there is some bug in the code
    if(!IS_VALID_DATE(date.value) || !IS_VALID_TIMEZONE(date.zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:date out of range")));


    struct pg_tm tm;
    j2date(date.value + POSTGRES_EPOCH_JDATE, &(tm.tm_year), &(tm.tm_mon), &(tm.tm_mday));


    char *str = buffer;

    if(tm.tm_year < 0)
        *str++ = '-';

    str = pg_ultostr_zeropad(str, (tm.tm_year > 0) ? tm.tm_year : -tm.tm_year, 4);
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

    return str - buffer;
}


static inline int64 get_time_value(ZonedDate arg)
{
    int64 timezone = arg.zone == ZONE_UNSPECIFIED ? implicit_timezone : arg.zone;

    return (int64) arg.value * HOURS_PER_DAY * MINS_PER_HOUR * SECS_PER_MINUTE - timezone;
}


int date_order_compare(ZonedDate left, ZonedDate right)
{
    int64 l = get_time_value(left);
    int64 r = get_time_value(right);

    if(l != r)
        return l < r ? -1 : 1;

    if(left.value != right.value)
        return left.value < right.value ? -1 : 1;

    if(left.zone != right.zone)
        return left.zone < right.zone ? -1 : 1;

    return 0;
}


PG_FUNCTION_INFO_V1(zoneddate_input);
Datum zoneddate_input(PG_FUNCTION_ARGS)
{
    char *data = PG_GETARG_CSTRING(0);
    PG_RETURN_ZONEDDATE(date_parse(data, strlen(data)));
}


PG_FUNCTION_INFO_V1(zoneddate_output);
Datum zoneddate_output(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);

    char buffer[DATE_MAXLEN];
    int size = date_print(date, buffer);

    PG_RETURN_CSTRING(pnstrdup(buffer, size));
}


PG_FUNCTION_INFO_V1(zoneddate_recv);
Datum zoneddate_recv(PG_FUNCTION_ARGS)
{
    StringInfo buf = (StringInfo) PG_GETARG_POINTER(0);

    ZonedDate result;
    result.value = (DateADT) pq_getmsgint(buf, sizeof(int32));
    result.zone = (int32) pq_getmsgint(buf, sizeof(int32));

    // the same invariants date_print() relies on
    if(!IS_VALID_DATE(result.value) || !IS_VALID_TIMEZONE(result.zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:date out of range")));

    PG_RETURN_ZONEDDATE(result);
}


PG_FUNCTION_INFO_V1(zoneddate_send);
Datum zoneddate_send(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);

    StringInfoData buf;
    pq_begintypsend(&buf);
    pq_sendint32(&buf, date.value);
    pq_sendint32(&buf, date.zone);

    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}


PG_FUNCTION_INFO_V1(zoneddate_create);
Datum zoneddate_create(PG_FUNCTION_ARGS)
{
    DateADT value = PG_GETARG_DATEADT(0);
    int32 zone = PG_GETARG_INT32(1);
    ZonedDate result = { .value = value, .zone = zone };
    PG_RETURN_ZONEDDATE(result);
}


PG_FUNCTION_INFO_V1(zoneddate_get_value);
Datum zoneddate_get_value(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    PG_RETURN_DATEADT(date.value);
}


PG_FUNCTION_INFO_V1(zoneddate_get_value_of_zone);
Datum zoneddate_get_value_of_zone(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    int32 zone = PG_GETARG_INT32(1);

    if(date.zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_DATEADT(date.value);
}


PG_FUNCTION_INFO_V1(zoneddate_get_zone);
Datum zoneddate_get_zone(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    PG_RETURN_INT32(date.zone);
}


PG_FUNCTION_INFO_V1(zoneddate_is_same_as);
Datum zoneddate_is_same_as(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = left.value == right.value && left.zone == right.zone;
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_is_equal_to);
Datum zoneddate_is_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) == get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_is_not_equal_to);
Datum zoneddate_is_not_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) != get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_is_less_than);
Datum zoneddate_is_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) < get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_is_greater_than);
Datum zoneddate_is_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) > get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_is_not_less_than);
Datum zoneddate_is_not_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) >= get_time_value(right);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(zoneddate_is_not_greater_than);
Datum zoneddate_is_not_greater_than(PG_FUNCTION_ARGS)
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


PG_FUNCTION_INFO_V1(zoneddate_order_is_equal_to);
Datum zoneddate_order_is_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) == 0);
}


PG_FUNCTION_INFO_V1(zoneddate_order_is_not_equal_to);
Datum zoneddate_order_is_not_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) != 0);
}


PG_FUNCTION_INFO_V1(zoneddate_order_is_less_than);
Datum zoneddate_order_is_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) < 0);
}


PG_FUNCTION_INFO_V1(zoneddate_order_is_greater_than);
Datum zoneddate_order_is_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) > 0);
}


PG_FUNCTION_INFO_V1(zoneddate_order_is_not_less_than);
Datum zoneddate_order_is_not_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) >= 0);
}


PG_FUNCTION_INFO_V1(zoneddate_order_is_not_greater_than);
Datum zoneddate_order_is_not_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) <= 0);
}


PG_FUNCTION_INFO_V1(zoneddate_order_compare);
Datum zoneddate_order_compare(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_INT32(date_order_compare(left, right));
}


PG_FUNCTION_INFO_V1(zoneddate_hash);
Datum zoneddate_hash(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);

    uint32 result = DatumGetUInt32(DirectFunctionCall1(hashint4, Int32GetDatum(date.value)));
    uint32 zone = DatumGetUInt32(DirectFunctionCall1(hashint4, Int32GetDatum(date.zone)));

    result = (result << 5) - result + zone;

    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(zoneddate_hash_extended);
Datum zoneddate_hash_extended(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    Datum seed = PG_GETARG_DATUM(1);

    uint64 result = DatumGetUInt64(DirectFunctionCall2(hashint4extended, Int32GetDatum(date.value), seed));
    uint64 zone = DatumGetUInt64(DirectFunctionCall2(hashint4extended, Int32GetDatum(date.zone), seed));

    result = (result << 5) - result + zone;

    PG_RETURN_UINT64(result);
}
