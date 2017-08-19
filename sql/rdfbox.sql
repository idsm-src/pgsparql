CREATE TYPE "RdfBox";

CREATE FUNCTION "RdfBoxInput"(cstring) RETURNS "RdfBox"  AS 'libpgsparql.so' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "RdfBoxOutput"("RdfBox") RETURNS cstring AS 'libpgsparql.so' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE "RdfBox"
(
    internallength = VARIABLE,
    input = "RdfBoxInput",
    output = "RdfBoxOutput",
    alignment = double
);
