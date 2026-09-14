CREATE TYPE zoneddate;

CREATE FUNCTION zoneddate_input(cstring) RETURNS zoneddate  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_output(zoneddate) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_recv(internal) RETURNS zoneddate AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_send(zoneddate) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
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
CREATE FUNCTION zoneddate_order_is_equal_to(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_order_is_not_equal_to(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_order_is_less_than(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_order_is_greater_than(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_order_is_not_less_than(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_order_is_not_greater_than(zoneddate,zoneddate) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_order_compare(zoneddate,zoneddate) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_hash(zoneddate) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddate_hash_extended(zoneddate,int8) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE TYPE zoneddate
(
    internallength = 8,
    input = zoneddate_input,
    output = zoneddate_output,
    receive = zoneddate_recv,
    send = zoneddate_send,
    alignment = double,
    passedbyvalue
);


CREATE OPERATOR === (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_same_as,
    commutator = ===,
    restrict = eqsel,
    join = eqjoinsel
);

CREATE OPERATOR = (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_equal_to,
    commutator = =,
    negator = <>,
    restrict = eqsel,
    join = eqjoinsel
);

CREATE OPERATOR <> (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_not_equal_to,
    commutator = <>,
    negator = =,
    restrict = neqsel,
    join = neqjoinsel
);

CREATE OPERATOR < (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_less_than,
    commutator = >,
    negator = >=,
    restrict = scalarltsel,
    join = scalarltjoinsel
);

CREATE OPERATOR > (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_greater_than,
    commutator = <,
    negator = <=,
    restrict = scalargtsel,
    join = scalargtjoinsel
);

CREATE OPERATOR >= (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_not_less_than,
    commutator = <=,
    negator = <,
    restrict = scalargesel,
    join = scalargejoinsel
);

CREATE OPERATOR <= (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_is_not_greater_than,
    commutator = >=,
    negator = >,
    restrict = scalarlesel,
    join = scalarlejoinsel
);

CREATE OPERATOR @= (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_order_is_equal_to,
    commutator = @=,
    negator = @<>,
    restrict = eqsel,
    join = eqjoinsel,
    hashes, merges
);

CREATE OPERATOR @<> (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_order_is_not_equal_to,
    commutator = @<>,
    negator = @=,
    restrict = neqsel,
    join = neqjoinsel
);

CREATE OPERATOR @< (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_order_is_less_than,
    commutator = @>,
    negator = @>=,
    restrict = scalarltsel,
    join = scalarltjoinsel
);

CREATE OPERATOR @> (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_order_is_greater_than,
    commutator = @<,
    negator = @<=,
    restrict = scalargtsel,
    join = scalargtjoinsel
);

CREATE OPERATOR @>= (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_order_is_not_less_than,
    commutator = @<=,
    negator = @<,
    restrict = scalargesel,
    join = scalargejoinsel
);

CREATE OPERATOR @<= (
    leftarg = zoneddate,
    rightarg = zoneddate,
    procedure = zoneddate_order_is_not_greater_than,
    commutator = @>=,
    negator = @>,
    restrict = scalarlesel,
    join = scalarlejoinsel
);


CREATE OPERATOR CLASS zoneddate DEFAULT FOR TYPE zoneddate USING btree AS
    OPERATOR   1   @<,
    OPERATOR   2   @<=,
    OPERATOR   3   @=,
    OPERATOR   4   @>=,
    OPERATOR   5   @>,
    FUNCTION   1   zoneddate_order_compare,
    FUNCTION   4   btequalimage(oid);

CREATE OPERATOR CLASS zoneddate DEFAULT FOR TYPE zoneddate USING hash AS
    OPERATOR   1   @=,
    FUNCTION   1   zoneddate_hash(zoneddate),
    FUNCTION   2   zoneddate_hash_extended(zoneddate,int8);
