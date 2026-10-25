/**
 * @file
 * The lexical forms of xsd:boolean, whose values are held by a bool in SQL.
 */
#ifndef TYPES_BOOLEAN_H_
#define TYPES_BOOLEAN_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


/**
 * The length of the longest canonical lexical form of an xsd:boolean, `false`.
 */
#define BOOLEAN_MAXLEN 5


bool boolean_parse(char *data, int size);
int boolean_print(bool value, char *buffer);


/**
 * Prints the canonical lexical form of an xsd:boolean into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *boolean_as_varchar(bool value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + BOOLEAN_MAXLEN);
    int size = boolean_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_BOOLEAN_H_ */
