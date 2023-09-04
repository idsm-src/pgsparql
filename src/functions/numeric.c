#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "call.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


PG_FUNCTION_INFO_V1(abs_rdfbox);
Datum abs_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_SHORT:
        {
            int32 value = RdfBoxGetInt16(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(abs(value))));
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_INT:
        {
            int64 value = RdfBoxGetInt32(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(labs(value))));
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_LONG:
        {
            int64 value = RdfBoxGetInt64(box);
            Numeric res;

            if(value == INT64_MIN)
            {
                Numeric num = DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(value)));
                res = DatumGetNumeric(DirectFunctionCall1(numeric_abs, NumericGetDatum(num)));
            }
            else
            {
                res = DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(labs(value))));
            }

            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_INTEGER:
        {
            Numeric value = RdfBoxGetNumeric(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_abs, NumericGetDatum(value)));
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_DECIMAL:
        {
            Numeric value = RdfBoxGetNumeric(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_abs, NumericGetDatum(value)));
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(res));
        }

        case XSD_FLOAT:
            PG_RETURN_RDFBOX_P(GetFloatRdfBox(fabsf(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(fabs(RdfBoxGetFloat8(box))));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(round_rdfbox);
Datum round_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_SHORT:
        case XSD_INT:
        case XSD_LONG:
        case XSD_INTEGER:
        {
            Numeric res = rdfbox_get_numeric_as_decimal(box);
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_DECIMAL:
        {
            Numeric value = RdfBoxGetNumeric(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall2(numeric_round, NumericGetDatum(value), Int32GetDatum(0)));
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(res));
        }

        case XSD_FLOAT:
            PG_RETURN_RDFBOX_P(GetFloatRdfBox(roundf(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(round(RdfBoxGetFloat8(box))));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(ceil_rdfbox);
Datum ceil_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_SHORT:
        case XSD_INT:
        case XSD_LONG:
        case XSD_INTEGER:
        {
            Numeric res = rdfbox_get_numeric_as_decimal(box);
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_DECIMAL:
        {
            Numeric value = RdfBoxGetNumeric(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_ceil, NumericGetDatum(value)));
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(res));
        }

        case XSD_FLOAT:
            PG_RETURN_RDFBOX_P(GetFloatRdfBox(ceilf(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(ceil(RdfBoxGetFloat8(box))));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(floor_rdfbox);
Datum floor_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_SHORT:
        case XSD_INT:
        case XSD_LONG:
        case XSD_INTEGER:
        {
            Numeric res = rdfbox_get_numeric_as_decimal(box);
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_DECIMAL:
        {
            Numeric value = RdfBoxGetNumeric(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_floor, NumericGetDatum(value)));
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(res));
        }

        case XSD_FLOAT:
            PG_RETURN_RDFBOX_P(GetFloatRdfBox(floorf(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(floor(RdfBoxGetFloat8(box))));

        default:
            PG_RETURN_NULL();
    }
}
