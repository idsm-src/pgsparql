/**
 * @file
 * The lexical forms of xsd:unsignedInt, whose values are held by an int8 in SQL.
 */
#ifndef TYPES_UNSIGNEDINT_H_
#define TYPES_UNSIGNEDINT_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


/**
 * The length of the longest canonical lexical form of an xsd:unsignedInt, `4294967295`.
 */
#define UNSIGNEDINT_MAXLEN 10


/**
 * Checks that an int8 holds an xsd:unsignedInt.
 *
 * The SQL type that stands for xsd:unsignedInt is int8, so a constructor may be handed a value that xsd:unsignedInt
 * cannot hold. It is the responsibility of the caller not to do so; the check is compiled in only with
 * `--enable-extra-checks`, otherwise checked_unsignedint() is a macro that only converts the value.
 *
 * @param value the value
 * @return the value as a uint32; a value out of the range of xsd:unsignedInt raises an error
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


/**
 * Prints the canonical lexical form of an xsd:unsignedInt into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *unsignedint_as_varchar(uint32 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + UNSIGNEDINT_MAXLEN);
    int size = unsignedint_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_UNSIGNEDINT_H_ */
