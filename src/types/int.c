#include <postgres.h>
#include <utils/builtins.h>
#include <common/int.h>
#include "pgsparql.h"
#include "types/parser.h"
#include "types/int.h"


int32 int_parse(char *data, int size)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    uint32 tmp = 0;
    bool neg = false;

    if(pos < size && data[pos] == '-')
    {
        pos++;
        neg = true;
    }
    else if(pos < size && data[pos] == '+')
    {
        pos++;
    }

    int begin = pos;

    while(pos < size)
    {
        unsigned char digit = (data[pos] - '0');

        if(digit >= 10)
            break;

        pos++;

        if(unlikely(tmp > -(PG_INT32_MIN / 10)))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:int out of range")));

        tmp = tmp * 10 + digit;
    }

    if(pos == begin)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:int literal")));

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:int literal")));

    if(neg)
    {
        int32 result;

        if(unlikely(pg_neg_u32_overflow(tmp, &result)))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:int out of range")));

        return result;
    }

    if(unlikely(tmp > PG_INT32_MAX))
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:int out of range")));

    return (int32) tmp;
}


int int_print(int32 value, char *buffer)
{
    uint32 uvalue = value;
    int size = 0;

    if(value < 0)
    {
        uvalue = (uint32) 0 - uvalue;
        buffer[size++] = '-';
    }

    return size + pg_ultoa_n(uvalue, buffer + size);
}
