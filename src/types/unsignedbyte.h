/**
 * @file
 * The lexical forms of xsd:unsignedByte, whose values are held by an int2 in SQL.
 */
#ifndef TYPES_UNSIGNEDBYTE_H_
#define TYPES_UNSIGNEDBYTE_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


/**
 * The length of the longest canonical lexical form of an xsd:unsignedByte, `255`.
 */
#define UNSIGNEDBYTE_MAXLEN 3


/**
 * Checks that an int2 holds an xsd:unsignedByte.
 *
 * The SQL type that stands for xsd:unsignedByte is int2, so a constructor may be handed a value that xsd:unsignedByte
 * cannot hold. It is the responsibility of the caller not to do so; the check is compiled in only with
 * `--enable-extra-checks`, otherwise checked_unsignedbyte() is a macro that only converts the value.
 *
 * @param value the value
 * @return the value as a uint8; a value out of the range of xsd:unsignedByte raises an error
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


/**
 * Prints the canonical lexical form of an xsd:unsignedByte into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *unsignedbyte_as_varchar(uint8 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + UNSIGNEDBYTE_MAXLEN);
    int size = unsignedbyte_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_UNSIGNEDBYTE_H_ */
