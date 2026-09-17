#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <math.h>
#include "call.h"
#include "constants.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


/*
 * SPARQL ROUND(), like fn:round(), rounds a half towards positive infinity:
 * ROUND(-2.5) is -2, not -3.  round()/roundf() and numeric_round() round a half
 * away from zero instead, so they cannot be used directly.
 *
 * floor(value + 0.5) is not an answer either, because the addition itself rounds:
 * for the double just below 0.5 it already yields 1.0.  Taking the floor first and
 * looking at the fractional part is exact for every finite value -- the difference
 * of a double and its floor is representable -- and leaves NaN and +-infinity
 * alone, as value - value is NaN and NaN >= 0.5 is false.
 */
static inline float8 round_half_up(float8 value)
{
    float8 result = floor(value);

    if(value - result >= 0.5)
        result += 1.0;

    // fn:round keeps the sign of a negative argument that rounds to zero
    if(result == 0 && signbit(value))
        return -0.0;

    return result;
}


static inline float4 round_half_up_float(float4 value)
{
    float4 result = floorf(value);

    if(value - result >= 0.5f)
        result += 1.0f;

    if(result == 0 && signbit(value))
        return -0.0f;

    return result;
}


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
            Numeric sum = DatumGetNumeric(DirectFunctionCall2(numeric_add, NumericGetDatum(value), NumericGetDatum(get_half())));
            Numeric res = DatumGetNumeric(DirectFunctionCall1(numeric_floor, NumericGetDatum(sum)));
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(res));
        }

        case XSD_FLOAT:
            PG_RETURN_RDFBOX_P(GetFloatRdfBox(round_half_up_float(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(round_half_up(RdfBoxGetFloat8(box))));

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
