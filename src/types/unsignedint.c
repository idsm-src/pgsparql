/**
 * @file
 * Parsing and printing of the lexical forms of xsd:unsignedInt.
 */
#include <postgres.h>
#include <utils/builtins.h>
#include "types/parser.h"
#include "types/unsignedint.h"


/**
 * Parses a lexical form of xsd:unsignedInt, an optionally signed sequence of decimal digits surrounded by optional
 * XML Schema whitespace; the minus sign is allowed only for zero.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the value; a malformed form or a value out of the range of xsd:unsignedInt raises an error
 */
uint32 unsignedint_parse(char *data, int size)
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

        if(unlikely(tmp > PG_UINT32_MAX))
            ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedInt out of range")));

        tmp = tmp * 10 + digit;
    }

    if(pos == begin)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:unsignedInt literal")));

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:unsignedInt literal")));

    /* the lexical space allows the minus sign, but only zero can be written with it */
    if(unlikely(tmp > PG_UINT32_MAX || (neg && tmp != 0)))
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedInt out of range")));

    return (uint32) tmp;
}


/**
 * Prints the canonical lexical form of an xsd:unsignedInt.
 *
 * @param value the value
 * @param buffer the buffer, with room for at least #UNSIGNEDINT_MAXLEN bytes; no terminating zero byte is written
 * @return the number of bytes written
 */
int unsignedint_print(uint32 value, char *buffer)
{
    return pg_ultoa_n(value, buffer);
}
