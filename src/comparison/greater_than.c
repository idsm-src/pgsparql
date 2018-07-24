#include <postgres.h>
#include "rdfbox.h"
#include "call.h"
#include "comparison.h"


PG_FUNCTION_INFO_V1(greater_than_rdfbox);
Datum greater_than_rdfbox(PG_FUNCTION_ARGS)
{
    Datum left = PG_GETARG_DATUM(0);
    Datum right = PG_GETARG_DATUM(1);

    NullableDatum result = NullableFunctionCall2(less_than_rdfbox, right, left);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}
