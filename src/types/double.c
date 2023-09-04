#include <postgres.h>
#include <fmgr.h>
#include <utils/builtins.h>
#include <utils/float.h>
#include "types/double.h"


PG_FUNCTION_INFO_V1(double_input);
Datum double_input(PG_FUNCTION_ARGS)
{
    char *input = PG_GETARG_CSTRING(0);

    while(*input != '\0' && isspace((unsigned char) *input))
        input++;

    if(*input == '\0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed double literal")));

    float8 value = 0;
    char *endptr = input;;

    if(isdigit((unsigned char) *input) || *input == '.' || ((*input == '+' || *input == '-') && isdigit((unsigned char) *(input + 1))))
    {
        errno = 0;
        value = strtod(input, &endptr);

        if(endptr == input || (errno != 0 && errno != ERANGE))
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed double literal")));
    }
    else if(strncmp(input, "NaN", 3) == 0)
    {
        value = get_float8_nan();
        endptr = input + 3;
    }
    else if(strncmp(input, "INF", 3) == 0)
    {
        value = get_float8_infinity();
        endptr = input + 3;
    }
    else if(strncmp(input, "+INF", 4) == 0)
    {
        value = get_float8_infinity();
        endptr = input + 4;
    }
    else if(strncmp(input, "-INF", 4) == 0)
    {
        value = -get_float8_infinity();
        endptr = input + 4;
    }

    while(*endptr != '\0' && isspace((unsigned char) *endptr))
        endptr++;

    if(*endptr != '\0')
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed double literal")));

    PG_RETURN_FLOAT8(value);
}


PG_FUNCTION_INFO_V1(double_output);
Datum double_output(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);

    if(isfinite(DatumGetFloat8(value)))
        PG_RETURN_DATUM(DirectFunctionCall1(float8out, value));
    else if(isnan(DatumGetFloat8(value)))
        PG_RETURN_CSTRING(pstrdup("NaN"));
    else if(DatumGetFloat8(value) > 0)
        PG_RETURN_CSTRING(pstrdup("INF"));
    else
        PG_RETURN_CSTRING(pstrdup("-INF"));
}


PG_FUNCTION_INFO_V1(double_uminus);
Datum double_uminus(PG_FUNCTION_ARGS)
{
    float8 arg = PG_GETARG_FLOAT8(0);

    PG_RETURN_FLOAT8(-arg);
}


PG_FUNCTION_INFO_V1(double_add);
Datum double_add(PG_FUNCTION_ARGS)
{
    float8 left = PG_GETARG_FLOAT8(0);
    float8 right = PG_GETARG_FLOAT8(1);

    PG_RETURN_FLOAT8(left + right);
}


PG_FUNCTION_INFO_V1(double_sub);
Datum double_sub(PG_FUNCTION_ARGS)
{
    float8 left = PG_GETARG_FLOAT8(0);
    float8 right = PG_GETARG_FLOAT8(1);

    PG_RETURN_FLOAT8(left - right);
}


PG_FUNCTION_INFO_V1(double_mul);
Datum double_mul(PG_FUNCTION_ARGS)
{
    float8 left = PG_GETARG_FLOAT8(0);
    float8 right = PG_GETARG_FLOAT8(1);

    PG_RETURN_FLOAT8(left * right);
}


PG_FUNCTION_INFO_V1(double_div);
Datum double_div(PG_FUNCTION_ARGS)
{
    float8 left = PG_GETARG_FLOAT8(0);
    float8 right = PG_GETARG_FLOAT8(1);

    PG_RETURN_FLOAT8(left / right);
}
