/**
 * @file
 * The lexical forms of xsd:dayTimeDuration, whose values are held by an int8 in SQL, the number of microseconds.
 */
#ifndef TYPES_DAYTIMEDURATION_H_
#define TYPES_DAYTIMEDURATION_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif


/**
 * The size of a buffer that holds any canonical lexical form of an xsd:dayTimeDuration, such as
 * `-P106751990DT23H59M59.999999S`.
 */
#define DAYTIMEDURATION_MAXLEN 32


int64 daytimeduration_parse(char *data, int size);
int daytimeduration_print(int64 value, char *buffer);


/**
 * Prints the canonical lexical form of an xsd:dayTimeDuration into a new varchar.
 *
 * @param value the duration in microseconds
 * @return the palloc'd varchar
 */
static inline VarChar *daytimeduration_as_varchar(int64 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + DAYTIMEDURATION_MAXLEN);
    int size = daytimeduration_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}

#endif /* TYPES_DAYTIMEDURATION_H_ */
