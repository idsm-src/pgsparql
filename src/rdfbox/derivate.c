/**
 * @file
 * The numeric type promotion of a boxed value: the functions `rdfbox_promote_to_<type>()` take the value of a numeric
 * rdfbox in the SQL type of a numeric datatype, if the datatype of the box is that datatype or another one that the
 * translator promotes to it.
 *
 * The targets of type promotion (xsd:short, xsd:int, xsd:long, xsd:integer, xsd:decimal, xsd:float and xsd:double)
 * accept every numeric datatype from #XSD_BYTE up to them, which are exactly the datatypes whose values their SQL types
 * represent (see ::RdfType); the other targets accept only themselves and the datatypes derived from them.
 */
#include <postgres.h>
#include <fmgr.h>
#include <utils/datum.h>
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


/**
 * Promotes a boxed number to xsd:byte, held by an int2.
 *
 * @param fcinfo the rdfbox
 * @return the value as an int2 if the datatype of the box is xsd:byte, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_byte);
Datum rdfbox_promote_to_byte(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_BYTE)
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


/**
 * Promotes a boxed number to xsd:unsignedByte, held by an int2.
 *
 * @param fcinfo the rdfbox
 * @return the value as an int2 if the datatype of the box is xsd:unsignedByte, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_unsignedbyte);
Datum rdfbox_promote_to_unsignedbyte(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_UNSIGNEDBYTE)
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


/**
 * Promotes a boxed number to xsd:short, held by an int2.
 *
 * @param fcinfo the rdfbox
 * @return the value as an int2 if the datatype of the box is xsd:byte, xsd:unsignedByte or xsd:short, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_short);
Datum rdfbox_promote_to_short(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_SHORT)
        PG_RETURN_NULL();

    PG_RETURN_INT16(RdfBoxGetInt16(box));
}


/**
 * Promotes a boxed number to xsd:unsignedShort, held by an int4.
 *
 * @param fcinfo the rdfbox
 * @return the value as an int4 if the datatype of the box is xsd:unsignedByte or xsd:unsignedShort, NULL otherwise
 */
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


/**
 * Promotes a boxed number to xsd:int, held by an int4.
 *
 * @param fcinfo the rdfbox
 * @return the value as an int4 if the datatype of the box is xsd:byte, xsd:unsignedByte, xsd:short, xsd:unsignedShort
 *         or xsd:int, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_int);
Datum rdfbox_promote_to_int(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_INT)
        PG_RETURN_NULL();

    int32 result = rdfbox_get_numeric_as_int(box);
    PG_RETURN_INT32(result);
}


/**
 * Promotes a boxed number to xsd:unsignedInt, held by an int8.
 *
 * @param fcinfo the rdfbox
 * @return the value as an int8 if the datatype of the box is xsd:unsignedByte, xsd:unsignedShort or xsd:unsignedInt,
 *         NULL otherwise
 */
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


/**
 * Promotes a boxed number to xsd:long, held by an int8.
 *
 * @param fcinfo the rdfbox
 * @return the value as an int8 if the datatype of the box is xsd:byte, xsd:unsignedByte, xsd:short, xsd:unsignedShort,
 *         xsd:int, xsd:unsignedInt or xsd:long, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_long);
Datum rdfbox_promote_to_long(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_LONG)
        PG_RETURN_NULL();

    int64 result = rdfbox_get_numeric_as_long(box);
    PG_RETURN_INT64(result);
}


/**
 * Promotes a boxed number to xsd:unsignedLong, held by a numeric.
 *
 * @param fcinfo the rdfbox
 * @return the value as a numeric if the datatype of the box is xsd:unsignedByte, xsd:unsignedShort, xsd:unsignedInt or
 *         xsd:unsignedLong, NULL otherwise
 */
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


/**
 * Promotes a boxed number to xsd:integer, held by a numeric.
 *
 * @param fcinfo the rdfbox
 * @return the value as a numeric if the datatype of the box is xsd:integer or a datatype derived from it, NULL
 *         otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_integer);
Datum rdfbox_promote_to_integer(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_POSITIVEINTEGER)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(rdfbox_get_numeric_as_decimal(box));
}


/**
 * Promotes a boxed number to xsd:nonPositiveInteger, held by a numeric.
 *
 * @param fcinfo the rdfbox
 * @return the value as a numeric if the datatype of the box is xsd:nonPositiveInteger or xsd:negativeInteger, NULL
 *         otherwise
 */
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


/**
 * Promotes a boxed number to xsd:negativeInteger, held by a numeric.
 *
 * @param fcinfo the rdfbox
 * @return the value as a numeric if the datatype of the box is xsd:negativeInteger, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_negativeinteger);
Datum rdfbox_promote_to_negativeinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_NEGATIVEINTEGER)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


/**
 * Promotes a boxed number to xsd:nonNegativeInteger, held by a numeric.
 *
 * @param fcinfo the rdfbox
 * @return the value as a numeric if the datatype of the box is xsd:nonNegativeInteger, xsd:positiveInteger or one of
 *         the unsigned datatypes, NULL otherwise
 */
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


/**
 * Promotes a boxed number to xsd:positiveInteger, held by a numeric.
 *
 * @param fcinfo the rdfbox
 * @return the value as a numeric if the datatype of the box is xsd:positiveInteger, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_positiveinteger);
Datum rdfbox_promote_to_positiveinteger(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type != XSD_POSITIVEINTEGER)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(RdfBoxGetNumeric(box));
}


/**
 * Promotes a boxed number to xsd:decimal, held by a numeric.
 *
 * @param fcinfo the rdfbox
 * @return the value as a numeric if the datatype of the box is xsd:decimal, xsd:integer or a datatype derived from
 *         xsd:integer, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_decimal);
Datum rdfbox_promote_to_decimal(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_DECIMAL)
        PG_RETURN_NULL();

    PG_RETURN_NUMERIC(rdfbox_get_numeric_as_decimal(box));
}


/**
 * Promotes a boxed number to xsd:float, held by a float4.
 *
 * A value that the float4 cannot represent exactly is rounded to the nearest one.
 *
 * @param fcinfo the rdfbox
 * @return the value as a float4 if the datatype of the box is xsd:float, xsd:decimal, xsd:integer or a datatype derived
 *         from xsd:integer, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_float);
Datum rdfbox_promote_to_float(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_FLOAT)
        PG_RETURN_NULL();

    float4 result = rdfbox_get_numeric_as_float(box);
    PG_RETURN_FLOAT4(result);
}


/**
 * Promotes a boxed number to xsd:double, held by a float8.
 *
 * A value that the float8 cannot represent exactly is rounded to the nearest one.
 *
 * @param fcinfo the rdfbox
 * @return the value as a float8 if the datatype of the box is any numeric datatype, NULL otherwise
 */
PG_FUNCTION_INFO_V1(rdfbox_promote_to_double);
Datum rdfbox_promote_to_double(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type < XSD_BYTE || box->type > XSD_DOUBLE)
        PG_RETURN_NULL();

    float8 result = rdfbox_get_numeric_as_double(box);
    PG_RETURN_FLOAT8(result);
}
