#include <postgres.h>
#include <fmgr.h>
#include <utils/float.h>
#include <math.h>
#include "ryu/ryu.h"
#include "types/parser.h"
#include "types/decimal.h"
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

        if(pos == num_pos || pos - num_pos == (data[num_pos] == '.'))
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


/*
 * The exact value of a finite double, which is what XPath asks of a cast to xsd:decimal or, after the truncation
 * towards zero, to xsd:integer.  PostgreSQL's float8_numeric() is of no use here: it goes through a text form of
 * DBL_DIG significant digits and so turns 2^53 into 9007199254740990.  A double is mantissa * 2^exponent with an
 * integer mantissa, so the value is either an integer, or mantissa * 5^-exponent / 10^-exponent, and both are
 * computed exactly by the numeric arithmetic.  The largest doubles take 309 digits and the smallest subnormal
 * 1074 decimal places, which a numeric still holds.
 */
Numeric double_as_numeric(float8 value)
{
    int exponent;
    int64 mantissa = (int64) ldexp(frexp(value, &exponent), 53);
    exponent -= 53;

    while(mantissa != 0 && mantissa % 2 == 0)
    {
        mantissa /= 2;
        exponent++;
    }

    Numeric result = numeric_from_int64(mantissa);

    if(mantissa == 0 || exponent == 0)
        return result;

    if(exponent > 0)
    {
        Numeric power = get_numeric_power(2, exponent);
        Numeric product = numeric_multiply(result, power);

        pfree(result);
        pfree(power);

        return product;
    }
    else
    {
        Numeric power = get_numeric_power(5, -exponent);
        Numeric scaled = numeric_multiply(result, power);

        char *scale_string = psprintf("1e%d", exponent);
        Numeric scale = numeric_from_string(scale_string);
        Numeric product = numeric_multiply(scaled, scale);

        pfree(result);
        pfree(power);
        pfree(scaled);
        pfree(scale_string);
        pfree(scale);

        return product;
    }
}
