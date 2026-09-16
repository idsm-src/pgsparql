#include <postgres.h>
#include <utils/numeric.h>
#include "call.h"
#include "try-catch.h"
#include "types/parser.h"
#include "types/decimal.h"


Numeric decimal_parse(char *data, int size)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    int begin = pos;

    if(pos < size && (data[pos] == '-' || data[pos] == '+'))
        pos++;

    int num_pos = pos;

    while(pos < size && xsd_isdigit(data[pos]))
        pos++;

    if(pos < size && data[pos] == '.')
        pos++;

    while(pos < size && xsd_isdigit(data[pos]))
        pos++;

    if(pos - num_pos == (data[num_pos] == '.'))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:decimal literal")));

    char *cstring = palloc(pos - begin + 1);
    memcpy(cstring, data + begin, pos - begin);
    cstring[pos - begin] = '\0';

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:decimal literal")));

    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(cstring), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}


static inline NullableDatum decimal_result(NullableDatum result)
{
    if(!result.isnull)
    {
        Numeric value = DatumGetNumeric(result.value);

        if(numeric_is_inf(value) || numeric_is_nan(value))
            result = NULL_DATUM;
    }

    return result;
}


PG_FUNCTION_INFO_V1(decimal_uminus);
Datum decimal_uminus(PG_FUNCTION_ARGS)
{
    PG_RETURN(decimal_result(NullableFunctionCall1(numeric_uminus, PG_GETARG_DATUM(0))));
}


PG_FUNCTION_INFO_V1(decimal_add);
Datum decimal_add(PG_FUNCTION_ARGS)
{
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_add, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(decimal_result(result));
}


PG_FUNCTION_INFO_V1(decimal_sub);
Datum decimal_sub(PG_FUNCTION_ARGS)
{
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_sub, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(decimal_result(result));
}


PG_FUNCTION_INFO_V1(decimal_mul);
Datum decimal_mul(PG_FUNCTION_ARGS)
{
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_mul, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(decimal_result(result));
}


PG_FUNCTION_INFO_V1(decimal_div);
Datum decimal_div(PG_FUNCTION_ARGS)
{
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_div, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_DIVISION_BY_ZERO && sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(decimal_result(result));
}
