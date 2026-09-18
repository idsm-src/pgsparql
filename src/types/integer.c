#include <postgres.h>
#include <utils/numeric.h>
#include "constants.h"
#include "types/parser.h"
#include "types/integer.h"


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


int integer_sign(Numeric value)
{
    return DatumGetInt32(DirectFunctionCall2(numeric_cmp, NumericGetDatum(value), NumericGetDatum(get_zero())));
}


/* the types derived from xsd:integer by a bound are those whose sign lies in a range */
static Numeric bounded(Numeric value, int min_sign, int max_sign, const char *type)
{
    int sign = integer_sign(value);

    if(sign < min_sign || sign > max_sign)
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("%s out of range", type)));

    return value;
}


Numeric integer_parse(char *data, int size)
{
    return parse(data, size, "xsd:integer");
}


Numeric nonpositiveinteger_parse(char *data, int size)
{
    return bounded(parse(data, size, "xsd:nonPositiveInteger"), -1, 0, "xsd:nonPositiveInteger");
}


Numeric negativeinteger_parse(char *data, int size)
{
    return bounded(parse(data, size, "xsd:negativeInteger"), -1, -1, "xsd:negativeInteger");
}


Numeric nonnegativeinteger_parse(char *data, int size)
{
    return bounded(parse(data, size, "xsd:nonNegativeInteger"), 0, 1, "xsd:nonNegativeInteger");
}


Numeric positiveinteger_parse(char *data, int size)
{
    return bounded(parse(data, size, "xsd:positiveInteger"), 1, 1, "xsd:positiveInteger");
}


#ifdef PGSPARQL_EXTRA_CHECKS
static Numeric check(Numeric value, int min_sign, int max_sign, const char *type)
{
    /* NaN and the infinities are not integers, and neither is a value with a fractional part */
    Datum truncated = DirectFunctionCall2(numeric_trunc, NumericGetDatum(value), Int32GetDatum(0));

    if(numeric_is_nan(value) || numeric_is_inf(value) || !DatumGetBool(DirectFunctionCall2(numeric_eq, NumericGetDatum(value), truncated)))
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("%s is not an integer", type)));

    return bounded(value, min_sign, max_sign, type);
}


Numeric checked_nonpositiveinteger(Numeric value)
{
    return check(value, -1, 0, "xsd:nonPositiveInteger");
}


Numeric checked_negativeinteger(Numeric value)
{
    return check(value, -1, -1, "xsd:negativeInteger");
}


Numeric checked_nonnegativeinteger(Numeric value)
{
    return check(value, 0, 1, "xsd:nonNegativeInteger");
}


Numeric checked_positiveinteger(Numeric value)
{
    return check(value, 1, 1, "xsd:positiveInteger");
}
#endif
