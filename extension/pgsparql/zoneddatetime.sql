CREATE TYPE zoneddatetime;

CREATE FUNCTION zoneddatetime_input(cstring) RETURNS zoneddatetime  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_output(zoneddatetime) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_recv(internal) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_send(zoneddatetime) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
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
CREATE FUNCTION zoneddatetime_order_is_equal_to(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_order_is_not_equal_to(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_order_is_less_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_order_is_greater_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_order_is_not_less_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_order_is_not_greater_than(zoneddatetime,zoneddatetime) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_order_compare(zoneddatetime,zoneddatetime) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_hash(zoneddatetime) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION zoneddatetime_hash_extended(zoneddatetime,int8) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE TYPE zoneddatetime
(
    internallength = 16,
    input = zoneddatetime_input,
    output = zoneddatetime_output,
    receive = zoneddatetime_recv,
    send = zoneddatetime_send,
    alignment = double
);


CREATE OPERATOR === (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_same_as,
    commutator = ===,
    restrict = eqsel,
    join = eqjoinsel
);

CREATE OPERATOR = (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_equal_to,
    commutator = =,
    negator = <>,
    restrict = eqsel,
    join = eqjoinsel
);

CREATE OPERATOR <> (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_not_equal_to,
    commutator = <>,
    negator = =,
    restrict = neqsel,
    join = neqjoinsel
);

CREATE OPERATOR < (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_less_than,
    commutator = >,
    negator = >=,
    restrict = scalarltsel,
    join = scalarltjoinsel
);

CREATE OPERATOR > (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_greater_than,
    commutator = <,
    negator = <=,
    restrict = scalargtsel,
    join = scalargtjoinsel
);

CREATE OPERATOR >= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_not_less_than,
    commutator = <=,
    negator = <,
    restrict = scalargesel,
    join = scalargejoinsel
);

CREATE OPERATOR <= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_is_not_greater_than,
    commutator = >=,
    negator = >,
    restrict = scalarlesel,
    join = scalarlejoinsel
);

CREATE OPERATOR @= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_order_is_equal_to,
    commutator = @=,
    negator = @<>,
    restrict = eqsel,
    join = eqjoinsel,
    hashes, merges
);

CREATE OPERATOR @<> (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_order_is_not_equal_to,
    commutator = @<>,
    negator = @=,
    restrict = neqsel,
    join = neqjoinsel
);

CREATE OPERATOR @< (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_order_is_less_than,
    commutator = @>,
    negator = @>=,
    restrict = scalarltsel,
    join = scalarltjoinsel
);

CREATE OPERATOR @> (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_order_is_greater_than,
    commutator = @<,
    negator = @<=,
    restrict = scalargtsel,
    join = scalargtjoinsel
);

CREATE OPERATOR @>= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_order_is_not_less_than,
    commutator = @<=,
    negator = @<,
    restrict = scalargesel,
    join = scalargejoinsel
);

CREATE OPERATOR @<= (
    leftarg = zoneddatetime,
    rightarg = zoneddatetime,
    procedure = zoneddatetime_order_is_not_greater_than,
    commutator = @>=,
    negator = @>,
    restrict = scalarlesel,
    join = scalarlejoinsel
);


CREATE OPERATOR CLASS zoneddatetime DEFAULT FOR TYPE zoneddatetime USING btree AS
    OPERATOR   1   @<,
    OPERATOR   2   @<=,
    OPERATOR   3   @=,
    OPERATOR   4   @>=,
    OPERATOR   5   @>,
    FUNCTION   1   zoneddatetime_order_compare,
    FUNCTION   4   btequalimage(oid);

CREATE OPERATOR CLASS zoneddatetime DEFAULT FOR TYPE zoneddatetime USING hash AS
    OPERATOR   1   @=,
    FUNCTION   1   zoneddatetime_hash(zoneddatetime),
    FUNCTION   2   zoneddatetime_hash_extended(zoneddatetime,int8);
