/**
 * @file
 * Parsing of the lexical forms of xsd:integer and of the types derived from it by a bound, and the checks of the
 * values of the derived types.
 */
#include <postgres.h>
#include <utils/numeric.h>
#include "constants.h"
#include "types/parser.h"
#include "types/integer.h"


/**
 * Parses a lexical form of xsd:integer, an optionally signed sequence of decimal digits surrounded by optional XML
 * Schema whitespace.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @param type the name of the datatype for the error message
 * @return the palloc'd value; a malformed form raises an error
 */
static Numeric parse(char *data, int size, const char *type)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    int begin = pos;

    if(pos < size && (data[pos] == '-' || data[pos] == '+'))
        pos++;

    if(pos == size || !xsd_isdigit(data[pos]))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed %s literal", type)));

    while(pos < size && xsd_isdigit(data[pos]))
        pos++;

    char *cstring = palloc(pos - begin + 1);
    memcpy(cstring, data + begin, pos - begin);
    cstring[pos - begin] = '\0';

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed %s literal", type)));

    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(cstring), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}


/**
 * Returns the sign of a numeric.
 *
 * @param value the value
 * @return -1, 0 or 1 if the value is negative, zero or positive; NaN counts as positive, as numeric_cmp() has it
 */
int integer_sign(Numeric value)
{
    return DatumGetInt32(DirectFunctionCall2(numeric_cmp, NumericGetDatum(value), NumericGetDatum(get_zero())));
}


/**
 * Checks the bound of a type derived from xsd:integer; the types derived from xsd:integer by a bound are those whose
 * sign lies in a range.
 *
 * @param value the integer
 * @param min_sign the least allowed sign
 * @param max_sign the greatest allowed sign
 * @param type the name of the datatype for the error message
 * @return the value; a value of a sign out of the range raises an error
 */
static Numeric bounded(Numeric value, int min_sign, int max_sign, const char *type)
{
    int sign = integer_sign(value);

    if(sign < min_sign || sign > max_sign)
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("%s out of range", type)));

    return value;
}


/**
 * Parses a lexical form of xsd:integer, an optionally signed sequence of decimal digits surrounded by optional XML
 * Schema whitespace.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the palloc'd value; a malformed form raises an error
 */
Numeric integer_parse(char *data, int size)
{
    return parse(data, size, "xsd:integer");
}


/**
 * Parses a lexical form of xsd:nonPositiveInteger, which is that of xsd:integer.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the palloc'd value; a malformed form or a positive value raises an error
 */
Numeric nonpositiveinteger_parse(char *data, int size)
{
    return bounded(parse(data, size, "xsd:nonPositiveInteger"), -1, 0, "xsd:nonPositiveInteger");
}


/**
 * Parses a lexical form of xsd:negativeInteger, which is that of xsd:integer.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the palloc'd value; a malformed form or a value that is not negative raises an error
 */
Numeric negativeinteger_parse(char *data, int size)
{
    return bounded(parse(data, size, "xsd:negativeInteger"), -1, -1, "xsd:negativeInteger");
}


/**
 * Parses a lexical form of xsd:nonNegativeInteger, which is that of xsd:integer.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the palloc'd value; a malformed form or a negative value raises an error
 */
Numeric nonnegativeinteger_parse(char *data, int size)
{
    return bounded(parse(data, size, "xsd:nonNegativeInteger"), 0, 1, "xsd:nonNegativeInteger");
}


/**
 * Parses a lexical form of xsd:positiveInteger, which is that of xsd:integer.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the palloc'd value; a malformed form or a value that is not positive raises an error
 */
Numeric positiveinteger_parse(char *data, int size)
{
    return bounded(parse(data, size, "xsd:positiveInteger"), 1, 1, "xsd:positiveInteger");
}


#ifdef PGSPARQL_EXTRA_CHECKS
/**
 * Checks that a numeric is a value of xsd:integer or of a type derived from it by a bound.
 *
 * @param value the numeric
 * @param min_sign the least allowed sign
 * @param max_sign the greatest allowed sign
 * @param type the name of the datatype for the error message
 * @return the value; NaN, an infinity, a value with a fractional part or a value of a sign out of the range raises
 *         an error
 */
static Numeric check(Numeric value, int min_sign, int max_sign, const char *type)
{
    /* NaN and the infinities are not integers, and neither is a value with a fractional part */
    Datum truncated = DirectFunctionCall2(numeric_trunc, NumericGetDatum(value), Int32GetDatum(0));

    if(numeric_is_nan(value) || numeric_is_inf(value) || !DatumGetBool(DirectFunctionCall2(numeric_eq, NumericGetDatum(value), truncated)))
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("%s is not an integer", type)));

    return bounded(value, min_sign, max_sign, type);
}


/**
 * Checks that a numeric holds an xsd:integer.
 *
 * The constructors take the value as a numeric, which may not be an integer. It is the responsibility of the caller
 * not to pass such a value; the check is compiled in only with `--enable-extra-checks`, otherwise checked_integer()
 * is a macro that passes the value through.
 *
 * @param value the numeric
 * @return the value; a value that is not an xsd:integer raises an error
 */
Numeric checked_integer(Numeric value)
{
    return check(value, -1, 1, "xsd:integer");
}


/**
 * Checks that a numeric holds an xsd:nonPositiveInteger.
 *
 * The constructors take the value as a numeric, which may not be an integer or may be positive. It is the
 * responsibility of the caller not to pass such a value; the check is compiled in only with `--enable-extra-checks`,
 * otherwise checked_nonpositiveinteger() is a macro that passes the value through.
 *
 * @param value the numeric
 * @return the value; a value that is not an xsd:nonPositiveInteger raises an error
 */
Numeric checked_nonpositiveinteger(Numeric value)
{
    return check(value, -1, 0, "xsd:nonPositiveInteger");
}


/**
 * Checks that a numeric holds an xsd:negativeInteger.
 *
 * The constructors take the value as a numeric, which may not be an integer or may not be negative. It is the
 * responsibility of the caller not to pass such a value; the check is compiled in only with `--enable-extra-checks`,
 * otherwise checked_negativeinteger() is a macro that passes the value through.
 *
 * @param value the numeric
 * @return the value; a value that is not an xsd:negativeInteger raises an error
 */
Numeric checked_negativeinteger(Numeric value)
{
    return check(value, -1, -1, "xsd:negativeInteger");
}


/**
 * Checks that a numeric holds an xsd:nonNegativeInteger.
 *
 * The constructors take the value as a numeric, which may not be an integer or may be negative. It is the
 * responsibility of the caller not to pass such a value; the check is compiled in only with `--enable-extra-checks`,
 * otherwise checked_nonnegativeinteger() is a macro that passes the value through.
 *
 * @param value the numeric
 * @return the value; a value that is not an xsd:nonNegativeInteger raises an error
 */
Numeric checked_nonnegativeinteger(Numeric value)
{
    return check(value, 0, 1, "xsd:nonNegativeInteger");
}


/**
 * Checks that a numeric holds an xsd:positiveInteger.
 *
 * The constructors take the value as a numeric, which may not be an integer or may not be positive. It is the
 * responsibility of the caller not to pass such a value; the check is compiled in only with `--enable-extra-checks`,
 * otherwise checked_positiveinteger() is a macro that passes the value through.
 *
 * @param value the numeric
 * @return the value; a value that is not an xsd:positiveInteger raises an error
 */
Numeric checked_positiveinteger(Numeric value)
{
    return check(value, 1, 1, "xsd:positiveInteger");
}
#endif
