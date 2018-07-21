/*
 * https://www.w3.org/TR/xmlschema11-2/#dayTimeDuration
 * https://www.w3.org/TR/xpath-functions/#casting-to-durations
 */
#include <postgres.h>
#include <utils/builtins.h>
#include "rdfbox.h"
#include "call.h"
#include "try-catch.h"


PG_FUNCTION_INFO_V1(cast_as_daytimeduration_from_string);
Datum cast_as_daytimeduration_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    bool isNull = false;
    Datum result;

    char *cstring = text_to_cstring(value);

    PG_TRY_EX();
    {
        result = DirectFunctionCall1(daytimeduration_input, CStringGetDatum(cstring));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        isNull = true;
    }
    PG_END_TRY_EX();

    pfree(cstring);
    PG_FREE_IF_COPY(value, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(cast_as_daytimeduration_from_rdfbox);
Datum cast_as_daytimeduration_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isNull = false };

    switch(box->type)
    {
        case XSD_DAYTIMEDURATION:
            result.datum = Int64GetDatum(((RdfBoxDayTimeDuration *) box)->value);
            break;

        case XSD_STRING:
            result = NullableFunctionCall1(cast_as_daytimeduration_from_string, PointerGetDatum(((RdfBoxString *) box)->value));
            break;

        default:
            result.isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}
