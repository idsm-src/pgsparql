#include <postgres.h>
#include <fmgr.h>
#include <utils/float.h>
#include "ryu/ryu.h"
#include "types/parser.h"
#include "types/double.h"


float8 double_parse(char *data, int size)
{
    float8 result;
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos + 2 < size && !memcmp(data + pos, "NaN", 3))
    {
        pos += 3;
        result = get_float8_nan();
    }
    else if(pos + 2 < size && !memcmp(data + pos, "INF", 3))
    {
        pos += 3;
        result = get_float8_infinity();
    }
    else if(pos + 3 < size && !memcmp(data + pos, "+INF", 4))
    {
        pos += 4;
        result = get_float8_infinity();
    }
    else if(pos + 3 < size && !memcmp(data + pos, "-INF", 4))
    {
        pos += 4;
        result = -get_float8_infinity();
    }
    else
    {
        int begin = pos;

        if(pos < size && (data[pos] == '-' || data[pos] == '+'))
            pos++;

        int num_pos = pos;

        while(pos < size && xsd_isdigit(data[pos]))
            pos++;

        if(pos < size && data[pos] == '.')
            pos++;

        while(pos < size && xsd_isdigit(data[pos]))
            pos++;

        if(pos - num_pos == (data[num_pos] == '.'))
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:double literal")));

        if(pos < size && (data[pos] == 'e' || data[pos] == 'E'))
        {
            pos++;

            if(pos < size && (data[pos] == '-' || data[pos] == '+'))
                pos++;

            if(pos == size || !xsd_isdigit(data[pos]))
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:double literal")));

            while(pos < size && xsd_isdigit(data[pos]))
                pos++;
        }

        char *buffer = palloc(pos - begin + 1);
        memcpy(buffer, data + begin, pos - begin);
        buffer[pos - begin] = '\0';

        char *endptr = buffer;
        errno = 0;

        result = strtod(buffer, &endptr);

        if(endptr == buffer || (errno != 0 && errno != ERANGE))
            elog(ERROR, "unexpected error while parsing xsd:double");
    }

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:double literal")));

    return result;
}


int double_print(float8 value, char *buffer)
{
    return d2s_buffered_n(value, buffer, true);
}


PG_FUNCTION_INFO_V1(double_uminus);
Datum double_uminus(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT8(-PG_GETARG_FLOAT8(0));
}


PG_FUNCTION_INFO_V1(double_add);
Datum double_add(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT8(PG_GETARG_FLOAT8(0) + PG_GETARG_FLOAT8(1));
}


PG_FUNCTION_INFO_V1(double_sub);
Datum double_sub(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT8(PG_GETARG_FLOAT8(0) - PG_GETARG_FLOAT8(1));
}


PG_FUNCTION_INFO_V1(double_mul);
Datum double_mul(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT8(PG_GETARG_FLOAT8(0) * PG_GETARG_FLOAT8(1));
}


PG_FUNCTION_INFO_V1(double_div);
Datum double_div(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT8(PG_GETARG_FLOAT8(0) / PG_GETARG_FLOAT8(1));
}
