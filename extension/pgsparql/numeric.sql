CREATE FUNCTION numeric_div_checked(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_is_equal_to(float4,float4) RETURNS bool AS $$ select $1 = $2 and $2 != 'NaN'::float4 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_not_equal_to(float4,float4) RETURNS bool AS $$ select $1 != $2 or $2 = 'NaN'::float4 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_less_than(float4,float4) RETURNS bool AS $$ select $1 < $2 and $2 != 'NaN'::float4 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_greater_than(float4,float4) RETURNS bool AS $$ select $1 > $2 and $1 != 'NaN'::float4 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_not_less_than(float4,float4) RETURNS bool AS $$ select $1 >= $2 and $1 != 'NaN'::float4 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_not_greater_than(float4,float4) RETURNS bool AS $$ select $1 <= $2 and $2 != 'NaN'::float4 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_uminus(float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_add(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_sub(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_mul(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_div(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_is_equal_to(float8,float8) RETURNS bool AS $$ select $1 = $2 and $2 != 'NaN'::float8 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_not_equal_to(float8,float8) RETURNS bool AS $$ select $1 != $2 or $2 = 'NaN'::float8 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_less_than(float8,float8) RETURNS bool AS $$ select $1 < $2 and $2 != 'NaN'::float8 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_greater_than(float8,float8) RETURNS bool AS $$ select $1 > $2 and $1 != 'NaN'::float8 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_not_less_than(float8,float8) RETURNS bool AS $$ select $1 >= $2 and $1 != 'NaN'::float8 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_not_greater_than(float8,float8) RETURNS bool AS $$ select $1 <= $2 and $2 != 'NaN'::float8 $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_uminus(float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_add(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_sub(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_mul(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_div(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;



CREATE OPERATOR - (
    rightarg = decimal,
    procedure = numeric_uminus
);

CREATE OPERATOR + (
    leftarg = decimal,
    rightarg = decimal,
    procedure = numeric_add,
    commutator = +
);

CREATE OPERATOR - (
    leftarg = decimal,
    rightarg = decimal,
    procedure = numeric_sub
);

CREATE OPERATOR * (
    leftarg = decimal,
    rightarg = decimal,
    procedure = numeric_mul,
    commutator = *
);

CREATE OPERATOR / (
    leftarg = decimal,
    rightarg = decimal,
    procedure = numeric_div_checked
);

CREATE OPERATOR = (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_equal_to,
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_not_equal_to,
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_less_than,
    commutator = >,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_greater_than,
    commutator = <,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_not_less_than,
    commutator = <=,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_not_greater_than,
    commutator = >=,
    hashes, merges
);

CREATE OPERATOR - (
    rightarg = float4,
    procedure = float_uminus
);

CREATE OPERATOR + (
    leftarg = float4,
    rightarg = float4,
    procedure = float_add,
    commutator = +
);

CREATE OPERATOR - (
    leftarg = float4,
    rightarg = float4,
    procedure = float_sub
);

CREATE OPERATOR * (
    leftarg = float4,
    rightarg = float4,
    procedure = float_mul,
    commutator = *
);

CREATE OPERATOR / (
    leftarg = float4,
    rightarg = float4,
    procedure = float_div
);

CREATE OPERATOR = (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_equal_to,
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_not_equal_to,
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_less_than,
    commutator = >,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_greater_than,
    commutator = <,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_not_less_than,
    commutator = <=,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_not_greater_than,
    commutator = >=,
    hashes, merges
);

CREATE OPERATOR - (
    rightarg = float8,
    procedure = double_uminus
);

CREATE OPERATOR + (
    leftarg = float8,
    rightarg = float8,
    procedure = double_add,
    commutator = +
);

CREATE OPERATOR - (
    leftarg = float8,
    rightarg = float8,
    procedure = double_sub
);

CREATE OPERATOR * (
    leftarg = float8,
    rightarg = float8,
    procedure = double_mul,
    commutator = *
);

CREATE OPERATOR / (
    leftarg = float8,
    rightarg = float8,
    procedure = double_div
);
