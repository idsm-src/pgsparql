#include <postgres.h>
#include <fmgr.h>
#include <utils/builtins.h>
#include "constants.h"
#include "rdfbox/rdfbox.h"


PG_FUNCTION_INFO_V1(ebv_rdfbox);
Datum ebv_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN_BOOL(RdfBoxGetBool(box));

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            PG_RETURN_BOOL(RdfBoxGetInt16(box) != 0);

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            PG_RETURN_BOOL(RdfBoxGetInt32(box) != 0);

        case XSD_UNSIGNEDINT:
            PG_RETURN_BOOL(RdfBoxGetUInt32(box) != 0);

        case XSD_LONG:
            PG_RETURN_BOOL(RdfBoxGetInt64(box) != 0);

        case XSD_UNSIGNEDLONG:
            PG_RETURN_BOOL(RdfBoxGetUInt64(box) != 0);

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        case XSD_DECIMAL:
            PG_RETURN_DATUM(DirectFunctionCall2(numeric_ne, NumericGetDatum(RdfBoxGetNumeric(box)), NumericGetDatum(get_zero())));

        case XSD_FLOAT:
            PG_RETURN_BOOL(!isnan(RdfBoxGetFloat4(box)) && RdfBoxGetFloat4(box) != 0);

        case XSD_DOUBLE:
            PG_RETURN_BOOL(!isnan(RdfBoxGetFloat8(box)) && RdfBoxGetFloat8(box) != 0);

        case XSD_STRING:
            PG_RETURN_BOOL(VARSIZE(RdfBoxGetVarChar(box)) > VARHDRSZ);

        default:
            PG_RETURN_NULL();
    }
}
