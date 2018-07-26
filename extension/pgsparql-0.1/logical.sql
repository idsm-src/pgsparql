-- effective boolean value
CREATE FUNCTION "ebv_short"(x int2) RETURNS bool AS $$ select x != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "ebv_int"(x int4) RETURNS bool AS $$ select x != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "ebv_long"(x int8) RETURNS bool AS $$ select x != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "ebv_float"(x float4) RETURNS bool AS $$ select x != 'NaN'::float4 and x != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "ebv_double"(x float8) RETURNS bool AS $$ select x != 'NaN'::float8 and x != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "ebv_integer"(x decimal) RETURNS bool AS $$ select x != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "ebv_decimal"(x decimal) RETURNS bool AS $$ select x != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "ebv_string"(x varchar) RETURNS bool AS $$ select octet_length(x) != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "ebv_rdfbox"(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
