-- cast as boolean
CREATE FUNCTION cast_as_boolean_from_byte(int2) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_unsignedbyte(int2) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_short(int2) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_unsignedshort(int4) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_int(int4) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_unsignedint(int8) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_long(int8) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_unsignedlong(decimal) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_integer(decimal) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_nonpositiveinteger(decimal) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_negativeinteger(decimal) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_nonnegativeinteger(decimal) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_positiveinteger(decimal) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_decimal(decimal) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_float(float4) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_double(float8) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_string(varchar) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_boolean_from_rdfbox(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as byte
CREATE FUNCTION cast_as_byte_from_boolean(bool) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_unsignedbyte(int2) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_byte_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_short(int2) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_unsignedshort(int4) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_byte_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_int(int4) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_unsignedint(int8) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_byte_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_long(int8) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_unsignedlong(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_byte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_integer(decimal) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_nonpositiveinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_byte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_negativeinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_byte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_nonnegativeinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_byte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_positiveinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_byte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_decimal(decimal) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_float(float4) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_double(float8) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_string(varchar) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_byte_from_rdfbox(rdfbox) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as unsignedbyte
CREATE FUNCTION cast_as_unsignedbyte_from_boolean(bool) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_byte(int2) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_unsignedbyte_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_short(int2) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_unsignedshort(int4) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_unsignedbyte_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_int(int4) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_unsignedint(int8) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_unsignedbyte_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_long(int8) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_unsignedlong(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_unsignedbyte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_integer(decimal) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_nonpositiveinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_unsignedbyte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_negativeinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_unsignedbyte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_nonnegativeinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_unsignedbyte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_positiveinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_unsignedbyte_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_decimal(decimal) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_float(float4) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_double(float8) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_string(varchar) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedbyte_from_rdfbox(rdfbox) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as short
CREATE FUNCTION cast_as_short_from_boolean(bool) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_byte(int2) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_unsignedbyte(int2) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_short_from_byte' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_unsignedshort(int4) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_short_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_int(int4) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_unsignedint(int8) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_short_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_long(int8) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_unsignedlong(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_short_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_integer(decimal) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_nonpositiveinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_short_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_negativeinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_short_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_nonnegativeinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_short_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_positiveinteger(decimal) RETURNS int2 AS 'MODULE_PATHNAME','cast_as_short_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_decimal(decimal) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_float(float4) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_double(float8) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_string(varchar) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_short_from_rdfbox(rdfbox) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as unsignedshort
CREATE FUNCTION cast_as_unsignedshort_from_boolean(bool) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_byte(int2) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_unsignedshort_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_unsignedbyte(int2) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_unsignedshort_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_short(int2) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_int(int4) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_unsignedint(int8) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_unsignedshort_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_long(int8) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_unsignedlong(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_unsignedshort_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_integer(decimal) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_nonpositiveinteger(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_unsignedshort_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_negativeinteger(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_unsignedshort_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_nonnegativeinteger(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_unsignedshort_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_positiveinteger(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_unsignedshort_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_decimal(decimal) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_float(float4) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_double(float8) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_string(varchar) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedshort_from_rdfbox(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as int
CREATE FUNCTION cast_as_int_from_boolean(bool) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_byte(int2) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_int_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_unsignedbyte(int2) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_int_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_short(int2) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_unsignedshort(int4) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_unsignedint(int8) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_int_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_long(int8) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_unsignedlong(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_int_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_integer(decimal) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_nonpositiveinteger(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_int_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_negativeinteger(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_int_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_nonnegativeinteger(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_int_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_positiveinteger(decimal) RETURNS int4 AS 'MODULE_PATHNAME','cast_as_int_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_decimal(decimal) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_float(float4) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_double(float8) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_string(varchar) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_int_from_rdfbox(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as unsignedint
CREATE FUNCTION cast_as_unsignedint_from_boolean(bool) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_byte(int2) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_unsignedint_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_unsignedbyte(int2) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_unsignedint_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_short(int2) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_unsignedshort(int4) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_unsignedint_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_int(int4) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_long(int8) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_unsignedlong(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_unsignedint_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_integer(decimal) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_nonpositiveinteger(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_unsignedint_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_negativeinteger(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_unsignedint_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_nonnegativeinteger(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_unsignedint_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_positiveinteger(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_unsignedint_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_decimal(decimal) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_float(float4) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_double(float8) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_string(varchar) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedint_from_rdfbox(rdfbox) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as long
CREATE FUNCTION cast_as_long_from_boolean(bool) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_byte(int2) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_long_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_unsignedbyte(int2) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_long_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_short(int2) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_unsignedshort(int4) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_long_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_int(int4) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_unsignedint(int8) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_unsignedlong(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_long_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_integer(decimal) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_nonpositiveinteger(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_long_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_negativeinteger(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_long_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_nonnegativeinteger(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_long_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_positiveinteger(decimal) RETURNS int8 AS 'MODULE_PATHNAME','cast_as_long_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_decimal(decimal) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_float(float4) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_double(float8) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_string(varchar) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_long_from_rdfbox(rdfbox) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as unsignedlong
CREATE FUNCTION cast_as_unsignedlong_from_boolean(bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_byte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_unsignedlong_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_unsignedbyte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_unsignedlong_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_short(int2) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_unsignedshort(int4) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_unsignedlong_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_int(int4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_unsignedint(int8) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_unsignedlong_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_long(int8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_integer(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_nonpositiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_unsignedlong_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_negativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_unsignedlong_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_nonnegativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_unsignedlong_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_positiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_unsignedlong_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_decimal(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_float(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_double(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_string(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_unsignedlong_from_rdfbox(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as integer
CREATE FUNCTION cast_as_integer_from_boolean(bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_byte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_integer_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_unsignedbyte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_integer_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_short(int2) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_unsignedshort(int4) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_integer_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_int(int4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_unsignedint(int8) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_integer_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_long(int8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_unsignedlong(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_nonpositiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_integer_from_unsignedlong' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_negativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_integer_from_unsignedlong' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_nonnegativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_integer_from_unsignedlong' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_positiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_integer_from_unsignedlong' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_decimal(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_float(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_double(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_string(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_integer_from_rdfbox(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as nonpositiveinteger
CREATE FUNCTION cast_as_nonpositiveinteger_from_boolean(bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_byte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonpositiveinteger_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_unsignedbyte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonpositiveinteger_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_short(int2) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_unsignedshort(int4) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonpositiveinteger_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_int(int4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_unsignedint(int8) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonpositiveinteger_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_long(int8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_unsignedlong(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonpositiveinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_integer(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_negativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonpositiveinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_nonnegativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonpositiveinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_positiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonpositiveinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_decimal(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_float(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_double(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_string(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonpositiveinteger_from_rdfbox(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as negativeinteger
CREATE FUNCTION cast_as_negativeinteger_from_boolean(bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_byte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_negativeinteger_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_unsignedbyte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_negativeinteger_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_short(int2) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_unsignedshort(int4) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_negativeinteger_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_int(int4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_unsignedint(int8) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_negativeinteger_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_long(int8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_unsignedlong(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_negativeinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_integer(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_nonpositiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_negativeinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_nonnegativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_negativeinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_positiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_negativeinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_decimal(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_float(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_double(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_string(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_negativeinteger_from_rdfbox(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as nonnegativeinteger
CREATE FUNCTION cast_as_nonnegativeinteger_from_boolean(bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_byte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonnegativeinteger_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_unsignedbyte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonnegativeinteger_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_short(int2) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_unsignedshort(int4) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonnegativeinteger_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_int(int4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_unsignedint(int8) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonnegativeinteger_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_long(int8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_unsignedlong(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonnegativeinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_integer(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_nonpositiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonnegativeinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_negativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonnegativeinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_positiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_nonnegativeinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_decimal(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_float(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_double(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_string(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_nonnegativeinteger_from_rdfbox(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as positiveinteger
CREATE FUNCTION cast_as_positiveinteger_from_boolean(bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_byte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_positiveinteger_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_unsignedbyte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_positiveinteger_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_short(int2) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_unsignedshort(int4) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_positiveinteger_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_int(int4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_unsignedint(int8) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_positiveinteger_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_long(int8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_unsignedlong(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_positiveinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_integer(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_nonpositiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_positiveinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_negativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_positiveinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_nonnegativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_positiveinteger_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_decimal(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_float(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_double(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_string(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_positiveinteger_from_rdfbox(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as decimal
CREATE FUNCTION cast_as_decimal_from_boolean(bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_byte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_unsignedbyte(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_short(int2) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_unsignedshort(int4) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_int(int4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_unsignedint(int8) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_long(int8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_unsignedlong(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_integer(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_nonpositiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_negativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_nonnegativeinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_positiveinteger(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_integer' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_float(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_double(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_string(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_decimal_from_rdfbox(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as float
CREATE FUNCTION cast_as_float_from_boolean(bool) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_byte(int2) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_unsignedbyte(int2) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_short(int2) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_unsignedshort(int4) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_int(int4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_unsignedint(int8) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_long(int8) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_unsignedlong(decimal) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_integer(decimal) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_nonpositiveinteger(decimal) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_negativeinteger(decimal) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_nonnegativeinteger(decimal) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_positiveinteger(decimal) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_decimal(decimal) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_double(float8) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_string(varchar) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_float_from_rdfbox(rdfbox) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as double
CREATE FUNCTION cast_as_double_from_boolean(bool) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_byte(int2) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_unsignedbyte(int2) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_short(int2) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_unsignedshort(int4) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_int(int4) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_unsignedint(int8) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_long(int8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_unsignedlong(decimal) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_integer(decimal) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_nonpositiveinteger(decimal) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_negativeinteger(decimal) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_nonnegativeinteger(decimal) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_positiveinteger(decimal) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_decimal(decimal) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_float(float4) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_string(varchar) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_double_from_rdfbox(rdfbox) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as datetime
CREATE FUNCTION cast_as_datetime_from_date(zoneddate) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_datetime_from_date(date,int4) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_datetime_from_string(varchar) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_datetime_from_rdfbox(rdfbox) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as plain datetime (datetime without timezone)
CREATE FUNCTION cast_as_plain_datetime_from_date(date,int4) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_plain_datetime_from_rdfbox(rdfbox) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as date
CREATE FUNCTION cast_as_date_from_datetime(zoneddatetime) RETURNS zoneddate AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_date_from_datetime(timestamptz,int4) RETURNS zoneddate AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_date_from_string(varchar) RETURNS zoneddate AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_date_from_rdfbox(rdfbox) RETURNS zoneddate AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as plain date (date without timezone)
CREATE FUNCTION cast_as_plain_date_from_datetime(timestamptz,int4) RETURNS date AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_plain_date_from_rdfbox(rdfbox) RETURNS date AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as daytimeduration
CREATE FUNCTION cast_as_daytimeduration_from_string(varchar) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_daytimeduration_from_rdfbox(rdfbox) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- cast as string
CREATE FUNCTION cast_as_string_from_boolean(bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_byte(int2) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_unsignedbyte(int2) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_short' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_short(int2) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_unsignedshort(int4) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_int' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_int(int4) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_unsignedint(int8) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_long' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_long(int8) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_unsignedlong(decimal) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_integer(decimal) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_nonpositiveinteger(decimal) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_negativeinteger(decimal) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_nonnegativeinteger(decimal) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_positiveinteger(decimal) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_string_from_decimal' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_decimal(decimal) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_float(float4) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_double(float8) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_datetime(zoneddatetime) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_datetime(timestamptz,int4) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_date(zoneddate) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_date(date,int4) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_daytimeduration(int8) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION cast_as_string_from_rdfbox(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
