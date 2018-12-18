#include <postgres.h>
#include <utils/numeric.h>
#include "call.h"
#include "rdfbox.h"
#include "xsd.h"
#include "cast/cast.h"

#define PCRE2_CODE_UNIT_WIDTH 8
#include <pcre2.h>


static pcre2_code *languageTagRegex = NULL;
static pcre2_match_data *languageTagMatchData = NULL;
static const char *languageTagPattern = "^(([A-Za-z]{2,3}(-[A-Za-z]{3}){0,3}|[A-Za-z]{4,8})"
        "(-[A-Za-z]{4})?(-([A-Za-z]{2}|[0-9]{3}))?(-([A-Za-z0-9]{5,8}|[0-9][A-Za-z0-9]{3}))*"
        "(-[0-9A-WY-Za-wy-z](-[A-Za-z0-9]{2,8})+)*(-x(-[A-Za-z0-9]{1,8})+)?|x(-[A-Za-z0-9]{1,8})+"
        "|i-ami|i-bnn|i-default|i-enochian|i-hak|i-klingon|i-lux|i-mingo|i-navajo|i-pwn"
        "|i-tao|i-tay|i-tsu|sgn-BE-FR|sgn-BE-NL|sgn-CH-DE)$";


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_boolean);
Datum cast_as_rdfbox_from_boolean(PG_FUNCTION_ARGS)
{
    RdfBoxBoolean *result = (RdfBoxBoolean *) palloc0(sizeof(RdfBoxBoolean));
    SET_VARSIZE(result, sizeof(RdfBoxBoolean));
    result->header.type = XSD_BOOLEAN;
    result->value = PG_GETARG_BOOL(0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_short);
Datum cast_as_rdfbox_from_short(PG_FUNCTION_ARGS)
{
    RdfBoxShort *result = (RdfBoxShort *) palloc0(sizeof(RdfBoxShort));
    SET_VARSIZE(result, sizeof(RdfBoxShort));
    result->header.type = XSD_SHORT;
    result->value = PG_GETARG_INT16(0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_int);
Datum cast_as_rdfbox_from_int(PG_FUNCTION_ARGS)
{
    RdfBoxInt *result = (RdfBoxInt *) palloc0(sizeof(RdfBoxInt));
    SET_VARSIZE(result, sizeof(RdfBoxInt));
    result->header.type = XSD_INT;
    result->value = PG_GETARG_INT32(0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_long);
Datum cast_as_rdfbox_from_long(PG_FUNCTION_ARGS)
{
    RdfBoxLong *result = (RdfBoxLong *) palloc0(sizeof(RdfBoxLong));
    SET_VARSIZE(result, sizeof(RdfBoxLong));
    result->header.type = XSD_LONG;
    result->value = PG_GETARG_INT64(0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_float);
Datum cast_as_rdfbox_from_float(PG_FUNCTION_ARGS)
{
    RdfBoxFloat *result = (RdfBoxFloat *) palloc0(sizeof(RdfBoxFloat));
    SET_VARSIZE(result, sizeof(RdfBoxFloat));
    result->header.type = XSD_FLOAT;
    result->value = PG_GETARG_FLOAT4(0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_double);
Datum cast_as_rdfbox_from_double(PG_FUNCTION_ARGS)
{
    RdfBoxDouble *result = (RdfBoxDouble *) palloc0(sizeof(RdfBoxDouble));
    SET_VARSIZE(result, sizeof(RdfBoxDouble));
    result->header.type = XSD_DOUBLE;
    result->value = PG_GETARG_FLOAT8(0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_integer);
Datum cast_as_rdfbox_from_integer(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    int32 size = VARSIZE(value);

    RdfBoxDecinal *result = (RdfBoxDecinal *) palloc0(sizeof(RdfBoxDecinal) + size);
    SET_VARSIZE(result, sizeof(RdfBoxDecinal) + size);
    result->header.type = XSD_INTEGER;
    memcpy(result->value, value, size);

    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_decimal);
Datum cast_as_rdfbox_from_decimal(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    int32 size = VARSIZE(value);

    RdfBoxDecinal *result = (RdfBoxDecinal *) palloc0(sizeof(RdfBoxDecinal) + size);
    SET_VARSIZE(result, sizeof(RdfBoxDecinal) + size);
    result->header.type = XSD_DECIMAL;
    memcpy(result->value, value, size);

    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_datetime);
Datum cast_as_rdfbox_from_datetime(PG_FUNCTION_ARGS)
{
    RdfBoxDateTime *result = (RdfBoxDateTime *) palloc0(sizeof(RdfBoxDateTime));
    SET_VARSIZE(result, sizeof(RdfBoxDateTime));
    result->header.type = XSD_DATETIME;

    if(PG_NARGS() == 1)
        result->value = *PG_GETARG_ZONEDDATETIME_P(0);
    else
        result->value = (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) };

    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_date);
Datum cast_as_rdfbox_from_date(PG_FUNCTION_ARGS)
{
    RdfBoxDate *result = (RdfBoxDate *) palloc0(sizeof(RdfBoxDate));
    SET_VARSIZE(result, sizeof(RdfBoxDate));
    result->header.type = XSD_DATE;

    if(PG_NARGS() == 1)
        result->value = PG_GETARG_ZONEDDATE(0);
    else
        result->value = (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) };

    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_daytimeduration);
Datum cast_as_rdfbox_from_daytimeduration(PG_FUNCTION_ARGS)
{
    RdfBoxDayTimeDuration *result = (RdfBoxDayTimeDuration *) palloc0(sizeof(RdfBoxDayTimeDuration));
    SET_VARSIZE(result, sizeof(RdfBoxDayTimeDuration));
    result->header.type = XSD_DAYTIMEDURATION;
    result->value = PG_GETARG_INT64(0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_string);
Datum cast_as_rdfbox_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    int32 size = VARSIZE(value);

    RdfBoxString *result = (RdfBoxString *) palloc0(sizeof(RdfBoxString) + size);
    SET_VARSIZE(result, sizeof(RdfBoxString) + size);
    result->header.type = XSD_STRING;
    memcpy(result->value, value, size);

    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_iri);
Datum cast_as_rdfbox_from_iri(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    int32 size = VARSIZE(value);

    RdfBoxIri *result = (RdfBoxIri *) palloc0(sizeof(RdfBoxIri) + size);
    SET_VARSIZE(result, sizeof(RdfBoxIri) + size);
    result->header.type = IRI;
    memcpy(result->value, value, size);

    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_lang_string);
Datum cast_as_rdfbox_from_lang_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *lang = PG_GETARG_VARCHAR_P(1);
    int32 valueSize = VARSIZE(value);
    int32 langSize = VARSIZE(lang);


    int errornumber;
    PCRE2_SIZE erroroffset;

    if(languageTagRegex == NULL &&
            (languageTagRegex = pcre2_compile(languageTagPattern, strlen(languageTagPattern), PCRE2_CASELESS, &errornumber, &erroroffset, NULL)) == NULL)
        elog(ERROR, "cannot compile language tag pattern");

    if(languageTagMatchData == NULL &&
            (languageTagMatchData = pcre2_match_data_create_from_pattern(languageTagRegex, NULL)) == NULL)
        elog(ERROR, "cannot create language tag match data");

    int rc = pcre2_match(languageTagRegex, VARDATA(lang), langSize - VARHDRSZ, 0, 0, languageTagMatchData, NULL);

    if(rc == PCRE2_ERROR_NOMATCH)
        PG_RETURN_NULL();

    if(rc < 0)
        elog(ERROR, "language tag match failed");


    RdfBoxLangString *result = (RdfBoxLangString *) palloc0(sizeof(RdfBoxLangString) + valueSize + langSize);
    SET_VARSIZE(result, sizeof(RdfBoxLangString) + valueSize + langSize);
    result->header.type = RDF_LANGSTRING;
    memcpy(result->value, value, valueSize);
    memcpy(result->value + valueSize, lang, langSize);

    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(lang, 1);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_typed_literal);
Datum cast_as_rdfbox_from_typed_literal(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *type = PG_GETARG_VARCHAR_P(1);
    RdfBox *result = NULL;

    if(strncmp(XSD_BOOLEAN_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_boolean_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_boolean, retval.datum));
    }
    else if(strncmp(XSD_SHORT_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_short_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_short, retval.datum));
    }
    else if(strncmp(XSD_INT_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_int_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_int, retval.datum));
    }
    else if(strncmp(XSD_LONG_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_long_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_long, retval.datum));
    }
    else if(strncmp(XSD_FLOAT_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_float_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_float, retval.datum));
    }
    else if(strncmp(XSD_DOUBLE_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_double_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_double, retval.datum));
    }
    else if(strncmp(XSD_INTEGER_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_integer_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
        {
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_integer, retval.datum));
            pfree(DatumGetNumeric(retval.datum));
        }
    }
    else if(strncmp(XSD_DECIMAL_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_decimal_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
        {
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_decimal, retval.datum));
            pfree(DatumGetNumeric(retval.datum));
        }
    }
    else if(strncmp(XSD_DATETIME_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_datetime_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
        {
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_datetime, retval.datum));
            pfree(DatumGetZonedDateTime(retval.datum));
        }
    }
    else if(strncmp(XSD_DATE_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_date_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_date, retval.datum));
    }
    else if(strncmp(XSD_DAYTIMEDURATION_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_daytimeduration_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_daytimeduration, retval.datum));
    }
    else if(strncmp(XSD_STRING_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        result = DatumGetRdfBox(DirectFunctionCall1(cast_as_rdfbox_from_string, PointerGetDatum(value)));
    }

    if(result == NULL)
    {
        int32 valueSize = VARSIZE(value);
        int32 typeSize = VARSIZE(type);

        result = (RdfBox *) palloc0(sizeof(RdfBoxTypedLiteral) + valueSize + typeSize);
        SET_VARSIZE(result, sizeof(RdfBoxTypedLiteral) + valueSize + typeSize);
        ((RdfBoxTypedLiteral *) result)->header.type = TYPED_LITERAL;
        memcpy(((RdfBoxTypedLiteral *) result)->value, value, valueSize);
        memcpy(((RdfBoxTypedLiteral *) result)->value + valueSize, type, typeSize);
    }


    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(type, 1);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_int_blanknode);
Datum cast_as_rdfbox_from_int_blanknode(PG_FUNCTION_ARGS)
{
    RdfBoxBlankNodeInt *result = (RdfBoxBlankNodeInt *) palloc0(sizeof(RdfBoxBlankNodeInt));
    SET_VARSIZE(result, sizeof(RdfBoxBlankNodeInt));
    result->header.type = BLANKNODE_INT;
    result->value = PG_GETARG_INT64(0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_str_blanknode);
Datum cast_as_rdfbox_from_str_blanknode(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    int32 size = VARSIZE(value);

    RdfBoxBlankNodeStr *result = (RdfBoxBlankNodeStr *) palloc0(sizeof(RdfBoxBlankNodeStr) + size);
    SET_VARSIZE(result, sizeof(RdfBoxBlankNodeStr) + size);
    result->header.type = BLANKNODE_STR;
    memcpy(result->value, value, size);

    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}
