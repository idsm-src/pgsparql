/**
 * @file
 * The SPARQL numeric functions ABS, ROUND, CEIL and FLOOR.
 *
 * A function of an rdfbox gives NULL for a term that is not a number. As in XPath, the result has the type of the
 * argument, except that a value of xsd:integer or of a datatype derived from it gives an xsd:integer.
 *
 * @see https://www.w3.org/TR/xpath-functions/#numeric-value-functions
 */
#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <math.h>
#include "call.h"
#include "constants.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


/**
 * Rounds a double to the nearest integer, a half towards positive infinity.
 *
 * SPARQL ROUND(), like fn:round(), rounds a half towards positive infinity:
 * ROUND(-2.5) is -2, not -3.  round()/roundf() and numeric_round() round a half
 * away from zero instead, so they cannot be used directly.
 *
 * floor(value + 0.5) is not an answer either, because the addition itself rounds:
 * for the double just below 0.5 it already yields 1.0.  Taking the floor first and
 * looking at the fractional part is exact for every finite value -- the difference
 * of a double and its floor is representable -- and leaves NaN and +-infinity
 * alone, as value - value is NaN and NaN >= 0.5 is false.
 *
 * @param value the value
 * @return the rounded value; NaN and the infinities are returned as they are, and a negative value that rounds to
 *         zero gives negative zero, as fn:round keeps the sign
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


/**
 * Rounds a float to the nearest integer, a half towards positive infinity, the way round_half_up() rounds a double.
 *
 * @param value the value
 * @return the rounded value; NaN and the infinities are returned as they are, and a negative value that rounds to
 *         zero gives negative zero
 */
static inline float4 round_half_up_float(float4 value)
{
    float4 result = floorf(value);

    if(value - result >= 0.5f)
        result += 1.0f;

    if(result == 0 && signbit(value))
        return -0.0f;

    return result;
}


/**
 * Rounds a numeric to the nearest integer, a half towards positive infinity, as the floor of the value plus 0.5.
 *
 * The addition is exact for a numeric, which has no negative zero either.
 *
 * @param value the value
 * @return the palloc'd rounded value
 */
static inline Numeric round_half_up_numeric(Numeric value)
{
    Numeric sum = DatumGetNumeric(DirectFunctionCall2(numeric_add, NumericGetDatum(value), NumericGetDatum(get_half())));
    return DatumGetNumeric(DirectFunctionCall1(numeric_floor, NumericGetDatum(sum)));
}


/**
 * Computes the absolute value of a number, the SPARQL function ABS.
 *
 * @param fcinfo the rdfbox
 * @return the rdfbox with the absolute value: an xsd:integer for the integer datatypes and a value of the same type
 *         for xsd:decimal, xsd:float and xsd:double; NULL if the term is not a number
 */
PG_FUNCTION_INFO_V1(abs_rdfbox);
Datum abs_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
        {
            int32 value = RdfBoxGetInt16(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(abs(value))));
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
        {
            int64 value = RdfBoxGetInt32(box);
            Numeric res = DatumGetNumeric(DirectFunctionCall1(int8_numeric, Int64GetDatum(labs(value))));
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_UNSIGNEDINT:
        case XSD_UNSIGNEDLONG:
        {
            /* the value is never negative */
            Numeric res = rdfbox_get_numeric_as_decimal(box);
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
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
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


/**
 * Rounds a number to the nearest integer, a half towards positive infinity, the SPARQL function ROUND.
 *
 * @param fcinfo the rdfbox
 * @return the rdfbox with the rounded value: the value itself as an xsd:integer for the integer datatypes and a
 *         value of the same type for xsd:decimal, xsd:float and xsd:double, see round_half_up(); NULL if the term is
 *         not a number
 */
PG_FUNCTION_INFO_V1(round_rdfbox);
Datum round_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
        case XSD_UNSIGNEDINT:
        case XSD_LONG:
        case XSD_UNSIGNEDLONG:
        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        {
            Numeric res = rdfbox_get_numeric_as_decimal(box);
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(res));
        }

        case XSD_DECIMAL:
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(round_half_up_numeric(RdfBoxGetNumeric(box))));

        case XSD_FLOAT:
            PG_RETURN_RDFBOX_P(GetFloatRdfBox(round_half_up_float(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(round_half_up(RdfBoxGetFloat8(box))));

        default:
            PG_RETURN_NULL();
    }
}


/*
 * ROUND() of a value stored in a column of its own type; round() of PostgreSQL
 * cannot serve there, as it rounds a numeric half away from zero and a double
 * half to even.
 */

/**
 * Rounds an xsd:decimal held in a numeric to the nearest integer, a half towards positive infinity, the SPARQL
 * function ROUND.
 *
 * @param fcinfo the decimal
 * @return the rounded decimal
 */
PG_FUNCTION_INFO_V1(round_decimal);
Datum round_decimal(PG_FUNCTION_ARGS)
{
    PG_RETURN_NUMERIC(round_half_up_numeric(PG_GETARG_NUMERIC(0)));
}


/**
 * Rounds an xsd:float held in a float4 to the nearest integer, a half towards positive infinity, the SPARQL function
 * ROUND.
 *
 * @param fcinfo the float4
 * @return the rounded float4, see round_half_up_float()
 */
PG_FUNCTION_INFO_V1(round_float);
Datum round_float(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT4(round_half_up_float(PG_GETARG_FLOAT4(0)));
}


/**
 * Rounds an xsd:double held in a float8 to the nearest integer, a half towards positive infinity, the SPARQL function
 * ROUND.
 *
 * @param fcinfo the float8
 * @return the rounded float8, see round_half_up()
 */
PG_FUNCTION_INFO_V1(round_double);
Datum round_double(PG_FUNCTION_ARGS)
{
    PG_RETURN_FLOAT8(round_half_up(PG_GETARG_FLOAT8(0)));
}


/**
 * Rounds a number up to an integer, the SPARQL function CEIL.
 *
 * @param fcinfo the rdfbox
 * @return the rdfbox with the least integer not less than the value: the value itself as an xsd:integer for the
 *         integer datatypes and a value of the same type for xsd:decimal, xsd:float and xsd:double; NULL if the term
 *         is not a number
 */
PG_FUNCTION_INFO_V1(ceil_rdfbox);
Datum ceil_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
        case XSD_UNSIGNEDINT:
        case XSD_LONG:
        case XSD_UNSIGNEDLONG:
        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
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


/**
 * Rounds a number down to an integer, the SPARQL function FLOOR.
 *
 * @param fcinfo the rdfbox
 * @return the rdfbox with the greatest integer not greater than the value: the value itself as an xsd:integer for
 *         the integer datatypes and a value of the same type for xsd:decimal, xsd:float and xsd:double; NULL if the
 *         term is not a number
 */
PG_FUNCTION_INFO_V1(floor_rdfbox);
Datum floor_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
        case XSD_UNSIGNEDINT:
        case XSD_LONG:
        case XSD_UNSIGNEDLONG:
        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
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
