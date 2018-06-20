CREATE TYPE "rdfbox";

CREATE FUNCTION "rdfbox_input"(cstring) RETURNS "rdfbox"  AS 'libpgsparql.so','pg_rdfbox_input' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "rdfbox_output"("rdfbox") RETURNS cstring AS 'libpgsparql.so','pg_rdfbox_output' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE "rdfbox"
(
    internallength = VARIABLE,
    input = "rdfbox_input",
    output = "rdfbox_output",
    alignment = double
);
