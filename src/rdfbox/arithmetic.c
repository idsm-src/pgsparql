#include <postgres.h>
#include <fmgr.h>
#include <utils/numeric.h>
#include "try-catch.h"
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
        Numeric v = DatumGetNumeric(DirectFunctionCall1(numeric_uminus, NumericGetDatum(a)));

        if(arg->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(v));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(v));
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
        Numeric v = DatumGetNumeric(DirectFunctionCall2(numeric_add, NumericGetDatum(l), NumericGetDatum(r)));

        if(left->type == XSD_DECIMAL || right->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(v));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(v));
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
        Numeric v = DatumGetNumeric(DirectFunctionCall2(numeric_sub, NumericGetDatum(l), NumericGetDatum(r)));

        if(left->type == XSD_DECIMAL || right->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(v));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(v));
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
        Numeric v = DatumGetNumeric(DirectFunctionCall2(numeric_mul, NumericGetDatum(l), NumericGetDatum(r)));

        if(left->type == XSD_DECIMAL || right->type == XSD_DECIMAL)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(v));
        else
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(v));
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
        Numeric v = NULL;

        PG_TRY_EX();
        {
            v = DatumGetNumeric(DirectFunctionCall2(numeric_div, NumericGetDatum(l), NumericGetDatum(r)));
        }
        PG_CATCH_EX();
        {
            if(sqlerrcode != ERRCODE_DIVISION_BY_ZERO)
                PG_RE_THROW_EX();
        }
        PG_END_TRY_EX();

        if(v == NULL)
            PG_RETURN_NULL();

        PG_RETURN_RDFBOX_P(GetDecimalRdfBox(v));
    }
}
