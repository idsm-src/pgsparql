/**
 * @file
 * The magic block that marks the shared library as a PostgreSQL module.
 *
 * @mainpage pgsparql
 *
 * pgsparql is the PostgreSQL extension that the IOCB SPARQL to SQL translator relies on: the SQL that the translator
 * generates holds RDF terms in the types of the extension and evaluates the SPARQL operators, functions and
 * aggregates by calling the functions of the extension. Everything is installed into the schema @c sparql; the SQL
 * declarations are in the scripts of `extension/pgsparql`, this documentation covers their implementation in C.
 *
 * @section mainpage_types Types
 *
 * - @c rdfbox (::RdfBox) holds any RDF term: an IRI, a blank node, a literal or a triple term. A literal of one of the
 *   handled XSD datatypes is stored as its value, so that it compares and orders by the value, together with its
 *   lexical form if that is not the canonical one; a literal of another datatype or with an invalid lexical form is
 *   stored as its lexical form and datatype IRI, and a user literal as a ::UBox and its datatype IRI. The type tag
 *   (::RdfType) tells the kinds apart, and its order carries meaning.
 * - @c ubox (::UBox) holds a value of an arbitrary SQL type together with the OID of that type; it is the value of a
 *   user literal, a literal whose datatype a deployment of the translator maps to an SQL type of its own.
 * - @c zoneddatetime (::ZonedDateTime) and @c zoneddate (::ZonedDate) hold an xsd:dateTime and an xsd:date with an
 *   optional time zone.
 *
 * Outside of an rdfbox, the values of the other datatypes are held by built-in SQL types: xsd:boolean by @c bool,
 * xsd:byte, xsd:unsignedByte and xsd:short by @c int2, xsd:unsignedShort and xsd:int by @c int4, xsd:unsignedInt and
 * xsd:long by @c int8, xsd:unsignedLong, xsd:integer, its subtypes and xsd:decimal by @c numeric, xsd:float by
 * @c float4, xsd:double by @c float8, xsd:dayTimeDuration by @c int8 (in microseconds), and xsd:string and IRIs by
 * @c varchar.
 *
 * @section mainpage_functions SQL-callable functions
 *
 * A function callable from SQL is a version-1 C function, `Datum name(PG_FUNCTION_ARGS)`, bound to the SQL function
 * of the same name by a `CREATE FUNCTION ... LANGUAGE C` statement unless its documentation names another binding.
 * Its documentation describes the SQL arguments, in their order, under the parameter @c fcinfo and the SQL value it
 * returns. Unless stated otherwise, such a function is declared STRICT, so it is never called with a NULL argument,
 * and a NULL result stands for an error of the SPARQL expression.
 *
 * A function implementing a SPARQL function is named after it, `<lower-case SPARQL name>_<argument kinds>`, for
 * example `strstarts_rdfbox_string()`; the other families are `rdfbox_create_from_<type>()` and
 * `rdfbox_get_<type>()`, which put a value into an rdfbox and take it out again,
 * `cast_as_<target>_from_<source>()`, the XPath casts between the datatypes, and `<type>_is_equal_to()`,
 * `<type>_order_compare()` and the like, the operators and the B-tree and hash support functions of a type.
 *
 * @section mainpage_layout Source layout
 *
 * - `cast/` the casts between the XSD datatypes,
 * - `functions/` the SPARQL functions and aggregates,
 * - `rdfbox/` the rdfbox type: its layout, text and binary forms, constructors and getters, comparison, ordering,
 *   hashing and arithmetic,
 * - `types/` the lexical forms of the XSD datatypes and the types ubox, zoneddate and zoneddatetime,
 * - `ryu/` the vendored Ryu library, which prints floats and doubles in the shortest form that reads back exactly;
 *   it is not part of this documentation.
 *
 * @dir cast
 * The casts between the XSD datatypes, as XPath and SPARQL define them.
 *
 * @dir functions
 * The SPARQL functions and aggregates.
 *
 * @dir rdfbox
 * The rdfbox type, which holds any RDF term, and the operations on it.
 *
 * @dir types
 * The lexical forms of the XSD datatypes and the types ubox, zoneddate and zoneddatetime.
 */
#include <postgres.h>
#include <fmgr.h>
#include <utils/guc.h>
#include "functions/regex.h"

PG_MODULE_MAGIC;


#if PG_VERSION_NUM < 160000
void _PG_init(void);
#endif


/**
 * Initializes the module when PostgreSQL loads it: defines the settings of the module and reserves their prefix
 * `pgsparql`.
 */
void _PG_init(void)
{
    regex_cache_init();
    MarkGUCPrefixReserved("pgsparql");
}
