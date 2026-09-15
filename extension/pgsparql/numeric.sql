CREATE FUNCTION decimal_uminus(decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION decimal_add(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION decimal_sub(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION decimal_mul(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION decimal_div(decimal,decimal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_is_equal_to(float4,float4) RETURNS bool AS $$ select $1 = $2 and ($2 != 'NaN'::float4 or $1 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_not_equal_to(float4,float4) RETURNS bool AS $$ select $1 != $2 or ($2 = 'NaN'::float4 and $1 is not null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_less_than(float4,float4) RETURNS bool AS $$ select $1 < $2 and ($2 != 'NaN'::float4 or $1 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_greater_than(float4,float4) RETURNS bool AS $$ select $1 > $2 and ($1 != 'NaN'::float4 or $2 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_not_less_than(float4,float4) RETURNS bool AS $$ select $1 >= $2 and ($1 != 'NaN'::float4 or $2 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_is_not_greater_than(float4,float4) RETURNS bool AS $$ select $1 <= $2 and ($2 != 'NaN'::float4 or $1 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION float_uminus(float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_add(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_sub(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_mul(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION float_div(float4,float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_is_equal_to(float8,float8) RETURNS bool AS $$ select $1 = $2 and ($2 != 'NaN'::float8 or $1 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_not_equal_to(float8,float8) RETURNS bool AS $$ select $1 != $2 or ($2 = 'NaN'::float8 and $1 is not null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_less_than(float8,float8) RETURNS bool AS $$ select $1 < $2 and ($2 != 'NaN'::float8 or $1 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_greater_than(float8,float8) RETURNS bool AS $$ select $1 > $2 and ($1 != 'NaN'::float8 or $2 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_not_less_than(float8,float8) RETURNS bool AS $$ select $1 >= $2 and ($1 != 'NaN'::float8 or $2 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_is_not_greater_than(float8,float8) RETURNS bool AS $$ select $1 <= $2 and ($2 != 'NaN'::float8 or $1 is null) $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION double_uminus(float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_add(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_sub(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_mul(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION double_div(float8,float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE OPERATOR - (
    rightarg = decimal,
    procedure = decimal_uminus
);

CREATE OPERATOR + (
    leftarg = decimal,
    rightarg = decimal,
    procedure = decimal_add,
    commutator = operator(@extschema@.+)
);

CREATE OPERATOR - (
    leftarg = decimal,
    rightarg = decimal,
    procedure = decimal_sub
);

CREATE OPERATOR * (
    leftarg = decimal,
    rightarg = decimal,
    procedure = decimal_mul,
    commutator = operator(@extschema@.*)
);

CREATE OPERATOR / (
    leftarg = decimal,
    rightarg = decimal,
    procedure = decimal_div
);

CREATE OPERATOR = (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_equal_to,
    commutator = operator(@extschema@.=),
    negator = operator(@extschema@.!=),
    restrict = eqsel,
    join = eqjoinsel,
    hashes
);

CREATE OPERATOR != (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_not_equal_to,
    commutator = operator(@extschema@.!=),
    negator = operator(@extschema@.=),
    restrict = neqsel,
    join = neqjoinsel
);

CREATE OPERATOR < (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_less_than,
    commutator = operator(@extschema@.>),
    restrict = scalarltsel,
    join = scalarltjoinsel
);

CREATE OPERATOR > (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_greater_than,
    commutator = operator(@extschema@.<),
    restrict = scalargtsel,
    join = scalargtjoinsel
);

CREATE OPERATOR >= (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_not_less_than,
    commutator = operator(@extschema@.<=),
    restrict = scalargesel,
    join = scalargejoinsel
);

CREATE OPERATOR <= (
    leftarg = float4,
    rightarg = float4,
    procedure = float_is_not_greater_than,
    commutator = operator(@extschema@.>=),
    restrict = scalarlesel,
    join = scalarlejoinsel
);

CREATE OPERATOR - (
    rightarg = float4,
    procedure = float_uminus
);

CREATE OPERATOR + (
    leftarg = float4,
    rightarg = float4,
    procedure = float_add,
    commutator = operator(@extschema@.+)
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
    commutator = operator(@extschema@.*)
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
    commutator = operator(@extschema@.=),
    negator = operator(@extschema@.!=),
    restrict = eqsel,
    join = eqjoinsel,
    hashes
);

CREATE OPERATOR != (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_not_equal_to,
    commutator = operator(@extschema@.!=),
    negator = operator(@extschema@.=),
    restrict = neqsel,
    join = neqjoinsel
);

CREATE OPERATOR < (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_less_than,
    commutator = operator(@extschema@.>),
    restrict = scalarltsel,
    join = scalarltjoinsel
);

CREATE OPERATOR > (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_greater_than,
    commutator = operator(@extschema@.<),
    restrict = scalargtsel,
    join = scalargtjoinsel
);

CREATE OPERATOR >= (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_not_less_than,
    commutator = operator(@extschema@.<=),
    restrict = scalargesel,
    join = scalargejoinsel
);

CREATE OPERATOR <= (
    leftarg = float8,
    rightarg = float8,
    procedure = double_is_not_greater_than,
    commutator = operator(@extschema@.>=),
    restrict = scalarlesel,
    join = scalarlejoinsel
);

CREATE OPERATOR - (
    rightarg = float8,
    procedure = double_uminus
);

CREATE OPERATOR + (
    leftarg = float8,
    rightarg = float8,
    procedure = double_add,
    commutator = operator(@extschema@.+)
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
    commutator = operator(@extschema@.*)
);

CREATE OPERATOR / (
    leftarg = float8,
    rightarg = float8,
    procedure = double_div
);


CREATE OPERATOR CLASS float_hash_ops FOR TYPE float4 USING hash AS
    OPERATOR   1   @extschema@.= (float4, float4),
    FUNCTION   1   hashfloat4(float4),
    FUNCTION   2   hashfloat4extended(float4, int8);

CREATE OPERATOR CLASS double_hash_ops FOR TYPE float8 USING hash AS
    OPERATOR   1   @extschema@.= (float8, float8),
    FUNCTION   1   hashfloat8(float8),
    FUNCTION   2   hashfloat8extended(float8, int8);
