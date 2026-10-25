/**
 * @file
 * The lexical forms of xsd:int, whose values are held by an int4 in SQL.
 */
#ifndef TYPES_INT_H_
#define TYPES_INT_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


/**
 * The length of the longest canonical lexical form of an xsd:int, `-2147483648`.
 */
#define INT_MAXLEN 11


int32 int_parse(char *data, int size);
int int_print(int32 value, char *buffer);


/**
 * Prints the canonical lexical form of an xsd:int into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *int_as_varchar(int32 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + INT_MAXLEN);
    int size = int_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_INT_H_ */
