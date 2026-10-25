/**
 * @file
 * The getters of rdfbox, `rdfbox_get_<type>()` and their variants, which take the value of one kind of term out of a
 * box.
 *
 * A getter returns NULL if the box holds another kind of term, so that the translator can split a boxed value into the
 * columns of the resource classes it may belong to. The getters of the literals that may keep a lexical form take an
 * optional bool as their last argument, a restriction on a kept lexical form: when it is given, a box is accepted only
 * if it keeps a lexical form (true) or if it does not (false). The getters `rdfbox_get_<type>_lexical()` return the
 * kept lexical form, or the empty varchar if the literal is in its canonical form. The variants `_of_zone`, `_of_lang`,
 * `_of_type` and `_of_segment` accept only a box whose time zone, language tag, datatype IRI or blank node segment is
 * the given one. A result of a by-reference type points into the box.
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/datum.h>
#include <utils/numeric.h>
#include "call.h"
#include "compare.h"
#include "constants.h"
#include "rdfbox/rdfbox.h"
#include "types/date.h"
#include "types/datetime.h"
#include "types/iblanknode.h"
#include "types/sblanknode.h"
#include "types/unsignedlong.h"


/**
 * Extracts the value of an xsd:boolean.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the bool value, NULL if the box is not an xsd:boolean or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_boolean);
Datum rdfbox_get_boolean(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_BOOLEAN || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(RdfBoxGetBool(box));
}


/**
 * Extracts the lexical form of an xsd:boolean.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:boolean or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_boolean_lexical);
Datum rdfbox_get_boolean_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_BOOLEAN || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetBoolLexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:byte.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int2 value, NULL if the box is not an xsd:byte or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_byte);
Datum rdfbox_get_byte(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_BYTE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt8(box));
}


/**
 * Extracts the lexical form of an xsd:byte.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:byte or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_byte_lexical);
Datum rdfbox_get_byte_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_BYTE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetInt16Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:unsignedByte.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int2 value, NULL if the box is not an xsd:unsignedByte or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_unsignedbyte);
Datum rdfbox_get_unsignedbyte(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_UNSIGNEDBYTE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetUInt8(box));
}


/**
 * Extracts the lexical form of an xsd:unsignedByte.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:unsignedByte or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_unsignedbyte_lexical);
Datum rdfbox_get_unsignedbyte_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_UNSIGNEDBYTE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetInt16Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:short.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int2 value, NULL if the box is not an xsd:short or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_short);
Datum rdfbox_get_short(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_SHORT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


/**
 * Extracts the lexical form of an xsd:short.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:short or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_short_lexical);
Datum rdfbox_get_short_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_SHORT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetInt16Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:unsignedShort.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int4 value, NULL if the box is not an xsd:unsignedShort or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_unsignedshort);
Datum rdfbox_get_unsignedshort(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_UNSIGNEDSHORT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT32(RdfBoxGetUInt16(box));
}


/**
 * Extracts the lexical form of an xsd:unsignedShort.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:unsignedShort or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_unsignedshort_lexical);
Datum rdfbox_get_unsignedshort_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_UNSIGNEDSHORT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetInt32Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:int.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int4 value, NULL if the box is not an xsd:int or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_int);
Datum rdfbox_get_int(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_INT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT32(RdfBoxGetInt32(box));
}


/**
 * Extracts the lexical form of an xsd:int.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:int or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_int_lexical);
Datum rdfbox_get_int_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_INT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetInt32Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:unsignedInt.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int8 value, NULL if the box is not an xsd:unsignedInt or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_unsignedint);
Datum rdfbox_get_unsignedint(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_UNSIGNEDINT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT64(RdfBoxGetUInt32(box));
}


/**
 * Extracts the lexical form of an xsd:unsignedInt.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:unsignedInt or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_unsignedint_lexical);
Datum rdfbox_get_unsignedint_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_UNSIGNEDINT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetUInt32Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:long.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int8 value, NULL if the box is not an xsd:long or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_long);
Datum rdfbox_get_long(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_LONG || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT64(RdfBoxGetInt64(box));
}


/**
 * Extracts the lexical form of an xsd:long.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:long or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_long_lexical);
Datum rdfbox_get_long_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_LONG || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetInt64Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:unsignedLong.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the numeric value, NULL if the box is not an xsd:unsignedLong or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_unsignedlong);
Datum rdfbox_get_unsignedlong(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_UNSIGNEDLONG || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(unsignedlong_as_numeric(RdfBoxGetUInt64(box)));
}


/**
 * Extracts the lexical form of an xsd:unsignedLong.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:unsignedLong or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_unsignedlong_lexical);
Datum rdfbox_get_unsignedlong_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_UNSIGNEDLONG || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetUInt64Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:integer.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the numeric value, NULL if the box is not an xsd:integer or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_integer);
Datum rdfbox_get_integer(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_INTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


/**
 * Extracts the lexical form of an xsd:integer.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:integer or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_integer_lexical);
Datum rdfbox_get_integer_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_INTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetAttachment(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:nonPositiveInteger.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the numeric value, NULL if the box is not an xsd:nonPositiveInteger or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_nonpositiveinteger);
Datum rdfbox_get_nonpositiveinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_NONPOSITIVEINTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


/**
 * Extracts the lexical form of an xsd:nonPositiveInteger.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:nonPositiveInteger or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_nonpositiveinteger_lexical);
Datum rdfbox_get_nonpositiveinteger_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_NONPOSITIVEINTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetAttachment(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:negativeInteger.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the numeric value, NULL if the box is not an xsd:negativeInteger or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_negativeinteger);
Datum rdfbox_get_negativeinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_NEGATIVEINTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


/**
 * Extracts the lexical form of an xsd:negativeInteger.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:negativeInteger or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_negativeinteger_lexical);
Datum rdfbox_get_negativeinteger_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_NEGATIVEINTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetAttachment(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:nonNegativeInteger.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the numeric value, NULL if the box is not an xsd:nonNegativeInteger or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_nonnegativeinteger);
Datum rdfbox_get_nonnegativeinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_NONNEGATIVEINTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


/**
 * Extracts the lexical form of an xsd:nonNegativeInteger.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:nonNegativeInteger or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_nonnegativeinteger_lexical);
Datum rdfbox_get_nonnegativeinteger_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_NONNEGATIVEINTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetAttachment(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:positiveInteger.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the numeric value, NULL if the box is not an xsd:positiveInteger or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_positiveinteger);
Datum rdfbox_get_positiveinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_POSITIVEINTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


/**
 * Extracts the lexical form of an xsd:positiveInteger.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:positiveInteger or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_positiveinteger_lexical);
Datum rdfbox_get_positiveinteger_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_POSITIVEINTEGER || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetAttachment(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:decimal.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the numeric value, NULL if the box is not an xsd:decimal or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_decimal);
Datum rdfbox_get_decimal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DECIMAL || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


/**
 * Extracts the lexical form of an xsd:decimal.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:decimal or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_decimal_lexical);
Datum rdfbox_get_decimal_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DECIMAL || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetAttachment(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:float.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the float4 value, NULL if the box is not an xsd:float or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_float);
Datum rdfbox_get_float(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_FLOAT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_FLOAT4(RdfBoxGetFloat4(box));
}


/**
 * Extracts the lexical form of an xsd:float.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:float or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_float_lexical);
Datum rdfbox_get_float_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_FLOAT || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetFloat4Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:double.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the float8 value, NULL if the box is not an xsd:double or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_double);
Datum rdfbox_get_double(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DOUBLE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_FLOAT8(RdfBoxGetFloat8(box));
}


/**
 * Extracts the lexical form of an xsd:double.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:double or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_double_lexical);
Datum rdfbox_get_double_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DOUBLE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetFloat8Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:dateTime together with its time zone.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the zoneddatetime, NULL if the box is not an xsd:dateTime or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_datetime);
Datum rdfbox_get_datetime(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DATETIME || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_ZONEDDATETIME_P(RdfBoxGetZonedDateTime(box));
}


/**
 * Extracts the value of an xsd:dateTime without its time zone.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the timestamptz instant, NULL if the box is not an xsd:dateTime or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_datetime_value);
Datum rdfbox_get_datetime_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DATETIME || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_TIMESTAMPTZ(RdfBoxGetZonedDateTime(box)->value);
}


/**
 * Extracts the value of an xsd:dateTime in a given time zone.
 *
 * @param fcinfo the rdfbox, the int4 time zone (an offset in seconds, #ZONE_UNSPECIFIED for none) and the optional bool
 *               restriction on a kept lexical form
 * @return the timestamptz instant, NULL if the box is not an xsd:dateTime of the time zone or does not satisfy the
 *         restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_datetime_value_of_zone);
Datum rdfbox_get_datetime_value_of_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    int32 zone = PG_GETARG_INT32(1);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(2);

    if(box->type != XSD_DATETIME || !RdfBoxCheckLexicalFlag(box, flag) || RdfBoxGetZonedDateTime(box)->zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_TIMESTAMPTZ(RdfBoxGetZonedDateTime(box)->value);
}


/**
 * Extracts the time zone of an xsd:dateTime.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int4 time zone, an offset in seconds or #ZONE_UNSPECIFIED for none; NULL if the box is not an
 *         xsd:dateTime or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_datetime_zone);
Datum rdfbox_get_datetime_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DATETIME || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT32(RdfBoxGetZonedDateTime(box)->zone);
}


/**
 * Extracts the lexical form of an xsd:dateTime.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:dateTime or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_datetime_lexical);
Datum rdfbox_get_datetime_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DATETIME || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetZonedDateTimeLexical(box) : get_empty_varchar());
}


/**
 * Extracts the lexical form of an xsd:dateTime in a given time zone.
 *
 * @param fcinfo the rdfbox, the int4 time zone (an offset in seconds, #ZONE_UNSPECIFIED for none) and the optional bool
 *               restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:dateTime of the time zone or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_datetime_lexical_of_zone);
Datum rdfbox_get_datetime_lexical_of_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    int32 zone = PG_GETARG_INT32(1);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(2);

    if(box->type != XSD_DATETIME || !RdfBoxCheckLexicalFlag(box, flag) || RdfBoxGetZonedDateTime(box)->zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetZonedDateTimeLexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:date together with its time zone.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the zoneddate, NULL if the box is not an xsd:date or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_date);
Datum rdfbox_get_date(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DATE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_ZONEDDATE(RdfBoxGetZonedDate(box));
}


/**
 * Extracts the value of an xsd:date without its time zone.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the date, NULL if the box is not an xsd:date or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_date_value);
Datum rdfbox_get_date_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DATE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_DATEADT(RdfBoxGetZonedDate(box).value);
}


/**
 * Extracts the value of an xsd:date in a given time zone.
 *
 * @param fcinfo the rdfbox, the int4 time zone (an offset in seconds, #ZONE_UNSPECIFIED for none) and the optional bool
 *               restriction on a kept lexical form
 * @return the date, NULL if the box is not an xsd:date of the time zone or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_date_value_of_zone);
Datum rdfbox_get_date_value_of_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    int32 zone = PG_GETARG_INT32(1);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(2);

    if(box->type != XSD_DATE || !RdfBoxCheckLexicalFlag(box, flag) || RdfBoxGetZonedDate(box).zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_DATEADT(RdfBoxGetZonedDate(box).value);
}


/**
 * Extracts the time zone of an xsd:date.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int4 time zone, an offset in seconds or #ZONE_UNSPECIFIED for none; NULL if the box is not an xsd:date or
 *         does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_date_zone);
Datum rdfbox_get_date_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DATE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT32(RdfBoxGetZonedDate(box).zone);
}


/**
 * Extracts the lexical form of an xsd:date.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:date or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_date_lexical);
Datum rdfbox_get_date_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DATE || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetZonedDateLexical(box) : get_empty_varchar());
}


/**
 * Extracts the lexical form of an xsd:date in a given time zone.
 *
 * @param fcinfo the rdfbox, the int4 time zone (an offset in seconds, #ZONE_UNSPECIFIED for none) and the optional bool
 *               restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:date of the time zone or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_date_lexical_of_zone);
Datum rdfbox_get_date_lexical_of_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    int32 zone = PG_GETARG_INT32(1);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(2);

    if(box->type != XSD_DATE || !RdfBoxCheckLexicalFlag(box, flag) || RdfBoxGetZonedDate(box).zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetZonedDateLexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:dayTimeDuration.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the int8 value in microseconds, NULL if the box is not an xsd:dayTimeDuration or does not satisfy the
 *         restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_daytimeduration);
Datum rdfbox_get_daytimeduration(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DAYTIMEDURATION || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_INT64(RdfBoxGetInt64(box));
}


/**
 * Extracts the lexical form of an xsd:dayTimeDuration.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not an xsd:dayTimeDuration or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_daytimeduration_lexical);
Datum rdfbox_get_daytimeduration_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != XSD_DAYTIMEDURATION || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetInt64Lexical(box) : get_empty_varchar());
}


/**
 * Extracts the value of an xsd:string.
 *
 * @param fcinfo the rdfbox
 * @return the varchar value, NULL if the box is not an xsd:string
 */
PG_FUNCTION_INFO_V1(rdfbox_get_string);
Datum rdfbox_get_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_STRING)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the value of a language-tagged string without a base direction.
 *
 * @param fcinfo the rdfbox
 * @return the varchar value without the language tag, NULL if the box is not a language-tagged string without a base
 *         direction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_langstring_value);
Datum rdfbox_get_langstring_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_LANGSTRING)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the value of a language-tagged string without a base direction with a given language tag.
 *
 * @param fcinfo the rdfbox and the varchar language tag, compared byte by byte
 * @return the varchar value without the language tag, NULL if the box is not a language-tagged string without a base
 *         direction with this tag
 */
PG_FUNCTION_INFO_V1(rdfbox_get_langstring_value_of_lang);
Datum rdfbox_get_langstring_value_of_lang(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *lang = PG_GETARG_VARCHAR_PP(1);

    if(box->type != RDF_LANGSTRING)
        PG_RETURN_NULL();

    if(!varchar_eq(lang, RdfBoxGetAttachment(box)))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the language tag of a language-tagged string without a base direction.
 *
 * @param fcinfo the rdfbox
 * @return the varchar language tag, NULL if the box is not a language-tagged string without a base direction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_langstring_lang);
Datum rdfbox_get_langstring_lang(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_LANGSTRING)
        PG_RETURN_NULL();

    VarChar *lang = RdfBoxGetAttachment(box);
    PG_RETURN_VARCHAR_P(lang);
}


/**
 * Extracts the value of a language-tagged string with the base direction ltr.
 *
 * @param fcinfo the rdfbox
 * @return the varchar value without the language tag, NULL if the box is not a language-tagged string with the base
 *         direction ltr
 */
PG_FUNCTION_INFO_V1(rdfbox_get_ltrlangstring_value);
Datum rdfbox_get_ltrlangstring_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_LTR_LANGSTRING)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the value of a language-tagged string with the base direction ltr with a given language tag.
 *
 * @param fcinfo the rdfbox and the varchar language tag, compared byte by byte
 * @return the varchar value without the language tag, NULL if the box is not a language-tagged string with the base
 *         direction ltr with this tag
 */
PG_FUNCTION_INFO_V1(rdfbox_get_ltrlangstring_value_of_lang);
Datum rdfbox_get_ltrlangstring_value_of_lang(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *lang = PG_GETARG_VARCHAR_PP(1);

    if(box->type != RDF_LTR_LANGSTRING)
        PG_RETURN_NULL();

    if(!varchar_eq(lang, RdfBoxGetAttachment(box)))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the language tag of a language-tagged string with the base direction ltr.
 *
 * @param fcinfo the rdfbox
 * @return the varchar language tag, NULL if the box is not a language-tagged string with the base direction ltr
 */
PG_FUNCTION_INFO_V1(rdfbox_get_ltrlangstring_lang);
Datum rdfbox_get_ltrlangstring_lang(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_LTR_LANGSTRING)
        PG_RETURN_NULL();

    VarChar *lang = RdfBoxGetAttachment(box);
    PG_RETURN_VARCHAR_P(lang);
}


/**
 * Extracts the value of a language-tagged string with the base direction rtl.
 *
 * @param fcinfo the rdfbox
 * @return the varchar value without the language tag, NULL if the box is not a language-tagged string with the base
 *         direction rtl
 */
PG_FUNCTION_INFO_V1(rdfbox_get_rtllangstring_value);
Datum rdfbox_get_rtllangstring_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_RTL_LANGSTRING)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the value of a language-tagged string with the base direction rtl with a given language tag.
 *
 * @param fcinfo the rdfbox and the varchar language tag, compared byte by byte
 * @return the varchar value without the language tag, NULL if the box is not a language-tagged string with the base
 *         direction rtl with this tag
 */
PG_FUNCTION_INFO_V1(rdfbox_get_rtllangstring_value_of_lang);
Datum rdfbox_get_rtllangstring_value_of_lang(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *lang = PG_GETARG_VARCHAR_PP(1);

    if(box->type != RDF_RTL_LANGSTRING)
        PG_RETURN_NULL();

    if(!varchar_eq(lang, RdfBoxGetAttachment(box)))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the language tag of a language-tagged string with the base direction rtl.
 *
 * @param fcinfo the rdfbox
 * @return the varchar language tag, NULL if the box is not a language-tagged string with the base direction rtl
 */
PG_FUNCTION_INFO_V1(rdfbox_get_rtllangstring_lang);
Datum rdfbox_get_rtllangstring_lang(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_RTL_LANGSTRING)
        PG_RETURN_NULL();

    VarChar *lang = RdfBoxGetAttachment(box);
    PG_RETURN_VARCHAR_P(lang);
}


/**
 * Extracts the value of a user literal.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the ubox value, NULL if the box is not a user literal or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_userliteral_value);
Datum rdfbox_get_userliteral_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != USER_LITERAL || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_UBOX_P(RdfBoxGetUBox(box));
}


/**
 * Extracts the value of a user literal of a given datatype.
 *
 * @param fcinfo the rdfbox, the varchar datatype IRI and the optional bool restriction on a kept lexical form
 * @return the ubox value, NULL if the box is not a user literal of the datatype or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_userliteral_value_of_type);
Datum rdfbox_get_userliteral_value_of_type(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *type = PG_GETARG_VARCHAR_PP(1);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(2);

    if(box->type != USER_LITERAL || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    if(!varchar_eq(type, RdfBoxGetAttachment(box)))
        PG_RETURN_NULL();

    PG_RETURN_UBOX_P(RdfBoxGetUBox(box));
}


/**
 * Extracts the value of a user literal of a given datatype as a value of its own SQL type.
 *
 * The function is not declared STRICT, so that the type can be given by a NULL of that type.
 *
 * @param fcinfo the rdfbox, the varchar datatype IRI, an anyelement of the SQL type of the value, whose value is
 *               ignored, and the optional bool restriction on a kept lexical form
 * @return the value as the anyelement type, NULL if the box, the datatype IRI or the restriction is NULL, if the box is
 *         not a user literal of the datatype or if it does not satisfy the restriction; a value of another SQL type
 *         raises an error
 */
PG_FUNCTION_INFO_V1(rdfbox_get_userliteral_typedvalue_of_type);
Datum rdfbox_get_userliteral_typedvalue_of_type(PG_FUNCTION_ARGS)
{
    if(PG_ARGISNULL(0) || PG_ARGISNULL(1) || (PG_NARGS() == 4 && PG_ARGISNULL(3)))
        PG_RETURN_NULL();

    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *type = PG_GETARG_VARCHAR_PP(1);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(3);

    if(box->type != USER_LITERAL || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    if(!varchar_eq(type, RdfBoxGetAttachment(box)))
        PG_RETURN_NULL();

    PG_RETURN_DATUM(ubox_value_of_type(RdfBoxGetUBox(box), get_fn_expr_rettype(fcinfo->flinfo)));
}


/**
 * Extracts the datatype IRI of a user literal.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar datatype IRI, NULL if the box is not a user literal or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_userliteral_type);
Datum rdfbox_get_userliteral_type(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != USER_LITERAL || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
}


/**
 * Extracts the lexical form of a user literal.
 *
 * @param fcinfo the rdfbox and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not a user literal or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_userliteral_lexical);
Datum rdfbox_get_userliteral_lexical(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(1);

    if(box->type != USER_LITERAL || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetUserLiteralLexical(box) : get_empty_varchar());
}


/**
 * Extracts the lexical form of a user literal of a given datatype.
 *
 * @param fcinfo the rdfbox, the varchar datatype IRI and the optional bool restriction on a kept lexical form
 * @return the varchar lexical form kept by the box, empty if the literal is in the canonical form; NULL if the box is
 *         not a user literal of the datatype or does not satisfy the restriction
 */
PG_FUNCTION_INFO_V1(rdfbox_get_userliteral_lexical_of_type);
Datum rdfbox_get_userliteral_lexical_of_type(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *type = PG_GETARG_VARCHAR_PP(1);
    LexicalFlag flag = PG_GETARG_LEXICAL_FLAG(2);

    if(box->type != USER_LITERAL || !RdfBoxCheckLexicalFlag(box, flag))
        PG_RETURN_NULL();

    if(!varchar_eq(type, RdfBoxGetAttachment(box)))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(box->lexical ? RdfBoxGetUserLiteralLexical(box) : get_empty_varchar());
}


/**
 * Extracts the lexical form of a typed literal, a literal of a datatype not handled by pgsparql or with an invalid
 * lexical form.
 *
 * @param fcinfo the rdfbox
 * @return the varchar lexical form, NULL if the box is not a typed literal
 */
PG_FUNCTION_INFO_V1(rdfbox_get_typedliteral_value);
Datum rdfbox_get_typedliteral_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TYPED_LITERAL)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the lexical form of a typed literal of a given datatype.
 *
 * @param fcinfo the rdfbox and the varchar datatype IRI
 * @return the varchar lexical form, NULL if the box is not a typed literal of the datatype
 */
PG_FUNCTION_INFO_V1(rdfbox_get_typedliteral_value_of_type);
Datum rdfbox_get_typedliteral_value_of_type(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *type = PG_GETARG_VARCHAR_PP(1);

    if(box->type != TYPED_LITERAL)
        PG_RETURN_NULL();

    if(!varchar_eq(type, RdfBoxGetAttachment(box)))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the datatype IRI of a typed literal.
 *
 * @param fcinfo the rdfbox
 * @return the varchar datatype IRI, NULL if the box is not a typed literal
 */
PG_FUNCTION_INFO_V1(rdfbox_get_typedliteral_type);
Datum rdfbox_get_typedliteral_type(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TYPED_LITERAL)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
}


/**
 * Extracts an IRI.
 *
 * @param fcinfo the rdfbox
 * @return the varchar IRI, NULL if the box is not an IRI
 */
PG_FUNCTION_INFO_V1(rdfbox_get_iri);
Datum rdfbox_get_iri(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IRI)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts an integer blank node.
 *
 * @param fcinfo the rdfbox
 * @return the int8 blank node, its segment in the upper and its value in the lower 32 bits; NULL if the box is not an
 *         integer blank node
 */
PG_FUNCTION_INFO_V1(rdfbox_get_iblanknode);
Datum rdfbox_get_iblanknode(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_INT64(RdfBoxGetInt64(box));
}


/**
 * Extracts the value of an integer blank node, whatever its segment is.
 *
 * @param fcinfo the rdfbox
 * @return the int4 value, NULL if the box is not an integer blank node
 */
PG_FUNCTION_INFO_V1(rdfbox_get_iblanknode_value);
Datum rdfbox_get_iblanknode_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IBLANKNODE)
        PG_RETURN_NULL();

    int64 blanknode = RdfBoxGetInt64(box);
    PG_RETURN_DATUM(DirectFunctionCall1(iblanknode_get_value, Int64GetDatum(blanknode)));
}


/**
 * Extracts the value of an integer blank node of a given segment.
 *
 * @param fcinfo the rdfbox and the int4 segment
 * @return the int4 value, NULL if the box is not an integer blank node of the segment
 */
PG_FUNCTION_INFO_V1(rdfbox_get_iblanknode_value_of_segment);
Datum rdfbox_get_iblanknode_value_of_segment(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum segment  = PG_GETARG_DATUM(1);

    if(box->type != IBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN(NullableFunctionCall2(iblanknode_get_value_of_segment, Int64GetDatum(RdfBoxGetInt64(box)), segment));
}


/**
 * Extracts the segment of an integer blank node.
 *
 * @param fcinfo the rdfbox
 * @return the int4 segment, NULL if the box is not an integer blank node
 */
PG_FUNCTION_INFO_V1(rdfbox_get_iblanknode_segment);
Datum rdfbox_get_iblanknode_segment(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(DirectFunctionCall1(iblanknode_get_segment, Int64GetDatum(RdfBoxGetInt64(box))));
}


/**
 * Extracts a string blank node.
 *
 * @param fcinfo the rdfbox
 * @return the varchar stored form of the blank node, its segment as eight lower-case hexadecimal digits followed by its
 *         label; NULL if the box is not a string blank node
 */
PG_FUNCTION_INFO_V1(rdfbox_get_sblanknode);
Datum rdfbox_get_sblanknode(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != SBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


/**
 * Extracts the label of a string blank node, whatever its segment is.
 *
 * @param fcinfo the rdfbox
 * @return the varchar label, NULL if the box is not a string blank node
 */
PG_FUNCTION_INFO_V1(rdfbox_get_sblanknode_value);
Datum rdfbox_get_sblanknode_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != SBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(DirectFunctionCall1(sblanknode_get_value, PointerGetDatum(RdfBoxGetVarChar(box))));
}


/**
 * Extracts the label of a string blank node of a given segment.
 *
 * @param fcinfo the rdfbox and the int4 segment
 * @return the varchar label, NULL if the box is not a string blank node of the segment
 */
PG_FUNCTION_INFO_V1(rdfbox_get_sblanknode_value_of_segment);
Datum rdfbox_get_sblanknode_value_of_segment(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum segment  = PG_GETARG_DATUM(1);

    if(box->type != SBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN(NullableFunctionCall2(sblanknode_get_value_of_segment, PointerGetDatum(RdfBoxGetVarChar(box)), segment));
}


/**
 * Extracts the segment of a string blank node.
 *
 * @param fcinfo the rdfbox
 * @return the int4 segment, NULL if the box is not a string blank node
 */
PG_FUNCTION_INFO_V1(rdfbox_get_sblanknode_segment);
Datum rdfbox_get_sblanknode_segment(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != SBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(DirectFunctionCall1(sblanknode_get_segment, PointerGetDatum(RdfBoxGetVarChar(box))));
}


/**
 * Extracts the subject of a triple term, the SPARQL 1.2 function SUBJECT.
 *
 * @param fcinfo the rdfbox
 * @return the rdfbox subject, NULL if the box is not a triple term
 */
PG_FUNCTION_INFO_V1(rdfbox_get_tripleterm_subject);
Datum rdfbox_get_tripleterm_subject(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TRIPLE_TERM)
        PG_RETURN_NULL();

    PG_RETURN_RDFBOX_P(RdfBoxGetTripleTermSubject(box));
}


/**
 * Extracts the predicate of a triple term, the SPARQL 1.2 function PREDICATE.
 *
 * @param fcinfo the rdfbox
 * @return the varchar predicate IRI, NULL if the box is not a triple term
 */
PG_FUNCTION_INFO_V1(rdfbox_get_tripleterm_predicate);
Datum rdfbox_get_tripleterm_predicate(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TRIPLE_TERM)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetTripleTermPredicate(box));
}


/**
 * Extracts the object of a triple term, the SPARQL 1.2 function OBJECT.
 *
 * @param fcinfo the rdfbox
 * @return the rdfbox object, NULL if the box is not a triple term
 */
PG_FUNCTION_INFO_V1(rdfbox_get_tripleterm_object);
Datum rdfbox_get_tripleterm_object(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TRIPLE_TERM)
        PG_RETURN_NULL();

    PG_RETURN_RDFBOX_P(RdfBoxGetTripleTermObject(box));
}


/**
 * Extracts the lexical form of any string literal, an xsd:string or a language-tagged string with or without a base
 * direction.
 *
 * @param fcinfo the rdfbox
 * @return the varchar lexical form without a language tag, NULL if the box is not a string literal
 */
PG_FUNCTION_INFO_V1(rdfbox_get_string_literal);
Datum rdfbox_get_string_literal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(!rdfbox_is_string_literal(box))
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}
