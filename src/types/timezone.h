#ifndef TYPES_TIMEZONE_H_
#define TYPES_TIMEZONE_H_

#include <postgres.h>
#include <datatype/timestamp.h>


/*
 * The timezone that a value without one is taken to be in, as XPath calls it.
 * It is deliberately a compile-time constant and not a variable or a GUC.
 *
 * date_order_compare() and datetime_order_compare() use it to place a value
 * with no timezone among the values that have one, and those comparisons are
 * what the default B-tree operator classes of zoneddate, zoneddatetime and
 * rdfbox are built on.  The comparison functions are therefore declared
 * IMMUTABLE and their results are stored in indexes: were the implicit
 * timezone to become settable at run time, every such index would silently go
 * stale the moment it changed, and the operators would have to be reclassified
 * as STABLE, which no operator class member may be.
 */
#define IMPLICIT_TIMEZONE               0

#define ZONE_MAX                        (14*MINS_PER_HOUR*SECS_PER_MINUTE)
#define ZONE_MIN                        (-ZONE_MAX)
#define ZONE_UNSPECIFIED                PG_INT32_MIN

#define IS_VALID_TIMEZONE(tz)           (((tz) >= ZONE_MIN && (tz) <= ZONE_MAX) || (tz) == ZONE_UNSPECIFIED)


#ifdef PGSPARQL_EXTRA_CHECKS
static inline int32 checked_zone(int32 zone)
{
    if(!IS_VALID_TIMEZONE(zone))
        ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("time zone out of range")));

    return zone;
}
#else
#define checked_zone(x)    (x)
#endif

#endif /* TYPES_TIMEZONE_H_ */
