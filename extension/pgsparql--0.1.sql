-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pgsparql" to load this file. \quit


CREATE TYPE "zoneddate";

CREATE FUNCTION "zoneddate_input"(cstring) RETURNS "zoneddate"  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddate_output"("zoneddate") RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

DO $$ BEGIN
CREATE TYPE "zoneddate"
(
    internallength = 8,
    input = "zoneddate_input",
    output = "zoneddate_output",
    alignment = double,
    passedbyvalue
);
EXCEPTION WHEN invalid_object_definition THEN
CREATE TYPE "zoneddate"
(
    internallength = 8,
    input = "zoneddate_input",
    output = "zoneddate_output",
    alignment = int4
);
END; $$ LANGUAGE 'plpgsql';

CREATE FUNCTION "zoneddate_equal"("zoneddate", "zoneddate") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddate_not_equal"("zoneddate", "zoneddate") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddate_less_than"("zoneddate", "zoneddate") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddate_greater_than"("zoneddate", "zoneddate") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddate_not_less_than"("zoneddate", "zoneddate") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddate_not_greater_than"("zoneddate", "zoneddate") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR = (
    leftarg = "zoneddate",
    rightarg = "zoneddate",
    procedure = "zoneddate_equal",
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = "zoneddate",
    rightarg = "zoneddate",
    procedure = "zoneddate_not_equal",
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = "zoneddate",
    rightarg = "zoneddate",
    procedure = "zoneddate_less_than",
    commutator = >,
    negator = >=,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = "zoneddate",
    rightarg = "zoneddate",
    procedure = "zoneddate_greater_than",
    commutator = <,
    negator = <=,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = "zoneddate",
    rightarg = "zoneddate",
    procedure = "zoneddate_not_less_than",
    commutator = <=,
    negator = <,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = "zoneddate",
    rightarg = "zoneddate",
    procedure = "zoneddate_not_greater_than",
    commutator = >=,
    negator = >,
    hashes, merges
);

------------------------------------------------------------------------------------------------------------------------


CREATE TYPE "zoneddatetime";

CREATE FUNCTION "zoneddatetime_input"(cstring) RETURNS "zoneddatetime"  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddatetime_output"("zoneddatetime") RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE "zoneddatetime"
(
    internallength = 16,
    input = "zoneddatetime_input",
    output = "zoneddatetime_output",
    alignment = double
);

CREATE FUNCTION "zoneddatetime_equal"("zoneddatetime", "zoneddatetime") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddatetime_not_equal"("zoneddatetime", "zoneddatetime") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddatetime_less_than"("zoneddatetime", "zoneddatetime") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddatetime_greater_than"("zoneddatetime", "zoneddatetime") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddatetime_not_less_than"("zoneddatetime", "zoneddatetime") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "zoneddatetime_not_greater_than"("zoneddatetime", "zoneddatetime") RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR = (
    leftarg = "zoneddatetime",
    rightarg = "zoneddatetime",
    procedure = "zoneddatetime_equal",
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = "zoneddatetime",
    rightarg = "zoneddatetime",
    procedure = "zoneddatetime_not_equal",
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = "zoneddatetime",
    rightarg = "zoneddatetime",
    procedure = "zoneddatetime_less_than",
    commutator = >,
    negator = >=,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = "zoneddatetime",
    rightarg = "zoneddatetime",
    procedure = "zoneddatetime_greater_than",
    commutator = <,
    negator = <=,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = "zoneddatetime",
    rightarg = "zoneddatetime",
    procedure = "zoneddatetime_not_less_than",
    commutator = <=,
    negator = <,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = "zoneddatetime",
    rightarg = "zoneddatetime",
    procedure = "zoneddatetime_not_greater_than",
    commutator = >=,
    negator = >,
    hashes, merges
);

------------------------------------------------------------------------------------------------------------------------


CREATE TYPE "rdfbox";

CREATE FUNCTION "rdfbox_input"(cstring) RETURNS "rdfbox"  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "rdfbox_output"("rdfbox") RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE "rdfbox"
(
    internallength = VARIABLE,
    input = "rdfbox_input",
    output = "rdfbox_output",
    alignment = double
);


-- cast as boolean
CREATE FUNCTION "cast_as_boolean_from_short"(int2) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_boolean_from_int"(int4) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_boolean_from_long"(int8) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_boolean_from_float"(float4) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_boolean_from_double"(float8) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_boolean_from_integer"(decimal) RETURNS bool AS 'MODULE_PATHNAME','cast_as_boolean_from_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_boolean_from_decimal"(decimal) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_boolean_from_string"(varchar) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_boolean_from_rdfbox"(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as short
CREATE FUNCTION "cast_as_short_from_boolean"(bool) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_short_from_int"(int4) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_short_from_long"(int8) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_short_from_float"(float4) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_short_from_double"(float8) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_short_from_integer"(decimal) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_short_from_decimal"(decimal) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_short_from_string"(varchar) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_short_from_rdfbox"(rdfbox) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as int
CREATE FUNCTION "cast_as_int_from_boolean"(bool) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_int_from_short"(int2) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_int_from_long"(int8) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_int_from_float"(float4) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_int_from_double"(float8) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_int_from_integer"(decimal) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_int_from_decimal"(decimal) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_int_from_string"(varchar) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_int_from_rdfbox"(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as long
CREATE FUNCTION "cast_as_long_from_boolean"(bool) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_long_from_short"(int2) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_long_from_int"(int4) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_long_from_float"(float4) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_long_from_double"(float8) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_long_from_integer"(decimal) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_long_from_decimal"(decimal) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_long_from_string"(varchar) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_long_from_rdfbox"(rdfbox) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as float
CREATE FUNCTION "cast_as_float_from_boolean"(bool) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_float_from_short"(int2) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_float_from_int"(int4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_float_from_long"(int8) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_float_from_double"(float8) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_float_from_integer"(decimal) RETURNS float4 AS 'MODULE_PATHNAME','cast_as_float_from_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_float_from_decimal"(decimal) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_float_from_string"(varchar) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_float_from_rdfbox"(rdfbox) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as double
CREATE FUNCTION "cast_as_double_from_boolean"(bool) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_double_from_short"(int2) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_double_from_int"(int4) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_double_from_long"(int8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_double_from_float"(float4) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_double_from_integer"(decimal) RETURNS float8 AS 'MODULE_PATHNAME','cast_as_double_from_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_double_from_decimal"(decimal) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_double_from_string"(varchar) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_double_from_rdfbox"(rdfbox) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as integer
CREATE FUNCTION "cast_as_integer_from_boolean"(bool) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_boolean' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_integer_from_short"(int2) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_short' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_integer_from_int"(int4) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_int' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_integer_from_long"(int8) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_long' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_integer_from_float"(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_integer_from_double"(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_integer_from_decimal"(decimal) RETURNS decimal AS 'MODULE_PATHNAME','cast_as_decimal_from_integer' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_integer_from_string"(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_integer_from_rdfbox"(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as decimal
CREATE FUNCTION "cast_as_decimal_from_boolean"(bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_decimal_from_short"(int2) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_decimal_from_int"(int4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_decimal_from_long"(int8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_decimal_from_float"(float4) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_decimal_from_double"(float8) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_decimal_from_integer"(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_decimal_from_string"(varchar) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_decimal_from_rdfbox"(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as datetime
CREATE FUNCTION "cast_as_datetime_from_date"(zoneddate) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_datetime_from_string"(varchar) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_datetime_from_rdfbox"(rdfbox) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as string
CREATE FUNCTION "cast_as_string_from_boolean"(bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_short"(int2) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_int"(int4) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_long"(int8) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_float"(float4) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_double"(float8) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_integer"(decimal) RETURNS varchar AS 'MODULE_PATHNAME','cast_as_rdfbox_from_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_decimal"(decimal) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_datetime"(zoneddatetime) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_string_from_rdfbox"(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- cast as rdfbox
CREATE FUNCTION "cast_as_rdfbox_from_boolean"(bool) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_short"(int2) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_int"(int4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_long"(int8) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_float"(float4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_double"(float8) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_integer"(decimal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_decimal"(decimal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_datetime"(zoneddatetime) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "cast_as_rdfbox_from_string"(varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;



-- unary minus
CREATE FUNCTION "uminus_float"(float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "uminus_double"(float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "uminus_integer"(decimal) RETURNS decimal AS 'MODULE_PATHNAME','uminus_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "uminus_decimal"(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "uminus_rdfbox"(rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- addition
CREATE FUNCTION "add_float"(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "add_double"(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "add_integer"(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME','add_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "add_decimal"(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "add_rdfbox"(rdfbox,rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- subtraction
CREATE FUNCTION "sub_float"(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "sub_double"(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "sub_integer"(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME','sub_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "sub_decimal"(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "sub_rdfbox"(rdfbox,rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- multiplication
CREATE FUNCTION "mul_float"(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "mul_double"(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "mul_integer"(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME','mul_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "mul_decimal"(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "mul_rdfbox"(rdfbox,rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- division
CREATE FUNCTION "div_float"(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "div_double"(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "div_integer"(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME','div_decimal' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "div_decimal"(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "div_rdfbox"(rdfbox,rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
