/**
 * @file
 * The arithmetic operators of SPARQL on rdfbox, the XPath functions op:numeric-unary-plus, op:numeric-unary-minus,
 * op:numeric-add, op:numeric-subtract, op:numeric-multiply and op:numeric-divide.
 *
 * The operands are promoted to a common type: xsd:double if one of them is an xsd:double, otherwise xsd:float if one
 * of them is an xsd:float, otherwise xsd:decimal if one of them is an xsd:decimal, otherwise xsd:integer, which is
 * also the type of the result for all the types derived from xsd:integer. An operand that is not numeric gives NULL,
 * and so does an xsd:integer or xsd:decimal result out of the range of numeric; xsd:float and xsd:double follow
 * IEEE 754 and give an infinity or NaN instead.
 */
#include <postgres.h>
#include <fmgr.h>
#include <utils/numeric.h>
#include "call.h"
#include "types/decimal.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


/**
 * Implements the unary operator `+` of SPARQL on rdfbox; bound to the SQL operator `+ rdfbox`.
 *
 * @param fcinfo the rdfbox operand
 * @return the rdfbox of the same value, of type xsd:double, xsd:float, xsd:decimal, or xsd:integer for the types
 *         derived from xsd:integer; NULL if the operand is not numeric
 */
PG_FUNCTION_INFO_V1(rdfbox_uplus);
Datum rdfbox_uplus(PG_FUNCTION_ARGS)
{
    RdfBox *arg = PG_GETARG_RDFBOX_P(0);

    if(!rdfbox_is_numeric(arg))
    {
        PG_RETURN_NULL();
    }
    else if(arg->type == XSD_DOUBLE)
    {
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(rdfbox_get_numeric_as_double(arg)));
    }
    else if(arg->type == XSD_FLOAT)
    {
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(rdfbox_get_numeric_as_float(arg)));
    }
    else
    {
        Numeric a = rdfbox_get_numeric_as_decimal(arg);

        if(numeric_is_inf(a) || numeric_is_nan(a))
            PG_RETURN_NULL();

        if(arg->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(a));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(a));
    }
}


/**
 * Implements the unary operator `-` of SPARQL on rdfbox; bound to the SQL operator `- rdfbox`.
 *
 * @param fcinfo the rdfbox operand
 * @return the rdfbox of the negated value, of type xsd:double, xsd:float, xsd:decimal, or xsd:integer for the types
 *         derived from xsd:integer; NULL if the operand is not numeric
 */
PG_FUNCTION_INFO_V1(rdfbox_uminus);
Datum rdfbox_uminus(PG_FUNCTION_ARGS)
{
    RdfBox *arg = PG_GETARG_RDFBOX_P(0);

    if(!rdfbox_is_numeric(arg))
    {
        PG_RETURN_NULL();
    }
    else if(arg->type == XSD_DOUBLE)
    {
        float8 a = rdfbox_get_numeric_as_double(arg);
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(-a));
    }
    else if(arg->type == XSD_FLOAT)
    {
        float4 a = rdfbox_get_numeric_as_float(arg);
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(-a));
    }
    else
    {
        Numeric a = rdfbox_get_numeric_as_decimal(arg);
        NullableDatum v = NullableFunctionCall1(decimal_uminus, NumericGetDatum(a));

        if(v.isnull)
            PG_RETURN_NULL();

        if(arg->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(v.value)));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(DatumGetNumeric(v.value)));
    }
}


/**
 * Implements the operator `+` of SPARQL on rdfbox; bound to the SQL operator `rdfbox + rdfbox`.
 *
 * @param fcinfo the left and the right rdfbox operand
 * @return the rdfbox of the sum in the promoted type, NULL if an operand is not numeric or a decimal sum is out of
 *         range
 */
PG_FUNCTION_INFO_V1(rdfbox_add);
Datum rdfbox_add(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(!rdfbox_is_numeric(left) || !rdfbox_is_numeric(right))
    {
        PG_RETURN_NULL();
    }
    else if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
    {
        float8 l = rdfbox_get_numeric_as_double(left);
        float8 r = rdfbox_get_numeric_as_double(right);
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(l + r));
    }
    else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
    {
        float4 l = rdfbox_get_numeric_as_float(left);
        float4 r = rdfbox_get_numeric_as_float(right);
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(l + r));
    }
    else
    {
        Numeric l = rdfbox_get_numeric_as_decimal(left);
        Numeric r = rdfbox_get_numeric_as_decimal(right);
        NullableDatum v = NullableFunctionCall2(decimal_add, NumericGetDatum(l), NumericGetDatum(r));

        if(v.isnull)
            PG_RETURN_NULL();

        if(left->type == XSD_DECIMAL || right->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(v.value)));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(DatumGetNumeric(v.value)));
    }
}


/**
 * Implements the binary operator `-` of SPARQL on rdfbox; bound to the SQL operator `rdfbox - rdfbox`.
 *
 * @param fcinfo the left and the right rdfbox operand
 * @return the rdfbox of the difference in the promoted type, NULL if an operand is not numeric or a decimal
 *         difference is out of range
 */
PG_FUNCTION_INFO_V1(rdfbox_sub);
Datum rdfbox_sub(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(!rdfbox_is_numeric(left) || !rdfbox_is_numeric(right))
    {
        PG_RETURN_NULL();
    }
    else if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
    {
        float8 l = rdfbox_get_numeric_as_double(left);
        float8 r = rdfbox_get_numeric_as_double(right);
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(l - r));
    }
    else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
    {
        float4 l = rdfbox_get_numeric_as_float(left);
        float4 r = rdfbox_get_numeric_as_float(right);
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(l - r));
    }
    else
    {
        Numeric l = rdfbox_get_numeric_as_decimal(left);
        Numeric r = rdfbox_get_numeric_as_decimal(right);
        NullableDatum v = NullableFunctionCall2(decimal_sub, NumericGetDatum(l), NumericGetDatum(r));

        if(v.isnull)
            PG_RETURN_NULL();

        if(left->type == XSD_DECIMAL || right->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(v.value)));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(DatumGetNumeric(v.value)));
    }
}


/**
 * Implements the operator `*` of SPARQL on rdfbox; bound to the SQL operator `rdfbox * rdfbox`.
 *
 * @param fcinfo the left and the right rdfbox operand
 * @return the rdfbox of the product in the promoted type, NULL if an operand is not numeric or a decimal product is
 *         out of range
 */
PG_FUNCTION_INFO_V1(rdfbox_mul);
Datum rdfbox_mul(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(!rdfbox_is_numeric(left) || !rdfbox_is_numeric(right))
    {
        PG_RETURN_NULL();
    }
    else if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
    {
        float8 l = rdfbox_get_numeric_as_double(left);
        float8 r = rdfbox_get_numeric_as_double(right);
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(l * r));
    }
    else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
    {
        float4 l = rdfbox_get_numeric_as_float(left);
        float4 r = rdfbox_get_numeric_as_float(right);
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(l * r));
    }
    else
    {
        Numeric l = rdfbox_get_numeric_as_decimal(left);
        Numeric r = rdfbox_get_numeric_as_decimal(right);
        NullableDatum v = NullableFunctionCall2(decimal_mul, NumericGetDatum(l), NumericGetDatum(r));

        if(v.isnull)
            PG_RETURN_NULL();

        if(left->type == XSD_DECIMAL || right->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(v.value)));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(DatumGetNumeric(v.value)));
    }
}


/**
 * Implements the operator `/` of SPARQL on rdfbox; bound to the SQL operator `rdfbox / rdfbox`.
 *
 * Unlike the other operators, the quotient of two integers is an xsd:decimal.
 *
 * @param fcinfo the left and the right rdfbox operand
 * @return the rdfbox of the quotient in the promoted type, NULL if an operand is not numeric or if a decimal division
 *         is a division by zero or its quotient is out of range
 */
PG_FUNCTION_INFO_V1(rdfbox_div);
Datum rdfbox_div(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    if(!rdfbox_is_numeric(left) || !rdfbox_is_numeric(right))
    {
        PG_RETURN_NULL();
    }
    else if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
    {
        float8 l = rdfbox_get_numeric_as_double(left);
        float8 r = rdfbox_get_numeric_as_double(right);
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(l / r));
    }
    else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
    {
        float4 l = rdfbox_get_numeric_as_float(left);
        float4 r = rdfbox_get_numeric_as_float(right);
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(l / r));
    }
    else
    {
        Numeric l = rdfbox_get_numeric_as_decimal(left);
        Numeric r = rdfbox_get_numeric_as_decimal(right);
        NullableDatum v = NullableFunctionCall2(decimal_div, NumericGetDatum(l), NumericGetDatum(r));

        if(v.isnull)
            PG_RETURN_NULL();

        PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(v.value)));
    }
}
