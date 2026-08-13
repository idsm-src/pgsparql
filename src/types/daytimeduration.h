#ifndef TYPES_DAYTIMEDURATION_H_
#define TYPES_DAYTIMEDURATION_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


#define DAYTIMEDURATION_MAXLEN 32


int64 daytimeduration_parse(char *data, int size);
int daytimeduration_print(int64 value, char *buffer);


static inline VarChar *daytimeduration_as_varchar(int64 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + DAYTIMEDURATION_MAXLEN);
    int size = daytimeduration_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_DAYTIMEDURATION_H_ */
