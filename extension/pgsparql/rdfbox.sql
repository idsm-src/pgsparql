CREATE TYPE rdfbox;

CREATE FUNCTION rdfbox_input(cstring) RETURNS rdfbox  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_output(rdfbox) RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_recv(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_send(rdfbox) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C PARALLEL SAFE IMMUTABLE STRICT;
CREATE FUNCTION rdfbox_is_same_as(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_is_equal_to(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_is_not_equal_to(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_is_less_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_is_greater_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_is_not_less_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_is_not_greater_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_is_equal_to(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_is_not_equal_to(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_is_less_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_is_greater_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_is_not_less_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_is_not_greater_than(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_order_compare(rdfbox,rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_boolean(bool) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_boolean_with_lexical(bool,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_short(int2) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_short_with_lexical(int2,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_int(int4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_int_with_lexical(int4,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_long(int8) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_long_with_lexical(int8,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_float(float4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_float_with_lexical(float4,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_double(float8) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_double_with_lexical(float8,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_integer(decimal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_integer_with_lexical(decimal,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_decimal(decimal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_decimal_with_lexical(decimal,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_datetime(zoneddatetime) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_datetime(timestamptz,int4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_datetime_with_lexical(zoneddatetime,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_datetime_with_lexical(timestamptz,int4,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_date(zoneddate) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_date(date,int4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_date_with_lexical(zoneddate,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_date_with_lexical(date,int4,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_daytimeduration(int8) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_daytimeduration_with_lexical(int8,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_string(varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_iri(varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_langstring(varchar,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_typedliteral(varchar,varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_iblanknode(int8) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_iblanknode(int4,int4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_sblanknode(varchar) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_create_from_sblanknode(varchar,int4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_boolean(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_boolean(rdfbox,bool) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_boolean_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_boolean_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_short(rdfbox) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_short(rdfbox,bool) RETURNS int2 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_short_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_short_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_int(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_int(rdfbox,bool) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_int_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_int_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_long(rdfbox) RETURNS int8  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_long(rdfbox,bool) RETURNS int8  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_long_lexical(rdfbox) RETURNS varchar  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_long_lexical(rdfbox,bool) RETURNS varchar  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_integer(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_integer(rdfbox,bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_integer_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_integer_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_decimal(rdfbox) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_decimal(rdfbox,bool) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_decimal_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_decimal_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_float(rdfbox) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_float(rdfbox,bool) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_float_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_float_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_double(rdfbox) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_double(rdfbox,bool) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_double_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_double_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime(rdfbox) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime(rdfbox,bool) RETURNS zoneddatetime AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime_value(rdfbox) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime_value(rdfbox,bool) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime_value_of_zone(rdfbox,int4) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime_value_of_zone(rdfbox,int4,bool) RETURNS timestamptz AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime_zone(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime_zone(rdfbox,bool) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_datetime_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date(rdfbox) RETURNS zoneddate AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date(rdfbox,bool) RETURNS zoneddate AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date_value(rdfbox) RETURNS date AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date_value(rdfbox,bool) RETURNS date AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date_value_of_zone(rdfbox,int4) RETURNS date AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date_value_of_zone(rdfbox,int4,bool) RETURNS date AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date_zone(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date_zone(rdfbox,bool) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_date_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_daytimeduration(rdfbox) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_daytimeduration(rdfbox,bool) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_daytimeduration_lexical(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_daytimeduration_lexical(rdfbox,bool) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_string(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_langstring_value(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_langstring_value_of_lang(rdfbox,varchar) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_langstring_lang(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_typedliteral_value(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_typedliteral_value_of_type(rdfbox,varchar) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_typedliteral_type(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_iri(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_iblanknode(rdfbox) RETURNS int8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_iblanknode_value(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_iblanknode_value_of_segment(rdfbox,int4) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_iblanknode_segment(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_sblanknode(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_sblanknode_value(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_sblanknode_value_of_segment(rdfbox,int4) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_sblanknode_segment(rdfbox) RETURNS int4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_get_string_literal(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_uminus(rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_add(rdfbox,rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_sub(rdfbox,rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_mul(rdfbox,rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION rdfbox_div(rdfbox,rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE TYPE rdfbox
(
    internallength = VARIABLE,
    input = rdfbox_input,
    output = rdfbox_output,
    receive = rdfbox_recv,
    send = rdfbox_send,
    alignment = double
);


CREATE OPERATOR === (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_is_same_as,
    commutator = ===,
    hashes, merges
);

CREATE OPERATOR = (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_is_equal_to,
    commutator = =,
    negator = !=,
    hashes, merges
);

CREATE OPERATOR != (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_is_not_equal_to,
    commutator = !=,
    negator = =,
    hashes, merges
);

CREATE OPERATOR < (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_is_less_than,
    commutator = >,
    hashes, merges
);

CREATE OPERATOR > (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_is_greater_than,
    commutator = <,
    hashes, merges
);

CREATE OPERATOR >= (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_is_not_less_than,
    commutator = <=,
    hashes, merges
);

CREATE OPERATOR <= (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_is_not_greater_than,
    commutator = >=,
    hashes, merges
);

CREATE OPERATOR @= (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_is_equal_to,
    commutator = @=,
    negator = @!=,
    hashes, merges
);

CREATE OPERATOR @!= (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_is_not_equal_to,
    commutator = @!=,
    negator = @=,
    hashes, merges
);

CREATE OPERATOR @< (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_is_less_than,
    commutator = @>,
    negator = @>=,
    hashes, merges
);

CREATE OPERATOR @> (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_is_greater_than,
    commutator = @<,
    negator = @<=,
    hashes, merges
);

CREATE OPERATOR @>= (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_is_not_less_than,
    commutator = @<=,
    negator = @<,
    hashes, merges
);

CREATE OPERATOR @<= (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_order_is_not_greater_than,
    commutator = @>=,
    negator = @>,
    hashes, merges
);

CREATE OPERATOR - (
    rightarg = rdfbox,
    procedure = rdfbox_uminus
);

CREATE OPERATOR + (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_add,
    commutator = +
);

CREATE OPERATOR - (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_sub
);

CREATE OPERATOR * (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_mul,
    commutator = *
);

CREATE OPERATOR / (
    leftarg = rdfbox,
    rightarg = rdfbox,
    procedure = rdfbox_div
);


CREATE OPERATOR CLASS rdfbox DEFAULT FOR TYPE rdfbox USING btree AS
    OPERATOR   1   @<,
    OPERATOR   2   @<=,
    OPERATOR   3   @=,
    OPERATOR   4   @>=,
    OPERATOR   5   @>,
    FUNCTION   1   rdfbox_order_compare;
