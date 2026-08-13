#include <postgres.h>
#include <utils/builtins.h>
#include <common/int.h>
#include "pgsparql.h"
#include "types/parser.h"
#include "types/short.h"


int16 short_parse(char *data, int size)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    uint16 tmp = 0;
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

        if(unlikely(tmp > -(PG_INT16_MIN / 10)))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:short out of range")));

        tmp = tmp * 10 + digit;
    }

    if(pos == begin)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:short literal")));

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:short literal")));

    if(neg)
    {
        int16 result;

        if(unlikely(pg_neg_u16_overflow(tmp, &result)))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:short out of range")));

        return result;
    }

    if(unlikely(tmp > PG_INT16_MAX))
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:short out of range")));

    return (int16) tmp;
}


int short_print(int16 value, char *buffer)
{
    uint16 uvalue = value;
    int size = 0;

    if(value < 0)
    {
        uvalue = (uint16) 0 - uvalue;
        buffer[size++] = '-';
    }

    return size + pg_ultoa_n(uvalue, buffer + size);
}
