#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "create.h"
#include "cast/cast.h"


PG_FUNCTION_INFO_V1(mul_float);
Datum mul_float(PG_FUNCTION_ARGS)
{
    float4 left = PG_GETARG_FLOAT4(0);
    float4 right = PG_GETARG_FLOAT4(1);
    PG_RETURN_FLOAT4(left * right);
}


PG_FUNCTION_INFO_V1(mul_double);
Datum mul_double(PG_FUNCTION_ARGS)
{
    float8 left = PG_GETARG_FLOAT8(0);
    float8 right = PG_GETARG_FLOAT8(1);
    PG_RETURN_FLOAT8(left * right);
}


PG_FUNCTION_INFO_V1(mul_decimal);
Datum mul_decimal(PG_FUNCTION_ARGS)
{
    Numeric left = PG_GETARG_NUMERIC(0);
    Numeric right = PG_GETARG_NUMERIC(1);

    Datum result = DirectFunctionCall2(numeric_mul, NumericGetDatum(left), NumericGetDatum(right));

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(mul_rdfbox);
Datum mul_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    bool isNull = false;
    Datum result;

    if(!rdfbox_is_numeric(left) || !rdfbox_is_numeric(right))
    {
        isNull = true;
    }
    else if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
    {
        float8 l = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(left)));
        float8 r = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(right)));
        result = DirectFunctionCall1(cast_as_rdfbox_from_double, Float8GetDatum(l * r));
    }
    else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
    {
        float4 l = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(left)));
        float4 r = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(right)));
        result = DirectFunctionCall1(cast_as_rdfbox_from_float, Float4GetDatum(l * r));
    }
    else
    {
        Numeric l = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(left)));
        Numeric r = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(right)));
        Numeric v = DatumGetNumeric(DirectFunctionCall2(numeric_mul, NumericGetDatum(l), NumericGetDatum(r)));

        if(left->type == XSD_DECIMAL || right->type == XSD_DECIMAL)
            result = DirectFunctionCall1(cast_as_rdfbox_from_decimal, NumericGetDatum(v));
        else
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(v));

        pfree(l);
        pfree(r);
        pfree(v);
    }

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}
