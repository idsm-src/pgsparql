/**
 * @file
 * The lexical forms of xsd:float, whose values are held by a float4 in SQL.
 */
#ifndef TYPES_FLOAT_H_
#define TYPES_FLOAT_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/numeric.h>
#include "types/double.h"


/**
 * The size of a buffer that holds any canonical lexical form of an xsd:float, such as `-1.17549435E-38`.
 */
#define FLOAT_MAXLEN 16


float4 float_parse(char *data, int size);
int float_print(float4 value, char *buffer);


/**
 * Prints the canonical lexical form of an xsd:float into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *float_as_varchar(float4 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + FLOAT_MAXLEN);
    int size = float_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}


/**
 * Converts a finite xsd:float to the numeric of its exact value; every float is exactly representable as a double.
 *
 * @param value the value, which must be finite
 * @return the palloc'd numeric
 */
static inline Numeric float_as_numeric(float4 value)
{
    return double_as_numeric(value);
}

#endif /* TYPES_FLOAT_H_ */
