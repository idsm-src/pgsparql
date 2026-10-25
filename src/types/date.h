/**
 * @file
 * The type zoneddate, an xsd:date with an optional time zone, and the lexical forms of xsd:date.
 */
#ifndef TYPES_DATE_H_
#define TYPES_DATE_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <fmgr.h>
#include <utils/date.h>


/**
 * An xsd:date with an optional time zone, the value of the type zoneddate.
 *
 * It is eight bytes long and has the representation of int8, which its SQL declaration copies by `LIKE`: it is
 * packed into the Datum where float8 is passed by value (`USE_FLOAT8_BYVAL`) and passed by reference otherwise.
 */
typedef struct
{
    DateADT value;  /**< the date as written, in days since 2000-01-01 */
    int32 zone;     /**< the time zone offset in seconds east of UTC, or #ZONE_UNSPECIFIED */
}
ZonedDate;


/**
 * Converts a Datum to a zoneddate.
 *
 * @param val the Datum
 * @return the zoneddate
 */
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


/**
 * Converts a zoneddate to a Datum.
 *
 * @param val the zoneddate
 * @return the Datum
 */
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


/**
 * The length of the longest canonical lexical form of an xsd:date, such as `5874897-12-31+14:00`.
 */
#define DATE_MAXLEN 19

/**
 * Fetches a zoneddate argument of a version-1 function.
 *
 * @param X the number of the argument
 * @return the zoneddate
 */
#define PG_GETARG_ZONEDDATE(X) DatumGetZonedDate(PG_GETARG_DATUM(X))

/**
 * Returns a zoneddate from a version-1 function.
 *
 * @param X the zoneddate
 */
#define PG_RETURN_ZONEDDATE(X) return ZonedDateGetDatum(X)

/**
 * Fetches the date argument of a version-1 function that is called either with a single zoneddate or with a date and
 * an int4 time zone.
 *
 * @return the zoneddate
 */
#define PG_GETARG_DATE() (PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) : (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) })


ZonedDate date_parse(char *data, int size);
int date_print(ZonedDate value, char *buffer);
int date_order_compare(ZonedDate left, ZonedDate right);


/**
 * Prints the canonical lexical form of an xsd:date into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *date_as_varchar(ZonedDate value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + DATE_MAXLEN);
    int size = date_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}


Datum zoneddate_input(PG_FUNCTION_ARGS);
Datum zoneddate_output(PG_FUNCTION_ARGS);
Datum zoneddate_recv(PG_FUNCTION_ARGS);
Datum zoneddate_send(PG_FUNCTION_ARGS);

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

Datum zoneddate_order_is_equal_to(PG_FUNCTION_ARGS);
Datum zoneddate_order_is_not_equal_to(PG_FUNCTION_ARGS);
Datum zoneddate_order_is_less_than(PG_FUNCTION_ARGS);
Datum zoneddate_order_is_greater_than(PG_FUNCTION_ARGS);
Datum zoneddate_order_is_not_less_than(PG_FUNCTION_ARGS);
Datum zoneddate_order_is_not_greater_than(PG_FUNCTION_ARGS);
Datum zoneddate_order_compare(PG_FUNCTION_ARGS);

Datum zoneddate_hash(PG_FUNCTION_ARGS);
Datum zoneddate_hash_extended(PG_FUNCTION_ARGS);

#endif /* TYPES_DATE_H_ */
