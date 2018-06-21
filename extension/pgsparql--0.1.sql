-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pgsparql" to load this file. \quit


CREATE TYPE "rdfbox";

CREATE FUNCTION "rdfbox_input"(cstring) RETURNS "rdfbox"  AS 'MODULE_PATHNAME','pg_rdfbox_input' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "rdfbox_output"("rdfbox") RETURNS cstring AS 'MODULE_PATHNAME','pg_rdfbox_output' LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE "rdfbox"
(
    internallength = VARIABLE,
    input = "rdfbox_input",
    output = "rdfbox_output",
    alignment = double
);
