/**
 * @file
 * The lexical forms of xsd:long, whose values are held by an int8 in SQL.
 */
#ifndef TYPES_LONG_H_
#define TYPES_LONG_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/builtins.h>


/**
 * The length of the longest canonical lexical form of an xsd:long, `-9223372036854775808`.
 */
#define LONG_MAXLEN MAXINT8LEN


int64 long_parse(char *data, int size);
int long_print(int64 value, char *buffer);


/**
 * Prints the canonical lexical form of an xsd:long into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *long_as_varchar(int64 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + LONG_MAXLEN);
    int size = long_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_LONG_H_ */
