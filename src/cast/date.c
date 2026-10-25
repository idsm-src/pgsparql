/**
 * @file
 * The casts to xsd:date, held by a zoneddate, and to a plain date, the date without its time zone.
 *
 * A value that cannot be cast, such as a malformed lexical form or a date out of range, gives NULL.
 *
 * @see https://www.w3.org/TR/xmlschema11-2/#date
 * @see https://www.w3.org/TR/xpath-functions/#casting-to-datetimes
 */
#include <postgres.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include "call.h"
#include "try-catch.h"
#include "rdfbox/rdfbox.h"
#include "types/date.h"
#include "types/datetime.h"
#include "types/timezone.h"


/**
 * Casts an xsd:dateTime to xsd:date: the date of its local time, with the same time zone.
 *
 * @param fcinfo the zoneddatetime to cast, or the timestamptz instant and the int4 time zone offset in seconds
 *               (#ZONE_UNSPECIFIED for none) of the dateTime
 * @return the zoneddate, NULL if the local time is out of range
 */
PG_FUNCTION_INFO_V1(cast_as_date_from_datetime);
Datum cast_as_date_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime datetime = PG_GETARG_DATETIME();
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        TimestampTz value = datetime.value;

        if(datetime.zone != ZONE_UNSPECIFIED)
        {
            value += datetime.zone * USECS_PER_SEC;

            if((datetime.value > 0 && datetime.zone > 0 && value < 0) || (datetime.value < 0 && datetime.zone < 0 && value > 0))
                ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)));
        }

        DateADT date = DatumGetDateADT(DirectFunctionCall1(timestamp_date, TimestampTzGetDatum(value)));
        result = NULLABLE_DATUM(ZonedDateGetDatum((ZonedDate) { .value = date, .zone = datetime.zone }));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


/**
 * Casts an xsd:string to xsd:date by parsing it as a lexical form of xsd:date.
 *
 * @param fcinfo the varchar to cast
 * @return the zoneddate, NULL if the string is not a lexical form of xsd:date or the date is out of range
 */
PG_FUNCTION_INFO_V1(cast_as_date_from_string);
Datum cast_as_date_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NULLABLE_DATUM(ZonedDateGetDatum(date_parse(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value))));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


/**
 * Casts an RDF term to xsd:date, the function `xsd:date()`.
 *
 * @param fcinfo the rdfbox to cast
 * @return the zoneddate, NULL if the term is not an xsd:dateTime, an xsd:date or an xsd:string, or if its value
 *         cannot be cast
 */
PG_FUNCTION_INFO_V1(cast_as_date_from_rdfbox);
Datum cast_as_date_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(cast_as_date_from_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN_ZONEDDATE(RdfBoxGetZonedDate(box));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_date_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * Casts an xsd:dateTime to the date of its local time, without the time zone.
 *
 * @param fcinfo the timestamptz instant and the int4 time zone offset in seconds (#ZONE_UNSPECIFIED for none) of the
 *               dateTime
 * @return the date, NULL if the local time is out of range
 */
PG_FUNCTION_INFO_V1(cast_as_plain_date_from_datetime);
Datum cast_as_plain_date_from_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime datetime = PG_GETARG_DATETIME();
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        TimestampTz value = datetime.value;

        if(datetime.zone != ZONE_UNSPECIFIED)
        {
            value += datetime.zone * USECS_PER_SEC;

            if((datetime.value > 0 && datetime.zone > 0 && value < 0) || (datetime.value < 0 && datetime.zone < 0 && value > 0))
                ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)));
        }

        result = NULLABLE_DATUM(DirectFunctionCall1(timestamp_date, TimestampTzGetDatum(value)));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = NULL_DATUM;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}


/**
 * Casts an xsd:dateTime or an xsd:date to its date without the time zone.
 *
 * Unlike cast_as_date_from_rdfbox(), it does not parse strings.
 *
 * @param fcinfo the rdfbox to cast
 * @return the date of the local time of an xsd:dateTime or the date of an xsd:date, NULL for another term or if the
 *         local time is out of range
 */
PG_FUNCTION_INFO_V1(cast_as_plain_date_from_rdfbox);
Datum cast_as_plain_date_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(cast_as_plain_date_from_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN_DATEADT(RdfBoxGetZonedDate(box).value);

        default:
            PG_RETURN_NULL();
    }
}
