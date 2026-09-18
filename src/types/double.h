#ifndef TYPES_DOUBLE_H_
#define TYPES_DOUBLE_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/numeric.h>


#define DOUBLE_MAXLEN 25


float8 double_parse(char *data, int size);
int double_print(float8 value, char *buffer);
Numeric double_as_numeric(float8 value);


static inline VarChar *double_as_varchar(float8 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + DOUBLE_MAXLEN);
    int size = double_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_DOUBLE_H_ */
