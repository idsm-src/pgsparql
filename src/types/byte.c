#include <postgres.h>
#include <utils/builtins.h>
#include "types/parser.h"
#include "types/byte.h"


int8 byte_parse(char *data, int size)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    uint8 tmp = 0;
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

        if(unlikely(tmp > -(PG_INT8_MIN / 10)))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:byte out of range")));

        tmp = tmp * 10 + digit;
    }

    if(pos == begin)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:byte literal")));

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:byte literal")));

    if(neg)
    {
        int16 result = -(int16) tmp;

        if(unlikely(result < PG_INT8_MIN))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:byte out of range")));

        return (int8) result;
    }

    if(unlikely(tmp > PG_INT8_MAX))
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:byte out of range")));

    return (int8) tmp;
}


int byte_print(int8 value, char *buffer)
{
    uint8 uvalue = value;
    int size = 0;

    if(value < 0)
    {
        uvalue = (uint8) 0 - uvalue;
        buffer[size++] = '-';
    }

    return size + pg_ultoa_n(uvalue, buffer + size);
}
