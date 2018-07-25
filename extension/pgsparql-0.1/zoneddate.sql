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
CREATE FUNCTION "zoneddate_compare"("zoneddate", "zoneddate") RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

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

CREATE OPERATOR CLASS "zoneddate" DEFAULT FOR TYPE "zoneddate" USING btree AS
    OPERATOR   1   <,
    OPERATOR   2   <=,
    OPERATOR   3   =,
    OPERATOR   4   >=,
    OPERATOR   5   >,
    FUNCTION   1   "zoneddate_compare";
