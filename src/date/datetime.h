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
#define PG_GETARG_ZONEDDATETIME_P(X)    DatumGetZonedDateTime(PG_GETARG_DATUM(X))
#define PG_RETURN_ZONEDDATETIME_P(X)    return ZonedDateTimeGetDatum(X)


Datum zoneddatetime_input(PG_FUNCTION_ARGS);
Datum zoneddatetime_output(PG_FUNCTION_ARGS);

Datum zoneddatetime_equal(PG_FUNCTION_ARGS);
Datum zoneddatetime_not_equal(PG_FUNCTION_ARGS);
Datum zoneddatetime_less_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_greater_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_not_less_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_not_greater_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_compare(PG_FUNCTION_ARGS);

#endif /* DATE_DATETIME_H_ */
