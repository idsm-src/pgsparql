#ifndef TYPES_BYTE_H_
#define TYPES_BYTE_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


#define BYTE_MAXLEN 4


/*
 * The SQL type that stands for xsd:byte is int2, so a constructor may be handed a value that xsd:byte cannot hold.
 * It is the responsibility of the caller not to do so; the check is compiled in only with --enable-extra-checks.
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline int8 checked_byte(int16 value)
{
    if(value < PG_INT8_MIN || value > PG_INT8_MAX)
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:byte out of range")));

    return (int8) value;
}
#else
#define checked_byte(x)    ((int8) (x))
#endif


int8 byte_parse(char *data, int size);
int byte_print(int8 value, char *buffer);


static inline VarChar *byte_as_varchar(int8 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + BYTE_MAXLEN);
    int size = byte_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_BYTE_H_ */
