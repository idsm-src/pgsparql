/**
 * @file
 * Parsing of the lexical forms of xsd:decimal and the arithmetic operators of xsd:decimal.
 *
 * The operators are those of numeric, except that a result that xsd:decimal cannot hold is NULL instead of an error
 * or NaN: a result out of the range of numeric, NaN, an infinity and the result of a division by zero.
 */
#include <postgres.h>
#include <utils/numeric.h>
#include "call.h"
#include "try-catch.h"
#include "types/parser.h"
#include "types/decimal.h"


/**
 * Parses a lexical form of xsd:decimal, an optionally signed sequence of decimal digits with an optional decimal
 * point and no exponent, surrounded by optional XML Schema whitespace; at least one digit is required.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the palloc'd value, with the scale of the lexical form; a malformed form raises an error
 */
Numeric decimal_parse(char *data, int size)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

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
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:decimal literal")));

    char *cstring = palloc(pos - begin + 1);
    memcpy(cstring, data + begin, pos - begin);
    cstring[pos - begin] = '\0';

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:decimal literal")));

    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(cstring), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}


/**
 * Computes an integer power of an integer exactly, by repeated squaring.
 *
 * @param base the base
 * @param exponent the exponent, which is not negative
 * @return the palloc'd numeric @a base to the power of @a exponent
 */
Numeric get_numeric_power(int base, int exponent)
{
    Numeric result = numeric_from_int64(1);
    Numeric power = numeric_from_int64(base);

    while(exponent > 0)
    {
        if(exponent & 1)
        {
            Numeric product = numeric_multiply(result, power);
            pfree(result);
            result = product;
        }

        exponent >>= 1;

        if(exponent > 0)
        {
            Numeric square = numeric_multiply(power, power);
            pfree(power);
            power = square;
        }
    }

    pfree(power);
    return result;
}


/**
 * Turns a numeric result that is not an xsd:decimal, NaN or an infinity, into NULL.
 *
 * @param result the result of a numeric function
 * @return @a result, or null if it is NaN or an infinity
 */
static inline NullableDatum decimal_result(NullableDatum result)
{
    if(!result.isnull)
    {
        Numeric value = DatumGetNumeric(result.value);

        if(numeric_is_inf(value) || numeric_is_nan(value))
            result = NULL_DATUM;
    }

    return result;
}


/**
 * Negates an xsd:decimal, the unary operator `-` on decimal in the schema sparql.
 *
 * @param fcinfo the numeric operand
 * @return the negated numeric, NULL if the operand is NaN or an infinity
 */
PG_FUNCTION_INFO_V1(decimal_uminus);
Datum decimal_uminus(PG_FUNCTION_ARGS)
{
    PG_RETURN(decimal_result(NullableFunctionCall1(numeric_uminus, PG_GETARG_DATUM(0))));
}


/**
 * Adds two xsd:decimal values, the operator `+` on decimal in the schema sparql.
 *
 * @param fcinfo the two numeric operands
 * @return the numeric sum, NULL if it is out of the range of numeric, NaN or an infinity
 */
PG_FUNCTION_INFO_V1(decimal_add);
Datum decimal_add(PG_FUNCTION_ARGS)
{
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_add, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(decimal_result(result));
}


/**
 * Subtracts two xsd:decimal values, the operator `-` on decimal in the schema sparql.
 *
 * @param fcinfo the numeric minuend and subtrahend
 * @return the numeric difference, NULL if it is out of the range of numeric, NaN or an infinity
 */
PG_FUNCTION_INFO_V1(decimal_sub);
Datum decimal_sub(PG_FUNCTION_ARGS)
{
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_sub, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(decimal_result(result));
}


/**
 * Multiplies two xsd:decimal values, the operator `*` on decimal in the schema sparql.
 *
 * @param fcinfo the two numeric factors
 * @return the numeric product, NULL if it is out of the range of numeric, NaN or an infinity
 */
PG_FUNCTION_INFO_V1(decimal_mul);
Datum decimal_mul(PG_FUNCTION_ARGS)
{
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_mul, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(decimal_result(result));
}


/**
 * Divides two xsd:decimal values, the operator `/` on decimal in the schema sparql.
 *
 * @param fcinfo the numeric dividend and divisor
 * @return the numeric quotient with the scale that numeric_div() chooses, NULL for a division by zero or if the
 *         quotient is out of the range of numeric, NaN or an infinity
 */
PG_FUNCTION_INFO_V1(decimal_div);
Datum decimal_div(PG_FUNCTION_ARGS)
{
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_div, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_DIVISION_BY_ZERO && sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(decimal_result(result));
}
