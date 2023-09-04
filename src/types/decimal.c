#include <postgres.h>
#include <utils/fmgrprotos.h>
#include "call.h"
#include "try-catch.h"


PG_FUNCTION_INFO_V1(numeric_div_checked);
Datum numeric_div_checked(PG_FUNCTION_ARGS)
{
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_div, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_DIVISION_BY_ZERO)
            PG_RE_THROW_EX();

        result.isnull = true;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}
