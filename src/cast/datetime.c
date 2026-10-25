/**
 * @file
 * The casts to xsd:dateTime, held by a zoneddatetime, and to a plain dateTime, the instant without its time zone.
 *
 * A value that cannot be cast, such as a malformed lexical form or a dateTime out of range, gives NULL.
 *
 * @see https://www.w3.org/TR/xmlschema11-2/#dateTime
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
 * Casts an xsd:date to xsd:dateTime: the midnight that begins the date in its time zone, with the same time zone.
 *
 * The midnight is computed by date_timestamptz(), which takes it in the TimeZone of the session.
 *
 * @param fcinfo the zoneddate to cast, or the date and the int4 time zone offset in seconds (#ZONE_UNSPECIFIED for
 *               none) of the xsd:date
 * @return the palloc'd zoneddatetime, NULL if the instant is out of range
 */
PG_FUNCTION_INFO_V1(cast_as_datetime_from_date);
Datum cast_as_datetime_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        TimestampTz timestamp = DatumGetTimestampTz(DirectFunctionCall1(date_timestamptz, DateADTGetDatum(date.value)));

        ZonedDateTime *datetime = palloc0(sizeof(ZonedDateTime));
        datetime->value = timestamp;
        datetime->zone = date.zone;

        if(date.zone != ZONE_UNSPECIFIED)
        {
            datetime->value -= date.zone * USECS_PER_SEC;

            if((timestamp > 0 && date.zone < 0 && datetime->value < 0) || (timestamp < 0 && date.zone > 0 && datetime->value > 0))
                ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)));
        }

        result = NULLABLE_DATUM(ZonedDateTimeGetDatum(datetime));
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
 * Casts an xsd:string to xsd:dateTime by parsing it as a lexical form of xsd:dateTime.
 *
 * @param fcinfo the varchar to cast
 * @return the zoneddatetime, NULL if the string is not a lexical form of xsd:dateTime or the dateTime is out of range
 */
PG_FUNCTION_INFO_V1(cast_as_datetime_from_string);
Datum cast_as_datetime_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NULLABLE_DATUM(ZonedDateTimeGetDatum(datetime_parse(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value))));
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
 * Casts an RDF term to xsd:dateTime, the SPARQL function `xsd:dateTime()`.
 *
 * @param fcinfo the rdfbox to cast
 * @return the zoneddatetime, which points into the box for an xsd:dateTime, NULL if the term is not an
 *         xsd:dateTime, an xsd:date or an xsd:string, or if its value cannot be cast
 */
PG_FUNCTION_INFO_V1(cast_as_datetime_from_rdfbox);
Datum cast_as_datetime_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN_ZONEDDATETIME_P(RdfBoxGetZonedDateTime(box));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(cast_as_datetime_from_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        case XSD_STRING:
            PG_RETURN(NullableFunctionCall1(cast_as_datetime_from_string, PointerGetDatum(RdfBoxGetVarChar(box))));

        default:
            PG_RETURN_NULL();
    }
}


/**
 * Casts an xsd:date to the instant of the midnight that begins the date in its time zone, without the time zone.
 *
 * The midnight is computed by date_timestamptz(), which takes it in the TimeZone of the session.
 *
 * @param fcinfo the date and the int4 time zone offset in seconds (#ZONE_UNSPECIFIED for none) of the xsd:date
 * @return the timestamptz, NULL if the instant is out of range
 */
PG_FUNCTION_INFO_V1(cast_as_plain_datetime_from_date);
Datum cast_as_plain_datetime_from_date(PG_FUNCTION_ARGS)
{
    ZonedDate date = PG_GETARG_DATE();
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        TimestampTz timestamp = DatumGetTimestampTz(DirectFunctionCall1(date_timestamptz, DateADTGetDatum(date.value)));

        TimestampTz datetime = timestamp;

        if(date.zone != ZONE_UNSPECIFIED)
        {
            datetime -= date.zone * USECS_PER_SEC;

            if((timestamp > 0 && date.zone < 0 && datetime < 0) || (timestamp < 0 && date.zone > 0 && datetime > 0))
                ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)));
        }

        result = NULLABLE_DATUM(TimestampTzGetDatum(datetime));
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
 * Casts an xsd:dateTime or an xsd:date to its instant without the time zone.
 *
 * Unlike cast_as_datetime_from_rdfbox(), it does not parse strings.
 *
 * @param fcinfo the rdfbox to cast
 * @return the timestamptz instant of an xsd:dateTime or of the midnight that begins an xsd:date, NULL for another
 *         term or if the instant is out of range
 */
PG_FUNCTION_INFO_V1(cast_as_plain_datetime_from_rdfbox);
Datum cast_as_plain_datetime_from_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_DATETIME:
            PG_RETURN_TIMESTAMPTZ(RdfBoxGetZonedDateTime(box)->value);

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(cast_as_plain_datetime_from_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        default:
            PG_RETURN_NULL();
    }
}
