-- equal
CREATE FUNCTION equal_bool(bool,bool) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_short(int2,int2) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_int(int4,int4) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_long(int8,int8) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_integer(decimal,decimal) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_decimal(decimal,decimal) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_string(varchar,varchar) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_iri(varchar,varchar) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_int_blanknode(int8,int8) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_str_blanknode(varchar,varchar) RETURNS bool AS $$ select $1 = $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION equal_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- not equal
CREATE FUNCTION not_equal_bool(bool,bool) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_short(int2,int2) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_int(int4,int4) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_long(int8,int8) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_integer(decimal,decimal) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_decimal(decimal,decimal) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_string(varchar,varchar) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_iri(varchar,varchar) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_int_blanknode(int8,int8) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_str_blanknode(varchar,varchar) RETURNS bool AS $$ select $1 != $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_equal_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- less than
CREATE FUNCTION less_than_bool(bool,bool) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_short(int2,int2) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_int(int4,int4) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_long(int8,int8) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_integer(decimal,decimal) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_decimal(decimal,decimal) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_string(varchar,varchar) RETURNS bool AS $$ select $1 < $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION less_than_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- greater than
CREATE FUNCTION greater_than_bool(bool,bool) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_short(int2,int2) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_int(int4,int4) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_long(int8,int8) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_integer(decimal,decimal) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_decimal(decimal,decimal) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_string(varchar,varchar) RETURNS bool AS $$ select $1 > $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION greater_than_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- not less than
CREATE FUNCTION not_less_than_bool(bool,bool) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_short(int2,int2) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_int(int4,int4) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_long(int8,int8) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_integer(decimal,decimal) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_decimal(decimal,decimal) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_string(varchar,varchar) RETURNS bool AS $$ select $1 >= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_less_than_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- not greater than
CREATE FUNCTION not_greater_than_bool(bool,bool) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_short(int2,int2) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_int(int4,int4) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_long(int8,int8) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_float(float4,float4) RETURNS bool AS $$ select $1 != 'NaN'::float4 and $2 != 'NaN'::float4 and $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_double(float8,float8) RETURNS bool AS $$ select $1 != 'NaN'::float8 and $2 != 'NaN'::float8 and $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_integer(decimal,decimal) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_decimal(decimal,decimal) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_datetime(zoneddatetime,zoneddatetime) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_date(zoneddate,zoneddate) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_daytimeduration(int8,int8) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_string(varchar,varchar) RETURNS bool AS $$ select $1 <= $2; $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION not_greater_than_rdfbox(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
