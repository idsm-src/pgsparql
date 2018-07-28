#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "cast/cast.h"


PG_FUNCTION_INFO_V1(uminus_float);
Datum uminus_float(PG_FUNCTION_ARGS)
{
    float4 arg = PG_GETARG_FLOAT4(0);
    PG_RETURN_FLOAT4(-arg);
}


PG_FUNCTION_INFO_V1(uminus_double);
Datum uminus_double(PG_FUNCTION_ARGS)
{
    float8 arg = PG_GETARG_FLOAT8(0);
    PG_RETURN_FLOAT8(-arg);
}


PG_FUNCTION_INFO_V1(uminus_decimal);
Datum uminus_decimal(PG_FUNCTION_ARGS)
{
    Numeric arg = PG_GETARG_NUMERIC(0);

    Datum result = DirectFunctionCall1(numeric_uminus, NumericGetDatum(arg));

    PG_FREE_IF_COPY(arg, 0);

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(uminus_rdfbox);
Datum uminus_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *arg = PG_GETARG_RDFBOX_P(0);

    bool isNull = false;
    Datum result;

    if(!rdfbox_is_numeric(arg))
    {
        isNull = true;
    }
    else if(arg->type == XSD_DOUBLE)
    {
        float8 a = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(arg)));
        result = DirectFunctionCall1(cast_as_rdfbox_from_double, Float8GetDatum(-a));
    }
    else if(arg->type == XSD_FLOAT)
    {
        float4 a = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(arg)));
        result = DirectFunctionCall1(cast_as_rdfbox_from_float, Float4GetDatum(-a));
    }
    else
    {
        Numeric a = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(arg)));
        Numeric v = DatumGetNumeric(DirectFunctionCall1(numeric_uminus, NumericGetDatum(a)));

        if(arg->type == XSD_DECIMAL)
            result = DirectFunctionCall1(cast_as_rdfbox_from_decimal, NumericGetDatum(v));
        else
            result = DirectFunctionCall1(cast_as_rdfbox_from_integer, NumericGetDatum(v));

        pfree(a);
        pfree(v);
    }

    PG_FREE_IF_COPY(arg, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}
