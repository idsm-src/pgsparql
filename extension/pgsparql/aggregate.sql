CREATE FUNCTION sum_integer_final(internal) RETURNS decimal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_decimal_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_float_accum(float4, float4) RETURNS float4 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_float_final(float4) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_double_accum(float8, float8) RETURNS float8 AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_double_final(float8) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION sum_rdfbox_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_decimal_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_float_accum(internal, float4) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_float_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_float_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_float_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION avg_float_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION avg_double_accum(internal, float8) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_double_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_double_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_double_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION avg_double_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION avg_rdfbox_accum(internal, rdfbox) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_rdfbox_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_rdfbox_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION avg_rdfbox_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION avg_rdfbox_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION min_rdfbox(rdfbox, rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION max_rdfbox(rdfbox, rdfbox) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION group_concat_string(varchar, varchar, varchar) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION group_concat_string_accum(internal, varchar) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_string_accum(internal, varchar, varchar) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_string_final(internal) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_rdfbox_accum(internal, rdfbox) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_rdfbox_accum(internal, rdfbox, varchar) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_rdfbox_final(internal) RETURNS rdfbox AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_combine(internal, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE;
CREATE FUNCTION group_concat_serialize(internal) RETURNS bytea AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION group_concat_deserialize(bytea, internal) RETURNS internal AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION sample(anyelement, anyelement) RETURNS anyelement AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;


CREATE AGGREGATE sum_integer(decimal) (
    stype = internal,
    sfunc = numeric_avg_accum,
    combinefunc = numeric_avg_combine,    
    finalfunc = sum_integer_final,
    serialfunc = numeric_avg_serialize,
    deserialfunc = numeric_avg_deserialize,
    parallel = safe
);

CREATE AGGREGATE sum_decimal(decimal) (
    stype = internal,
    sfunc = numeric_avg_accum,
    combinefunc = numeric_avg_combine,    
    finalfunc = sum_decimal_final,
    serialfunc = numeric_avg_serialize,
    deserialfunc = numeric_avg_deserialize,
    parallel = safe
);

CREATE AGGREGATE sum_float(float4) (
    stype = float4,
    sfunc = sum_float_accum,
    combinefunc = sum_float_accum,
    finalfunc = sum_float_final,
    parallel = safe
);

CREATE AGGREGATE sum_double(float8) (
    stype = float8,
    sfunc = sum_double_accum,
    combinefunc = sum_double_accum,
    finalfunc = sum_double_final,
    parallel = safe
);

CREATE AGGREGATE sum_rdfbox(rdfbox) (
    stype = internal,
    sfunc = avg_rdfbox_accum,
    combinefunc = avg_rdfbox_combine,
    finalfunc = sum_rdfbox_final,
    serialfunc = avg_rdfbox_serialize,
    deserialfunc = avg_rdfbox_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_integer(decimal) (
    stype = internal,
    sfunc = numeric_avg_accum,
    combinefunc = numeric_avg_combine,    
    finalfunc = avg_decimal_final,
    serialfunc = numeric_avg_serialize,
    deserialfunc = numeric_avg_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_decimal(decimal) (
    stype = internal,
    sfunc = numeric_avg_accum,
    combinefunc = numeric_avg_combine,    
    finalfunc = avg_decimal_final,
    serialfunc = numeric_avg_serialize,
    deserialfunc = numeric_avg_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_float(float4) (
    stype = internal,
    sfunc = avg_float_accum,
    combinefunc = avg_float_combine,
    finalfunc = avg_float_final,
    serialfunc = avg_float_serialize,
    deserialfunc = avg_float_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_double(float8) (
    stype = internal,
    sfunc = avg_double_accum,
    combinefunc = avg_double_combine,
    finalfunc = avg_double_final,
    serialfunc = avg_double_serialize,
    deserialfunc = avg_double_deserialize,
    parallel = safe
);

CREATE AGGREGATE avg_rdfbox(rdfbox) (
    stype = internal,
    sfunc = avg_rdfbox_accum,
    combinefunc = avg_rdfbox_combine,
    finalfunc = avg_rdfbox_final,
    serialfunc = avg_rdfbox_serialize,
    deserialfunc = avg_rdfbox_deserialize,
    parallel = safe
);

CREATE AGGREGATE min_rdfbox(rdfbox) (
    stype = rdfbox,
    sfunc = min_rdfbox,
    combinefunc = min_rdfbox,
    sortop = @<,
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
    finalfunc = group_concat_string_final,
    serialfunc = group_concat_serialize,
    deserialfunc = group_concat_deserialize,
    parallel = safe
);

CREATE AGGREGATE group_concat_string(varchar, varchar) (
    stype = internal,
    sfunc = group_concat_string_accum,
    combinefunc = group_concat_combine,
    finalfunc = group_concat_string_final,
    serialfunc = group_concat_serialize,
    deserialfunc = group_concat_deserialize,
    parallel = safe
);

CREATE AGGREGATE group_concat_rdfbox(rdfbox) (
    stype = internal,
    sfunc = group_concat_rdfbox_accum,
    combinefunc = group_concat_combine,
    finalfunc = group_concat_rdfbox_final,
    serialfunc = group_concat_serialize,
    deserialfunc = group_concat_deserialize,
    parallel = safe
);

CREATE AGGREGATE group_concat_rdfbox(rdfbox, varchar) (
    stype = internal,
    sfunc = group_concat_rdfbox_accum,
    combinefunc = group_concat_combine,
    finalfunc = group_concat_rdfbox_final,
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
