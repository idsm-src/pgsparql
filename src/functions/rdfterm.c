/**
 * @file
 * The SPARQL functions on RDF terms: isIRI, isBlank, isLiteral, isNumeric, isTRIPLE, STR, LANG, LANGDIR, hasLANG,
 * hasLANGDIR, DATATYPE, IRI, BNODE, STRDT, STRLANG and STRLANGDIR.
 *
 * The `str_<type>()` functions give the lexical form of a value held by an SQL type, so that STR does not need the
 * value to be boxed.
 *
 * @see https://www.w3.org/TR/sparql12-query/#func-rdfTerms
 */
#include <postgres.h>
#include <pcre2.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <utils/formatting.h>
#include "call.h"
#include "try-catch.h"
#include "cast/cast.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/syntax.h"
#include "rdfbox/xsd.h"
#include "types/boolean.h"
#include "types/byte.h"
#include "types/unsignedbyte.h"
#include "types/short.h"
#include "types/unsignedshort.h"
#include "types/int.h"
#include "types/unsignedint.h"
#include "types/long.h"
#include "types/unsignedlong.h"
#include "types/integer.h"
#include "types/decimal.h"
#include "types/float.h"
#include "types/double.h"
#include "types/integer.h"
#include "types/decimal.h"
#include "types/daytimeduration.h"


/**
 * The components of an IRI reference, as section 3 of RFC 3986 splits it.
 *
 * Each component is a palloc'd string that keeps its delimiters, so that the components concatenated give the IRI
 * reference again; a component that is not present is NULL.
 */
typedef struct
{
    char *scheme;       /**< the scheme with the terminating `:` */
    char *authority;    /**< the authority with the leading `//` */
    char *path;         /**< the path, possibly empty */
    char *query;        /**< the query with the leading `?` */
    char *fragment;     /**< the fragment with the leading `#` */
}
IriComponents;


/**
 * The datatype IRIs of the literals whose datatype the type of the box determines, indexed by ::RdfType.
 *
 * The entry of #TRIPLE_TERM, which is not a literal, is NULL; the table ends with the language-tagged strings, as a
 * user literal and a typed literal carry their datatype IRI in the box.
 */
static const char *rdfbox_types[] =
{
        NULL,   /* TRIPLE_TERM is not a literal */
        XSD_BOOLEAN_IRI,
        XSD_BYTE_IRI,
        XSD_UNSIGNEDBYTE_IRI,
        XSD_SHORT_IRI,
        XSD_UNSIGNEDSHORT_IRI,
        XSD_INT_IRI,
        XSD_UNSIGNEDINT_IRI,
        XSD_LONG_IRI,
        XSD_UNSIGNEDLONG_IRI,
        XSD_INTEGER_IRI,
        XSD_NONPOSITIVEINTEGER_IRI,
        XSD_NEGATIVEINTEGER_IRI,
        XSD_NONNEGATIVEINTEGER_IRI,
        XSD_POSITIVEINTEGER_IRI,
        XSD_DECIMAL_IRI,
        XSD_FLOAT_IRI,
        XSD_DOUBLE_IRI,
        XSD_DATETIME_IRI,
        XSD_DATE_IRI,
        XSD_DAYTIMEDURATION_IRI,
        XSD_STRING_IRI,
        "http://www.w3.org/1999/02/22-rdf-syntax-ns#langString",
        "http://www.w3.org/1999/02/22-rdf-syntax-ns#dirLangString",
        "http://www.w3.org/1999/02/22-rdf-syntax-ns#dirLangString"
};


/**
 * Tests two varchars for byte-wise equality.
 *
 * @param arg1 the left varchar
 * @param arg2 the right varchar
 * @return true if both have the same bytes
 */
static bool varchar_equals(VarChar* arg1, VarChar* arg2)
{
        size_t len1 = VARSIZE_ANY_EXHDR(arg1);
        size_t len2 = VARSIZE_ANY_EXHDR(arg2);

        return len1 == len2 && !memcmp(VARDATA_ANY(arg1), VARDATA_ANY(arg2), len1);
}


/**
 * Splits an IRI reference into its components, as the regular expression of appendix B of RFC 3986 does.
 *
 * @param string the IRI reference, terminated by a zero byte
 * @return the components; the path is always present, possibly empty
 */
static IriComponents iri_parse(char *string)
{
    IriComponents iri = {.scheme = NULL, .authority = NULL, .path = NULL, .query = NULL, .fragment = NULL };

    char *c = string;
    char *begin = c;

    while(*c != ':' && *c != '/' && *c != '?' && *c != '#' && *c != '\0')
        c++;

    if(*c == ':' && c != begin)
    {
        c++;

        iri.scheme = pnstrdup(begin, c - begin);
        begin = c;
    }

    if(*c == '/' && *(c+1) == '/')
    {
        c += 2;

        while(*c != '/' && *c != '?' && *c != '#' && *c != '\0')
            c++;

        iri.authority = pnstrdup(begin, c - begin);
        begin = c;
    }

    while(*c != '?' && *c != '#' && *c != '\0')
        c++;

    iri.path = pnstrdup(begin, c - begin);
    begin = c;

    if(*c == '?')
    {
        c++;

        while(*c != '#' && *c != '\0')
            c++;

        iri.query = pnstrdup(begin, c - begin);
        begin = c;
    }

    if(*c == '#')
    {
        c++;

        while(*c != '\0')
            c++;

        iri.fragment = pnstrdup(begin, c - begin);
    }

    return iri;
}


/**
 * Merges a relative path with the path of a base IRI, as section 5.2.3 of RFC 3986 does: the relative path replaces
 * everything after the last `/` of the base path.
 *
 * @param base the path of the base IRI; the caller passes `/` for a base IRI with an authority and an empty path
 * @param relative the relative path
 * @return the merged path, palloc'd
 */
static char *iri_merge_path(char *base, char *relative)
{
    int length = strlen(base);

    while(length > 0 && base[length - 1] != '/')
        length--;

    return psprintf("%.*s%s", length, base, relative);
}


/**
 * Removes the dot segments "." and ".." from a path, by the algorithm of section 5.2.4 of RFC 3986.
 *
 * @param path the path, which is not modified
 * @return the path without dot segments, palloc'd
 */
static char *iri_remove_dot_segments(char *path)
{
    char *data = pstrdup(path);
    char *input = data;
    char *result = palloc0(strlen(data) + 1);
    char *output = result;


    // While the input buffer is not empty, loop as follows:
    while(*input != '\0')
    {
        // If the input buffer begins with a prefix of "../" or "./",
        // then remove that prefix from the input buffer; otherwise,
        if(strncmp(input, "../", 3) == 0)
            input += 3;
        else if(strncmp(input, "./", 2) == 0)
            input += 2;

        // if the input buffer begins with a prefix of "/./" or "/.",
        // where "." is a complete path segment, then replace that
        // prefix with "/" in the input buffer; otherwise,
        else if(strncmp(input, "/./", 3) == 0)
            input += 2;
        else if(strncmp(input, "/.", 3) == 0)
            input[1] = '\0';

        // if the input buffer begins with a prefix of "/../" or "/..",
        // where ".." is a complete path segment, then replace that
        // prefix with "/" in the input buffer and remove the last
        // segment and its preceding "/" (if any) from the output
        // buffer; otherwise,
        else if(strncmp(input, "/../", 4) == 0)
        {
            input += 3;

            while(*output != '/' && output != result)
                *(output--) = '\0';

            *output = '\0';
        }
        else if(strncmp(input, "/..", 4) == 0)
        {
            input[1] = '\0';

            while(*output != '/' && output != result)
                *(output--) = '\0';

            *output = '\0';
        }

        // if the input buffer consists only of "." or "..", then remove
        // that from the input buffer; otherwise,
        else if(strcmp(input, ".") == 0)
            input += 1;
        else if(strcmp(input, "..") == 0)
            input += 2;

        // move the first path segment in the input buffer to the end of
        // the output buffer, including the initial "/" character (if
        // any) and any subsequent characters up to, but not including,
        // the next "/" character or the end of the input buffer.
        else
        {
            do
                *(output++) = *(input++);
            while(*input != '\0' && *input != '/');
        }
    }

    return result;
}


/**
 * Tests whether an RDF term is an IRI, the SPARQL functions isIRI and isURI; also bound to `isuri_rdfbox(rdfbox)`.
 *
 * @param fcinfo the rdfbox term
 * @return true if the term is an IRI
 */
PG_FUNCTION_INFO_V1(isiri_rdfbox);
Datum isiri_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = box->type == IRI;
    PG_RETURN_BOOL(result);
}


/**
 * Tests whether an RDF term is a blank node, the SPARQL function isBlank.
 *
 * @param fcinfo the rdfbox term
 * @return true if the term is a blank node, with a numeric or a string label
 */
PG_FUNCTION_INFO_V1(isblank_rdfbox);
Datum isblank_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_blanknode(box);
    PG_RETURN_BOOL(result);
}


/**
 * Tests whether an RDF term is a literal, the SPARQL function isLiteral.
 *
 * @param fcinfo the rdfbox term
 * @return true if the term is a literal of any datatype, a user literal and a literal with an invalid lexical form
 *         included
 */
PG_FUNCTION_INFO_V1(isliteral_rdfbox);
Datum isliteral_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_literal(box);
    PG_RETURN_BOOL(result);
}


/**
 * Tests whether an RDF term is a numeric literal, the SPARQL function isNumeric.
 *
 * @param fcinfo the rdfbox term
 * @return true if the term is a literal of a numeric datatype; a literal with an invalid lexical form is held as a
 *         typed literal and is not numeric
 */
PG_FUNCTION_INFO_V1(isnumeric_rdfbox);
Datum isnumeric_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_numeric(box);
    PG_RETURN_BOOL(result);
}


/**
 * Tests whether an RDF term is a triple term, the SPARQL function isTRIPLE.
 *
 * @param fcinfo the rdfbox term
 * @return true if the term is a triple term
 */
PG_FUNCTION_INFO_V1(istriple_rdfbox);
Datum istriple_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = box->type == TRIPLE_TERM;
    PG_RETURN_BOOL(result);
}


/**
 * The SPARQL function STR of an xsd:boolean.
 *
 * @param fcinfo the bool
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_boolean);
Datum str_boolean(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(boolean_as_varchar(PG_GETARG_BOOL(0)));
}


/**
 * The SPARQL function STR of an xsd:short; also bound to `str_byte(int2)` and `str_unsignedbyte(int2)`.
 *
 * @param fcinfo the int2
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_short);
Datum str_short(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(short_as_varchar(PG_GETARG_INT16(0)));
}


/**
 * The SPARQL function STR of an xsd:int; also bound to `str_unsignedshort(int4)`.
 *
 * @param fcinfo the int4
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_int);
Datum str_int(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(int_as_varchar(PG_GETARG_INT32(0)));
}


/**
 * The SPARQL function STR of an xsd:long; also bound to `str_unsignedint(int8)`.
 *
 * @param fcinfo the int8
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_long);
Datum str_long(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(long_as_varchar(PG_GETARG_INT64(0)));
}


/**
 * The SPARQL function STR of an xsd:integer; also bound to `str_unsignedlong(decimal)` and to the STR functions of
 * the subtypes of xsd:integer.
 *
 * @param fcinfo the numeric
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_integer);
Datum str_integer(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(integer_as_varchar(PG_GETARG_NUMERIC(0)));
}


/**
 * The SPARQL function STR of an xsd:decimal.
 *
 * @param fcinfo the numeric
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_decimal);
Datum str_decimal(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(decimal_as_varchar(PG_GETARG_NUMERIC(0)));
}


/**
 * The SPARQL function STR of an xsd:float.
 *
 * @param fcinfo the float4
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_float);
Datum str_float(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(float_as_varchar(PG_GETARG_FLOAT4(0)));
}


/**
 * The SPARQL function STR of an xsd:double.
 *
 * @param fcinfo the float8
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_double);
Datum str_double(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(double_as_varchar(PG_GETARG_FLOAT8(0)));
}


/**
 * The SPARQL function STR of an xsd:dateTime.
 *
 * @param fcinfo the zoneddatetime, or the timestamptz and the int4 time zone offset
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_datetime);
Datum str_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime value = PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) : (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) };
    PG_RETURN_VARCHAR_P(datetime_as_varchar(&value));
}


/**
 * The SPARQL function STR of an xsd:date.
 *
 * @param fcinfo the zoneddate, or the date and the int4 time zone offset
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_date);
Datum str_date(PG_FUNCTION_ARGS)
{
    ZonedDate value = PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) : (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) };
    PG_RETURN_VARCHAR_P(date_as_varchar(value));
}


/**
 * The SPARQL function STR of an xsd:dayTimeDuration.
 *
 * @param fcinfo the int8 duration in microseconds
 * @return the canonical lexical form as a varchar
 */
PG_FUNCTION_INFO_V1(str_daytimeduration);
Datum str_daytimeduration(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(daytimeduration_as_varchar(PG_GETARG_INT64(0)));
}


/**
 * The SPARQL function STR: the lexical form of a literal or the text of an IRI.
 *
 * A literal that keeps a non-canonical lexical form gives that form, any other one its canonical form; the value of
 * a user literal is printed by the output function of its SQL type, which is why the SQL function is declared
 * STABLE.
 *
 * @param fcinfo the rdfbox term
 * @return the varchar, which may point into the box; NULL for a blank node and a triple term
 */
PG_FUNCTION_INFO_V1(str_rdfbox);
Datum str_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetBoolLexical(box));
            else
                PG_RETURN_VARCHAR_P(boolean_as_varchar(RdfBoxGetBool(box)));

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetInt16Lexical(box));
            else
                PG_RETURN_VARCHAR_P(short_as_varchar(RdfBoxGetInt16(box)));

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetInt32Lexical(box));
            else
                PG_RETURN_VARCHAR_P(int_as_varchar(RdfBoxGetInt32(box)));

        case XSD_UNSIGNEDINT:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetUInt32Lexical(box));
            else
                PG_RETURN_VARCHAR_P(unsignedint_as_varchar(RdfBoxGetUInt32(box)));

        case XSD_LONG:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetInt64Lexical(box));
            else
                PG_RETURN_VARCHAR_P(long_as_varchar(RdfBoxGetInt64(box)));

        case XSD_UNSIGNEDLONG:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetUInt64Lexical(box));
            else
                PG_RETURN_VARCHAR_P(unsignedlong_as_varchar(RdfBoxGetUInt64(box)));

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
            else
                PG_RETURN_VARCHAR_P(integer_as_varchar(RdfBoxGetNumeric(box)));

        case XSD_DECIMAL:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
            else
                PG_RETURN_VARCHAR_P(decimal_as_varchar(RdfBoxGetNumeric(box)));

        case XSD_FLOAT:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetFloat4Lexical(box));
            else
                PG_RETURN_VARCHAR_P(float_as_varchar(RdfBoxGetFloat4(box)));

        case XSD_DOUBLE:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetFloat8Lexical(box));
            else
                PG_RETURN_VARCHAR_P(double_as_varchar(RdfBoxGetFloat8(box)));

        case XSD_DATETIME:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetZonedDateTimeLexical(box));
            else
                PG_RETURN_VARCHAR_P(datetime_as_varchar(RdfBoxGetZonedDateTime(box)));

        case XSD_DATE:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetZonedDateLexical(box));
            else
                PG_RETURN_VARCHAR_P(date_as_varchar(RdfBoxGetZonedDate(box)));

        case XSD_DAYTIMEDURATION:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetInt64Lexical(box));
            else
                PG_RETURN_VARCHAR_P(daytimeduration_as_varchar(RdfBoxGetInt64(box)));

        case USER_LITERAL:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetUserLiteralLexical(box));
            else
                PG_RETURN_VARCHAR_P(ubox_value_as_varchar(fcinfo->flinfo, RdfBoxGetUBox(box)));

        case XSD_STRING:
        case IRI:
        case RDF_LANGSTRING:
        case RDF_LTR_LANGSTRING:
        case RDF_RTL_LANGSTRING:
        case TYPED_LITERAL:
            PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function LANG: the language tag of a literal.
 *
 * @param fcinfo the rdfbox term
 * @return the varchar language tag of a language-tagged string, with or without a base direction, the empty string
 *         for any other literal, NULL for a term that is not a literal
 */
PG_FUNCTION_INFO_V1(lang_rdfbox);
Datum lang_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(rdfbox_is_langstring(box))
    {
        PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
    }
    else if(rdfbox_is_literal(box))
    {
        VarChar *empty = palloc(VARHDRSZ);
        SET_VARSIZE(empty, VARHDRSZ);

        PG_RETURN_VARCHAR_P(empty);
    }
    else
    {
        PG_RETURN_NULL();
    }
}


/**
 * The SPARQL function LANGDIR: the base direction of a literal.
 *
 * @param fcinfo the rdfbox term
 * @return the varchar #RDF_LTR_DIRECTION or #RDF_RTL_DIRECTION of a directional language-tagged string, the empty
 *         string for any other literal, NULL for a term that is not a literal
 */
PG_FUNCTION_INFO_V1(langdir_rdfbox);
Datum langdir_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type == RDF_LTR_LANGSTRING)
    {
        PG_RETURN_TEXT_P(cstring_to_text(RDF_LTR_DIRECTION));
    }
    else if(box->type == RDF_RTL_LANGSTRING)
    {
        PG_RETURN_TEXT_P(cstring_to_text(RDF_RTL_DIRECTION));
    }
    else if(rdfbox_is_literal(box))
    {
        VarChar *empty = palloc(VARHDRSZ);
        SET_VARSIZE(empty, VARHDRSZ);

        PG_RETURN_VARCHAR_P(empty);
    }
    else
    {
        PG_RETURN_NULL();
    }
}


/**
 * Tests whether an RDF term is a language-tagged string, the SPARQL function hasLANG.
 *
 * @param fcinfo the rdfbox term
 * @return true if the term is a language-tagged string, with or without a base direction
 */
PG_FUNCTION_INFO_V1(haslang_rdfbox);
Datum haslang_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_langstring(box);
    PG_RETURN_BOOL(result);
}


/**
 * Tests whether an RDF term is a language-tagged string with a base direction, the SPARQL function hasLANGDIR.
 *
 * @param fcinfo the rdfbox term
 * @return true if the term is a directional language-tagged string
 */
PG_FUNCTION_INFO_V1(haslangdir_rdfbox);
Datum haslangdir_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_dirlangstring(box);
    PG_RETURN_BOOL(result);
}


/**
 * The SPARQL function DATATYPE: the datatype IRI of a literal.
 *
 * @param fcinfo the rdfbox term
 * @return the varchar datatype IRI, `rdf:langString` or `rdf:dirLangString` for a language-tagged string; NULL for
 *         a term that is not a literal
 */
PG_FUNCTION_INFO_V1(datatype_rdfbox);
Datum datatype_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type == TYPED_LITERAL || box->type == USER_LITERAL)
        PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
    else if(rdfbox_is_literal(box))
        PG_RETURN_TEXT_P(cstring_to_text(rdfbox_types[box->type]));
    else
        PG_RETURN_NULL();
}


/**
 * The SPARQL function IRI of a simple literal: resolves an IRI reference against a base IRI, as section 5.2 of
 * RFC 3986 does; also bound to `uri_string(varchar, varchar)`, the SPARQL function URI.
 *
 * The base IRI is taken as it is, without a check; its fragment is not used.
 *
 * @param fcinfo the varchar base IRI and the varchar IRI reference
 * @return the varchar resolved IRI, NULL if the IRI reference is not a valid one
 */
PG_FUNCTION_INFO_V1(iri_string);
Datum iri_string(PG_FUNCTION_ARGS)
{
    text *base_value = PG_GETARG_TEXT_PP(0);
    text *iri_value = PG_GETARG_TEXT_PP(1);

    if(!check_iri_reference(VARDATA_ANY(iri_value), VARSIZE_ANY_EXHDR(iri_value)))
        PG_RETURN_NULL();

    char *base_string = text_to_cstring(base_value);
    char *iri_string = text_to_cstring(iri_value);

    IriComponents base = iri_parse(base_string);
    IriComponents iri = iri_parse(iri_string);
    IriComponents result;

    if(iri.scheme != NULL)
    {
        result.scheme = iri.scheme;
        result.authority = iri.authority;
        result.path = iri_remove_dot_segments(iri.path);
        result.query = iri.query;
    }
    else
    {
        if(iri.authority != NULL)
        {
            result.authority = iri.authority;
            result.path = iri_remove_dot_segments(iri.path);
            result.query = iri.query;
        }
        else
        {
            if(iri.path[0] == '\0')
            {
                result.path = pstrdup(base.path);

                if(iri.query != NULL)
                    result.query = iri.query;
                else
                    result.query = base.query;
            }
            else
            {
                if(iri.path[0] == '/')
                {
                    result.path = iri_remove_dot_segments(iri.path);
                }
                else
                {
                    char *path = iri_merge_path((base.authority != NULL && base.path[0] == '\0') ? "/" : base.path, iri.path);
                    result.path = iri_remove_dot_segments(path);
                }

                result.query = iri.query;
            }

            result.authority = base.authority;
       }

       result.scheme = base.scheme;
    }

    result.fragment = iri.fragment;

    result.scheme = result.scheme != NULL ? result.scheme : "";
    result.authority = result.authority != NULL ? result.authority : "";
    result.path = result.path != NULL ? result.path : "";
    result.query = result.query != NULL ? result.query : "";
    result.fragment = result.fragment != NULL ? result.fragment : "";

    char *absolute = psprintf("%s%s%s%s%s", result.scheme, result.authority, result.path, result.query, result.fragment);
    Datum datum = PointerGetDatum(cstring_to_text(absolute));

    PG_RETURN_DATUM(datum);
}


/**
 * The SPARQL function IRI of an RDF term; also bound to `uri_rdfbox(varchar, rdfbox)`, the SPARQL function URI.
 *
 * @param fcinfo the varchar base IRI and the rdfbox term
 * @return the varchar IRI: an xsd:string resolved against the base IRI by iri_string(), an IRI unchanged; NULL for
 *         any other term and for a string that is not a valid IRI reference
 */
PG_FUNCTION_INFO_V1(iri_rdfbox);
Datum iri_rdfbox(PG_FUNCTION_ARGS)
{
    Datum base = PG_GETARG_DATUM(0);
    RdfBox *box = PG_GETARG_RDFBOX_P(1);

    switch(box->type)
    {
        case XSD_STRING:
            PG_RETURN(NullableFunctionCall2(iri_string, base, PointerGetDatum(RdfBoxGetVarChar(box))));

        case IRI:
            PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * Numbers a fresh blank node, for the SPARQL function BNODE without an argument.
 *
 * The number comes from a counter of the backend, which is why the SQL function is declared VOLATILE; the translator
 * makes it the label of a blank node of its own class.
 *
 * @param fcinfo no arguments
 * @return the int4 number, a different one for each call in the backend
 */
PG_FUNCTION_INFO_V1(bnode);
Datum bnode(PG_FUNCTION_ARGS)
{
    static int32 bnode_id = 0;
    PG_RETURN_INT32(bnode_id++);
}


/**
 * The SPARQL function STRDT: the literal of a lexical form and a datatype IRI.
 *
 * A lexical form of a handled XSD datatype is parsed into the value, and it is kept in the box only if it is not the
 * canonical one; a form that is not valid for its handled datatype or whose value is out of range gives a typed
 * literal, which holds the form and the datatype IRI as they are, and so does any other datatype.
 *
 * @param fcinfo the varchar lexical form and the varchar datatype IRI
 * @return the rdfbox literal, NULL if the datatype is not a handled one and not a valid IRI
 */
PG_FUNCTION_INFO_V1(strdt_string);
Datum strdt_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *type = PG_GETARG_VARCHAR_PP(1);

    char *data = VARDATA_ANY(value);
    int size = VARSIZE_ANY_EXHDR(value);

    char *type_data = VARDATA_ANY(type);
    int type_size = VARSIZE_ANY_EXHDR(type);

    RdfBox *result = NULL;


    PG_TRY_EX();
    {
        if(sizeof(XSD_BOOLEAN_IRI) == type_size + 1 && strncmp(XSD_BOOLEAN_IRI, type_data, type_size) == 0)
        {
            bool val = boolean_parse(data, size);
            char buffer[BOOLEAN_MAXLEN];

            if(boolean_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetBooleanRdfBox(val);
            else
                result = GetBooleanRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_BYTE_IRI) == type_size + 1 && strncmp(XSD_BYTE_IRI, type_data, type_size) == 0)
        {
            int8 val = byte_parse(data, size);
            char buffer[BYTE_MAXLEN];

            if(byte_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetByteRdfBox(val);
            else
                result = GetByteRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_UNSIGNEDBYTE_IRI) == type_size + 1 && strncmp(XSD_UNSIGNEDBYTE_IRI, type_data, type_size) == 0)
        {
            uint8 val = unsignedbyte_parse(data, size);
            char buffer[UNSIGNEDBYTE_MAXLEN];

            if(unsignedbyte_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetUnsignedByteRdfBox(val);
            else
                result = GetUnsignedByteRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_SHORT_IRI) == type_size + 1 && strncmp(XSD_SHORT_IRI, type_data, type_size) == 0)
        {
            int16 val = short_parse(data, size);
            char buffer[SHORT_MAXLEN];

            if(short_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetShortRdfBox(val);
            else
                result = GetShortRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_UNSIGNEDSHORT_IRI) == type_size + 1 && strncmp(XSD_UNSIGNEDSHORT_IRI, type_data, type_size) == 0)
        {
            uint16 val = unsignedshort_parse(data, size);
            char buffer[UNSIGNEDSHORT_MAXLEN];

            if(unsignedshort_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetUnsignedShortRdfBox(val);
            else
                result = GetUnsignedShortRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_INT_IRI) == type_size + 1 && strncmp(XSD_INT_IRI, type_data, type_size) == 0)
        {
            int32 val = int_parse(data, size);
            char buffer[INT_MAXLEN];

            if(int_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetIntRdfBox(val);
            else
                result = GetIntRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_UNSIGNEDINT_IRI) == type_size + 1 && strncmp(XSD_UNSIGNEDINT_IRI, type_data, type_size) == 0)
        {
            uint32 val = unsignedint_parse(data, size);
            char buffer[UNSIGNEDINT_MAXLEN];

            if(unsignedint_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetUnsignedIntRdfBox(val);
            else
                result = GetUnsignedIntRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_LONG_IRI) == type_size + 1 && strncmp(XSD_LONG_IRI, type_data, type_size) == 0)
        {
            int64 val = long_parse(data, size);
            char buffer[LONG_MAXLEN];

            if(long_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetLongRdfBox(val);
            else
                result = GetLongRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_UNSIGNEDLONG_IRI) == type_size + 1 && strncmp(XSD_UNSIGNEDLONG_IRI, type_data, type_size) == 0)
        {
            uint64 val = unsignedlong_parse(data, size);
            char buffer[UNSIGNEDLONG_MAXLEN];

            if(unsignedlong_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetUnsignedLongRdfBox(val);
            else
                result = GetUnsignedLongRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_INTEGER_IRI) == type_size + 1 && strncmp(XSD_INTEGER_IRI, type_data, type_size) == 0)
        {
            Numeric val = integer_parse(data, size);

            if(varchar_equals(value, integer_as_varchar(val)))
                result = GetIntegerRdfBox(val);
            else
                result = GetIntegerRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_NONPOSITIVEINTEGER_IRI) == type_size + 1 && strncmp(XSD_NONPOSITIVEINTEGER_IRI, type_data, type_size) == 0)
        {
            Numeric val = nonpositiveinteger_parse(data, size);

            if(varchar_equals(value, integer_as_varchar(val)))
                result = GetNonPositiveIntegerRdfBox(val);
            else
                result = GetNonPositiveIntegerRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_NEGATIVEINTEGER_IRI) == type_size + 1 && strncmp(XSD_NEGATIVEINTEGER_IRI, type_data, type_size) == 0)
        {
            Numeric val = negativeinteger_parse(data, size);

            if(varchar_equals(value, integer_as_varchar(val)))
                result = GetNegativeIntegerRdfBox(val);
            else
                result = GetNegativeIntegerRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_NONNEGATIVEINTEGER_IRI) == type_size + 1 && strncmp(XSD_NONNEGATIVEINTEGER_IRI, type_data, type_size) == 0)
        {
            Numeric val = nonnegativeinteger_parse(data, size);

            if(varchar_equals(value, integer_as_varchar(val)))
                result = GetNonNegativeIntegerRdfBox(val);
            else
                result = GetNonNegativeIntegerRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_POSITIVEINTEGER_IRI) == type_size + 1 && strncmp(XSD_POSITIVEINTEGER_IRI, type_data, type_size) == 0)
        {
            Numeric val = positiveinteger_parse(data, size);

            if(varchar_equals(value, integer_as_varchar(val)))
                result = GetPositiveIntegerRdfBox(val);
            else
                result = GetPositiveIntegerRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DECIMAL_IRI) == type_size + 1 && strncmp(XSD_DECIMAL_IRI, type_data, type_size) == 0)
        {
            Numeric val = decimal_parse(data, size);

            if(varchar_equals(value, decimal_as_varchar(val)))
                result = GetDecimalRdfBox(val);
            else
                result = GetDecimalRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_FLOAT_IRI) == type_size + 1 && strncmp(XSD_FLOAT_IRI, type_data, type_size) == 0)
        {
            float4 val = float_parse(data, size);
            char buffer[FLOAT_MAXLEN];

            if(float_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetFloatRdfBox(val);
            else
                result = GetFloatRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DOUBLE_IRI) == type_size + 1 && strncmp(XSD_DOUBLE_IRI, type_data, type_size) == 0)
        {
            float8 val = double_parse(data, size);
            char buffer[DOUBLE_MAXLEN];

            if(double_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetDoubleRdfBox(val);
            else
                result = GetDoubleRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DATETIME_IRI) == type_size + 1 && strncmp(XSD_DATETIME_IRI, type_data, type_size) == 0)
        {
            ZonedDateTime *val = datetime_parse(data, size);
            char buffer[DATETIME_MAXLEN];

            if(datetime_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetDateTimeRdfBox(val);
            else
                result = GetDateTimeRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DATE_IRI) == type_size + 1 && strncmp(XSD_DATE_IRI, type_data, type_size) == 0)
        {
            ZonedDate val = date_parse(data, size);
            char buffer[DATE_MAXLEN];

            if(date_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetDateRdfBox(val);
            else
                result = GetDateRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DAYTIMEDURATION_IRI) == type_size + 1 && strncmp(XSD_DAYTIMEDURATION_IRI, type_data, type_size) == 0)
        {
            int64 val = daytimeduration_parse(data, size);
            char buffer[DAYTIMEDURATION_MAXLEN];

            if(daytimeduration_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetDayTimeDurationRdfBox(val);
            else
                result = GetDayTimeDurationRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_STRING_IRI) == type_size + 1 && strncmp(XSD_STRING_IRI, type_data, type_size) == 0)
        {
            result = GetStringRdfBox(data, size);
        }
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE && sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = GetTypedLiteralRdfBox(data, size, type_data, type_size);
    }
    PG_END_TRY_EX();

    if(result == NULL)
    {
        if(!check_iri(type_data, type_size))
            PG_RETURN_NULL();

        result = GetTypedLiteralRdfBox(data, size, type_data, type_size);
    }

    PG_RETURN_RDFBOX_P(result);
}


/**
 * The SPARQL function STRLANG: the language-tagged string of a lexical form and a language tag.
 *
 * @param fcinfo the varchar lexical form and the varchar language tag
 * @return the rdfbox language-tagged string with the language tag in lower case, NULL if the tag is not a valid
 *         language tag
 */
PG_FUNCTION_INFO_V1(strlang_string);
Datum strlang_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *lang = PG_GETARG_VARCHAR_PP(1);

    if(!check_language_tag(VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)))
        PG_RETURN_NULL();

    Datum lcase_lang = CStringGetTextDatum(asc_tolower(VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)));
    PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lcase_lang), VARSIZE_ANY_EXHDR(lcase_lang)));
}


/**
 * The SPARQL function STRLANGDIR: the directional language-tagged string of a lexical form, a language tag and a
 * base direction.
 *
 * @param fcinfo the varchar lexical form, the varchar language tag and the varchar base direction
 * @return the rdfbox directional language-tagged string with the language tag in lower case, NULL if the tag is not
 *         a valid language tag or the direction is neither #RDF_LTR_DIRECTION nor #RDF_RTL_DIRECTION
 */
PG_FUNCTION_INFO_V1(strlangdir_string);
Datum strlangdir_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *lang = PG_GETARG_VARCHAR_PP(1);
    VarChar *dir = PG_GETARG_VARCHAR_PP(2);

    char *dir_data = VARDATA_ANY(dir);
    int dir_size = VARSIZE_ANY_EXHDR(dir);

    if(!check_language_tag(VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)))
        PG_RETURN_NULL();

    Datum lcase_lang = CStringGetTextDatum(asc_tolower(VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)));

    if(sizeof(RDF_LTR_DIRECTION) == dir_size + 1 && strncmp(RDF_LTR_DIRECTION, dir_data, dir_size) == 0)
        PG_RETURN_RDFBOX_P(GetLtrLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lcase_lang), VARSIZE_ANY_EXHDR(lcase_lang)));
    else if(sizeof(RDF_RTL_DIRECTION) == dir_size + 1 && strncmp(RDF_RTL_DIRECTION, dir_data, dir_size) == 0)
        PG_RETURN_RDFBOX_P(GetRtlLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lcase_lang), VARSIZE_ANY_EXHDR(lcase_lang)));
    else
        PG_RETURN_NULL();
}
