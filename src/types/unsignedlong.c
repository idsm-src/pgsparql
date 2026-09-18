#include <postgres.h>
#include <utils/builtins.h>
#include <common/int.h>
#include "types/parser.h"
#include "types/unsignedlong.h"


uint64 unsignedlong_parse(char *data, int size)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    uint64 tmp = 0;
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

        if(unlikely(pg_mul_u64_overflow(tmp, 10, &tmp) || pg_add_u64_overflow(tmp, digit, &tmp)))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedLong out of range")));
    }

    if(pos == begin)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:unsignedLong literal")));

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:unsignedLong literal")));

    /* the lexical space allows the minus sign, but only zero can be written with it */
    if(unlikely(neg && tmp != 0))
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedLong out of range")));

    return tmp;
}


int unsignedlong_print(uint64 value, char *buffer)
{
    return pg_ulltoa_n(value, buffer);
}
