CREATE TYPE ubox;

CREATE FUNCTION ubox_input(cstring) RETURNS ubox AS 'MODULE_PATHNAME' LANGUAGE C STABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_output(ubox) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C STABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_recv(internal) RETURNS ubox AS 'MODULE_PATHNAME' LANGUAGE C STABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_send(ubox) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C STABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_create(anyelement) RETURNS ubox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_get_value(ubox, anyelement) RETURNS anyelement AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION ubox_as_varchar(ubox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C STABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_is_equal_to(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_is_not_equal_to(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_is_less_than(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_is_greater_than(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_is_not_less_than(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_is_not_greater_than(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_order_compare(ubox, ubox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_order_is_equal_to(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_order_is_not_equal_to(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_order_is_less_than(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_order_is_greater_than(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_order_is_not_less_than(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_order_is_not_greater_than(ubox, ubox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_hash(ubox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;
CREATE FUNCTION ubox_hash_extended(ubox, int8) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;


CREATE TYPE ubox
(
    internallength = VARIABLE,
    input = ubox_input,
    output = ubox_output,
    receive = ubox_recv,
    send = ubox_send,
    alignment = double,
    storage = extended
);


CREATE OPERATOR = (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_is_equal_to,
    commutator = =,
    negator = <>,
    restrict = eqsel,
    join = eqjoinsel
);

CREATE OPERATOR <> (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_is_not_equal_to,
    commutator = <>,
    negator = =,
    restrict = neqsel,
    join = neqjoinsel
);

CREATE OPERATOR < (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_is_less_than,
    commutator = >,
    negator = >=
);

CREATE OPERATOR > (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_is_greater_than,
    commutator = <,
    negator = <=
);

CREATE OPERATOR >= (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_is_not_less_than,
    commutator = <=,
    negator = <
);

CREATE OPERATOR <= (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_is_not_greater_than,
    commutator = >=,
    negator = >
);

CREATE OPERATOR @= (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_order_is_equal_to,
    commutator = @=,
    negator = @<>,
    restrict = eqsel,
    join = eqjoinsel,
    hashes, merges
);

CREATE OPERATOR @<> (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_order_is_not_equal_to,
    commutator = @<>,
    negator = @=,
    restrict = neqsel,
    join = neqjoinsel
);

CREATE OPERATOR @< (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_order_is_less_than,
    commutator = @>,
    negator = @>=,
    restrict = scalarltsel,
    join = scalarltjoinsel
);

CREATE OPERATOR @> (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_order_is_greater_than,
    commutator = @<,
    negator = @<=,
    restrict = scalargtsel,
    join = scalargtjoinsel
);

CREATE OPERATOR @>= (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_order_is_not_less_than,
    commutator = @<=,
    negator = @<,
    restrict = scalargesel,
    join = scalargejoinsel
);

CREATE OPERATOR @<= (
    leftarg = ubox,
    rightarg = ubox,
    procedure = ubox_order_is_not_greater_than,
    commutator = @>=,
    negator = @>,
    restrict = scalarlesel,
    join = scalarlejoinsel
);


CREATE OPERATOR CLASS ubox DEFAULT FOR TYPE ubox USING btree AS
    OPERATOR   1   @<,
    OPERATOR   2   @<=,
    OPERATOR   3   @=,
    OPERATOR   4   @>=,
    OPERATOR   5   @>,
    FUNCTION   1   ubox_order_compare(ubox, ubox);

CREATE OPERATOR CLASS ubox_hash DEFAULT FOR TYPE ubox USING hash AS
    OPERATOR   1   @=,
    FUNCTION   1   ubox_hash(ubox),
    FUNCTION   2   ubox_hash_extended(ubox, int8);
