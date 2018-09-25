/*
 * https://www.w3.org/TR/xmlschema11-2/#date
 * https://www.w3.org/TR/xpath-functions/#casting-to-datetimes
 */
#include <postgres.h>
#include <utils/builtins.h>
#include "date/datetime.h"
#include "date/date.h"
#include "date/timezone.h"
#include "rdfbox.h"
#include "call.h"
#include "try-catch.h"


PG_FUNCTION_INFO_V1(cast_as_date_from_datetime);
Datum cast_as_date_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) :
            (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) };

    if(date.zone != ZONE_UNSPECIFIED)
        date.value += date.zone * USECS_PER_SEC;

    ZonedDate result = { .value = date.value / USECS_PER_DAY, .zone = date.zone };
    PG_RETURN_ZONEDDATE(result);
}


PG_FUNCTION_INFO_V1(cast_as_plain_date_from_datetime);
Datum cast_as_plain_date_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime date = PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) :
            (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) };

    if(date.zone != ZONE_UNSPECIFIED)
        date.value += date.zone * USECS_PER_SEC;

    PG_RETURN_DATEADT(date.value / USECS_PER_DAY);
}


PG_FUNCTION_INFO_V1(cast_as_date_from_string);
Datum cast_as_date_from_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    bool isNull = false;
    Datum result;

    char *cstring = text_to_cstring(value);

    PG_TRY_EX();
    {
        result = DirectFunctionCall1(zoneddate_input, CStringGetDatum(cstring));
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


PG_FUNCTION_INFO_V1(cast_as_date_from_rdfbox);
Datum cast_as_date_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isNull = false };

    switch(box->type)
    {
        case XSD_DATETIME:
            result = NullableFunctionCall1(cast_as_date_from_datetime, ZonedDateTimeGetDatum(&((RdfBoxDateTime *) box)->value));
            break;

        case XSD_DATE:
            result.datum = ZonedDateGetDatum(((RdfBoxDate *) box)->value);
            break;

        case XSD_STRING:
            result = NullableFunctionCall1(cast_as_date_from_string, PointerGetDatum(((RdfBoxString *) box)->value));
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


PG_FUNCTION_INFO_V1(cast_as_plain_date_from_rdfbox);
Datum cast_as_plain_date_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isNull = false };

    switch(box->type)
    {
        case XSD_DATETIME:
            result = NullableFunctionCall1(cast_as_plain_date_from_datetime, ZonedDateTimeGetDatum(&((RdfBoxDateTime *) box)->value));
            break;

        case XSD_DATE:
            result.datum = DateADTGetDatum(((RdfBoxDate *) box)->value.value);
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
