-- equal
CREATE FUNCTION equal_boolean(bool,bool) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_short(int2,int2) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_int(int4,int4) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_long(int8,int8) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_integer(decimal,decimal) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_decimal(decimal,decimal) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 operator(sparql.=) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_datetime(timestamptz,int4,timestamptz,int4) RETURNS bool AS $$ select $1 = $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 operator(sparql.=) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_date(date,int4,date,int4) RETURNS bool AS $$ select $1 = $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_string(varchar,varchar) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_iri(varchar,varchar) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_int_blanknode(int8,int8) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_str_blanknode(varchar,varchar) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_lang_string(varchar,varchar,varchar,varchar) RETURNS bool AS $$ select $1 = $3 and $2 = $4; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_typed_literal(varchar,varchar,varchar,varchar) RETURNS bool AS $$ select nullif($1 = $3 and $2 = $4, false); $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION equal_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- not equal
CREATE FUNCTION not_equal_boolean(bool,bool) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_short(int2,int2) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_int(int4,int4) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_long(int8,int8) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_integer(decimal,decimal) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_decimal(decimal,decimal) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 operator(sparql.!=) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_datetime(timestamptz,int4,timestamptz,int4) RETURNS bool AS $$ select $1 != $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 operator(sparql.!=) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_date(date,int4,date,int4) RETURNS bool AS $$ select $1 != $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_string(varchar,varchar) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_iri(varchar,varchar) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_int_blanknode(int8,int8) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_str_blanknode(varchar,varchar) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_lang_string(varchar,varchar,varchar,varchar) RETURNS bool AS $$ select $1 != $3 or $2 != $4; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_typed_literal(varchar,varchar,varchar,varchar) RETURNS bool AS $$ select nullif($1 != $3 or $2 != $4, true); $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_equal_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- less than
CREATE FUNCTION less_than_boolean(bool,bool) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_short(int2,int2) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_int(int4,int4) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_long(int8,int8) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_integer(decimal,decimal) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_decimal(decimal,decimal) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 operator(sparql.<) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_datetime(timestamptz,int4,timestamptz,int4) RETURNS bool AS $$ select $1 < $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 operator(sparql.<) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_date(date,int4,date,int4) RETURNS bool AS $$ select $1 < $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_string(varchar,varchar) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION less_than_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- greater than
CREATE FUNCTION greater_than_boolean(bool,bool) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_short(int2,int2) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_int(int4,int4) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_long(int8,int8) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_integer(decimal,decimal) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_decimal(decimal,decimal) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 operator(sparql.>) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_datetime(timestamptz,int4,timestamptz,int4) RETURNS bool AS $$ select $1 > $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 operator(sparql.>) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_date(date,int4,date,int4) RETURNS bool AS $$ select $1 > $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_string(varchar,varchar) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION greater_than_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- not less than
CREATE FUNCTION not_less_than_boolean(bool,bool) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_short(int2,int2) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_int(int4,int4) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_long(int8,int8) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_integer(decimal,decimal) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_decimal(decimal,decimal) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 operator(sparql.>=) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_datetime(timestamptz,int4,timestamptz,int4) RETURNS bool AS $$ select $1 >= $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 operator(sparql.>=) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_date(date,int4,date,int4) RETURNS bool AS $$ select $1 >= $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_string(varchar,varchar) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_less_than_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

-- not greater than
CREATE FUNCTION not_greater_than_boolean(bool,bool) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_short(int2,int2) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_int(int4,int4) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_long(int8,int8) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_integer(decimal,decimal) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_decimal(decimal,decimal) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 operator(sparql.<=) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_datetime(timestamptz,int4,timestamptz,int4) RETURNS bool AS $$ select $1 <= $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 operator(sparql.<=) $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_date(date,int4,date,int4) RETURNS bool AS $$ select $1 <= $3; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_string(varchar,varchar) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION not_greater_than_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
