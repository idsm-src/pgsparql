/**
 * @file
 * The lexical forms of xsd:date and the type zoneddate: its text and binary forms, construction and access, the
 * comparison of XPath and the total order and the hashing that the operator classes of zoneddate are built on.
 */
#include <postgres.h>
#include <fmgr.h>
#include <utils/datetime.h>
#include <libpq/pqformat.h>
#include <utils/fmgrprotos.h>
#include "pgsparql.h"
#include "types/date.h"
#include "types/parser.h"
#include "types/timezone.h"


/**
 * Skips a run of decimal digits of the xsd:date literal being parsed.
 *
 * @param data the literal
 * @param size the length of the literal in bytes
 * @param pos the position of the run, which receives the position after it
 * @param required_length the least number of digits
 * @param exact_length whether more than @a required_length digits are an error
 * @param opening_zero whether a run of more than @a required_length digits must not begin with a zero
 */
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


/**
 * Skips a character that the xsd:date literal being parsed must have at a position.
 *
 * @param data the literal
 * @param size the length of the literal in bytes
 * @param pos the position of the character, which receives the position after it
 * @param required_char the character; another character or the end of the literal raises an error
 */
static void read_input_char(char *data, int size, int *pos, char required_char)
{
    if(*pos == size || data[*pos] != required_char)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));

    (*pos)++;
}


/**
 * Converts a date before 1 AD into the form that DecodeDateTime() reads together with the field `bc`.
 *
 * XML Schema numbers the year 1 BC as 0000 and the year before it as -0001, so a year written as @c n (without its
 * minus sign) is the year n + 1 BC.
 *
 * @param data the date part `YYYY-MM-DD` without the minus sign
 * @param size the length of the date part in bytes
 * @return the palloc'd date part with the year n + 1
 */
static char *move_bc_year(char *data, int size)
{
    char *input = pnstrdup(data, size);

    errno = 0;
    char *endptr;

    // the caller has already cut the year down to at most nine digits, so long is
    // wide enough everywhere and its length modifier matches what strtol() returns
    long year = strtol(input, &endptr, 10);

    if(input == endptr || errno != 0) // should never happen
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:date literal")));

    return psprintf("%04li%.*s", year + 1, size - (int) (endptr - input), endptr);
}


/**
 * Parses a lexical form of xsd:date, `-?YYYY-MM-DD` with an optional time zone `Z`, `+hh:mm` or `-hh:mm`,
 * surrounded by optional XML Schema whitespace.
 *
 * The year has at least four digits and no leading zero beyond them, and the zone is at most 14 hours.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the value; a malformed form or a date out of the range of the SQL type date raises an error
 */
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


/**
 * Prints the canonical lexical form of an xsd:date: the date with a year of at least four digits, followed by `Z`
 * for the zone 0, by `+hh:mm` or `-hh:mm` for another zone and by nothing for an unspecified zone.
 *
 * @param date the value
 * @param buffer the buffer, with room for at least #DATE_MAXLEN bytes; no terminating zero byte is written
 * @return the number of bytes written; an invalid value raises an error
 */
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


/**
 * Returns the instant at which a date begins, a date without a time zone being taken to be in #IMPLICIT_TIMEZONE.
 *
 * @param arg the date
 * @return the instant in seconds since 2000-01-01T00:00:00Z
 */
static inline int64 get_time_value(ZonedDate arg)
{
    int64 timezone = arg.zone == ZONE_UNSPECIFIED ? IMPLICIT_TIMEZONE : arg.zone;

    return (int64) arg.value * HOURS_PER_DAY * MINS_PER_HOUR * SECS_PER_MINUTE - timezone;
}


/**
 * Compares two dates in the total order that the operator classes of zoneddate and the ordering of rdfbox are built
 * on: by the instants at which they begin (see get_time_value()), dates beginning at the same instant by their values
 * and then by their zones, so that only identical dates are equal.
 *
 * @param left the left date
 * @param right the right date
 * @return -1, 0 or 1 if @a left is less than, equal to or greater than @a right
 */
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


/**
 * The input function of the type zoneddate, which reads a lexical form of xsd:date.
 *
 * @param fcinfo the cstring
 * @return the zoneddate; a malformed form or a value out of range raises an error
 */
PG_FUNCTION_INFO_V1(zoneddate_input);
Datum zoneddate_input(PG_FUNCTION_ARGS)
{
    char *data = PG_GETARG_CSTRING(0);
    PG_RETURN_ZONEDDATE(date_parse(data, strlen(data)));
}


/**
 * The output function of the type zoneddate, which prints the canonical lexical form of xsd:date.
 *
 * @param fcinfo the zoneddate
 * @return the cstring
 */
PG_FUNCTION_INFO_V1(zoneddate_output);
Datum zoneddate_output(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);

    char buffer[DATE_MAXLEN];
    int size = date_print(date, buffer);

    PG_RETURN_CSTRING(pnstrdup(buffer, size));
}


/**
 * The receive function of the type zoneddate, which reads the int4 value and the int4 zone.
 *
 * @param fcinfo the internal StringInfo holding the message
 * @return the zoneddate; a value or a zone out of range raises an error
 */
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


/**
 * The send function of the type zoneddate, which writes the int4 value and the int4 zone.
 *
 * @param fcinfo the zoneddate
 * @return the bytea
 */
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


/**
 * Builds a zoneddate from its value and its zone.
 *
 * @param fcinfo the date value and the int4 zone, an offset in seconds east of UTC or #ZONE_UNSPECIFIED; with
 *               `--enable-extra-checks`, an infinite date or an invalid zone raises an error
 * @return the zoneddate
 */
PG_FUNCTION_INFO_V1(zoneddate_create);
Datum zoneddate_create(PG_FUNCTION_ARGS)
{
    DateADT value = checked_date(PG_GETARG_DATEADT(0));
    int32 zone = checked_zone(PG_GETARG_INT32(1));
    ZonedDate result = { .value = value, .zone = zone };
    PG_RETURN_ZONEDDATE(result);
}


/**
 * Returns the value of a zoneddate without its zone.
 *
 * @param fcinfo the zoneddate
 * @return the date as written
 */
PG_FUNCTION_INFO_V1(zoneddate_get_value);
Datum zoneddate_get_value(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    PG_RETURN_DATEADT(date.value);
}


/**
 * Returns the value of a zoneddate that has a given zone.
 *
 * @param fcinfo the zoneddate and the int4 zone, an offset in seconds or #ZONE_UNSPECIFIED
 * @return the date value, NULL if the zoneddate has another zone
 */
PG_FUNCTION_INFO_V1(zoneddate_get_value_of_zone);
Datum zoneddate_get_value_of_zone(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    int32 zone = PG_GETARG_INT32(1);

    if(date.zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_DATEADT(date.value);
}


/**
 * Returns the zone of a zoneddate.
 *
 * @param fcinfo the zoneddate
 * @return the int4 offset in seconds east of UTC, or #ZONE_UNSPECIFIED
 */
PG_FUNCTION_INFO_V1(zoneddate_get_zone);
Datum zoneddate_get_zone(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);
    PG_RETURN_INT32(date.zone);
}


/**
 * The operator `===` on zoneddate: whether two values are identical, with the same value and the same zone.
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_is_same_as);
Datum zoneddate_is_same_as(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = left.value == right.value && left.zone == right.zone;
    PG_RETURN_BOOL(result);
}


/**
 * The operator `=` on zoneddate, `op:date-equal` of XPath.
 *
 * It compares the instants at which the dates begin; a value without a time zone is taken to be in #IMPLICIT_TIMEZONE.
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_is_equal_to);
Datum zoneddate_is_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) == get_time_value(right);
    PG_RETURN_BOOL(result);
}


/**
 * The operator `<>` on zoneddate.
 *
 * It compares the instants at which the dates begin; a value without a time zone is taken to be in #IMPLICIT_TIMEZONE.
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_is_not_equal_to);
Datum zoneddate_is_not_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) != get_time_value(right);
    PG_RETURN_BOOL(result);
}


/**
 * The operator `<` on zoneddate, `op:date-less-than` of XPath.
 *
 * It compares the instants at which the dates begin; a value without a time zone is taken to be in #IMPLICIT_TIMEZONE.
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_is_less_than);
Datum zoneddate_is_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) < get_time_value(right);
    PG_RETURN_BOOL(result);
}


/**
 * The operator `>` on zoneddate, `op:date-greater-than` of XPath.
 *
 * It compares the instants at which the dates begin; a value without a time zone is taken to be in #IMPLICIT_TIMEZONE.
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_is_greater_than);
Datum zoneddate_is_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) > get_time_value(right);
    PG_RETURN_BOOL(result);
}


/**
 * The operator `>=` on zoneddate.
 *
 * It compares the instants at which the dates begin; a value without a time zone is taken to be in #IMPLICIT_TIMEZONE.
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_is_not_less_than);
Datum zoneddate_is_not_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) >= get_time_value(right);
    PG_RETURN_BOOL(result);
}


/**
 * The operator `<=` on zoneddate.
 *
 * It compares the instants at which the dates begin; a value without a time zone is taken to be in #IMPLICIT_TIMEZONE.
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_is_not_greater_than);
Datum zoneddate_is_not_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    bool result = get_time_value(left) <= get_time_value(right);
    PG_RETURN_BOOL(result);
}


/**
 * Compares two zoneddate values by the instants at which the dates begin, the three-way counterpart of the operators
 * `=`, `<` and `>`.
 *
 * @param fcinfo the two zoneddate values
 * @return the int4 -1, 0 or 1 if the first value is less than, equal to or greater than the second one
 */
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


/**
 * The operator `@=` on zoneddate: whether the first value is equal to the second one in the total order (see
 * date_order_compare()), the equality of the default B-tree and hash operator classes.
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_order_is_equal_to);
Datum zoneddate_order_is_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) == 0);
}


/**
 * The operator `@<>` on zoneddate: whether the first value is not equal to the second one in the total order (see
 * date_order_compare()).
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_order_is_not_equal_to);
Datum zoneddate_order_is_not_equal_to(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) != 0);
}


/**
 * The operator `@<` on zoneddate: whether the first value is less than the second one in the total order (see
 * date_order_compare()).
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_order_is_less_than);
Datum zoneddate_order_is_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) < 0);
}


/**
 * The operator `@>` on zoneddate: whether the first value is greater than the second one in the total order (see
 * date_order_compare()).
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_order_is_greater_than);
Datum zoneddate_order_is_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) > 0);
}


/**
 * The operator `@>=` on zoneddate: whether the first value is not less than the second one in the total order (see
 * date_order_compare()).
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_order_is_not_less_than);
Datum zoneddate_order_is_not_less_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) >= 0);
}


/**
 * The operator `@<=` on zoneddate: whether the first value is not greater than the second one in the total order (see
 * date_order_compare()).
 *
 * @param fcinfo the two zoneddate values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(zoneddate_order_is_not_greater_than);
Datum zoneddate_order_is_not_greater_than(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_BOOL(date_order_compare(left, right) <= 0);
}


/**
 * Compares two zoneddate values in the total order (see date_order_compare()), the support function 1 of the default
 * B-tree operator class of zoneddate.
 *
 * @param fcinfo the two zoneddate values
 * @return the int4 -1, 0 or 1 if the first value is less than, equal to or greater than the second one
 */
PG_FUNCTION_INFO_V1(zoneddate_order_compare);
Datum zoneddate_order_compare(PG_FUNCTION_ARGS)
{
    ZonedDate left = PG_GETARG_ZONEDDATE(0);
    ZonedDate right = PG_GETARG_ZONEDDATE(1);

    PG_RETURN_INT32(date_order_compare(left, right));
}


/**
 * Hashes a zoneddate by its value and its zone, the support function 1 of the default hash operator class of zoneddate.
 *
 * @param fcinfo the zoneddate
 * @return the int4 hash, the low 32 bits of zoneddate_hash_extended() at seed 0
 */
PG_FUNCTION_INFO_V1(zoneddate_hash);
Datum zoneddate_hash(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_ZONEDDATE(0);

    uint32 result = DatumGetUInt32(DirectFunctionCall1(hashint4, Int32GetDatum(date.value)));
    uint32 zone = DatumGetUInt32(DirectFunctionCall1(hashint4, Int32GetDatum(date.zone)));

    result = (result << 5) - result + zone;

    PG_RETURN_UINT32(result);
}


/**
 * Hashes a zoneddate by its value and its zone with a seed, the support function 2 of the default hash operator
 * class of zoneddate.
 *
 * @param fcinfo the zoneddate and the int8 seed
 * @return the int8 hash
 */
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
