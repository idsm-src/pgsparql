#ifndef TYPES_DATETIME_H_
#define TYPES_DATETIME_H_

#include <postgres.h>
#include <fmgr.h>
#include <utils/timestamp.h>


typedef struct
{
    TimestampTz value;
    int32 zone;
}
ZonedDateTime;


#define DatumGetZonedDateTime(X)  ((ZonedDateTime *) DatumGetPointer(X))
#define ZonedDateTimeGetDatum(X) PointerGetDatum(X)
#define PG_GETARG_ZONEDDATETIME_P(X) DatumGetZonedDateTime(PG_GETARG_DATUM(X))
#define PG_RETURN_ZONEDDATETIME_P(X) return ZonedDateTimeGetDatum(X)

#define PG_GETARG_DATETIME() (PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) : (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) })


Datum zoneddatetime_input(PG_FUNCTION_ARGS);
Datum zoneddatetime_output(PG_FUNCTION_ARGS);

Datum zoneddatetime_create(PG_FUNCTION_ARGS);
Datum zoneddatetime_get_value(PG_FUNCTION_ARGS);
Datum zoneddatetime_get_value_of_zone(PG_FUNCTION_ARGS);
Datum zoneddatetime_get_zone(PG_FUNCTION_ARGS);

Datum zoneddatetime_is_same_as(PG_FUNCTION_ARGS);
Datum zoneddatetime_is_equal_to(PG_FUNCTION_ARGS);
Datum zoneddatetime_is_not_equal_to(PG_FUNCTION_ARGS);
Datum zoneddatetime_is_less_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_is_greater_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_is_not_less_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_is_not_greater_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_compare(PG_FUNCTION_ARGS);

#endif /* TYPES_DATETIME_H_ */
