#ifndef TYPES_UNSIGNEDBYTE_H_
#define TYPES_UNSIGNEDBYTE_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


#define UNSIGNEDBYTE_MAXLEN 3


/*
 * The SQL type that stands for xsd:unsignedByte is int2, so a constructor may be handed a value that xsd:unsignedByte
 * cannot hold. It is the responsibility of the caller not to do so; the check is compiled in only with
 * --enable-extra-checks.
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline uint8 checked_unsignedbyte(int16 value)
{
    if(value < 0 || value > PG_UINT8_MAX)
        ereport(ERROR, (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), errmsg("xsd:unsignedByte out of range")));

    return (uint8) value;
}
#else
#define checked_unsignedbyte(x)    ((uint8) (x))
#endif


uint8 unsignedbyte_parse(char *data, int size);
int unsignedbyte_print(uint8 value, char *buffer);


static inline VarChar *unsignedbyte_as_varchar(uint8 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + UNSIGNEDBYTE_MAXLEN);
    int size = unsignedbyte_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_UNSIGNEDBYTE_H_ */
