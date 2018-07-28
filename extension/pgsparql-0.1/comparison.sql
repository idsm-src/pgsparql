-- equal
CREATE FUNCTION "equal_bool"(x bool, y bool) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_short"(x int2, y int2) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_int"(x int4, y int4) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_long"(x int8, y int8) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_float"(x float4, y float4) RETURNS bool AS $$ select x != 'NaN'::float4 and y != 'NaN'::float4 and x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_double"(x float8, y float8) RETURNS bool AS $$ select x != 'NaN'::float8 and y != 'NaN'::float8 and x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_integer"(x decimal, y decimal) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_decimal"(x decimal, y decimal) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_datetime"(x zoneddatetime, y zoneddatetime) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_date"(x zoneddate, y zoneddate) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_daytimeduration"(x int8, y int8) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_string"(x varchar, y varchar) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_iri"(x varchar, y varchar) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_int_blanknode"(x int8, y int8) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_str_blanknode"(x varchar, y varchar) RETURNS bool AS $$ select x = y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "equal_rdfbox"(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- not equal
CREATE FUNCTION "not_equal_bool"(x bool, y bool) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_short"(x int2, y int2) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_int"(x int4, y int4) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_long"(x int8, y int8) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_float"(x float4, y float4) RETURNS bool AS $$ select x != 'NaN'::float4 and y != 'NaN'::float4 and x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_double"(x float8, y float8) RETURNS bool AS $$ select x != 'NaN'::float8 and y != 'NaN'::float8 and x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_integer"(x decimal, y decimal) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_decimal"(x decimal, y decimal) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_datetime"(x zoneddatetime, y zoneddatetime) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_date"(x zoneddate, y zoneddate) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_daytimeduration"(x int8, y int8) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_string"(x varchar, y varchar) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_iri"(x varchar, y varchar) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_int_blanknode"(x int8, y int8) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_str_blanknode"(x varchar, y varchar) RETURNS bool AS $$ select x != y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_equal_rdfbox"(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- less than
CREATE FUNCTION "less_than_bool"(x bool, y bool) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_short"(x int2, y int2) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_int"(x int4, y int4) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_long"(x int8, y int8) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_float"(x float4, y float4) RETURNS bool AS $$ select x != 'NaN'::float4 and y != 'NaN'::float4 and x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_double"(x float8, y float8) RETURNS bool AS $$ select x != 'NaN'::float8 and y != 'NaN'::float8 and x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_integer"(x decimal, y decimal) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_decimal"(x decimal, y decimal) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_datetime"(x zoneddatetime, y zoneddatetime) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_date"(x zoneddate, y zoneddate) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_daytimeduration"(x int8, y int8) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_string"(x varchar, y varchar) RETURNS bool AS $$ select x < y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "less_than_rdfbox"(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- greater than
CREATE FUNCTION "greater_than_bool"(x bool, y bool) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_short"(x int2, y int2) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_int"(x int4, y int4) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_long"(x int8, y int8) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_float"(x float4, y float4) RETURNS bool AS $$ select x != 'NaN'::float4 and y != 'NaN'::float4 and x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_double"(x float8, y float8) RETURNS bool AS $$ select x != 'NaN'::float8 and y != 'NaN'::float8 and x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_integer"(x decimal, y decimal) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_decimal"(x decimal, y decimal) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_datetime"(x zoneddatetime, y zoneddatetime) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_date"(x zoneddate, y zoneddate) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_daytimeduration"(x int8, y int8) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_string"(x varchar, y varchar) RETURNS bool AS $$ select x > y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "greater_than_rdfbox"(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- not less than
CREATE FUNCTION "not_less_than_bool"(x bool, y bool) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_short"(x int2, y int2) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_int"(x int4, y int4) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_long"(x int8, y int8) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_float"(x float4, y float4) RETURNS bool AS $$ select x != 'NaN'::float4 and y != 'NaN'::float4 and x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_double"(x float8, y float8) RETURNS bool AS $$ select x != 'NaN'::float8 and y != 'NaN'::float8 and x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_integer"(x decimal, y decimal) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_decimal"(x decimal, y decimal) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_datetime"(x zoneddatetime, y zoneddatetime) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_date"(x zoneddate, y zoneddate) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_daytimeduration"(x int8, y int8) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_string"(x varchar, y varchar) RETURNS bool AS $$ select x >= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_less_than_rdfbox"(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- not greater than
CREATE FUNCTION "not_greater_than_bool"(x bool, y bool) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_short"(x int2, y int2) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_int"(x int4, y int4) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_long"(x int8, y int8) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_float"(x float4, y float4) RETURNS bool AS $$ select x != 'NaN'::float4 and y != 'NaN'::float4 and x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_double"(x float8, y float8) RETURNS bool AS $$ select x != 'NaN'::float8 and y != 'NaN'::float8 and x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_integer"(x decimal, y decimal) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_decimal"(x decimal, y decimal) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_datetime"(x zoneddatetime, y zoneddatetime) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_date"(x zoneddate, y zoneddate) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_daytimeduration"(x int8, y int8) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_string"(x varchar, y varchar) RETURNS bool AS $$ select x <= y; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "not_greater_than_rdfbox"(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
