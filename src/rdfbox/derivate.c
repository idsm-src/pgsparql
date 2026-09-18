#include <postgres.h>
#include <fmgr.h>
#include <utils/datum.h>
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


PG_FUNCTION_INFO_V1(rdfbox_promote_to_byte);
Datum rdfbox_promote_to_byte(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_BYTE)
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_unsignedbyte);
Datum rdfbox_promote_to_unsignedbyte(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_UNSIGNEDBYTE)
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_short);
Datum rdfbox_promote_to_short(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_SHORT)
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_unsignedshort);
Datum rdfbox_promote_to_unsignedshort(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_UNSIGNEDBYTE:
        case XSD_UNSIGNEDSHORT:
            PG_RETURN_INT32(rdfbox_get_numeric_as_int(box));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_int);
Datum rdfbox_promote_to_int(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_INT)
        PG_RETURN_NULL();

    int32 result = rdfbox_get_numeric_as_int(box);
    PG_RETURN_INT32(result);
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_unsignedint);
Datum rdfbox_promote_to_unsignedint(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_UNSIGNEDBYTE:
        case XSD_UNSIGNEDSHORT:
        case XSD_UNSIGNEDINT:
            PG_RETURN_INT64(rdfbox_get_numeric_as_long(box));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_long);
Datum rdfbox_promote_to_long(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_LONG)
        PG_RETURN_NULL();

    int64 result = rdfbox_get_numeric_as_long(box);
    PG_RETURN_INT64(result);
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_unsignedlong);
Datum rdfbox_promote_to_unsignedlong(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_UNSIGNEDBYTE:
        case XSD_UNSIGNEDSHORT:
        case XSD_UNSIGNEDINT:
        case XSD_UNSIGNEDLONG:
            PG_RETURN_NUMERIC(rdfbox_get_numeric_as_decimal(box));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_integer);
Datum rdfbox_promote_to_integer(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_POSITIVEINTEGER)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(rdfbox_get_numeric_as_decimal(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_nonpositiveinteger);
Datum rdfbox_promote_to_nonpositiveinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
            PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_negativeinteger);
Datum rdfbox_promote_to_negativeinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_NEGATIVEINTEGER)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_nonnegativeinteger);
Datum rdfbox_promote_to_nonnegativeinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_UNSIGNEDBYTE:
        case XSD_UNSIGNEDSHORT:
        case XSD_UNSIGNEDINT:
        case XSD_UNSIGNEDLONG:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
            PG_RETURN_NUMERIC(rdfbox_get_numeric_as_decimal(box));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_positiveinteger);
Datum rdfbox_promote_to_positiveinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_POSITIVEINTEGER)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_decimal);
Datum rdfbox_promote_to_decimal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_DECIMAL)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(rdfbox_get_numeric_as_decimal(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_float);
Datum rdfbox_promote_to_float(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_FLOAT)
        PG_RETURN_NULL();

    float4 result = rdfbox_get_numeric_as_float(box);
    PG_RETURN_FLOAT4(result);
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_double);
Datum rdfbox_promote_to_double(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_DOUBLE)
        PG_RETURN_NULL();

    float8 result = rdfbox_get_numeric_as_double(box);
    PG_RETURN_FLOAT8(result);
}
