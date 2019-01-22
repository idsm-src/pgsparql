CREATE FUNCTION aggregate_extract(anyarray) RETURNS anyelement AS $$ select $1[1]; $$ LANGUAGE SQL IMMUTABLE STRICT;


-- sum aggregate

CREATE FUNCTION aggregate_sum(anyarray, anyelement) RETURNS anyarray AS $$
    select case when $1 is null or $2 is null then array[$2]
                when $1[1] is null then $1
                else array[$1[1]+$2] end;
    $$ LANGUAGE SQL IMMUTABLE;

CREATE FUNCTION aggregate_sum(rdfbox[], rdfbox) RETURNS rdfbox[] AS $$
    select case when $1 is null or $2 is null then array[$2]
                when $1[1] is null then $1
                else array[add_rdfbox($1[1],$2)] end;
    $$ LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE sum(anyelement) (
    stype = anyarray,
    sfunc = aggregate_sum,
    finalfunc = aggregate_extract
);

CREATE AGGREGATE sum(rdfbox) (
    stype = rdfbox[],
    sfunc = aggregate_sum,
    finalfunc = aggregate_extract
);


-- avg aggregate

CREATE TYPE aggregate_avg_rdfbox AS (
    value rdfbox,
    count integer
);

CREATE FUNCTION aggregate_avg_extract(anyarray) RETURNS anyelement AS $$ select $1[1]/$1[2]; $$ LANGUAGE SQL IMMUTABLE STRICT;

CREATE FUNCTION aggregate_avg_extract(aggregate_avg_rdfbox) RETURNS rdfbox AS $$ select div_rdfbox($1.value, sparql.cast_as_rdfbox_from_integer($1.count)); $$ LANGUAGE SQL IMMUTABLE STRICT;

CREATE FUNCTION aggregate_avg(anyarray, anyelement) RETURNS anyarray AS $$
    select case when $1 is null or $2 is null then array[$2,1]
                when $1[1] is null then $1
                else array[$1[1]+$2,$1[2]+1] end;
    $$ LANGUAGE SQL IMMUTABLE;

CREATE FUNCTION aggregate_avg(aggregate_avg_rdfbox, rdfbox) RETURNS aggregate_avg_rdfbox AS $$
    select case when $1 is null or $2 is null then row($2,1)::aggregate_avg_rdfbox
                when $1.value is null then $1
                else row(add_rdfbox($1.value, $2), $1.count + 1)::aggregate_avg_rdfbox end;
    $$ LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE avg(anyelement) (
    stype = anyarray,
    sfunc = aggregate_avg,
    finalfunc = aggregate_avg_extract
);

CREATE AGGREGATE avg(rdfbox) (
    stype = aggregate_avg_rdfbox,
    sfunc = aggregate_avg,
    finalfunc = aggregate_avg_extract
);


-- min aggregate

CREATE FUNCTION aggregate_min(anyarray, anyelement) RETURNS anyarray AS $$
    select case when $1 is null or $2 is null or $2 < $1[1] then array[$2]
                else $1 end;
    $$ LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE min(anyelement) (
    stype = anyarray,
    sfunc = aggregate_min,
    finalfunc = aggregate_extract
);


-- max aggregate

CREATE FUNCTION max_aggregate(anyarray, anyelement) RETURNS anyarray AS $$
    select case when $1 is null or $2 is null or $1[1] < $2 then array[$2]
                else $1 end;
    $$ LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE max(anyelement) (
    stype = anyarray,
    sfunc = max_aggregate,
    finalfunc = aggregate_extract
);


-- sample aggregate

CREATE FUNCTION aggregate_sample(anyarray, anyelement) RETURNS anyarray AS $$
    select case when $1 is null or $2 is null then array[$2]
                else $1 end;
    $$ LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE sample(anyelement) (
    stype = anyarray,
    sfunc = aggregate_sample,
    finalfunc = aggregate_extract
);


-- group_concat aggregate

CREATE FUNCTION aggregate_group_concat(varchar[], varchar, varchar) RETURNS varchar[] AS $$
    select case when $1 is null or $2 is null then array[$2]
                when $1[1] is null then $1
                else array[concat($1[1],$3,$2)::varchar] end;
    $$ LANGUAGE SQL IMMUTABLE;

CREATE AGGREGATE group_concat(varchar, varchar) (
    stype = varchar[],
    sfunc = aggregate_group_concat,
    finalfunc = aggregate_extract
);
