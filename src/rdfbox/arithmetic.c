#include <postgres.h>
#include <fmgr.h>
#include <utils/numeric.h>
#include "call.h"
#include "types/decimal.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/promotion.h"


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
