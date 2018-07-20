#ifndef DATE_DATETIME_H_
#define DATE_DATETIME_H_

#include <postgres.h>
#include <utils/timestamp.h>


typedef struct
{
    TimestampTz value;
    int32 zone;
} ZonedDateTime;


#define DatumGetZonedDateTime(X)        ((ZonedDateTime *) DatumGetPointer(X))
#define ZonedDateTimeGetDatum(X)        PointerGetDatum(X)
#define PG_GETARG_ZONEDDATETIME_P(n)    DatumGetZonedDateTime(PG_GETARG_DATUM(n))
#define PG_RETURN_ZONEDDATETIME_P(x)    return ZonedDateTimeGetDatum(x)


Datum zoneddatetime_input(PG_FUNCTION_ARGS);
Datum zoneddatetime_output(PG_FUNCTION_ARGS);

#endif /* DATE_DATETIME_H_ */
