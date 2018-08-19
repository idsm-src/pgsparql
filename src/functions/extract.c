#include <postgres.h>
#include <fmgr.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "cast/cast.h"


PG_FUNCTION_INFO_V1(rdfbox_extract_boolean);
Datum rdfbox_extract_boolean(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_BOOLEAN)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    bool result = ((RdfBoxBoolean *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_short);
Datum rdfbox_extract_short(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_SHORT)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    int16 result = ((RdfBoxShort *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_INT16(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_int);
Datum rdfbox_extract_int(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_INT)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    int32 result = ((RdfBoxInt *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_INT32(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_long);
Datum rdfbox_extract_long(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_LONG)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    int64 result = ((RdfBoxLong *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_INT64(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_float);
Datum rdfbox_extract_float(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_FLOAT)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    float4 result = ((RdfBoxFloat *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_FLOAT4(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_double);
Datum rdfbox_extract_double(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DOUBLE)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    float8 result = ((RdfBoxDouble *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_FLOAT8(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_integer);
Datum rdfbox_extract_integer(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_INTEGER)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
    size_t length = VARSIZE(value);
    Numeric result = palloc(length);
    memcpy(result, value, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_decimal);
Datum rdfbox_extract_decimal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DECIMAL)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
    size_t length = VARSIZE(value);
    Numeric result = palloc(length);
    memcpy(result, value, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_NUMERIC(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_datetime);
Datum rdfbox_extract_datetime(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATETIME)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    ZonedDateTime *result = palloc0(sizeof(ZonedDateTime));
    *result = ((RdfBoxDateTime *) box)->value;

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_ZONEDDATETIME_P(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_datetime_datetime);
Datum rdfbox_extract_datetime_datetime(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATETIME)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    TimestampTz result = ((RdfBoxDateTime *) box)->value.value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_TIMESTAMPTZ(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_datetime_zone);
Datum rdfbox_extract_datetime_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATETIME)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    int32 result = ((RdfBoxDateTime *) box)->value.zone;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_INT32(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_date);
Datum rdfbox_extract_date(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATE)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    ZonedDate result = ((RdfBoxDate *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_ZONEDDATE(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_date_date);
Datum rdfbox_extract_date_date(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATE)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    DateADT result = ((RdfBoxDate *) box)->value.value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_DATEADT(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_date_zone);
Datum rdfbox_extract_date_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATE)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    int32 result = ((RdfBoxDate *) box)->value.zone;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_INT32(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_daytimeduration);
Datum rdfbox_extract_daytimeduration(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DAYTIMEDURATION)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    int64 result = ((RdfBoxDayTimeDuration *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_INT64(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_string);
Datum rdfbox_extract_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_STRING)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    VarChar *value = (VarChar *) ((RdfBoxString *) box)->value;
    size_t length = VARSIZE(value);
    VarChar *result = palloc(length);
    memcpy(result, value, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_lang_string_string);
Datum rdfbox_extract_lang_string_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_LANGSTRING)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    VarChar *value = (VarChar *) ((RdfBoxLangString *) box)->value;
    size_t length = VARSIZE(value);
    VarChar *result = palloc(length);
    memcpy(result, value, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_lang_string_lang);
Datum rdfbox_extract_lang_string_lang(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_LANGSTRING)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    VarChar *value = (VarChar *) ((RdfBoxLangString *) box)->value;
    VarChar *lang = (VarChar *) (((RdfBoxLangString *) box)->value + VARSIZE(value));
    size_t length = VARSIZE(lang);
    VarChar *result = palloc(length);
    memcpy(result, lang, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_typed_literal_literal);
Datum rdfbox_extract_typed_literal_literal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TYPED_LITERAL)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    VarChar *value = (VarChar *) ((RdfBoxTypedLiteral *) box)->value;
    size_t length = VARSIZE(value);
    VarChar *result = palloc(length);
    memcpy(result, value, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_typed_literal_type);
Datum rdfbox_extract_typed_literal_type(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TYPED_LITERAL)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    VarChar *value = (VarChar *) ((RdfBoxTypedLiteral *) box)->value;
    VarChar *type = (VarChar *) (((RdfBoxTypedLiteral *) box)->value + VARSIZE(value));
    size_t length = VARSIZE(type);
    VarChar *result = palloc(length);
    memcpy(result, type, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_iri);
Datum rdfbox_extract_iri(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IRI)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    VarChar *value = (VarChar *) ((RdfBoxIri *) box)->value;
    size_t length = VARSIZE(value);
    VarChar *result = palloc(length);
    memcpy(result, value, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_int_blanknode);
Datum rdfbox_extract_int_blanknode(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != BLANKNODE_INT)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    int64 result = ((RdfBoxBlankNodeInt *) box)->value;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_INT64(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_str_blanknode);
Datum rdfbox_extract_str_blanknode(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != BLANKNODE_STR)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    VarChar *value = (VarChar *) ((RdfBoxBlankNodeStr *) box)->value;
    size_t length = VARSIZE(value);
    VarChar *result = palloc(length);
    memcpy(result, value, length);

    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_derivated_from_short);
Datum rdfbox_extract_derivated_from_short(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_SHORT)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Datum result = DirectFunctionCall1(cast_as_short_from_rdfbox, RdfBoxGetDatum(box));
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_derivated_from_int);
Datum rdfbox_extract_derivated_from_int(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_INT)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Datum result = DirectFunctionCall1(cast_as_int_from_rdfbox, RdfBoxGetDatum(box));
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_derivated_from_long);
Datum rdfbox_extract_derivated_from_long(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_LONG)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Datum result = DirectFunctionCall1(cast_as_long_from_rdfbox, RdfBoxGetDatum(box));
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_derivated_from_integer);
Datum rdfbox_extract_derivated_from_integer(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_INTEGER)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Datum result = DirectFunctionCall1(cast_as_integer_from_rdfbox, RdfBoxGetDatum(box));
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_derivated_from_decimal);
Datum rdfbox_extract_derivated_from_decimal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_DECIMAL)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Datum result = DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(box));
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_derivated_from_float);
Datum rdfbox_extract_derivated_from_float(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_FLOAT)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Datum result = DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(box));
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(rdfbox_extract_derivated_from_double);
Datum rdfbox_extract_derivated_from_double(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_DOUBLE)
    {
        PG_FREE_IF_COPY(box, 0);
        PG_RETURN_NULL();
    }

    Datum result = DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(box));
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_DATUM(result);
}
