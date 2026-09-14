#ifndef RDFBOX_PROMOTION_H_
#define RDFBOX_PROMOTION_H_

#include <postgres.h>
#include <utils/numeric.h>
#include <utils/fmgrprotos.h>
#include "rdfbox/rdfbox.h"


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


static inline float8 rdfbox_get_numeric_as_double(RdfBox *box)
{
    switch(box->type)
    {
        case XSD_SHORT:
            return RdfBoxGetInt16(box);

        case XSD_INT:
            return RdfBoxGetInt32(box);

        case XSD_LONG:
            return RdfBoxGetInt64(box);

        case XSD_INTEGER:
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
        case XSD_SHORT:
            return RdfBoxGetInt16(box);

        case XSD_INT:
            return RdfBoxGetInt32(box);

        case XSD_LONG:
            return RdfBoxGetInt64(box);

        case XSD_INTEGER:
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
        case XSD_SHORT:
            return DatumGetNumeric(DirectFunctionCall1(int2_numeric, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_INT:
            return DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_LONG:
            return DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_INTEGER:
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
        case XSD_SHORT:
            return RdfBoxGetInt16(box);

        case XSD_INT:
            return RdfBoxGetInt32(box);

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
        case XSD_SHORT:
            return RdfBoxGetInt16(box);

        case XSD_INT:
            return RdfBoxGetInt32(box);

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}

#endif /* RDFBOX_PROMOTION_H_ */
