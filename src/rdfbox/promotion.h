#ifndef RDFBOX_PROMOTION_H_
#define RDFBOX_PROMOTION_H_

#include <postgres.h>
#include <utils/numeric.h>
#include <utils/fmgrprotos.h>
#include "rdfbox/rdfbox.h"
#include "types/unsignedlong.h"


static inline float8 numeric_get_as_double(Numeric value)
{
    char *string = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(value)));
    float8 result = strtod(string, NULL);
    pfree(string);
    return result;
}


static inline float4 numeric_get_as_float(Numeric value)
{
    char *string = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(value)));
    float4 result = strtof(string, NULL);
    pfree(string);
    return result;
}


/*
 * Whether a numeric box holds a value that an int32 or an int64 represents; the order of the types is such that
 * these are ranges (see the definition of RdfType).
 */
static inline bool rdfbox_fits_in_int(RdfBox *box)
{
    return box->type >= XSD_BYTE && box->type <= XSD_INT;
}


static inline bool rdfbox_fits_in_long(RdfBox *box)
{
    return box->type >= XSD_BYTE && box->type <= XSD_LONG;
}


/*
 * xsd:byte, xsd:unsignedByte and xsd:unsignedShort are held in the box of the built-in type of the same SQL
 * representation (see the definition of RdfType), so their values are read through the getter of that type: the first
 * two as an int16, the third as an int32.  xsd:unsignedInt and xsd:unsignedLong have boxes of their own.
 */
static inline float8 rdfbox_get_numeric_as_double(RdfBox *box)
{
    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            return RdfBoxGetInt16(box);

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            return RdfBoxGetInt32(box);

        case XSD_UNSIGNEDINT:
            return RdfBoxGetUInt32(box);

        case XSD_LONG:
            return RdfBoxGetInt64(box);

        case XSD_UNSIGNEDLONG:
            return RdfBoxGetUInt64(box);

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        case XSD_DECIMAL:
            return numeric_get_as_double(RdfBoxGetNumeric(box));

        case XSD_FLOAT:
            return RdfBoxGetFloat4(box);

        case XSD_DOUBLE:
            return RdfBoxGetFloat8(box);

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}


static inline float4 rdfbox_get_numeric_as_float(RdfBox *box)
{
    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            return RdfBoxGetInt16(box);

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            return RdfBoxGetInt32(box);

        case XSD_UNSIGNEDINT:
            return RdfBoxGetUInt32(box);

        case XSD_LONG:
            return RdfBoxGetInt64(box);

        case XSD_UNSIGNEDLONG:
            return RdfBoxGetUInt64(box);

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        case XSD_DECIMAL:
            return numeric_get_as_float(RdfBoxGetNumeric(box));

        case XSD_FLOAT:
            return RdfBoxGetFloat4(box);

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}


static inline Numeric rdfbox_get_numeric_as_decimal(RdfBox *box)
{
    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            return DatumGetNumeric(DirectFunctionCall1(int2_numeric, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            return DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_UNSIGNEDINT:
            return DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(RdfBoxGetUInt32(box))));

        case XSD_LONG:
            return DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_UNSIGNEDLONG:
            return unsignedlong_as_numeric(RdfBoxGetUInt64(box));

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        case XSD_DECIMAL:
            return RdfBoxGetNumeric(box);

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}


static inline int64 rdfbox_get_numeric_as_long(RdfBox *box)
{
    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            return RdfBoxGetInt16(box);

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            return RdfBoxGetInt32(box);

        case XSD_UNSIGNEDINT:
            return RdfBoxGetUInt32(box);

        case XSD_LONG:
            return RdfBoxGetInt64(box);

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}


static inline int32 rdfbox_get_numeric_as_int(RdfBox *box)
{
    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            return RdfBoxGetInt16(box);

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            return RdfBoxGetInt32(box);

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}

#endif /* RDFBOX_PROMOTION_H_ */
