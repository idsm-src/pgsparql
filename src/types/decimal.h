#ifndef TYPES_DECIMAL_H_
#define TYPES_DECIMAL_H_

#include <postgres.h>
#include <fmgr.h>
#include <string.h>
#include <utils/numeric.h>
#include <utils/builtins.h>


Numeric decimal_parse(char *data, int size);


static inline VarChar *decimal_as_varchar(Numeric value)
{
    char *result = numeric_normalize(value);

    if(strchr(result, '.'))
        return (VarChar *) cstring_to_text(result);
    else
        return (VarChar *) cstring_to_text(psprintf("%s.0", result));
}


static inline Numeric numeric_from_int64(int64 value)
{
    return DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(value)));
}


static inline Numeric numeric_from_string(const char *string)
{
    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(string), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}


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
