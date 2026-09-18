#ifndef TYPES_UNSIGNEDINT_H_
#define TYPES_UNSIGNEDINT_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


#define UNSIGNEDINT_MAXLEN 10


/*
 * The SQL type that stands for xsd:unsignedInt is int8, so a constructor may be handed a value that xsd:unsignedInt
 * cannot hold. It is the responsibility of the caller not to do so; the check is compiled in only with
 * --enable-extra-checks.
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline uint32 checked_unsignedint(int64 value)
{
    if(value < 0 || value > PG_UINT32_MAX)
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedInt out of range")));

    return (uint32) value;
}
#else
#define checked_unsignedint(x)    ((uint32) (x))
#endif


uint32 unsignedint_parse(char *data, int size);
int unsignedint_print(uint32 value, char *buffer);


static inline VarChar *unsignedint_as_varchar(uint32 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + UNSIGNEDINT_MAXLEN);
    int size = unsignedint_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_UNSIGNEDINT_H_ */
