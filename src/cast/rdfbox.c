#include <postgres.h>
#include "call.h"
#include "rdfbox.h"
#include "create.h"
#include "xsd.h"
#include "cast/cast.h"


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_boolean);
Datum cast_as_rdfbox_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    RdfBox *result = rdfbox_from_boolean(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_short);
Datum cast_as_rdfbox_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    RdfBox *result = rdfbox_from_short(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_int);
Datum cast_as_rdfbox_from_int(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    RdfBox *result = rdfbox_from_int(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_long);
Datum cast_as_rdfbox_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    RdfBox *result = rdfbox_from_long(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_float);
Datum cast_as_rdfbox_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);
    RdfBox *result = rdfbox_from_float(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_double);
Datum cast_as_rdfbox_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);
    RdfBox *result = rdfbox_from_double(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_integer);
Datum cast_as_rdfbox_from_integer(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    RdfBox *result = rdfbox_from_integer(value);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_decimal);
Datum cast_as_rdfbox_from_decimal(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    RdfBox *result = rdfbox_from_decimal(value);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_datetime);
Datum cast_as_rdfbox_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime *value = PG_GETARG_ZONEDDATETIME_P(0);
    RdfBox *result = rdfbox_from_datetime(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_date);
Datum cast_as_rdfbox_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate value = PG_GETARG_ZONEDDATE(0);
    RdfBox *result = rdfbox_from_date(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_daytimeduration);
Datum cast_as_rdfbox_from_daytimeduration(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    RdfBox *result = rdfbox_from_daytimeduration(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_string);
Datum cast_as_rdfbox_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    RdfBox *result = rdfbox_from_string(value);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_iri);
Datum cast_as_rdfbox_from_iri(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    RdfBox *result = rdfbox_from_iri(value);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_lang_string);
Datum cast_as_rdfbox_from_lang_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *lang = PG_GETARG_VARCHAR_P(1);
    RdfBox *result = rdfbox_from_lang_string(value, lang);
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
            result = rdfbox_from_boolean(DatumGetBool(retval.datum));
    }
    else if(strncmp(XSD_SHORT_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_short_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = rdfbox_from_short(DatumGetInt16(retval.datum));
    }
    else if(strncmp(XSD_INT_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_int_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = rdfbox_from_int(DatumGetInt32(retval.datum));
    }
    else if(strncmp(XSD_LONG_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_long_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = rdfbox_from_long(DatumGetInt64(retval.datum));
    }
    else if(strncmp(XSD_FLOAT_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_float_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = rdfbox_from_float(DatumGetFloat4(retval.datum));
    }
    else if(strncmp(XSD_DOUBLE_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_double_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = rdfbox_from_double(DatumGetFloat8(retval.datum));
    }
    else if(strncmp(XSD_INTEGER_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_integer_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
        {
            result = rdfbox_from_integer(DatumGetNumeric(retval.datum));
            pfree(DatumGetNumeric(retval.datum));
        }
    }
    else if(strncmp(XSD_DECIMAL_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_decimal_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
        {
            result = rdfbox_from_decimal(DatumGetNumeric(retval.datum));
            pfree(DatumGetNumeric(retval.datum));
        }
    }
    else if(strncmp(XSD_DATETIME_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_datetime_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
        {
            result = rdfbox_from_datetime(DatumGetZonedDateTime(retval.datum));
            pfree(DatumGetZonedDateTime(retval.datum));
        }
    }
    else if(strncmp(XSD_DATE_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_date_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = rdfbox_from_date(DatumGetZonedDate(retval.datum));
    }
    else if(strncmp(XSD_DAYTIMEDURATION_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_daytimeduration_from_string, PointerGetDatum(value));

        if(retval.isNull == false)
            result = rdfbox_from_daytimeduration(DatumGetInt64(retval.datum));
    }
    else if(strncmp(XSD_STRING_IRI, VARDATA(type), VARSIZE(type)) == 0)
    {
        result = rdfbox_from_string(value);
    }

    if(result == NULL)
        result = rdfbox_from_typed_literal(value, type);

    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(type, 1);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_int_blanknode);
Datum cast_as_rdfbox_from_int_blanknode(PG_FUNCTION_ARGS)
{
    int32 space = PG_GETARG_INT32(0);
    int32 value = PG_GETARG_INT32(1);
    RdfBox *result = rdfbox_from_int_blanknode(space, value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_str_blanknode);
Datum cast_as_rdfbox_from_str_blanknode(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    RdfBox *result = rdfbox_from_typed_str_blanknode(value);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_RDFBOX_P(result);
}
