#include <postgres.h>
#include <fmgr.h>
#include <math.h>
#include <common/int.h>
#include <utils/timestamp.h>
#include "pgsparql.h"
#include "types/daytimeduration.h"


static int64 read_integer(char **input)
{
    errno = 0;
    char *endptr;

    if(!isdigit((unsigned char) **input))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

    int64 result = strtol(*input, &endptr, 10);

    if(*input == endptr)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

    if(errno == EINVAL)
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("daytimeduration out of range")));

    *input = endptr;

    return result;
}


static int64 add_duration_part(int64 sum, int64 value, int64 multiplier)
{
    int64 addition;

    if(pg_mul_s64_overflow(value, multiplier, &addition))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("daytimeduration out of range")));

    int64 result;

    if(pg_add_s64_overflow(sum, addition, &result))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("daytimeduration out of range")));

    return result;
}


PG_FUNCTION_INFO_V1(daytimeduration_input);
Datum daytimeduration_input(PG_FUNCTION_ARGS)
{
    char *value = PG_GETARG_CSTRING(0);

    int64 result = 0;
    bool minus = false;
    bool is_valid = true;
    char *input = value;

    while(isspace((unsigned char) *input))
        input++;

    if(*input == '-')
    {
        minus = true;
        result = -1;    // to not overflow for INT64_MIN duration
        input++;
    }

    if(*input++ != 'P')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

    int last = 0;

    if(*input != 'T')
    {
        int64 value = read_integer(&input);

        if(*input != 'D')
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

        result = add_duration_part(result, value, USECS_PER_DAY);
        last = 1;
        input++;
    }

    if(*input == 'T')
    {
        input++;

        if(*input == '\0' || isspace((unsigned char) *input))
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

        while((*input != '\0' && !isspace((unsigned char) *input)) || last == 0)
        {
            int64 value = read_integer(&input);

            if(*input == 'H' && last < 2)
            {
                result = add_duration_part(result, value, USECS_PER_HOUR);
                last = 2;
                input++;
            }
            else if(*input == 'M' && last < 3)
            {
                result = add_duration_part(result, value, USECS_PER_MINUTE);
                last = 3;
                input++;
            }
            else if(*input == '.' && last < 4)
            {
                result = add_duration_part(result, value, USECS_PER_SEC);
                last = 4;

                input++;

                if(!isdigit((unsigned char) *input))
                    ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

                // truncate field to microseconds
                char frac[] = {'0', '0', '0', '0', '0', '0', '\0'};

                for(int i = 0; i < 6 && isdigit((unsigned char) *input); i++)
                    frac[i] = *(input++);

                while(isdigit((unsigned char) *input))
                    input++;

                if(*input != 'S' || errno != 0)
                    ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

                result = add_duration_part(result, strtol(frac, NULL, 10), 1);
                input++;
            }
            else if(*input == 'S' && last < 4)
            {
                result = add_duration_part(result, value, USECS_PER_SEC);
                last = 4;
                input++;
            }
            else
            {
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));
            }
        }
    }

    while(isspace((unsigned char) *input))
        input++;

    if(*input != '\0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

    if(!is_valid)
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("daytimeduration out of range")));

    if(minus)
        result = -result -1;

    PG_RETURN_INT64(result);
}


PG_FUNCTION_INFO_V1(daytimeduration_output);
Datum daytimeduration_output(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);

    if(value == 0)
        PG_RETURN_CSTRING(pstrdup("PT0S"));

    if(value == INT64_MIN)
        PG_RETURN_CSTRING(pstrdup("-P106751991DT4H54.775808S"));


    char data[32];
    char *str = data;

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

    *str++ = '\0';

    PG_RETURN_CSTRING(pstrdup(data));
}
