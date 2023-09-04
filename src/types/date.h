#ifndef TYPES_DATE_H_
#define TYPES_DATE_H_

#include <postgres.h>
#include <fmgr.h>
#include <utils/date.h>


typedef struct
{
    DateADT value;
    int32 zone;
}
ZonedDate;


static inline ZonedDate DatumGetZonedDate(Datum val)
{
#ifdef USE_FLOAT8_BYVAL
    union
    {
        int64 value;
        ZonedDate retval;
    } myunion;

    myunion.value = DatumGetInt64(val);
    return myunion.retval;
#else
    return *((ZonedDate *) DatumGetPointer(val));
#endif
}


static inline Datum ZonedDateGetDatum(ZonedDate val)
{
#ifdef USE_FLOAT8_BYVAL
    union
    {
        ZonedDate value;
        int64 retval;
    } myunion;

    myunion.value = val;
    return Int64GetDatum(myunion.retval);
#else
    ZonedDate *retval = (ZonedDate *) palloc(sizeof(ZonedDate));

    *retval = val;
    return PointerGetDatum(retval);
#endif
}


#define PG_GETARG_ZONEDDATE(X) DatumGetZonedDate(PG_GETARG_DATUM(X))
#define PG_RETURN_ZONEDDATE(X) return ZonedDateGetDatum(X)

#define PG_GETARG_DATE() (PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) : (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) })


Datum zoneddate_input(PG_FUNCTION_ARGS);
Datum zoneddate_output(PG_FUNCTION_ARGS);

Datum zoneddate_create(PG_FUNCTION_ARGS);
Datum zoneddate_get_value(PG_FUNCTION_ARGS);
Datum zoneddate_get_value_of_zone(PG_FUNCTION_ARGS);
Datum zoneddate_get_zone(PG_FUNCTION_ARGS);

Datum zoneddate_is_same_as(PG_FUNCTION_ARGS);
Datum zoneddate_is_equal_to(PG_FUNCTION_ARGS);
Datum zoneddate_is_not_equal_to(PG_FUNCTION_ARGS);
Datum zoneddate_is_less_than(PG_FUNCTION_ARGS);
Datum zoneddate_is_greater_than(PG_FUNCTION_ARGS);
Datum zoneddate_is_not_less_than(PG_FUNCTION_ARGS);
Datum zoneddate_is_not_greater_than(PG_FUNCTION_ARGS);
Datum zoneddate_compare(PG_FUNCTION_ARGS);

#endif /* TYPES_DATE_H_ */
