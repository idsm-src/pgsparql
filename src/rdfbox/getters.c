#include <postgres.h>
#include <utils/datum.h>
#include <utils/numeric.h>
#include "call.h"
#include "compare.h"
#include "rdfbox/rdfbox.h"
#include "types/date.h"
#include "types/datetime.h"
#include "types/iblanknode.h"
#include "types/sblanknode.h"


PG_FUNCTION_INFO_V1(rdfbox_get_boolean);
Datum rdfbox_get_boolean(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_BOOLEAN)
        PG_RETURN_NULL();

    PG_RETURN_BOOL(RdfBoxGetBool(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_short);
Datum rdfbox_get_short(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_SHORT)
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_int);
Datum rdfbox_get_int(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_INT)
        PG_RETURN_NULL();

    PG_RETURN_INT32(RdfBoxGetInt32(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_long);
Datum rdfbox_get_long(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_LONG)
        PG_RETURN_NULL();

    PG_RETURN_INT64(RdfBoxGetInt64(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_float);
Datum rdfbox_get_float(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_FLOAT)
        PG_RETURN_NULL();

    PG_RETURN_FLOAT4(RdfBoxGetFloat4(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_double);
Datum rdfbox_get_double(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DOUBLE)
        PG_RETURN_NULL();

    PG_RETURN_FLOAT8(RdfBoxGetFloat8(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_integer);
Datum rdfbox_get_integer(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_INTEGER)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_decimal);
Datum rdfbox_get_decimal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DECIMAL)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_datetime);
Datum rdfbox_get_datetime(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATETIME)
        PG_RETURN_NULL();

    PG_RETURN_ZONEDDATETIME_P(RdfBoxGetZonedDateTime(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_datetime_value);
Datum rdfbox_get_datetime_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATETIME)
        PG_RETURN_NULL();

    PG_RETURN_TIMESTAMPTZ(RdfBoxGetZonedDateTime(box)->value);
}


PG_FUNCTION_INFO_V1(rdfbox_get_datetime_value_of_zone);
Datum rdfbox_get_datetime_value_of_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    int32 zone = PG_GETARG_INT32(1);

    if(box->type != XSD_DATETIME || RdfBoxGetZonedDateTime(box)->zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_TIMESTAMPTZ(RdfBoxGetZonedDateTime(box)->value);
}


PG_FUNCTION_INFO_V1(rdfbox_get_datetime_zone);
Datum rdfbox_get_datetime_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATETIME)
        PG_RETURN_NULL();

    PG_RETURN_INT32(RdfBoxGetZonedDateTime(box)->zone);
}


PG_FUNCTION_INFO_V1(rdfbox_get_date);
Datum rdfbox_get_date(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATE)
        PG_RETURN_NULL();

    PG_RETURN_ZONEDDATE(RdfBoxGetZonedDate(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_date_value);
Datum rdfbox_get_date_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATE)
        PG_RETURN_NULL();

    PG_RETURN_DATEADT(RdfBoxGetZonedDate(box).value);
}


PG_FUNCTION_INFO_V1(rdfbox_get_date_value_of_zone);
Datum rdfbox_get_date_value_of_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    int32 zone = PG_GETARG_INT32(1);

    if(box->type != XSD_DATE || RdfBoxGetZonedDate(box).zone != zone)
        PG_RETURN_NULL();

    PG_RETURN_DATEADT(RdfBoxGetZonedDate(box).value);
}


PG_FUNCTION_INFO_V1(rdfbox_get_date_zone);
Datum rdfbox_get_date_zone(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DATE)
        PG_RETURN_NULL();

    PG_RETURN_INT32(RdfBoxGetZonedDate(box).zone);
}


PG_FUNCTION_INFO_V1(rdfbox_get_daytimeduration);
Datum rdfbox_get_daytimeduration(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_DAYTIMEDURATION)
        PG_RETURN_NULL();

    PG_RETURN_INT64(RdfBoxGetInt64(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_string);
Datum rdfbox_get_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_STRING)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_langstring_value);
Datum rdfbox_get_langstring_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_LANGSTRING)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


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


PG_FUNCTION_INFO_V1(rdfbox_get_langstring_lang);
Datum rdfbox_get_langstring_lang(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != RDF_LANGSTRING)
        PG_RETURN_NULL();

    VarChar *lang = RdfBoxGetAttachment(box);
    PG_RETURN_VARCHAR_P(lang);
}


PG_FUNCTION_INFO_V1(rdfbox_get_typedliteral_value);
Datum rdfbox_get_typedliteral_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TYPED_LITERAL)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


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


PG_FUNCTION_INFO_V1(rdfbox_get_typedliteral_type);
Datum rdfbox_get_typedliteral_type(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != TYPED_LITERAL)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_iri);
Datum rdfbox_get_iri(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IRI)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_iblanknode);
Datum rdfbox_get_iblanknode(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_INT64(RdfBoxGetInt64(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_iblanknode_value);
Datum rdfbox_get_iblanknode_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IBLANKNODE)
        PG_RETURN_NULL();

    int64 blanknode = RdfBoxGetInt64(box);
    PG_RETURN_DATUM(DirectFunctionCall1(iblanknode_get_value, Int64GetDatum(blanknode)));
}


PG_FUNCTION_INFO_V1(rdfbox_get_iblanknode_value_of_segment);
Datum rdfbox_get_iblanknode_value_of_segment(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum segment  = PG_GETARG_DATUM(1);

    if(box->type != IBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN(NullableFunctionCall2(iblanknode_get_value_of_segment, Int64GetDatum(RdfBoxGetInt64(box)), segment));
}


PG_FUNCTION_INFO_V1(rdfbox_get_iblanknode_segment);
Datum rdfbox_get_iblanknode_segment(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != IBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(DirectFunctionCall1(iblanknode_get_segment, Int64GetDatum(RdfBoxGetInt64(box))));
}


PG_FUNCTION_INFO_V1(rdfbox_get_sblanknode);
Datum rdfbox_get_sblanknode(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != SBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}


PG_FUNCTION_INFO_V1(rdfbox_get_sblanknode_value);
Datum rdfbox_get_sblanknode_value(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != SBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(DirectFunctionCall1(sblanknode_get_value, PointerGetDatum(RdfBoxGetVarChar(box))));
}


PG_FUNCTION_INFO_V1(rdfbox_get_sblanknode_value_of_segment);
Datum rdfbox_get_sblanknode_value_of_segment(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum segment  = PG_GETARG_DATUM(1);

    if(box->type != SBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN(NullableFunctionCall2(sblanknode_get_value_of_segment, PointerGetDatum(RdfBoxGetVarChar(box)), segment));
}


PG_FUNCTION_INFO_V1(rdfbox_get_sblanknode_segment);
Datum rdfbox_get_sblanknode_segment(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != SBLANKNODE)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(DirectFunctionCall1(sblanknode_get_segment, PointerGetDatum(RdfBoxGetVarChar(box))));
}


PG_FUNCTION_INFO_V1(rdfbox_get_string_literal);
Datum rdfbox_get_string_literal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_STRING && box->type != RDF_LANGSTRING)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));
}
