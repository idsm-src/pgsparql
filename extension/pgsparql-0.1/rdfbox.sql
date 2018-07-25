CREATE TYPE "rdfbox";

CREATE FUNCTION "rdfbox_input"(cstring) RETURNS "rdfbox"  AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "rdfbox_output"("rdfbox") RETURNS cstring AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE "rdfbox"
(
    internallength = VARIABLE,
    input = "rdfbox_input",
    output = "rdfbox_output",
    alignment = double
);
