#ifndef CAST_CAST_H_
#define CAST_CAST_H_

#include <postgres.h>


Datum cast_as_boolean_from_short(PG_FUNCTION_ARGS);
Datum cast_as_boolean_from_int(PG_FUNCTION_ARGS);
Datum cast_as_boolean_from_long(PG_FUNCTION_ARGS);
Datum cast_as_boolean_from_float(PG_FUNCTION_ARGS);
Datum cast_as_boolean_from_double(PG_FUNCTION_ARGS);
Datum cast_as_boolean_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_boolean_from_string(PG_FUNCTION_ARGS);
Datum cast_as_boolean_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_short_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_short_from_int(PG_FUNCTION_ARGS);
Datum cast_as_short_from_long(PG_FUNCTION_ARGS);
Datum cast_as_short_from_float(PG_FUNCTION_ARGS);
Datum cast_as_short_from_double(PG_FUNCTION_ARGS);
Datum cast_as_short_from_integer(PG_FUNCTION_ARGS);
Datum cast_as_short_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_short_from_string(PG_FUNCTION_ARGS);
Datum cast_as_short_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_int_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_int_from_short(PG_FUNCTION_ARGS);
Datum cast_as_int_from_long(PG_FUNCTION_ARGS);
Datum cast_as_int_from_float(PG_FUNCTION_ARGS);
Datum cast_as_int_from_double(PG_FUNCTION_ARGS);
Datum cast_as_int_from_integer(PG_FUNCTION_ARGS);
Datum cast_as_int_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_int_from_string(PG_FUNCTION_ARGS);
Datum cast_as_int_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_long_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_long_from_short(PG_FUNCTION_ARGS);
Datum cast_as_long_from_int(PG_FUNCTION_ARGS);
Datum cast_as_long_from_float(PG_FUNCTION_ARGS);
Datum cast_as_long_from_double(PG_FUNCTION_ARGS);
Datum cast_as_long_from_integer(PG_FUNCTION_ARGS);
Datum cast_as_long_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_long_from_string(PG_FUNCTION_ARGS);
Datum cast_as_long_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_float_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_float_from_short(PG_FUNCTION_ARGS);
Datum cast_as_float_from_int(PG_FUNCTION_ARGS);
Datum cast_as_float_from_long(PG_FUNCTION_ARGS);
Datum cast_as_float_from_double(PG_FUNCTION_ARGS);
Datum cast_as_float_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_float_from_string(PG_FUNCTION_ARGS);
Datum cast_as_float_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_double_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_double_from_short(PG_FUNCTION_ARGS);
Datum cast_as_double_from_int(PG_FUNCTION_ARGS);
Datum cast_as_double_from_long(PG_FUNCTION_ARGS);
Datum cast_as_double_from_float(PG_FUNCTION_ARGS);
Datum cast_as_double_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_double_from_string(PG_FUNCTION_ARGS);
Datum cast_as_double_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_integer_from_float(PG_FUNCTION_ARGS);
Datum cast_as_integer_from_double(PG_FUNCTION_ARGS);
Datum cast_as_integer_from_string(PG_FUNCTION_ARGS);
Datum cast_as_integer_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_decimal_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_short(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_int(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_long(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_float(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_double(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_integer(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_string(PG_FUNCTION_ARGS);
Datum cast_as_decimal_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_string_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_string_from_short(PG_FUNCTION_ARGS);
Datum cast_as_string_from_int(PG_FUNCTION_ARGS);
Datum cast_as_string_from_long(PG_FUNCTION_ARGS);
Datum cast_as_string_from_float(PG_FUNCTION_ARGS);
Datum cast_as_string_from_double(PG_FUNCTION_ARGS);
Datum cast_as_string_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_string_from_rdfbox(PG_FUNCTION_ARGS);

Datum cast_as_rdfbox_from_boolean(PG_FUNCTION_ARGS);
Datum cast_as_rdfbox_from_short(PG_FUNCTION_ARGS);
Datum cast_as_rdfbox_from_int(PG_FUNCTION_ARGS);
Datum cast_as_rdfbox_from_long(PG_FUNCTION_ARGS);
Datum cast_as_rdfbox_from_float(PG_FUNCTION_ARGS);
Datum cast_as_rdfbox_from_double(PG_FUNCTION_ARGS);
Datum cast_as_rdfbox_from_integer(PG_FUNCTION_ARGS);
Datum cast_as_rdfbox_from_decimal(PG_FUNCTION_ARGS);
Datum cast_as_rdfbox_from_string(PG_FUNCTION_ARGS);

#endif /* CAST_CAST_H_ */
