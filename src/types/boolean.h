#ifndef TYPES_BOOLEAN_H_
#define TYPES_BOOLEAN_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


#define BOOLEAN_MAXLEN 5


bool boolean_parse(char *data, int size);
int boolean_print(bool value, char *buffer);


static inline VarChar *boolean_as_varchar(bool value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + BOOLEAN_MAXLEN);
    int size = boolean_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_BOOLEAN_H_ */
