CREATE TYPE rdfbox;

CREATE FUNCTION rdfbox_input(cstring) RETURNS rdfbox  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_output(rdfbox) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE TYPE rdfbox
(
    internallength = VARIABLE,
    input = rdfbox_input,
    output = rdfbox_output,
    alignment = double
);


CREATE FUNCTION rdfbox_order_equal(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_not_equal(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_less_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_greater_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_not_less_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_not_greater_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_compare(rdfbox,rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE OPERATOR = (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_equal,
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_not_equal,
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_less_than,
    commutator = >,
    negator = >=,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_greater_than,
    commutator = <,
    negator = <=,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_not_less_than,
    commutator = <=,
    negator = <,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_not_greater_than,
    commutator = >=,
    negator = >,
    hashes, merges
);

CREATE OPERATOR CLASS rdfbox DEFAULT FOR TYPE rdfbox USING btree AS
    OPERATOR   1   <,
    OPERATOR   2   <=,
    OPERATOR   3   =,
    OPERATOR   4   >=,
    OPERATOR   5   >,
    FUNCTION   1   rdfbox_order_compare;
