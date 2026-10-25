/**
 * @file
 * Parsing and printing of the lexical forms of xsd:float and the arithmetic operators of xsd:float.
 *
 * The operators follow IEEE 754: an overflow gives an infinity, an underflow zero and a division by zero an infinity
 * or NaN, where the operators of PostgreSQL raise an error.
 */
#include <postgres.h>
#include <fmgr.h>
#include <utils/float.h>
#include "ryu/ryu.h"
#include "types/parser.h"
#include "types/float.h"


/**
 * Parses a lexical form of xsd:float: `NaN`, `INF`, `+INF`, `-INF` or an optionally signed decimal number with an
 * optional decimal point and an optional exponent introduced by `e` or `E`, surrounded by optional XML Schema
 * whitespace.
 *
 * The number is rounded to the nearest float4 by strtof(); a number beyond the range of float4 becomes an infinity
 * and a number too close to zero becomes a subnormal number or zero.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the value; a malformed form raises an error
 */
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

        if(pos == num_pos || pos - num_pos == (data[num_pos] == '.'))
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


/**
 * Prints the canonical lexical form of an xsd:float, the shortest one that reads back as the same value, by Ryu.
 *
 * The form is the mantissa with one digit before the decimal point and at least one after it, followed by `E` and
 * the exponent, as in `1.0E0` or `-1.25E-7`; NaN, the infinities and the zeros are printed as `NaN`, `INF`, `-INF`,
 * `0.0E0` and `-0.0E0`.
 *
 * @param value the value
 * @param buffer the buffer, with room for at least #FLOAT_MAXLEN bytes; no terminating zero byte is written
 * @return the number of bytes written
 */
int float_print(float4 value, char *buffer)
{
    return f2s_buffered_n(value, buffer, true);
}


/**
 * Negates an xsd:float, the unary operator `-` on float4 in the schema sparql.
 *
 * @param fcinfo the float4 operand
 * @return the negated float4
 */
PG_FUNCTION_INFO_V1(float_uminus);
Datum float_uminus(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(-PG_GETARG_FLOAT4(0));
}


/**
 * Adds two xsd:float values, the operator `+` on float4 in the schema sparql.
 *
 * @param fcinfo the two float4 operands
 * @return the float4 sum
 */
PG_FUNCTION_INFO_V1(float_add);
Datum float_add(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) + PG_GETARG_FLOAT4(1));
}


/**
 * Subtracts two xsd:float values, the operator `-` on float4 in the schema sparql.
 *
 * @param fcinfo the float4 minuend and subtrahend
 * @return the float4 difference
 */
PG_FUNCTION_INFO_V1(float_sub);
Datum float_sub(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) - PG_GETARG_FLOAT4(1));
}


/**
 * Multiplies two xsd:float values, the operator `*` on float4 in the schema sparql.
 *
 * @param fcinfo the two float4 factors
 * @return the float4 product
 */
PG_FUNCTION_INFO_V1(float_mul);
Datum float_mul(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) * PG_GETARG_FLOAT4(1));
}


/**
 * Divides two xsd:float values, the operator `/` on float4 in the schema sparql.
 *
 * @param fcinfo the float4 dividend and divisor
 * @return the float4 quotient, an infinity or NaN for a division by zero
 */
PG_FUNCTION_INFO_V1(float_div);
Datum float_div(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) / PG_GETARG_FLOAT4(1));
}
