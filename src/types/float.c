#include <postgres.h>
#include <fmgr.h>
#include <utils/float.h>
#include "ryu/ryu.h"
#include "types/parser.h"
#include "types/float.h"


float4 float_parse(char *data, int size)
{
    float4 result;
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos + 2 < size && !memcmp(data + pos, "NaN", 3))
    {
        pos += 3;
        result = get_float4_nan();
    }
    else if(pos + 2 < size && !memcmp(data + pos, "INF", 3))
    {
        pos += 3;
        result = get_float4_infinity();
    }
    else if(pos + 3 < size && !memcmp(data + pos, "+INF", 4))
    {
        pos += 4;
        result = get_float4_infinity();
    }
    else if(pos + 3 < size && !memcmp(data + pos, "-INF", 4))
    {
        pos += 4;
        result = -get_float4_infinity();
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
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:float literal")));

        if(pos < size && (data[pos] == 'e' || data[pos] == 'E'))
        {
            pos++;

            if(pos < size && (data[pos] == '-' || data[pos] == '+'))
                pos++;

            if(pos == size || !xsd_isdigit(data[pos]))
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:float literal")));

            while(pos < size && xsd_isdigit(data[pos]))
                pos++;
        }

        char *buffer = palloc(pos - begin + 1);
        memcpy(buffer, data + begin, pos - begin);
        buffer[pos - begin] = '\0';

        char *endptr = buffer;
        errno = 0;

        result = strtof(buffer, &endptr);

        if(endptr == buffer || (errno != 0 && errno != ERANGE))
            elog(ERROR, "unexpected error while parsing xsd:float");
    }

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:float literal")));

    return result;
}


int float_print(float4 value, char *buffer)
{
    return f2s_buffered_n(value, buffer, true);
}


PG_FUNCTION_INFO_V1(float_uminus);
Datum float_uminus(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(-PG_GETARG_FLOAT4(0));
}


PG_FUNCTION_INFO_V1(float_add);
Datum float_add(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) + PG_GETARG_FLOAT4(1));
}


PG_FUNCTION_INFO_V1(float_sub);
Datum float_sub(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) - PG_GETARG_FLOAT4(1));
}


PG_FUNCTION_INFO_V1(float_mul);
Datum float_mul(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) * PG_GETARG_FLOAT4(1));
}


PG_FUNCTION_INFO_V1(float_div);
Datum float_div(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) / PG_GETARG_FLOAT4(1));
}
