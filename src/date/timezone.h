#ifndef DATE_TIMEZONE_H_
#define DATE_TIMEZONE_H_

#include <postgres.h>
#include <datatype/timestamp.h>


#define ZONE_MAX                        (14*MINS_PER_HOUR)
#define ZONE_MIN                        (-ZONE_MAX)
#define ZONE_UNSPECIFIED                PG_INT16_MIN

#define IS_VALID_TIMEZONE(tz)           ((tz) >= ZONE_MIN && (tz) <= ZONE_MAX || (tz) == ZONE_UNSPECIFIED)


extern int16 implicit_timezone;

#endif /* DATE_TIMEZONE_H_ */
