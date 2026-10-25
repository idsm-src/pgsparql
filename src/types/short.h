/**
 * @file
 * The lexical forms of xsd:short, whose values are held by an int2 in SQL.
 */
#ifndef TYPES_SHORT_H_
#define TYPES_SHORT_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


/**
 * The length of the longest canonical lexical form of an xsd:short, `-32768`.
 */
#define SHORT_MAXLEN 6


int16 short_parse(char *data, int size);
int short_print(int16 value, char *buffer);


/**
 * Prints the canonical lexical form of an xsd:short into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *short_as_varchar(int16 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + SHORT_MAXLEN);
    int size = short_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_SHORT_H_ */
