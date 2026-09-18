#ifndef TYPES_UNSIGNEDSHORT_H_
#define TYPES_UNSIGNEDSHORT_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


#define UNSIGNEDSHORT_MAXLEN 5


/*
 * The SQL type that stands for xsd:unsignedShort is int4, so a constructor may be handed a value that xsd:unsignedShort
 * cannot hold. It is the responsibility of the caller not to do so; the check is compiled in only with
 * --enable-extra-checks.
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline uint16 checked_unsignedshort(int32 value)
{
    if(value < 0 || value > PG_UINT16_MAX)
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedShort out of range")));

    return (uint16) value;
}
#else
#define checked_unsignedshort(x)    ((uint16) (x))
#endif


uint16 unsignedshort_parse(char *data, int size);
int unsignedshort_print(uint16 value, char *buffer);


static inline VarChar *unsignedshort_as_varchar(uint16 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + UNSIGNEDSHORT_MAXLEN);
    int size = unsignedshort_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_UNSIGNEDSHORT_H_ */
