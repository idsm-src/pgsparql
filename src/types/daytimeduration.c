/**
 * @file
 * Parsing and printing of the lexical forms of xsd:dayTimeDuration, whose values are numbers of microseconds.
 */
#include <postgres.h>
#include <math.h>
#include <common/int.h>
#include <utils/timestamp.h>
#include "pgsparql.h"
#include "types/parser.h"
#include "types/daytimeduration.h"


/**
 * Reads the unsigned decimal number of a part of a duration.
 *
 * @param data the lexical form
 * @param begin the position of the first digit, advanced past the last digit read
 * @param size the length of the lexical form in bytes
 * @return the number; a missing number raises an error, as does a number beyond the range of int64
 */
static int64 read_integer(char *data, int *begin, int size)
{
    int pos = *begin;
    uint64 tmp = 0;

    while(pos < size)
    {
        unsigned char digit = (data[pos] - '0');

        if(digit >= 10)
            break;

        pos++;

        if(unlikely(tmp > -(PG_INT64_MIN / 10)))
            ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dayTimeDuration out of range")));

        tmp = tmp * 10 + digit;
    }

    if(unlikely(tmp > PG_INT64_MAX))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dayTimeDuration out of range")));

    if(pos == *begin)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));

    *begin = pos;
    return (int64) tmp;
}


/**
 * Adds a part of a duration to the sum of the parts read before it.
 *
 * @param sum the sum of the previous parts in microseconds
 * @param value the number of units of the part
 * @param multiplier the number of microseconds of a unit
 * @return the new sum; an overflow of int64 raises an error
 */
static int64 add_duration_part(int64 sum, int64 value, int64 multiplier)
{
    int64 addition;

    if(pg_mul_s64_overflow(value, multiplier, &addition))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dayTimeDuration out of range")));

    int64 result;

    if(pg_add_s64_overflow(sum, addition, &result))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dayTimeDuration out of range")));

    return result;
}


/**
 * Parses a lexical form of xsd:dayTimeDuration, `-?P(nD)?(T(nH)?(nM)?(n(.n)?S)?)?` surrounded by optional XML Schema
 * whitespace, with at least one part, and at least one part after `T` when it is present.
 *
 * The number of a part may be of any size as long as the whole duration fits into an int64 of microseconds; the
 * fractional seconds may have more than six digits only if the extra digits are zeros.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the duration in microseconds; a malformed form, a duration out of range or a non-zero digit beyond the
 *         microseconds raises an error
 */
int64 daytimeduration_parse(char *data, int size)
{
    bool minus = false;
    int64 result = 0;
    int pos = 0;


    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos < size && data[pos] == '-')
    {
        minus = true;
        result = -1;    // to not overflow for INT64_MIN duration
        pos++;
    }

    if(pos == size || data[pos++] != 'P')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));

    int last = 0;

    if(pos < size && data[pos] != 'T')
    {
        int64 value = read_integer(data, &pos, size);

        if(pos == size || data[pos] != 'D')
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));

        result = add_duration_part(result, value, USECS_PER_DAY);
        last = 1;
        pos++;
    }

    if(pos < size && data[pos] == 'T')
    {
        pos++;

        if(pos == size || xsd_isspace(data[pos]))
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));

        while((pos < size && !xsd_isspace(data[pos])))
        {
            int64 value = read_integer(data, &pos, size);

            if(pos < size && data[pos] == 'H' && last < 2)
            {
                result = add_duration_part(result, value, USECS_PER_HOUR);
                last = 2;
                pos++;
            }
            else if(pos < size && data[pos] == 'M' && last < 3)
            {
                result = add_duration_part(result, value, USECS_PER_MINUTE);
                last = 3;
                pos++;
            }
            else if(pos < size && data[pos] == '.' && last < 4)
            {
                result = add_duration_part(result, value, USECS_PER_SEC);
                last = 4;

                pos++;

                if(pos == size || !xsd_isdigit(data[pos]))
                    ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));

                char frac[] = {'0', '0', '0', '0', '0', '0', '\0'};

                for(int i = 0; i < 6 && pos < size && xsd_isdigit(data[pos]); i++)
                    frac[i] = data[pos++];

                // digits beyond microseconds are accepted only if they do not carry any value
                while(pos < size && xsd_isdigit(data[pos]))
                    if(data[pos++] != '0')
                        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dayTimeDuration precision out of range")));

                if(pos == size || data[pos] != 'S')
                    ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));

                result = add_duration_part(result, strtol(frac, NULL, 10), 1);
                pos++;
            }
            else if(pos < size && data[pos] == 'S' && last < 4)
            {
                result = add_duration_part(result, value, USECS_PER_SEC);
                last = 4;
                pos++;
            }
            else
            {
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));
            }
        }

        if(last < 2)
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));
    }

    if(last == 0)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:dayTimeDuration literal")));

    if(minus)
        result = -result -1;

    return result;
}


/**
 * Prints the canonical lexical form of an xsd:dayTimeDuration: the parts that are not zero, the fractional seconds
 * without trailing zeros, as in `-P1DT2H0.5S`, and `PT0S` for the zero duration.
 *
 * @param value the duration in microseconds
 * @param buffer the buffer, with room for at least #DAYTIMEDURATION_MAXLEN bytes; no terminating zero byte is
 *               written
 * @return the number of bytes written
 */
int daytimeduration_print(int64 value, char *buffer)
{
    if(value == 0)
    {
        memcpy(buffer, "PT0S", sizeof("PT0S") - 1);
        return sizeof("PT0S") - 1;
    }

    if(value == INT64_MIN)
    {
        memcpy(buffer, "-P106751991DT4H54.775808S", sizeof("-P106751991DT4H54.775808S") - 1);
        return sizeof("-P106751991DT4H54.775808S") - 1;
    }


    char *str = buffer;

    if(value < 0)
        *str++ = '-';

    value = labs(value);

    int days =  value / USECS_PER_DAY;
    int hours = (value % USECS_PER_DAY) / USECS_PER_HOUR;
    int minutes = (value % USECS_PER_HOUR) / USECS_PER_MINUTE;
    int seconds =  (value % USECS_PER_MINUTE) / USECS_PER_SEC;
    int useconds =  value % USECS_PER_SEC;

    *str++ = 'P';

    if(days > 0)
    {
        str = pg_ultostr(str, days);
        *str++ = 'D';
    }

    if(hours > 0 || minutes > 0 || seconds > 0 || useconds > 0)
        *str++ = 'T';

    if(hours > 0)
    {
        str = pg_ultostr(str, hours);
        *str++ = 'H';
    }

    if(minutes > 0)
    {
        str = pg_ultostr(str, minutes);
        *str++ = 'M';
    }

    if(seconds > 0)
    {
        str = pg_ultostr(str, seconds);

        if(useconds == 0)
            *str++ = 'S';
    }

    if(useconds > 0)
    {
        if(seconds == 0)
            *str++ = '0';

        *str++ = '.';

        int length = MAX_TIMESTAMP_PRECISION;

        while(useconds % 10 == 0)
        {
            useconds /= 10;
            length--;
        }

        str = pg_ultostr_zeropad(str, useconds, length);
        *str++ = 'S';
    }

    return str - buffer;
}
