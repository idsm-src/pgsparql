CREATE FUNCTION sum_integer(decimal, decimal) RETURNS decimal AS $$
    select case when $2 is null then $1
                else sparql.add_integer($1, $2) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum_integer(decimal) (
    stype = decimal,
    sfunc = sum_integer,
    initcond = 0
);


CREATE FUNCTION sum_decimal(decimal, decimal) RETURNS decimal AS $$
    select case when $2 is null then $1
                when $1 is null then $2
                else sparql.add_decimal($1, $2) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION sum_decimal_extract(decimal) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else sparql.cast_as_rdfbox_from_decimal($1) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum_decimal(decimal) (
    stype = decimal,
    sfunc = sum_decimal,
    finalfunc = sum_decimal_extract
);


CREATE FUNCTION sum_float(float4, float4) RETURNS float4 AS $$
    select case when $2 is null then $1
                when $1 is null then $2
                else sparql.add_float($1, $2) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION sum_float_extract(float4) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else sparql.cast_as_rdfbox_from_float($1) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum_float(float4) (
    stype = float4,
    sfunc = sum_float,
    finalfunc = sum_float_extract
);


CREATE FUNCTION sum_double(float8, float8) RETURNS float8 AS $$
    select case when $2 is null then $1
                when $1 is null then $2
                else sparql.add_double($1, $2) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION sum_double_extract(float8) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else sparql.cast_as_rdfbox_from_double($1) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum_double(float8) (
    stype = float8,
    sfunc = sum_double,
    finalfunc = sum_double_extract
);


CREATE TYPE sum_rdfbox_state AS (
    value rdfbox
);

CREATE FUNCTION sum_rdfbox(sum_rdfbox_state, rdfbox) RETURNS sum_rdfbox_state AS $$
    select case when $2 is null then $1
                when $1 is null then row($2)::sparql.sum_rdfbox_state
                else row(sparql.add_rdfbox($1.value, $2))::sparql.sum_rdfbox_state end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION sum_rdfbox_extract(sum_rdfbox_state) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else $1.value end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum_rdfbox(rdfbox) (
    stype = sum_rdfbox_state,
    sfunc = sum_rdfbox,
    finalfunc = sum_rdfbox_extract
);


-- avg aggregate

CREATE TYPE avg_integer_state AS (
    value decimal,
    count integer
);

CREATE FUNCTION avg_integer(avg_integer_state, decimal) RETURNS avg_integer_state AS $$
    select case when $2 is null then $1
                when $1 is null then row($2,1)::sparql.avg_integer_state
                else row(sparql.add_integer($1.value, $2), $1.count + 1)::sparql.avg_integer_state end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION avg_integer_extract(avg_integer_state) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else sparql.cast_as_rdfbox_from_decimal(sparql.div_integer($1.value, ($1.count)::decimal)) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE avg_integer(decimal) (
    stype = avg_integer_state,
    sfunc = avg_integer,
    finalfunc = avg_integer_extract
);


CREATE TYPE avg_decimal_state AS (
    value decimal,
    count integer
);

CREATE FUNCTION avg_decimal(avg_decimal_state, decimal) RETURNS avg_decimal_state AS $$
    select case when $2 is null then $1
                when $1 is null then row($2,1)::sparql.avg_decimal_state
                else row(sparql.add_decimal($1.value, $2), $1.count + 1)::sparql.avg_decimal_state end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION avg_decimal_extract(avg_decimal_state) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else sparql.cast_as_rdfbox_from_decimal(sparql.div_decimal($1.value, ($1.count)::decimal)) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE avg_decimal(decimal) (
    stype = avg_decimal_state,
    sfunc = avg_decimal,
    finalfunc = avg_decimal_extract
);


CREATE TYPE avg_float_state AS (
    value float4,
    count integer
);

CREATE FUNCTION avg_float(avg_float_state, float4) RETURNS avg_float_state AS $$
    select case when $2 is null then $1
                when $1 is null then row($2,1)::sparql.avg_float_state
                else row(sparql.add_float($1.value, $2), $1.count + 1)::sparql.avg_float_state end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION avg_float_extract(avg_float_state) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else sparql.cast_as_rdfbox_from_float(sparql.div_float($1.value, ($1.count)::float4)) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE avg_float(float4) (
    stype = avg_float_state,
    sfunc = avg_float,
    finalfunc = avg_float_extract
);


CREATE TYPE avg_double_state AS (
    value float8,
    count integer
);

CREATE FUNCTION avg_double(avg_double_state, float8) RETURNS avg_double_state AS $$
    select case when $2 is null then $1
                when $1 is null then row($2,1)::sparql.avg_double_state
                else row(sparql.add_double($1.value, $2), $1.count + 1)::sparql.avg_double_state end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION avg_double_extract(avg_double_state) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else sparql.cast_as_rdfbox_from_double(sparql.div_double($1.value, ($1.count)::float8)) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE avg_double(float8) (
    stype = avg_double_state,
    sfunc = avg_double,
    finalfunc = avg_double_extract
);


CREATE TYPE avg_rdfbox_state AS (
    value rdfbox,
    count integer
);

CREATE FUNCTION avg_rdfbox(avg_rdfbox_state, rdfbox) RETURNS avg_rdfbox_state AS $$
    select case when $2 is null then $1
                when $1 is null then row($2,1)::sparql.avg_rdfbox_state
                else row(sparql.add_rdfbox($1.value, $2), $1.count + 1)::sparql.avg_rdfbox_state end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION avg_rdfbox_extract(avg_rdfbox_state) RETURNS rdfbox AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_integer(0)
                else sparql.div_rdfbox($1.value, sparql.cast_as_rdfbox_from_integer($1.count)) end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE avg_rdfbox(rdfbox) (
    stype = avg_rdfbox_state,
    sfunc = avg_rdfbox,
    finalfunc = avg_rdfbox_extract
);


-- min aggregate

CREATE FUNCTION aggregate_min(anyelement, anyelement) RETURNS anyelement AS $$
    select case when $2 is null then $1
                when $1 is null then $2
                when $1 < $2 then $1
                else $2 end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE min(anyelement) (
    stype = anyelement,
    sfunc = aggregate_min
);


CREATE FUNCTION aggregate_min(rdfbox, rdfbox) RETURNS rdfbox AS $$
    select case when $2 is null then $1
                when $1 is null then $2
                when sparql.rdfbox_order_less_than($1, $2) then $1
                else $2 end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE min(rdfbox) (
    stype = rdfbox,
    sfunc = aggregate_min
);


-- max aggregate

CREATE FUNCTION aggregate_max(anyelement, anyelement) RETURNS anyelement AS $$
    select case when $2 is null then $1
                when $1 is null then $2
                when $1 < $2 then $2
                else $1 end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;
    
CREATE AGGREGATE max(anyelement) (
    stype = anyelement,
    sfunc = aggregate_max
);


CREATE FUNCTION aggregate_max(rdfbox, rdfbox) RETURNS rdfbox AS $$
    select case when $2 is null then $1
                when $1 is null then $2
                when sparql.rdfbox_order_less_than($1, $2) then $2
                else $1 end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE max(rdfbox) (
    stype = rdfbox,
    sfunc = aggregate_max
);


-- sample aggregate

CREATE FUNCTION aggregate_sample(anyelement, anyelement) RETURNS anyelement AS $$
    select case when $1 is null then $2
                else $1 end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sample(anyelement) (
    stype = anyelement,
    sfunc = aggregate_sample
);


-- group_concat aggregate

CREATE TYPE group_concat_string_state AS (
    value varchar
);

CREATE FUNCTION group_concat_string(group_concat_string_state, varchar, varchar) RETURNS group_concat_string_state AS $$
    select case when $2 is null then $1
                when $1 is null then row($2)::sparql.group_concat_string_state
                else row(sparql.concat_string_string(sparql.concat_string_string($1.value, $3), $2))::sparql.group_concat_string_state end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION group_concat_string_extract(group_concat_string_state) RETURNS varchar AS $$
    select case when $1 is null then ''
                else $1.value end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE group_concat_string(varchar, varchar) (
    stype = group_concat_string_state,
    sfunc = group_concat_string,
    finalfunc = group_concat_string_extract
);


CREATE TYPE group_concat_rdfbox_state AS (
    value varchar
);

CREATE FUNCTION group_concat_rdfbox(group_concat_rdfbox_state, rdfbox, varchar) RETURNS group_concat_rdfbox_state AS $$
    select case when $2 is null then $1
                when $1 is null then row(sparql.rdfbox_extract_string_literal($2))::sparql.group_concat_rdfbox_state
                else row(sparql.concat_string_string(sparql.concat_string_string($1.value, $3), sparql.rdfbox_extract_string_literal($2)))::sparql.group_concat_rdfbox_state end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION group_concat_rdfbox_extract(group_concat_rdfbox_state) RETURNS varchar AS $$
    select case when $1 is null then sparql.cast_as_rdfbox_from_string('')
                else $1.value end;
    $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE group_concat_rdfbox(rdfbox, varchar) (
    stype = group_concat_rdfbox_state,
    sfunc = group_concat_rdfbox,
    finalfunc = group_concat_rdfbox_extract
);
