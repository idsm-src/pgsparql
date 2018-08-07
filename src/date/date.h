#ifndef DATE_DATE_H_
#define DATE_DATE_H_

#include <postgres.h>
#include <utils/date.h>


typedef struct
{
    DateADT value;
    int32 zone;
} ZonedDate;


static inline ZonedDate DatumGetZonedDate(Datum val)
{
#if SIZEOF_DATUM == 4
    return *((ZonedDate *) DatumGetPointer(val));
#else
    union
    {
        int64 value;
        ZonedDate retval;
    } myunion;

    myunion.value = DatumGetInt64(val);
    return myunion.retval;
#endif
}


static inline Datum ZonedDateGetDatum(ZonedDate val)
{
#if SIZEOF_DATUM == 4
    ZonedDate *retval = (ZonedDate *) palloc(sizeof(ZonedDate));

    *retval = val;
    return PointerGetDatum(retval);
#else
    union
    {
        ZonedDate value;
        int64 retval;
    } myunion;

    myunion.value = val;
    return Int64GetDatum(myunion.retval);
#endif
}


#define PG_GETARG_ZONEDDATE(X)          DatumGetZonedDate(PG_GETARG_DATUM(X))
#define PG_RETURN_ZONEDDATE(X)          return ZonedDateGetDatum(X)


Datum zoneddate_input(PG_FUNCTION_ARGS);
Datum zoneddate_output(PG_FUNCTION_ARGS);

Datum zoneddate_create(PG_FUNCTION_ARGS);
Datum zoneddate_date(PG_FUNCTION_ARGS);
Datum zoneddate_zone(PG_FUNCTION_ARGS);

Datum zoneddate_equal(PG_FUNCTION_ARGS);
Datum zoneddate_not_equal(PG_FUNCTION_ARGS);
Datum zoneddate_less_than(PG_FUNCTION_ARGS);
Datum zoneddate_greater_than(PG_FUNCTION_ARGS);
Datum zoneddate_not_less_than(PG_FUNCTION_ARGS);
Datum zoneddate_not_greater_than(PG_FUNCTION_ARGS);
Datum zoneddate_compare(PG_FUNCTION_ARGS);

#endif /* DATE_DATE_H_ */
