#ifndef DATE_DATE_H_
#define DATE_DATE_H_

#include <postgres.h>
#include <utils/date.h>


typedef struct
{
    DateADT value;
    int16 zone;
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

    myunion.retval = 0;
    myunion.value = val;
    return Int64GetDatum(myunion.retval);
#endif
}


#define PG_GETARG_ZONEDDATE(n)          DatumGetZonedDate(PG_GETARG_DATUM(n))
#define PG_RETURN_ZONEDDATE(x)          return ZonedDateGetDatum(x)


Datum zoneddate_input(PG_FUNCTION_ARGS);
Datum zoneddate_output(PG_FUNCTION_ARGS);

#endif /* DATE_DATE_H_ */
