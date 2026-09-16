CREATE FUNCTION agg_decimal_accum(internal, decimal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION agg_decimal_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION agg_decimal_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION agg_decimal_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION agg_float_accum(internal, float4) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION agg_float_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION agg_float_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION agg_float_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION agg_double_accum(internal, float8) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION agg_double_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION agg_double_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION agg_double_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION agg_rdfbox_accum(internal, rdfbox) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION agg_rdfbox_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION agg_rdfbox_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION agg_rdfbox_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION sum_integer_final(internal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_decimal_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_float_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_double_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_rdfbox_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_decimal_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_float_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_double_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_rdfbox_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION min_accum(internal, anyelement) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION min_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION min_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION min_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION min_final(internal, anyelement) RETURNS anyelement AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION max_rdfbox(rdfbox, rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION group_concat_string(varchar, varchar, varchar) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION group_concat_string_accum(internal, varchar) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_string_accum(internal, varchar, varchar) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_final(internal) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_rdfbox_accum(internal, rdfbox) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_rdfbox_accum(internal, rdfbox, varchar) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION group_concat_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION sample(anyelement, anyelement) RETURNS anyelement AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE AGGREGATE sum_integer(decimal) (
    stype = internal,
    sfunc = agg_decimal_accum,
    combinefunc = agg_decimal_combine,
    finalfunc = sum_integer_final,
    serialfunc = agg_decimal_serialize,
    deserialfunc = agg_decimal_deserialize,
    parallel = safe
);

CREATE AGGREGATE sum_decimal(decimal) (
    stype = internal,
    sfunc = agg_decimal_accum,
    combinefunc = agg_decimal_combine,
    finalfunc = sum_decimal_final,
    serialfunc = agg_decimal_serialize,
    deserialfunc = agg_decimal_deserialize,
    parallel = safe
);

CREATE AGGREGATE sum_float(float4) (
    stype = internal,
    sfunc = agg_float_accum,
    combinefunc = agg_float_combine,
    finalfunc = sum_float_final,
    serialfunc = agg_float_serialize,
    deserialfunc = agg_float_deserialize,
    parallel = safe
);

CREATE AGGREGATE sum_double(float8) (
    stype = internal,
    sfunc = agg_double_accum,
    combinefunc = agg_double_combine,
    finalfunc = sum_double_final,
    serialfunc = agg_double_serialize,
    deserialfunc = agg_double_deserialize,
    parallel = safe
);

CREATE AGGREGATE sum_rdfbox(rdfbox) (
    stype = internal,
    sfunc = agg_rdfbox_accum,
    combinefunc = agg_rdfbox_combine,
    finalfunc = sum_rdfbox_final,
    serialfunc = agg_rdfbox_serialize,
    deserialfunc = agg_rdfbox_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_integer(decimal) (
    stype = internal,
    sfunc = agg_decimal_accum,
    combinefunc = agg_decimal_combine,
    finalfunc = avg_decimal_final,
    serialfunc = agg_decimal_serialize,
    deserialfunc = agg_decimal_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_decimal(decimal) (
    stype = internal,
    sfunc = agg_decimal_accum,
    combinefunc = agg_decimal_combine,
    finalfunc = avg_decimal_final,
    serialfunc = agg_decimal_serialize,
    deserialfunc = agg_decimal_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_float(float4) (
    stype = internal,
    sfunc = agg_float_accum,
    combinefunc = agg_float_combine,
    finalfunc = avg_float_final,
    serialfunc = agg_float_serialize,
    deserialfunc = agg_float_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_double(float8) (
    stype = internal,
    sfunc = agg_double_accum,
    combinefunc = agg_double_combine,
    finalfunc = avg_double_final,
    serialfunc = agg_double_serialize,
    deserialfunc = agg_double_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_rdfbox(rdfbox) (
    stype = internal,
    sfunc = agg_rdfbox_accum,
    combinefunc = agg_rdfbox_combine,
    finalfunc = avg_rdfbox_final,
    serialfunc = agg_rdfbox_serialize,
    deserialfunc = agg_rdfbox_deserialize,
    parallel = safe
);

CREATE AGGREGATE min(anyelement) (
    stype = internal,
    sfunc = min_accum,
    combinefunc = min_combine,
    finalfunc = min_final,
    finalfunc_extra,
    serialfunc = min_serialize,
    deserialfunc = min_deserialize,
    parallel = safe
);

CREATE AGGREGATE max_rdfbox(rdfbox) (
    stype = rdfbox,
    sfunc = max_rdfbox,
    combinefunc = max_rdfbox,
    sortop = @>,
    parallel = safe
);

CREATE AGGREGATE group_concat_string(varchar) (
    stype = internal,
    sfunc = group_concat_string_accum,
    combinefunc = group_concat_combine,
    finalfunc = group_concat_final,
    serialfunc = group_concat_serialize,
    deserialfunc = group_concat_deserialize,
    parallel = safe
);

CREATE AGGREGATE group_concat_string(varchar, varchar) (
    stype = internal,
    sfunc = group_concat_string_accum,
    combinefunc = group_concat_combine,
    finalfunc = group_concat_final,
    serialfunc = group_concat_serialize,
    deserialfunc = group_concat_deserialize,
    parallel = safe
);

CREATE AGGREGATE group_concat_rdfbox(rdfbox) (
    stype = internal,
    sfunc = group_concat_rdfbox_accum,
    combinefunc = group_concat_combine,
    finalfunc = group_concat_final,
    serialfunc = group_concat_serialize,
    deserialfunc = group_concat_deserialize,
    parallel = safe
);

CREATE AGGREGATE group_concat_rdfbox(rdfbox, varchar) (
    stype = internal,
    sfunc = group_concat_rdfbox_accum,
    combinefunc = group_concat_combine,
    finalfunc = group_concat_final,
    serialfunc = group_concat_serialize,
    deserialfunc = group_concat_deserialize,
    parallel = safe
);

CREATE AGGREGATE sample(anyelement) (
    stype = anyelement,
    sfunc = sample,
    combinefunc = sample,
    parallel = safe
);
