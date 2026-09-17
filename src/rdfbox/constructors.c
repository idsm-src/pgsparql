#include <postgres.h>
#include <utils/numeric.h>
#include "call.h"
#include "rdfbox/syntax.h"
#include "types/sblanknode.h"
#include "types/timezone.h"
#include "rdfbox/rdfbox.h"


#ifdef PGSPARQL_EXTRA_CHECKS
static inline VarChar *checked_iri(VarChar *iri)
{
    if(!check_iri(VARDATA_ANY(iri), VARSIZE_ANY_EXHDR(iri)))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("invalid IRI")));

    return iri;
}
#else
#define checked_iri(x)    (x)
#endif


#ifdef PGSPARQL_EXTRA_CHECKS
static inline VarChar *checked_language_tag(VarChar *lang)
{
    if(!check_language_tag(VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("invalid language tag")));

    return lang;
}
#else
#define checked_language_tag(x)    (x)
#endif


#ifdef PGSPARQL_EXTRA_CHECKS
static inline VarChar *checked_sblanknode(VarChar *value)
{
    if(!is_sblanknode_value(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("invalid blank node")));

    return value;
}
#else
#define checked_sblanknode(x)    (x)
#endif


PG_FUNCTION_INFO_V1(rdfbox_create_from_boolean);
Datum rdfbox_create_from_boolean(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetBooleanRdfBox(PG_GETARG_BOOL(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_boolean_with_lexical);
Datum rdfbox_create_from_boolean_with_lexical(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetBooleanRdfBox(value));

    PG_RETURN_RDFBOX_P(GetBooleanRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_short);
Datum rdfbox_create_from_short(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetShortRdfBox(PG_GETARG_INT16(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_short_with_lexical);
Datum rdfbox_create_from_short_with_lexical(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetShortRdfBox(value));

    PG_RETURN_RDFBOX_P(GetShortRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_int);
Datum rdfbox_create_from_int(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetIntRdfBox(PG_GETARG_INT32(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_int_with_lexical);
Datum rdfbox_create_from_int_with_lexical(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetIntRdfBox(value));

    PG_RETURN_RDFBOX_P(GetIntRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_long);
Datum rdfbox_create_from_long(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetLongRdfBox(PG_GETARG_INT64(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_long_with_lexical);
Datum rdfbox_create_from_long_with_lexical(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetLongRdfBox(value));

    PG_RETURN_RDFBOX_P(GetLongRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_float);
Datum rdfbox_create_from_float(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetFloatRdfBox(PG_GETARG_FLOAT4(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_float_with_lexical);
Datum rdfbox_create_from_float_with_lexical(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(value));

    PG_RETURN_RDFBOX_P(GetFloatRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_double);
Datum rdfbox_create_from_double(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDoubleRdfBox(PG_GETARG_FLOAT8(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_double_with_lexical);
Datum rdfbox_create_from_double_with_lexical(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDoubleRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_integer);
Datum rdfbox_create_from_integer(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(PG_GETARG_NUMERIC(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_integer_with_lexical);
Datum rdfbox_create_from_integer_with_lexical(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetIntegerRdfBox(value));

    PG_RETURN_RDFBOX_P(GetIntegerRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_decimal);
Datum rdfbox_create_from_decimal(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDecimalRdfBox(PG_GETARG_NUMERIC(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_decimal_with_lexical);
Datum rdfbox_create_from_decimal_with_lexical(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDecimalRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDecimalRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_datetime);
Datum rdfbox_create_from_datetime(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetDateTimeRdfBox(PG_GETARG_ZONEDDATETIME_P(0)));
    else
        PG_RETURN_RDFBOX_P(GetDateTimeRdfBox(&((ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = checked_zone(PG_GETARG_INT32(1))})));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_datetime_with_lexical);
Datum rdfbox_create_from_datetime_with_lexical(PG_FUNCTION_ARGS)
{
    ZonedDateTime *value = PG_NARGS() == 2 ? PG_GETARG_ZONEDDATETIME_P(0) : &((ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = checked_zone(PG_GETARG_INT32(1))});
    VarChar *lexical = PG_GETARG_VARCHAR_PP(PG_NARGS() - 1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDateTimeRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDateTimeRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_date);
Datum rdfbox_create_from_date(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetDateRdfBox(PG_GETARG_ZONEDDATE(0)));
    else
        PG_RETURN_RDFBOX_P(GetDateRdfBox((ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = checked_zone(PG_GETARG_INT32(1))}));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_date_with_lexical);
Datum rdfbox_create_from_date_with_lexical(PG_FUNCTION_ARGS)
{
    ZonedDate value = PG_NARGS() == 2 ? PG_GETARG_ZONEDDATE(0) : (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = checked_zone(PG_GETARG_INT32(1))};
    VarChar *lexical = PG_GETARG_VARCHAR_PP(PG_NARGS() - 1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDateRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDateRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_daytimeduration);
Datum rdfbox_create_from_daytimeduration(PG_FUNCTION_ARGS)
{
    PG_RETURN_RDFBOX_P(GetDayTimeDurationRdfBox(PG_GETARG_INT64(0)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_daytimeduration_with_lexical);
Datum rdfbox_create_from_daytimeduration_with_lexical(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    VarChar *lexical = PG_GETARG_VARCHAR_PP(1);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetDayTimeDurationRdfBox(value));

    PG_RETURN_RDFBOX_P(GetDayTimeDurationRdfBoxWithLexical(value, VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_string);
Datum rdfbox_create_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    PG_RETURN_RDFBOX_P(GetStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_iri);
Datum rdfbox_create_from_iri(PG_FUNCTION_ARGS)
{
    VarChar *value = checked_iri(PG_GETARG_VARCHAR_PP(0));
    PG_RETURN_RDFBOX_P(GetIriRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_langstring);
Datum rdfbox_create_from_langstring(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *lang = checked_language_tag(PG_GETARG_VARCHAR_PP(1));
    PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_userliteral);
Datum rdfbox_create_from_userliteral(PG_FUNCTION_ARGS)
{
    Oid typeoid = get_fn_expr_argtype(fcinfo->flinfo, 0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));

    if(!OidIsValid(typeoid))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("could not determine input data type")));

    UBox *value = ubox_make(typeoid, PG_GETARG_DATUM(0));

    PG_RETURN_RDFBOX_P(GetUserLiteralRdfBox(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_userliteral_with_lexical);
Datum rdfbox_create_from_userliteral_with_lexical(PG_FUNCTION_ARGS)
{
    Oid typeoid = get_fn_expr_argtype(fcinfo->flinfo, 0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(2);

    if(!OidIsValid(typeoid))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("could not determine input data type")));

    UBox *value = ubox_make(typeoid, PG_GETARG_DATUM(0));

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetUserLiteralRdfBox(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));

    PG_RETURN_RDFBOX_P(GetUserLiteralRdfBoxWithLexical(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type), VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_boxed_userliteral);
Datum rdfbox_create_from_boxed_userliteral(PG_FUNCTION_ARGS)
{
    UBox *value = PG_GETARG_UBOX_P(0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));

    PG_RETURN_RDFBOX_P(GetUserLiteralRdfBox(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_boxed_userliteral_with_lexical);
Datum rdfbox_create_from_boxed_userliteral_with_lexical(PG_FUNCTION_ARGS)
{
    UBox *value = PG_GETARG_UBOX_P(0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));
    VarChar *lexical = PG_GETARG_VARCHAR_PP(2);

    if(VARSIZE_ANY_EXHDR(lexical) == 0)
        PG_RETURN_RDFBOX_P(GetUserLiteralRdfBox(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));

    PG_RETURN_RDFBOX_P(GetUserLiteralRdfBoxWithLexical(value, VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type), VARDATA_ANY(lexical), VARSIZE_ANY_EXHDR(lexical)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_typedliteral);
Datum rdfbox_create_from_typedliteral(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *type = checked_iri(PG_GETARG_VARCHAR_PP(1));
    PG_RETURN_RDFBOX_P(GetTypedLiteralRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(type), VARSIZE_ANY_EXHDR(type)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_iblanknode);
Datum rdfbox_create_from_iblanknode(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
        PG_RETURN_RDFBOX_P(GetIBlankNodeRdfBox(PG_GETARG_INT64(0)));
    else
        PG_RETURN_RDFBOX_P(GetIBlankNodeRdfBox(((uint64) PG_GETARG_INT32(1)) << 32 | ((uint64) PG_GETARG_INT32(0) & 0xFFFFFFFF)));
}


PG_FUNCTION_INFO_V1(rdfbox_create_from_sblanknode);
Datum rdfbox_create_from_sblanknode(PG_FUNCTION_ARGS)
{
    if(PG_NARGS() == 1)
    {
        VarChar *value = checked_sblanknode(PG_GETARG_VARCHAR_PP(0));
        PG_RETURN_RDFBOX_P(GetSBlankNodeRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value)));
    }
    else
    {
        VarChar *label = PG_GETARG_VARCHAR_PP(0);
        int32 segment = PG_GETARG_INT32(1);

        int32 size = VARSIZE_ANY_EXHDR(label);
        char *buffer = palloc(8 + size);
        write_sblanknode_segment(buffer, segment);
        memcpy(buffer + 8, VARDATA_ANY(label), size);

        PG_RETURN_RDFBOX_P(GetSBlankNodeRdfBox(buffer, 8 + size));
    }
}
