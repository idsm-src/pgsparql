/**
 * @file
 * The lexical forms of xsd:byte, whose values are held by an int2 in SQL.
 */
#ifndef TYPES_BYTE_H_
#define TYPES_BYTE_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


/**
 * The length of the longest canonical lexical form of an xsd:byte, `-128`.
 */
#define BYTE_MAXLEN 4


/**
 * Checks that an int2 holds an xsd:byte.
 *
 * The SQL type that stands for xsd:byte is int2, so a constructor may be handed a value that xsd:byte cannot hold.
 * It is the responsibility of the caller not to do so; the check is compiled in only with `--enable-extra-checks`,
 * otherwise checked_byte() is a macro that only converts the value.
 *
 * @param value the value
 * @return the value as an int8; a value out of the range of xsd:byte raises an error
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


/**
 * Prints the canonical lexical form of an xsd:byte into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *byte_as_varchar(int8 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + BYTE_MAXLEN);
    int size = byte_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_BYTE_H_ */
