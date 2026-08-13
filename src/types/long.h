#ifndef TYPES_LONG_H_
#define TYPES_LONG_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/builtins.h>


#define LONG_MAXLEN MAXINT8LEN


int64 long_parse(char *data, int size);
int long_print(int64 value, char *buffer);


static inline VarChar *long_as_varchar(int64 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + LONG_MAXLEN);
    int size = long_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_LONG_H_ */
