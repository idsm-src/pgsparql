/**
 * @file
 * The lexical forms and the arithmetic of xsd:decimal, whose values are held by a numeric in SQL, and helpers for the
 * numeric arithmetic.
 */
#ifndef TYPES_DECIMAL_H_
#define TYPES_DECIMAL_H_

#include <postgres.h>
#include <fmgr.h>
#include <string.h>
#include <utils/numeric.h>
#include <utils/builtins.h>


Numeric decimal_parse(char *data, int size);


/*
 * xsd:decimal is represented by a numeric in SQL, so a constructor may be handed NaN or an infinity, which are no
 * values of xsd:decimal. It is the responsibility of the caller not to do so; the check is compiled in only with
 * --enable-extra-checks.
 */
#ifdef PGSPARQL_EXTRA_CHECKS
Numeric checked_decimal(Numeric value);
#else
#define checked_decimal(x)    (x)
#endif


/**
 * Prints the canonical lexical form of an xsd:decimal into a new varchar: the value without trailing zeros of its
 * fraction but with at least one fractional digit, as in `1.0` or `-0.25`.
 *
 * @param value the value, which is finite
 * @return the palloc'd varchar
 */
static inline VarChar *decimal_as_varchar(Numeric value)
{
    char *result = numeric_normalize(value);

    if(strchr(result, '.'))
        return (VarChar *) cstring_to_text(result);
    else
        return (VarChar *) cstring_to_text(psprintf("%s.0", result));
}


/**
 * Converts an int64 to a numeric.
 *
 * @param value the value
 * @return the palloc'd numeric
 */
static inline Numeric numeric_from_int64(int64 value)
{
    return DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(value)));
}


/**
 * Converts the text form of a numeric to a numeric.
 *
 * @param string the zero-terminated text form, as numeric_in() reads it
 * @return the palloc'd numeric; an invalid text form raises an error
 */
static inline Numeric numeric_from_string(const char *string)
{
    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(string), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}


/**
 * Multiplies two numerics.
 *
 * @param left the left factor
 * @param right the right factor
 * @return the palloc'd product
 */
static inline Numeric numeric_multiply(Numeric left, Numeric right)
{
    return DatumGetNumeric(DirectFunctionCall2(numeric_mul, NumericGetDatum(left), NumericGetDatum(right)));
}


Numeric get_numeric_power(int base, int exponent);


Datum decimal_uminus(PG_FUNCTION_ARGS);
Datum decimal_add(PG_FUNCTION_ARGS);
Datum decimal_sub(PG_FUNCTION_ARGS);
Datum decimal_mul(PG_FUNCTION_ARGS);
Datum decimal_div(PG_FUNCTION_ARGS);

#endif /* TYPES_DECIMAL_H_ */
