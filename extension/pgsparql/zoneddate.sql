CREATE TYPE zoneddate;

CREATE FUNCTION zoneddate_input(cstring) RETURNS zoneddate  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_output(zoneddate) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_create(date,int4) RETURNS zoneddate AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_get_value(zoneddate) RETURNS date AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_get_value_of_zone(zoneddate, int4) RETURNS date AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_get_zone(zoneddate) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_is_same_as(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_is_equal_to(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_is_not_equal_to(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_is_less_than(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_is_greater_than(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_is_not_less_than(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_is_not_greater_than(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_compare(zoneddate,zoneddate) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE TYPE zoneddate
(
    internallength = 8,
    input = zoneddate_input,
    output = zoneddate_output,
    alignment = double,
    passedbyvalue
);


CREATE OPERATOR === (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_same_as,
    commutator = ===,
    hashes, merges
);

CREATE OPERATOR = (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_equal_to,
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_not_equal_to,
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_less_than,
    commutator = >,
    negator = >=,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_greater_than,
    commutator = <,
    negator = <=,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_not_less_than,
    commutator = <=,
    negator = <,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_not_greater_than,
    commutator = >=,
    negator = >,
    hashes, merges
);


CREATE OPERATOR CLASS zoneddate DEFAULT FOR TYPE zoneddate USING btree AS
    OPERATOR   1   <,
    OPERATOR   2   <=,
    OPERATOR   3   =,
    OPERATOR   4   >=,
    OPERATOR   5   >,
    FUNCTION   1   zoneddate_compare;
