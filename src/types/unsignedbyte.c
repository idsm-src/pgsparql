#include <postgres.h>
#include <utils/builtins.h>
#include "types/parser.h"
#include "types/unsignedbyte.h"


uint8 unsignedbyte_parse(char *data, int size)
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

        if(unlikely(tmp > PG_UINT8_MAX))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedByte out of range")));

        tmp = tmp * 10 + digit;
    }

    if(pos == begin)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:unsignedByte literal")));

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:unsignedByte literal")));

    /* the lexical space allows the minus sign, but only zero can be written with it */
    if(unlikely(tmp > PG_UINT8_MAX || (neg && tmp != 0)))
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedByte out of range")));

    return (uint8) tmp;
}


int unsignedbyte_print(uint8 value, char *buffer)
{
    return pg_ultoa_n(value, buffer);
}
