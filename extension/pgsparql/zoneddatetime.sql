CREATE TYPE zoneddatetime;

CREATE FUNCTION zoneddatetime_input(cstring) RETURNS zoneddatetime  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_output(zoneddatetime) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_create(timestamptz,int4) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_get_value(zoneddatetime) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_get_value_of_zone(zoneddatetime,int4) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_get_zone(zoneddatetime) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_is_same_as(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_is_equal_to(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_is_not_equal_to(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_is_less_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_is_greater_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_is_not_less_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_is_not_greater_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_compare(zoneddatetime,zoneddatetime) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE TYPE zoneddatetime
(
    internallength = 16,
    input = zoneddatetime_input,
    output = zoneddatetime_output,
    alignment = double
);


CREATE OPERATOR === (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_same_as,
    commutator = ===,
    hashes, merges
);

CREATE OPERATOR = (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_equal_to,
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_not_equal_to,
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_less_than,
    commutator = >,
    negator = >=,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_greater_than,
    commutator = <,
    negator = <=,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_not_less_than,
    commutator = <=,
    negator = <,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_not_greater_than,
    commutator = >=,
    negator = >,
    hashes, merges
);


CREATE OPERATOR CLASS zoneddatetime DEFAULT FOR TYPE zoneddatetime USING btree AS
    OPERATOR   1   <,
    OPERATOR   2   <=,
    OPERATOR   3   =,
    OPERATOR   4   >=,
    OPERATOR   5   >,
    FUNCTION   1   zoneddatetime_compare;
