#ifndef TYPES_UNSIGNEDLONG_H_
#define TYPES_UNSIGNEDLONG_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/numeric.h>
#include <utils/builtins.h>


#define UNSIGNEDLONG_MAXLEN 20


uint64 unsignedlong_parse(char *data, int size);
int unsignedlong_print(uint64 value, char *buffer);


static inline VarChar *unsignedlong_as_varchar(uint64 value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + UNSIGNEDLONG_MAXLEN);
    int size = unsignedlong_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}


/*
 * PostgreSQL has no integer type of 64 bits without a sign, so xsd:unsignedLong is represented by a numeric in SQL
 * and the conversions go through int8 where the value fits and through the text form where it does not.
 */
static inline Numeric unsignedlong_as_numeric(uint64 value)
{
    if(value <= PG_INT64_MAX)
        return DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum((int64) value)));

    char buffer[UNSIGNEDLONG_MAXLEN + 1];
    buffer[unsignedlong_print(value, buffer)] = '\0';

    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(buffer), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}


/*
 * Unlike the other constructors, the conversion cannot be done without looking at the value, so a numeric that is not
 * an integer of the range of xsd:unsignedLong is always reported as an error.
 */
static inline uint64 unsignedlong_from_numeric(Numeric value)
{
    char *string = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(value)));
    uint64 result = unsignedlong_parse(string, strlen(string));
    pfree(string);
    return result;
}

#endif /* TYPES_UNSIGNEDLONG_H_ */
