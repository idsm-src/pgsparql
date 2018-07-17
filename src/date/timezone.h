#ifndef DATE_TIMEZONE_H_
#define DATE_TIMEZONE_H_

#include <postgres.h>
#include <datatype/timestamp.h>


#define ZONE_MAX                        (14*MINS_PER_HOUR)
#define ZONE_MIN                        (-ZONE_MAX)
#define ZONE_UNSPECIFIED                PG_INT16_MIN


extern int16 implicit_timezone;

#endif /* DATE_TIMEZONE_H_ */
