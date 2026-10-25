/**
 * @file
 * The constructors of rdfbox, `rdfbox_create_from_<type>()`, which box an SQL value as an RDF term.
 *
 * The variants `rdfbox_create_from_<type>_with_lexical()` take the lexical form that the literal was read from as an
 * extra varchar argument: an empty one stands for the canonical lexical form, which the box does not keep, any other is
 * kept as given, without a check that it denotes the value.
 *
 * The constructors trust their arguments: the syntax of an IRI, a language tag or a blank node label, the subject of a
 * triple term, a time zone, and a value of a datatype whose SQL type holds more values than the datatype (xsd:byte,
 * xsd:unsignedByte, xsd:unsignedShort, xsd:unsignedInt and the subtypes of xsd:integer bounded by zero) are checked
 * only when the extension is configured with `--enable-extra-checks`. A box built from arguments that do not satisfy
 * them can be stored, but rdfbox_input() may not read its text form back. Only the numeric of an xsd:unsignedLong is
 * always checked, as it has to be converted anyway.
 */
#include <postgres.h>
#include <utils/numeric.h>
#include "call.h"
#include "rdfbox/syntax.h"
#include "types/byte.h"
#include "types/decimal.h"
#include "types/integer.h"
#include "types/sblanknode.h"
#include "types/timezone.h"
#include "types/unsignedbyte.h"
#include "types/unsignedint.h"
#include "types/unsignedlong.h"
#include "types/unsignedshort.h"
#include "rdfbox/rdfbox.h"


/**
 * Checks that a varchar is an IRI, as the production IRI of RFC 3987 defines it.
 *
 * The check is compiled in only with `--enable-extra-checks`, otherwise checked_iri() is a macro that passes the value
 * through.
 *
 * @param iri the IRI
 * @return the same varchar; an invalid IRI raises an error
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline VarChar *checked_iri(VarChar *iri)
{
    if(!check_iri(VARDATA_ANY(iri), VARSIZE_ANY_EXHDR(iri)))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("invalid IRI")));

    return iri;
}
#else
#define checked_iri(x)    (x)
#endif


/**
 * Checks that a varchar is a language tag.
 *
 * The check is compiled in only with `--enable-extra-checks`, otherwise checked_language_tag() is a macro that passes
 * the value through.
 *
 * @param lang the language tag
 * @return the same varchar; an invalid language tag raises an error
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline VarChar *checked_language_tag(VarChar *lang)
{
    if(!check_language_tag(VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("invalid language tag")));

    return lang;
}
#else
#define checked_language_tag(x)    (x)
#endif


/**
 * Checks that a varchar is the stored form of a string blank node, which begins with its segment written as eight
 * lower-case hexadecimal digits.
 *
 * The check is compiled in only with `--enable-extra-checks`, otherwise checked_sblanknode() is a macro that passes the
 * value through.
 *
 * @param value the stored form of the blank node
 * @return the same varchar; an invalid blank node raises an error
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline VarChar *checked_sblanknode(VarChar *value)
{
    if(!is_sblanknode_value(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("invalid blank node")));

    return value;
}
#else
#define checked_sblanknode(x)    (x)
#endif


/**
 * Checks that a box can be the subject of a triple term, that is an IRI or a blank node.
 *
 * The check is compiled in only with `--enable-extra-checks`, otherwise checked_subject() is a macro that passes the
 * value through.
 *
 * @param subject the subject
 * @return the same box; any other term raises an error
 */
#ifdef PGSPARQL_EXTRA_CHECKS
static inline RdfBox *checked_subject(RdfBox *subject)
{
    if(subject->type != IRI && !rdfbox_is_blanknode(subject))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("invalid subject of triple term")));

    return subject;
}
#else
#define checked_subject(x)    (x)
#endif


/**
 * Boxes an xsd:boolean.
 *
 * @param fcinfo the bool value
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_boolean);
Datum rdfbox_create_from_boolean(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetBooleanRdfBox(PG_GETARG_BOOL(0)));
}


/**
 * Boxes an xsd:boolean together with its lexical form.
 *
 * @param fcinfo the bool value and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_boolean_with_lexical);
Datum rdfbox_create_from_boolean_with_lexical(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetBooleanRdfBox(value));

    PG_RETURN_RDFBOX_P(GetBooleanRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:byte.
 *
 * @param fcinfo the int2 value, in the range of xsd:byte
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_byte);
Datum rdfbox_create_from_byte(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetByteRdfBox(checked_byte(PG_GETARG_INT16(0))));
}


/**
 * Boxes an xsd:byte together with its lexical form.
 *
 * @param fcinfo the int2 value, in the range of xsd:byte, and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_byte_with_lexical);
Datum rdfbox_create_from_byte_with_lexical(PG_FUNCTION_ARGS)
{
    int8 value = checked_byte(PG_GETARG_INT16(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetByteRdfBox(value));

    PG_RETURN_RDFBOX_P(GetByteRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:unsignedByte.
 *
 * @param fcinfo the int2 value, in the range of xsd:unsignedByte
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_unsignedbyte);
Datum rdfbox_create_from_unsignedbyte(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetUnsignedByteRdfBox(checked_unsignedbyte(PG_GETARG_INT16(0))));
}


/**
 * Boxes an xsd:unsignedByte together with its lexical form.
 *
 * @param fcinfo the int2 value, in the range of xsd:unsignedByte, and the varchar lexical form, empty for the canonical
 *               one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_unsignedbyte_with_lexical);
Datum rdfbox_create_from_unsignedbyte_with_lexical(PG_FUNCTION_ARGS)
{
    uint8 value = checked_unsignedbyte(PG_GETARG_INT16(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetUnsignedByteRdfBox(value));

    PG_RETURN_RDFBOX_P(GetUnsignedByteRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:short.
 *
 * @param fcinfo the int2 value
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_short);
Datum rdfbox_create_from_short(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetShortRdfBox(PG_GETARG_INT16(0)));
}


/**
 * Boxes an xsd:short together with its lexical form.
 *
 * @param fcinfo the int2 value and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_short_with_lexical);
Datum rdfbox_create_from_short_with_lexical(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetShortRdfBox(value));

    PG_RETURN_RDFBOX_P(GetShortRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:unsignedShort.
 *
 * @param fcinfo the int4 value, in the range of xsd:unsignedShort
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_unsignedshort);
Datum rdfbox_create_from_unsignedshort(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetUnsignedShortRdfBox(checked_unsignedshort(PG_GETARG_INT32(0))));
}


/**
 * Boxes an xsd:unsignedShort together with its lexical form.
 *
 * @param fcinfo the int4 value, in the range of xsd:unsignedShort, and the varchar lexical form, empty for the
 *               canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_unsignedshort_with_lexical);
Datum rdfbox_create_from_unsignedshort_with_lexical(PG_FUNCTION_ARGS)
{
    uint16 value = checked_unsignedshort(PG_GETARG_INT32(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetUnsignedShortRdfBox(value));

    PG_RETURN_RDFBOX_P(GetUnsignedShortRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:int.
 *
 * @param fcinfo the int4 value
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_int);
Datum rdfbox_create_from_int(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetIntRdfBox(PG_GETARG_INT32(0)));
}


/**
 * Boxes an xsd:int together with its lexical form.
 *
 * @param fcinfo the int4 value and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_int_with_lexical);
Datum rdfbox_create_from_int_with_lexical(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetIntRdfBox(value));

    PG_RETURN_RDFBOX_P(GetIntRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:unsignedInt.
 *
 * @param fcinfo the int8 value, in the range of xsd:unsignedInt
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_unsignedint);
Datum rdfbox_create_from_unsignedint(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetUnsignedIntRdfBox(checked_unsignedint(PG_GETARG_INT64(0))));
}


/**
 * Boxes an xsd:unsignedInt together with its lexical form.
 *
 * @param fcinfo the int8 value, in the range of xsd:unsignedInt, and the varchar lexical form, empty for the canonical
 *               one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_unsignedint_with_lexical);
Datum rdfbox_create_from_unsignedint_with_lexical(PG_FUNCTION_ARGS)
{
    uint32 value = checked_unsignedint(PG_GETARG_INT64(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetUnsignedIntRdfBox(value));

    PG_RETURN_RDFBOX_P(GetUnsignedIntRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:long.
 *
 * @param fcinfo the int8 value
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_long);
Datum rdfbox_create_from_long(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetLongRdfBox(PG_GETARG_INT64(0)));
}


/**
 * Boxes an xsd:long together with its lexical form.
 *
 * @param fcinfo the int8 value and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_long_with_lexical);
Datum rdfbox_create_from_long_with_lexical(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetLongRdfBox(value));

    PG_RETURN_RDFBOX_P(GetLongRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:unsignedLong.
 *
 * @param fcinfo the numeric value
 * @return the rdfbox; a numeric that is not an integer in the range of xsd:unsignedLong raises an error
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_unsignedlong);
Datum rdfbox_create_from_unsignedlong(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetUnsignedLongRdfBox(unsignedlong_from_numeric(PG_GETARG_NUMERIC(0))));
}


/**
 * Boxes an xsd:unsignedLong together with its lexical form.
 *
 * @param fcinfo the numeric value and the varchar lexical form, empty for the canonical one
 * @return the rdfbox; a numeric that is not an integer in the range of xsd:unsignedLong raises an error
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_unsignedlong_with_lexical);
Datum rdfbox_create_from_unsignedlong_with_lexical(PG_FUNCTION_ARGS)
{
    uint64 value = unsignedlong_from_numeric(PG_GETARG_NUMERIC(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetUnsignedLongRdfBox(value));

    PG_RETURN_RDFBOX_P(GetUnsignedLongRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:integer.
 *
 * @param fcinfo the numeric value, which has to be an integer
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_integer);
Datum rdfbox_create_from_integer(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(checked_integer(PG_GETARG_NUMERIC(0))));
}


/**
 * Boxes an xsd:integer together with its lexical form.
 *
 * @param fcinfo the numeric value, which has to be an integer, and the varchar lexical form, empty for the canonical
 *               one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_integer_with_lexical);
Datum rdfbox_create_from_integer_with_lexical(PG_FUNCTION_ARGS)
{
    Numeric value = checked_integer(PG_GETARG_NUMERIC(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetIntegerRdfBox(value));

    PG_RETURN_RDFBOX_P(GetIntegerRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:nonPositiveInteger.
 *
 * @param fcinfo the numeric value, an integer not greater than zero
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_nonpositiveinteger);
Datum rdfbox_create_from_nonpositiveinteger(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetNonPositiveIntegerRdfBox(checked_nonpositiveinteger(PG_GETARG_NUMERIC(0))));
}


/**
 * Boxes an xsd:nonPositiveInteger together with its lexical form.
 *
 * @param fcinfo the numeric value, an integer not greater than zero, and the varchar lexical form, empty for the
 *               canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_nonpositiveinteger_with_lexical);
Datum rdfbox_create_from_nonpositiveinteger_with_lexical(PG_FUNCTION_ARGS)
{
    Numeric value = checked_nonpositiveinteger(PG_GETARG_NUMERIC(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetNonPositiveIntegerRdfBox(value));

    PG_RETURN_RDFBOX_P(GetNonPositiveIntegerRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:negativeInteger.
 *
 * @param fcinfo the numeric value, an integer less than zero
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_negativeinteger);
Datum rdfbox_create_from_negativeinteger(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetNegativeIntegerRdfBox(checked_negativeinteger(PG_GETARG_NUMERIC(0))));
}


/**
 * Boxes an xsd:negativeInteger together with its lexical form.
 *
 * @param fcinfo the numeric value, an integer less than zero, and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_negativeinteger_with_lexical);
Datum rdfbox_create_from_negativeinteger_with_lexical(PG_FUNCTION_ARGS)
{
    Numeric value = checked_negativeinteger(PG_GETARG_NUMERIC(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetNegativeIntegerRdfBox(value));

    PG_RETURN_RDFBOX_P(GetNegativeIntegerRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:nonNegativeInteger.
 *
 * @param fcinfo the numeric value, an integer not less than zero
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_nonnegativeinteger);
Datum rdfbox_create_from_nonnegativeinteger(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetNonNegativeIntegerRdfBox(checked_nonnegativeinteger(PG_GETARG_NUMERIC(0))));
}


/**
 * Boxes an xsd:nonNegativeInteger together with its lexical form.
 *
 * @param fcinfo the numeric value, an integer not less than zero, and the varchar lexical form, empty for the canonical
 *               one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_nonnegativeinteger_with_lexical);
Datum rdfbox_create_from_nonnegativeinteger_with_lexical(PG_FUNCTION_ARGS)
{
    Numeric value = checked_nonnegativeinteger(PG_GETARG_NUMERIC(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetNonNegativeIntegerRdfBox(value));

    PG_RETURN_RDFBOX_P(GetNonNegativeIntegerRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:positiveInteger.
 *
 * @param fcinfo the numeric value, an integer greater than zero
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_positiveinteger);
Datum rdfbox_create_from_positiveinteger(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetPositiveIntegerRdfBox(checked_positiveinteger(PG_GETARG_NUMERIC(0))));
}


/**
 * Boxes an xsd:positiveInteger together with its lexical form.
 *
 * @param fcinfo the numeric value, an integer greater than zero, and the varchar lexical form, empty for the canonical
 *               one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_positiveinteger_with_lexical);
Datum rdfbox_create_from_positiveinteger_with_lexical(PG_FUNCTION_ARGS)
{
    Numeric value = checked_positiveinteger(PG_GETARG_NUMERIC(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetPositiveIntegerRdfBox(value));

    PG_RETURN_RDFBOX_P(GetPositiveIntegerRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:decimal.
 *
 * @param fcinfo the numeric value, which has to be finite
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_decimal);
Datum rdfbox_create_from_decimal(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDecimalRdfBox(checked_decimal(PG_GETARG_NUMERIC(0))));
}


/**
 * Boxes an xsd:decimal together with its lexical form.
 *
 * @param fcinfo the numeric value, which has to be finite, and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_decimal_with_lexical);
Datum rdfbox_create_from_decimal_with_lexical(PG_FUNCTION_ARGS)
{
    Numeric value = checked_decimal(PG_GETARG_NUMERIC(0));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDecimalRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDecimalRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:float.
 *
 * @param fcinfo the float4 value
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_float);
Datum rdfbox_create_from_float(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetFloatRdfBox(PG_GETARG_FLOAT4(0)));
}


/**
 * Boxes an xsd:float together with its lexical form.
 *
 * @param fcinfo the float4 value and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_float_with_lexical);
Datum rdfbox_create_from_float_with_lexical(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(value));

    PG_RETURN_RDFBOX_P(GetFloatRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:double.
 *
 * @param fcinfo the float8 value
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_double);
Datum rdfbox_create_from_double(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDoubleRdfBox(PG_GETARG_FLOAT8(0)));
}


/**
 * Boxes an xsd:double together with its lexical form.
 *
 * @param fcinfo the float8 value and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_double_with_lexical);
Datum rdfbox_create_from_double_with_lexical(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDoubleRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:dateTime.
 *
 * @param fcinfo either the zoneddatetime value, or the timestamptz instant and the int4 time zone (an offset in
 *               seconds, #ZONE_UNSPECIFIED for none)
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_datetime);
Datum rdfbox_create_from_datetime(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetDateTimeRdfBox(PG_GETARG_ZONEDDATETIME_P(0)));
    else
        PG_RETURN_RDFBOX_P(GetDateTimeRdfBox(&((ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = checked_zone(PG_GETARG_INT32(1))})));
}


/**
 * Boxes an xsd:dateTime together with its lexical form.
 *
 * @param fcinfo either the zoneddatetime value, or the timestamptz instant and the int4 time zone, followed by the
 *               varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_datetime_with_lexical);
Datum rdfbox_create_from_datetime_with_lexical(PG_FUNCTION_ARGS)
{
    ZonedDateTime *value = PG_NARGS() == 2 ? PG_GETARG_ZONEDDATETIME_P(0) : &((ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = checked_zone(PG_GETARG_INT32(1))});
    VarChar *lexical = PG_GETARG_VARCHAR_PP(PG_NARGS() - 1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDateTimeRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDateTimeRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:date.
 *
 * @param fcinfo either the zoneddate value, or the date and the int4 time zone (an offset in seconds, #ZONE_UNSPECIFIED
 *               for none)
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_date);
Datum rdfbox_create_from_date(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetDateRdfBox(PG_GETARG_ZONEDDATE(0)));
    else
        PG_RETURN_RDFBOX_P(GetDateRdfBox((ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = checked_zone(PG_GETARG_INT32(1))}));
}


/**
 * Boxes an xsd:date together with its lexical form.
 *
 * @param fcinfo either the zoneddate value, or the date and the int4 time zone, followed by the varchar lexical form,
 *               empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_date_with_lexical);
Datum rdfbox_create_from_date_with_lexical(PG_FUNCTION_ARGS)
{
    ZonedDate value = PG_NARGS() == 2 ? PG_GETARG_ZONEDDATE(0) : (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = checked_zone(PG_GETARG_INT32(1))};
    VarChar *lexical = PG_GETARG_VARCHAR_PP(PG_NARGS() - 1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDateRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDateRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:dayTimeDuration.
 *
 * @param fcinfo the int8 duration in microseconds
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_daytimeduration);
Datum rdfbox_create_from_daytimeduration(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDayTimeDurationRdfBox(PG_GETARG_INT64(0)));
}


/**
 * Boxes an xsd:dayTimeDuration together with its lexical form.
 *
 * @param fcinfo the int8 duration in microseconds and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_daytimeduration_with_lexical);
Datum rdfbox_create_from_daytimeduration_with_lexical(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDayTimeDurationRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDayTimeDurationRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes an xsd:string.
 *
 * @param fcinfo the varchar value
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_string);
Datum rdfbox_create_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    PG_RETURN_RDFBOX_P(GetStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)));
}


/**
 * Boxes a language-tagged string without a base direction.
 *
 * @param fcinfo the varchar value and the varchar language tag
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_langstring);
Datum rdfbox_create_from_langstring(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *lang = checked_language_tag(PG_GETARG_VARCHAR_PP(1));
    PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)));
}


/**
 * Boxes a language-tagged string with the base direction ltr, `"value"@tag--ltr`.
 *
 * @param fcinfo the varchar value and the varchar language tag
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_ltrlangstring);
Datum rdfbox_create_from_ltrlangstring(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *lang = checked_language_tag(PG_GETARG_VARCHAR_PP(1));
    PG_RETURN_RDFBOX_P(GetLtrLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)));
}


/**
 * Boxes a language-tagged string with the base direction rtl, `"value"@tag--rtl`.
 *
 * @param fcinfo the varchar value and the varchar language tag
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_rtllangstring);
Datum rdfbox_create_from_rtllangstring(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *lang = checked_language_tag(PG_GETARG_VARCHAR_PP(1));
    PG_RETURN_RDFBOX_P(GetRtlLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)));
}


/**
 * Boxes a user literal, a value of an arbitrary SQL type together with its datatype IRI.
 *
 * The value is boxed in a ::UBox under the type that the call expression gives the argument.
 *
 * @param fcinfo the anyelement value and the varchar datatype IRI
 * @return the rdfbox; an argument whose type cannot be determined raises an error
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_userliteral);
Datum rdfbox_create_from_userliteral(PG_FUNCTION_ARGS)
{
    Oid typeoid = get_fn_expr_argtype(fcinfo->flinfo, 0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));

    if(!OidIsValid(typeoid))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("could not determine input data type")));

    UBox *value = ubox_make(typeoid, PG_GETARG_DATUM(0));

    PG_RETURN_RDFBOX_P(GetUserLiteralRdfBox(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));
}


/**
 * Boxes a user literal together with its lexical form.
 *
 * The value is boxed in a ::UBox under the type that the call expression gives the argument.
 *
 * @param fcinfo the anyelement value, the varchar datatype IRI and the varchar lexical form, empty for the canonical
 *               one
 * @return the rdfbox; an argument whose type cannot be determined raises an error
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_userliteral_with_lexical);
Datum rdfbox_create_from_userliteral_with_lexical(PG_FUNCTION_ARGS)
{
    Oid typeoid = get_fn_expr_argtype(fcinfo->flinfo, 0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(2);

    if(!OidIsValid(typeoid))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("could not determine input data type")));

    UBox *value = ubox_make(typeoid, PG_GETARG_DATUM(0));

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetUserLiteralRdfBox(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));

    PG_RETURN_RDFBOX_P(GetUserLiteralRdfBoxWithLexical(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type), VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes a user literal whose value is boxed already; bound to `rdfbox_create_from_userliteral(ubox, varchar)`.
 *
 * @param fcinfo the ubox value and the varchar datatype IRI
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_boxed_userliteral);
Datum rdfbox_create_from_boxed_userliteral(PG_FUNCTION_ARGS)
{
    UBox *value = PG_GETARG_UBOX_P(0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));

    PG_RETURN_RDFBOX_P(GetUserLiteralRdfBox(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));
}


/**
 * Boxes a user literal whose value is boxed already, together with its lexical form; bound to
 * `rdfbox_create_from_userliteral_with_lexical(ubox, varchar, varchar)`.
 *
 * @param fcinfo the ubox value, the varchar datatype IRI and the varchar lexical form, empty for the canonical one
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_boxed_userliteral_with_lexical);
Datum rdfbox_create_from_boxed_userliteral_with_lexical(PG_FUNCTION_ARGS)
{
    UBox *value = PG_GETARG_UBOX_P(0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(2);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetUserLiteralRdfBox(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));

    PG_RETURN_RDFBOX_P(GetUserLiteralRdfBoxWithLexical(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type), VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


/**
 * Boxes a typed literal, a literal whose datatype is not handled by pgsparql or whose lexical form is not valid for its
 * datatype.
 *
 * @param fcinfo the varchar lexical form and the varchar datatype IRI
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_typedliteral);
Datum rdfbox_create_from_typedliteral(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));
    PG_RETURN_RDFBOX_P(GetTypedLiteralRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));
}


/**
 * Boxes an IRI.
 *
 * @param fcinfo the varchar IRI
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_iri);
Datum rdfbox_create_from_iri(PG_FUNCTION_ARGS)
{
    VarChar *value = checked_iri(PG_GETARG_VARCHAR_PP(0));
    PG_RETURN_RDFBOX_P(GetIriRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)));
}


/**
 * Boxes an integer blank node.
 *
 * @param fcinfo either the int8 blank node, or its int4 value and its int4 segment
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_iblanknode);
Datum rdfbox_create_from_iblanknode(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetIBlankNodeRdfBox(PG_GETARG_INT64(0)));
    else
        PG_RETURN_RDFBOX_P(GetIBlankNodeRdfBox(((uint64) PG_GETARG_INT32(1)) << 32 | ((uint64) PG_GETARG_INT32(0) & 0xFFFFFFFF)));
}


/**
 * Boxes a string blank node.
 *
 * @param fcinfo either the varchar stored form of the blank node (its segment as eight lower-case hexadecimal digits
 *               followed by its label), or the varchar label and the int4 segment
 * @return the rdfbox
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_sblanknode);
Datum rdfbox_create_from_sblanknode(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
    {
        VarChar *value = checked_sblanknode(PG_GETARG_VARCHAR_PP(0));
        PG_RETURN_RDFBOX_P(GetSBlankNodeRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)));
    }
    else
    {
        VarChar *label = PG_GETARG_VARCHAR_PP(0);
        int32 segment = PG_GETARG_INT32(1);

        int32 size = VARSIZE_ANY_EXHDR(label);
        char *buffer = palloc(8 + size);
        write_sblanknode_segment(buffer, segment);
        memcpy(buffer + 8, VARDATA_ANY(label), size);

        PG_RETURN_RDFBOX_P(GetSBlankNodeRdfBox(buffer, 8 + size));
    }
}


/**
 * Boxes a triple term.
 *
 * @param fcinfo the rdfbox subject, an IRI or a blank node, the varchar predicate IRI and the rdfbox object
 * @return the rdfbox, which embeds copies of the subject and the object
 */
PG_FUNCTION_INFO_V1(rdfbox_create_from_tripleterm);
Datum rdfbox_create_from_tripleterm(PG_FUNCTION_ARGS)
{
    RdfBox *subject = checked_subject(PG_GETARG_RDFBOX_P(0));
    VarChar *predicate = checked_iri(PG_GETARG_VARCHAR_PP(1));
    RdfBox *object = PG_GETARG_RDFBOX_P(2);
    PG_RETURN_RDFBOX_P(GetTripleTermRdfBox(subject, VARDATA_ANY(predicate), VARSIZE_ANY_EXHDR(predicate), object));
}
