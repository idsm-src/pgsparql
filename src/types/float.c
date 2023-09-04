#include <postgres.h>
#include <fmgr.h>
#include <utils/builtins.h>
#include <utils/float.h>
#include "types/float.h"


PG_FUNCTION_INFO_V1(float_input);
Datum float_input(PG_FUNCTION_ARGS)
{
    char *input = PG_GETARG_CSTRING(0);

    while(*input != '\0' && isspace((unsigned char) *input))
        input++;

    if(*input == '\0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed float literal")));

    float4 value = 0;
    char *endptr = input;;

    if(isdigit((unsigned char) *input) || *input == '.' || ((*input == '+' || *input == '-') && isdigit((unsigned char) *(input + 1))))
    {
        errno = 0;
        value = strtof(input, &endptr);

        if(endptr == input || (errno != 0 && errno != ERANGE))
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed float literal")));
    }
    else if(strncmp(input, "NaN", 3) == 0)
    {
        value = get_float4_nan();
        endptr = input + 3;
    }
    else if(strncmp(input, "INF", 3) == 0)
    {
        value = get_float4_infinity();
        endptr = input + 3;
    }
    else if(strncmp(input, "+INF", 4) == 0)
    {
        value = get_float4_infinity();
        endptr = input + 4;
    }
    else if(strncmp(input, "-INF", 4) == 0)
    {
        value = -get_float4_infinity();
        endptr = input + 4;
    }

    while(*endptr != '\0' && isspace((unsigned char) *endptr))
        endptr++;

    if(*endptr != '\0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed float literal")));

    PG_RETURN_FLOAT4(value);
}


PG_FUNCTION_INFO_V1(float_output);
Datum float_output(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);

    if(isfinite(DatumGetFloat4(value)))
        PG_RETURN_DATUM(DirectFunctionCall1(float4out, value));
    else if(isnan(DatumGetFloat4(value)))
        PG_RETURN_CSTRING(pstrdup("NaN"));
    else if(DatumGetFloat4(value) > 0)
        PG_RETURN_CSTRING(pstrdup("INF"));
    else
        PG_RETURN_CSTRING(pstrdup("-INF"));
}


PG_FUNCTION_INFO_V1(float_uminus);
Datum float_uminus(PG_FUNCTION_ARGS)
{
    float4 arg = PG_GETARG_FLOAT4(0);

    PG_RETURN_FLOAT4(-arg);
}


PG_FUNCTION_INFO_V1(float_add);
Datum float_add(PG_FUNCTION_ARGS)
{
    float4 left = PG_GETARG_FLOAT4(0);
    float4 right = PG_GETARG_FLOAT4(1);

    PG_RETURN_FLOAT4(left + right);
}


PG_FUNCTION_INFO_V1(float_sub);
Datum float_sub(PG_FUNCTION_ARGS)
{
    float4 left = PG_GETARG_FLOAT4(0);
    float4 right = PG_GETARG_FLOAT4(1);

    PG_RETURN_FLOAT4(left - right);
}


PG_FUNCTION_INFO_V1(float_mul);
Datum float_mul(PG_FUNCTION_ARGS)
{
    float4 left = PG_GETARG_FLOAT4(0);
    float4 right = PG_GETARG_FLOAT4(1);

    PG_RETURN_FLOAT4(left * right);
}


PG_FUNCTION_INFO_V1(float_div);
Datum float_div(PG_FUNCTION_ARGS)
{
    float4 left = PG_GETARG_FLOAT4(0);
    float4 right = PG_GETARG_FLOAT4(1);

    PG_RETURN_FLOAT4(left / right);
}
