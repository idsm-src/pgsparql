#include <postgres.h>
#include <utils/builtins.h>
#include <utils/timestamp.h>
#include <math.h>
#include "daytimeduration.h"


static bool read_integer(char **input, int64 *result)
{
    errno = 0;
    char *endptr;

    *result = strtol(*input, &endptr, 10);

    if(*input == endptr)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

    *input = endptr;
    return errno != EINVAL;
}


static bool add_duration_part(int64 *result, int64 value, int64 multiplier)
{
    uint64 addition = value * multiplier;

    if(addition / multiplier != value || addition > INT64_MAX)
        return false;

    uint64 sum = *result + addition;

    if(sum - addition != *result || sum > INT64_MAX)
        return false;

    *result = sum;
    return true;
}


PG_FUNCTION_INFO_V1(daytimeduration_input);
Datum daytimeduration_input(PG_FUNCTION_ARGS)
{
    char *value = PG_GETARG_CSTRING(0);

    int64 result = 0;
    bool minus = false;
    bool isValid = true;
    char *input = value;

    while(*input == ' ')
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
        int64 value;
        isValid &= read_integer(&input, &value);

        if(*input != 'D')
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

        isValid &= add_duration_part(&result, value, USECS_PER_DAY);
        last = 1;
        input++;
    }

    if(*input == 'T')
    {
        input++;

        while(*input != '\0' && *input != ' ' || last == 0)
        {
            int64 value;
            isValid &= read_integer(&input, &value);

            if(*input == 'H')
            {
                isValid &= add_duration_part(&result, value, USECS_PER_HOUR);
                last = 2;
                input++;
            }
            else if(*input == 'M' && last < 3)
            {
                isValid &= add_duration_part(&result, value, USECS_PER_MINUTE);
                last = 3;
                input++;
            }
            else if(*input == '.' && last < 4)
            {
                isValid &= add_duration_part(&result, value, USECS_PER_SEC);
                last = 4;

                input++;

                // truncate field to microseconds
                char frac[] = {'0', '0', '0', '0', '0', '0', '\0'};

                for(int i = 0; i < 6 && *input >= '0' && *input <= '9'; i++)
                    frac[i] = *(input++);

                while(*input >= '0' && *input <= '9')
                    input++;

                if(*input != 'S' || errno != 0)
                    ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

                isValid &= add_duration_part(&result, strtol(frac, NULL, 10), 1);
                input++;
            }
            else if(*input == 'S' && last < 5)
            {
                isValid &= add_duration_part(&result, value, USECS_PER_SEC);
                last = 5;
                input++;
            }
            else
            {
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));
            }
        }
    }

    while(*input == ' ')
        input++;

    if(*input != '\0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed daytimeduration literal")));

    if(!isValid)
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("daytimeduration out of range")));

    if(minus)
        result = -result -1;

    PG_FREE_IF_COPY(value, 0);
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
        str = pg_ltostr(str, days);
        *str++ = 'D';
    }

    if(hours > 0 || minutes > 0 || seconds > 0 || useconds > 0)
        *str++ = 'T';

    if(hours > 0)
    {
        str = pg_ltostr(str, hours);
        *str++ = 'H';
    }

    if(minutes > 0)
    {
        str = pg_ltostr(str, minutes);
        *str++ = 'M';
    }

    if(seconds > 0)
    {
        str = pg_ltostr(str, seconds);

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

        str = pg_ltostr_zeropad(str, useconds, length);
        *str++ = 'S';
    }

    *str++ = '\0';

    PG_RETURN_CSTRING(pstrdup(data));
}
