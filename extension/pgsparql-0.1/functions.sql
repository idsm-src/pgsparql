-- functional forms
CREATE FUNCTION "same_term_rdfbox"(rdfbox,rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;

-- functions on RDF terms
CREATE SEQUENCE "query_blanknode";
CREATE FUNCTION "is_bound"(anyelement) RETURNS bool AS $$ SELECT CASE WHEN $1 IS NOT NULL THEN true ELSE NULL END $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "is_iri_rdfbox"(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "is_blank_rdfbox"(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "is_literal_rdfbox"(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "is_numeric_rdfbox"(rdfbox) RETURNS bool AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "lang_rdfbox"(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "datatype_rdfbox"(rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "iri_string"(varchar,varchar) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "iri_rdfbox"(varchar,rdfbox) RETURNS varchar AS 'MODULE_PATHNAME' LANGUAGE C IMMUTABLE STRICT;
CREATE FUNCTION "bnode"() RETURNS int8 AS $$ select nextval('query_blanknode') % (2^32)::int8; $$ LANGUAGE SQL VOLATILE STRICT;
CREATE FUNCTION "uuid"() RETURNS varchar AS $$ select 'urn:uuid:' || uuid_generate_v4(); $$ LANGUAGE SQL VOLATILE STRICT;
CREATE FUNCTION "struuid"() RETURNS varchar AS $$ select uuid_generate_v4()::varchar; $$ LANGUAGE SQL VOLATILE STRICT;

-- hash functions
CREATE FUNCTION "md5_string"(varchar) RETURNS varchar AS $$ select substring(digest($1, 'md5')::varchar from 3); $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "sha1_string"(varchar) RETURNS varchar AS $$ select substring(digest($1, 'sha1')::varchar from 3); $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "sha256_string"(varchar) RETURNS varchar AS $$ select substring(digest($1, 'sha256')::varchar from 3); $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "sha384_string"(varchar) RETURNS varchar AS $$ select substring(digest($1, 'sha384')::varchar from 3); $$ LANGUAGE SQL IMMUTABLE STRICT;
CREATE FUNCTION "sha512_string"(varchar) RETURNS varchar AS $$ select substring(digest($1, 'sha512')::varchar from 3); $$ LANGUAGE SQL IMMUTABLE STRICT;
