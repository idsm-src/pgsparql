CREATE FUNCTION int_blanknode_create(int4,int4) RETURNS int8 AS $$ select ($1::int8 << 32) | ($2 & x'FFFFFFFF'::int8); $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION int_blanknode_segment(int8) RETURNS int4 AS $$ select ($1 >> 32)::int4; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION int_blanknode_label(int8) RETURNS int4 AS $$ select ($1 << 32 >> 32)::int4; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;

CREATE FUNCTION str_blanknode_create(int4,varchar) RETURNS varchar AS $$ select lpad(to_hex($1),8,'0') || $2; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION str_blanknode_segment(varchar) RETURNS int4 AS $$ select ('x' || substr($1, 0, 9))::bit(32)::int4; $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
CREATE FUNCTION str_blanknode_label(varchar) RETURNS varchar AS $$ select substr($1, 9); $$ LANGUAGE SQL IMMUTABLE PARALLEL SAFE STRICT;
