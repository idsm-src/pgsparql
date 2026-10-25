/**
 * @file
 * The type zoneddatetime, an xsd:dateTime with an optional time zone, and the lexical forms of xsd:dateTime.
 */
#ifndef TYPES_DATETIME_H_
#define TYPES_DATETIME_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <fmgr.h>
#include <utils/timestamp.h>


/**
 * An xsd:dateTime with an optional time zone, the value of the type zoneddatetime, which is passed by reference.
 */
typedef struct
{
    TimestampTz value;  /**< the instant; a date-time without a time zone holds its local date and time taken as UTC */
    int32 zone;         /**< the time zone offset in seconds east of UTC, or #ZONE_UNSPECIFIED */
    int32 reserved;     /**< always-zero member, which leaves no undefined padding byte in the value */
}
ZonedDateTime;


/**
 * The length of the longest canonical lexical form of an xsd:dateTime, such as `294276-12-31T23:59:59.999999-14:00`.
 */
#define DATETIME_MAXLEN 34

/**
 * Converts a Datum to a zoneddatetime.
 *
 * @param X the Datum
 * @return the pointer to the zoneddatetime
 */
#define DatumGetZonedDateTime(X)  ((ZonedDateTime *) DatumGetPointer(X))

/**
 * Converts a zoneddatetime to a Datum.
 *
 * @param X the pointer to the zoneddatetime
 * @return the Datum
 */
#define ZonedDateTimeGetDatum(X) PointerGetDatum(X)

/**
 * Fetches a zoneddatetime argument of a version-1 function.
 *
 * @param X the number of the argument
 * @return the pointer to the zoneddatetime
 */
#define PG_GETARG_ZONEDDATETIME_P(X) DatumGetZonedDateTime(PG_GETARG_DATUM(X))

/**
 * Returns a zoneddatetime from a version-1 function.
 *
 * @param X the pointer to the zoneddatetime
 */
#define PG_RETURN_ZONEDDATETIME_P(X) return ZonedDateTimeGetDatum(X)

/**
 * Fetches the date-time argument of a version-1 function that is called either with a single zoneddatetime or with a
 * timestamptz and an int4 time zone.
 *
 * @return the copy of the zoneddatetime
 */
#define PG_GETARG_DATETIME() (PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) : (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) })


/**
 * Checks that an instant handed to a constructor is a value of xsd:dateTime, which an infinite timestamp is not.
 *
 * It is the responsibility of the caller to pass a finite instant; the check is compiled in only with
 * `--enable-extra-checks`, otherwise checked_timestamp() is a macro that passes the value through.
 *
 * @param value the instant
 * @return the instant; an infinite timestamp or one out of range raises an error
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline TimestampTz checked_timestamp(TimestampTz value)
{
    if(!IS_VALID_TIMESTAMP(value))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("xsd:dateTime out of range")));

    return value;
}
#else
#define checked_timestamp(x)    (x)
#endif


ZonedDateTime *datetime_parse(char *data, int size);
int datetime_print(ZonedDateTime *value, char *buffer);
int datetime_order_compare(ZonedDateTime *left, ZonedDateTime *right);


/**
 * Prints the canonical lexical form of an xsd:dateTime into a new varchar.
 *
 * @param value the value
 * @return the palloc'd varchar
 */
static inline VarChar *datetime_as_varchar(ZonedDateTime *value)
{
    VarChar *result = (VarChar *) palloc0(VARHDRSZ + DATETIME_MAXLEN);
    int size = datetime_print(value, VARDATA(result));
    SET_VARSIZE(result, VARHDRSZ + size);
    return result;
}


Datum zoneddatetime_input(PG_FUNCTION_ARGS);
Datum zoneddatetime_output(PG_FUNCTION_ARGS);
Datum zoneddatetime_recv(PG_FUNCTION_ARGS);
Datum zoneddatetime_send(PG_FUNCTION_ARGS);

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

Datum zoneddatetime_order_is_equal_to(PG_FUNCTION_ARGS);
Datum zoneddatetime_order_is_not_equal_to(PG_FUNCTION_ARGS);
Datum zoneddatetime_order_is_less_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_order_is_greater_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_order_is_not_less_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_order_is_not_greater_than(PG_FUNCTION_ARGS);
Datum zoneddatetime_order_compare(PG_FUNCTION_ARGS);

Datum zoneddatetime_hash(PG_FUNCTION_ARGS);
Datum zoneddatetime_hash_extended(PG_FUNCTION_ARGS);

#endif /* TYPES_DATETIME_H_ */
