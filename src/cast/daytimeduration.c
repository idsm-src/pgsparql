/**
 * @file
 * The casts to xsd:dayTimeDuration, whose values are held by an int8 of microseconds.
 *
 * A value that cannot be cast, such as a malformed lexical form or a duration out of range, gives NULL.
 *
 * @see https://www.w3.org/TR/xmlschema11-2/#dayTimeDuration
 * @see https://www.w3.org/TR/xpath-functions/#casting-to-durations
 */
#include <postgres.h>
#include <utils/builtins.h>
#include "call.h"
#include "try-catch.h"
#include "types/daytimeduration.h"
#include "rdfbox/rdfbox.h"


/**
 * Casts an xsd:string to xsd:dayTimeDuration by parsing it as a lexical form of xsd:dayTimeDuration.
 *
 * @param fcinfo the varchar to cast
 * @return the int8 number of microseconds, NULL if the string is not a lexical form of xsd:dayTimeDuration or its
 *         value is out of range or more precise than a microsecond
 */
PG_FUNCTION_INFO_V1(cast_as_daytimeduration_from_string);
Datum cast_as_daytimeduration_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    NullableDatum result = NULL_DATUM;

    PG_TRY_EX();
    {
        result = NULLABLE_DATUM(Int64GetDatum(daytimeduration_parse(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value))));
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
 * Casts an RDF term to xsd:dayTimeDuration, the function `xsd:dayTimeDuration()`.
 *
 * @param fcinfo the rdfbox to cast
 * @return the int8 number of microseconds, NULL if the term is neither an xsd:dayTimeDuration nor an xsd:string
 *         holding a valid lexical form of xsd:dayTimeDuration
 */
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
