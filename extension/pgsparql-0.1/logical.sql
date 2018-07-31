-- effective boolean value
CREATE FUNCTION ebv_short(int2) RETURNS bool AS $$ select $1 != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION ebv_int(int4) RETURNS bool AS $$ select $1 != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION ebv_long(int8) RETURNS bool AS $$ select $1 != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION ebv_float(float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $1 != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION ebv_double(float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $1 != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION ebv_integer(decimal) RETURNS bool AS $$ select $1 != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION ebv_decimal(decimal) RETURNS bool AS $$ select $1 != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION ebv_string(varchar) RETURNS bool AS $$ select octet_length($1) != 0; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION ebv_rdfbox(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
