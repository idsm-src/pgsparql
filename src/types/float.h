#ifndef TYPES_FLOAT_H_
#define TYPES_FLOAT_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/numeric.h>
#include "types/double.h"


#define FLOAT_MAXLEN 16


float4 float_parse(char *data, int size);
int float_print(float4 value, char *buffer);


static inline VarChar *float_as_varchar(float4 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + FLOAT_MAXLEN);
    int size = float_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}


/* every float is exactly representable as a double */
static inline Numeric float_as_numeric(float4 value)
{
    return double_as_numeric(value);
}

#endif /* TYPES_FLOAT_H_ */
