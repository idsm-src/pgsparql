-- functional forms
CREATE FUNCTION "same_term_rdfbox"(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
