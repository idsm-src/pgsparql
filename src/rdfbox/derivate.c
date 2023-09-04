#include <postgres.h>
#include <fmgr.h>
#include <utils/datum.h>
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


PG_FUNCTION_INFO_V1(rdfbox_promote_to_short);
Datum rdfbox_promote_to_short(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_SHORT)
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_int);
Datum rdfbox_promote_to_int(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_INT)
        PG_RETURN_NULL();

    int32 result = rdfbox_get_numeric_as_int(box);
    PG_RETURN_INT32(result);
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_long);
Datum rdfbox_promote_to_long(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_LONG)
        PG_RETURN_NULL();

    int64 result = rdfbox_get_numeric_as_long(box);
    PG_RETURN_INT64(result);
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_integer);
Datum rdfbox_promote_to_integer(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_INTEGER)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(rdfbox_get_numeric_as_decimal(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_decimal);
Datum rdfbox_promote_to_decimal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_DECIMAL)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(rdfbox_get_numeric_as_decimal(box));
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_float);
Datum rdfbox_promote_to_float(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_FLOAT)
        PG_RETURN_NULL();

    float4 result = rdfbox_get_numeric_as_float(box);
    PG_RETURN_FLOAT4(result);
}


PG_FUNCTION_INFO_V1(rdfbox_promote_to_double);
Datum rdfbox_promote_to_double(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_SHORT || box->type > XSD_DOUBLE)
        PG_RETURN_NULL();

    float8 result = rdfbox_get_numeric_as_double(box);
    PG_RETURN_FLOAT8(result);
}
