CREATE TYPE zoneddatetime;

CREATE FUNCTION zoneddatetime_input(cstring) RETURNS zoneddatetime  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION zoneddatetime_output(zoneddatetime) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE zoneddatetime
(
    internallength = 16,
    input = zoneddatetime_input,
    output = zoneddatetime_output,
    alignment = double
);

CREATE FUNCTION zoneddatetime_datetime(zoneddatetime) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION zoneddatetime_zone(zoneddatetime) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION zoneddatetime_equal(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION zoneddatetime_not_equal(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION zoneddatetime_less_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION zoneddatetime_greater_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION zoneddatetime_not_less_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION zoneddatetime_not_greater_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION zoneddatetime_compare(zoneddatetime,zoneddatetime) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE OPERATOR = (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_equal,
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_not_equal,
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_less_than,
    commutator = >,
    negator = >=,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_greater_than,
    commutator = <,
    negator = <=,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_not_less_than,
    commutator = <=,
    negator = <,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_not_greater_than,
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
