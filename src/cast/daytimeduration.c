/*
 * https://www.w3.org/TR/xmlschema11-2/#dayTimeDuration
 * https://www.w3.org/TR/xpath-functions/#casting-to-durations
 */
#include <postgres.h>
#include <utils/builtins.h>
#include "call.h"
#include "try-catch.h"
#include "types/daytimeduration.h"
#include "rdfbox/rdfbox.h"


PG_FUNCTION_INFO_V1(cast_as_daytimeduration_from_string);
Datum cast_as_daytimeduration_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_PP(0);
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        result = NullableFunctionCall1(daytimeduration_input, CStringGetDatum(text_to_cstring(value)));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result.isnull = true;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


PG_FUNCTION_INFO_V1(cast_as_daytimeduration_from_rdfbox);
Datum cast_as_daytimeduration_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DAYTIMEDURATION:
            PG_RETURN_INT64(RdfBoxGetInt64(box));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_daytimeduration_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}
