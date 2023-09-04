#ifndef CAST_CAST_H_
#define CAST_CAST_H_

#include <postgres.h>
#include <fmgr.h>


Datum cast_as_boolean_from_string(PG_FUNCTION_ARGS);
Datum cast_as_short_from_string(PG_FUNCTION_ARGS);
Datum cast_as_int_from_string(PG_FUNCTION_ARGS);
Datum cast_as_long_from_string(PG_FUNCTION_ARGS);
Datum cast_as_integer_from_string(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_string(PG_FUNCTION_ARGS);
Datum cast_as_float_from_string(PG_FUNCTION_ARGS);
Datum cast_as_double_from_string(PG_FUNCTION_ARGS);
Datum cast_as_datetime_from_string(PG_FUNCTION_ARGS);
Datum cast_as_date_from_string(PG_FUNCTION_ARGS);
Datum cast_as_daytimeduration_from_string(PG_FUNCTION_ARGS);

Datum cast_as_string_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_string_from_short(PG_FUNCTION_ARGS);
Datum cast_as_string_from_int(PG_FUNCTION_ARGS);
Datum cast_as_string_from_long(PG_FUNCTION_ARGS);
Datum cast_as_string_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_string_from_float(PG_FUNCTION_ARGS);
Datum cast_as_string_from_double(PG_FUNCTION_ARGS);
Datum cast_as_string_from_datetime(PG_FUNCTION_ARGS);
Datum cast_as_string_from_date(PG_FUNCTION_ARGS);
Datum cast_as_string_from_daytimeduration(PG_FUNCTION_ARGS);

#endif /* CAST_CAST_H_ */
