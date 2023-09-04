#include <postgres.h>
#include <utils/numeric.h>
#include "call.h"
#include "types/sblanknode.h"
#include "rdfbox/rdfbox.h"


PG_FUNCTION_INFO_V1(rdfbox_create_from_boolean);
Datum rdfbox_create_from_boolean(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetBooleanRdfBox(PG_GETARG_BOOL(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_short);
Datum rdfbox_create_from_short(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetShortRdfBox(PG_GETARG_INT16(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_int);
Datum rdfbox_create_from_int(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetIntRdfBox(PG_GETARG_INT32(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_long);
Datum rdfbox_create_from_long(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetLongRdfBox(PG_GETARG_INT64(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_float);
Datum rdfbox_create_from_float(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetFloatRdfBox(PG_GETARG_FLOAT4(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_double);
Datum rdfbox_create_from_double(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDoubleRdfBox(PG_GETARG_FLOAT8(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_integer);
Datum rdfbox_create_from_integer(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(PG_GETARG_NUMERIC(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_decimal);
Datum rdfbox_create_from_decimal(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDecimalRdfBox(PG_GETARG_NUMERIC(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_datetime);
Datum rdfbox_create_from_datetime(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetDateTimeRdfBox(PG_GETARG_ZONEDDATETIME_P(0)));
    else
        PG_RETURN_RDFBOX_P(GetDateTimeRdfBox(&((ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1)})));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_date);
Datum rdfbox_create_from_date(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetDateRdfBox(PG_GETARG_ZONEDDATE(0)));
    else
        PG_RETURN_RDFBOX_P(GetDateRdfBox((ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1)}));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_daytimeduration);
Datum rdfbox_create_from_daytimeduration(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDayTimeDurationRdfBox(PG_GETARG_INT64(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_string);
Datum rdfbox_create_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    PG_RETURN_RDFBOX_P(GetStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_iri);
Datum rdfbox_create_from_iri(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    PG_RETURN_RDFBOX_P(GetIriRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_langstring);
Datum rdfbox_create_from_langstring(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *lang = PG_GETARG_VARCHAR_PP(1);
    PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_typedliteral);
Datum rdfbox_create_from_typedliteral(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *type = PG_GETARG_VARCHAR_PP(1);
    PG_RETURN_RDFBOX_P(GetTypedLiteralRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_iblanknode);
Datum rdfbox_create_from_iblanknode(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetIBlankNodeRdfBox(PG_GETARG_INT64(0)));
    else
        PG_RETURN_RDFBOX_P(GetIBlankNodeRdfBox(((uint64) PG_GETARG_INT32(1)) << 32 | ((uint64) PG_GETARG_INT32(0) & 0xFFFFFFFF)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_sblanknode);
Datum rdfbox_create_from_sblanknode(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
    {
        VarChar *value = PG_GETARG_VARCHAR_PP(0);
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
