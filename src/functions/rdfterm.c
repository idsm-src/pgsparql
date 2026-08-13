#include <postgres.h>
#include <pcre2.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <utils/formatting.h>
#include "call.h"
#include "try-catch.h"
#include "cast/cast.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/syntax.h"
#include "rdfbox/xsd.h"
#include "types/boolean.h"
#include "types/short.h"
#include "types/int.h"
#include "types/long.h"
#include "types/integer.h"
#include "types/decimal.h"
#include "types/float.h"
#include "types/double.h"
#include "types/integer.h"
#include "types/decimal.h"
#include "types/daytimeduration.h"


typedef struct
{
    char *scheme;
    char *authority;
    char *path;
    char *query;
    char *fragment;
}
IriComponents;


static const char *rdfbox_types[] =
{
        XSD_BOOLEAN_IRI,
        XSD_SHORT_IRI,
        XSD_INT_IRI,
        XSD_LONG_IRI,
        XSD_INTEGER_IRI,
        XSD_DECIMAL_IRI,
        XSD_FLOAT_IRI,
        XSD_DOUBLE_IRI,
        XSD_DATETIME_IRI,
        XSD_DATE_IRI,
        XSD_DAYTIMEDURATION_IRI,
        XSD_STRING_IRI,
        "http://www.w3.org/1999/02/22-rdf-syntax-ns#langString"
};


static bool varchar_equals(VarChar* arg1, VarChar* arg2)
{
        size_t len1 = VARSIZE_ANY_EXHDR(arg1);
        size_t len2 = VARSIZE_ANY_EXHDR(arg2);

        return len1 == len2 && !memcmp(VARDATA_ANY(arg1), VARDATA_ANY(arg2), len1);
}


PG_FUNCTION_INFO_V1(is_iri_rdfbox);
Datum is_iri_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = box->type == IRI;
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(is_blank_rdfbox);
Datum is_blank_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = box->type == IBLANKNODE || box->type == SBLANKNODE;
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(is_literal_rdfbox);
Datum is_literal_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_literal(box);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(is_numeric_rdfbox);
Datum is_numeric_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_numeric(box);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(str_boolean);
Datum str_boolean(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(boolean_as_varchar(PG_GETARG_BOOL(0)));
}


PG_FUNCTION_INFO_V1(str_short);
Datum str_short(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(short_as_varchar(PG_GETARG_INT16(0)));
}


PG_FUNCTION_INFO_V1(str_int);
Datum str_int(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(int_as_varchar(PG_GETARG_INT32(0)));
}


PG_FUNCTION_INFO_V1(str_long);
Datum str_long(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(long_as_varchar(PG_GETARG_INT64(0)));
}


PG_FUNCTION_INFO_V1(str_integer);
Datum str_integer(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(integer_as_varchar(PG_GETARG_NUMERIC(0)));
}


PG_FUNCTION_INFO_V1(str_decimal);
Datum str_decimal(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(decimal_as_varchar(PG_GETARG_NUMERIC(0)));
}


PG_FUNCTION_INFO_V1(str_float);
Datum str_float(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(float_as_varchar(PG_GETARG_FLOAT4(0)));
}


PG_FUNCTION_INFO_V1(str_double);
Datum str_double(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(double_as_varchar(PG_GETARG_FLOAT8(0)));
}


PG_FUNCTION_INFO_V1(str_datetime);
Datum str_datetime(PG_FUNCTION_ARGS)
{
    ZonedDateTime value = PG_NARGS() == 1 ? *PG_GETARG_ZONEDDATETIME_P(0) : (ZonedDateTime) { .value = PG_GETARG_TIMESTAMPTZ(0), .zone = PG_GETARG_INT32(1) };
    PG_RETURN_VARCHAR_P(datetime_as_varchar(&value));
}


PG_FUNCTION_INFO_V1(str_date);
Datum str_date(PG_FUNCTION_ARGS)
{
    ZonedDate value = PG_NARGS() == 1 ? PG_GETARG_ZONEDDATE(0) : (ZonedDate) { .value = PG_GETARG_DATEADT(0), .zone = PG_GETARG_INT32(1) };
    PG_RETURN_VARCHAR_P(date_as_varchar(value));
}


PG_FUNCTION_INFO_V1(str_daytimeduration);
Datum str_daytimeduration(PG_FUNCTION_ARGS)
{
    PG_RETURN_VARCHAR_P(daytimeduration_as_varchar(PG_GETARG_INT64(0)));
}


PG_FUNCTION_INFO_V1(str_rdfbox);
Datum str_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetBoolLexical(box));
            else
                PG_RETURN_VARCHAR_P(boolean_as_varchar(RdfBoxGetBool(box)));

        case XSD_SHORT:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetInt16Lexical(box));
            else
                PG_RETURN_VARCHAR_P(short_as_varchar(RdfBoxGetInt16(box)));

        case XSD_INT:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetInt32Lexical(box));
            else
                PG_RETURN_VARCHAR_P(int_as_varchar(RdfBoxGetInt32(box)));

        case XSD_LONG:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetInt64Lexical(box));
            else
                PG_RETURN_VARCHAR_P(long_as_varchar(RdfBoxGetInt64(box)));

        case XSD_INTEGER:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
            else
                PG_RETURN_VARCHAR_P(integer_as_varchar(RdfBoxGetNumeric(box)));

        case XSD_DECIMAL:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
            else
                PG_RETURN_VARCHAR_P(decimal_as_varchar(RdfBoxGetNumeric(box)));

        case XSD_FLOAT:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetFloat4Lexical(box));
            else
                PG_RETURN_VARCHAR_P(float_as_varchar(RdfBoxGetFloat4(box)));

        case XSD_DOUBLE:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetFloat8Lexical(box));
            else
                PG_RETURN_VARCHAR_P(double_as_varchar(RdfBoxGetFloat8(box)));

        case XSD_DATETIME:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetZonedDateTimeLexical(box));
            else
                PG_RETURN_VARCHAR_P(datetime_as_varchar(RdfBoxGetZonedDateTime(box)));

        case XSD_DATE:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetZonedDateLexical(box));
            else
                PG_RETURN_VARCHAR_P(date_as_varchar(RdfBoxGetZonedDate(box)));

        case XSD_DAYTIMEDURATION:
            if(box->lexical)
                PG_RETURN_VARCHAR_P(RdfBoxGetInt64Lexical(box));
            else
                PG_RETURN_VARCHAR_P(daytimeduration_as_varchar(RdfBoxGetInt64(box)));

        case XSD_STRING:
        case IRI:
        case RDF_LANGSTRING:
        case TYPED_LITERAL:
            PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(lang_rdfbox);
Datum lang_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type == RDF_LANGSTRING)
    {
        PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
    }
    else if(rdfbox_is_literal(box))
    {
        VarChar *empty = palloc(VARHDRSZ);
        SET_VARSIZE(empty, VARHDRSZ);

        PG_RETURN_VARCHAR_P(empty);
    }
    else
    {
        PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(datatype_rdfbox);
Datum datatype_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type == TYPED_LITERAL)
        PG_RETURN_VARCHAR_P(RdfBoxGetAttachment(box));
    else if(rdfbox_is_literal(box))
        PG_RETURN_TEXT_P(cstring_to_text(rdfbox_types[box->type]));
    else
        PG_RETURN_NULL();
}


static IriComponents iri_parse(char *string)
{
    IriComponents iri = {.scheme = NULL, .authority = NULL, .path = NULL, .query = NULL, .fragment = NULL };

    char *c = string;
    char *begin = c;

    while(*c != ':' && *c != '/' && *c != '?' && *c != '#' && *c != '\0')
        c++;

    if(*c == ':' && c != begin)
    {
        c++;

        iri.scheme = pnstrdup(begin, c - begin);
        begin = c;
    }

    if(*c == '/' && *(c+1) == '/')
    {
        c += 2;

        while(*c != '/' && *c != '?' && *c != '#' && *c != '\0')
            c++;

        iri.authority = pnstrdup(begin, c - begin);
        begin = c;
    }

    while(*c != '?' && *c != '#' && *c != '\0')
        c++;

    iri.path = pnstrdup(begin, c - begin);
    begin = c;

    if(*c == '?')
    {
        c++;

        while(*c != '#' && *c != '\0')
            c++;

        iri.query = pnstrdup(begin, c - begin);
        begin = c;
    }

    if(*c == '#')
    {
        c++;

        while(*c != '\0')
            c++;

        iri.fragment = pnstrdup(begin, c - begin);
    }

    return iri;
}


static char *iri_merge_path(char *base, char *relative)
{
    int length = strlen(base);

    while(length > 0 && base[length - 1] != '/')
        length--;

    return psprintf("%.*s%s", length, base, relative);
}


static char *iri_remove_dot_segments(char *path)
{
    char *data = pstrdup(path);
    char *input = data;
    char *result = palloc0(strlen(data) + 1);
    char *output = result;


    // While the input buffer is not empty, loop as follows:
    while(*input != '\0')
    {
        // If the input buffer begins with a prefix of "../" or "./",
        // then remove that prefix from the input buffer; otherwise,
        if(strncmp(input, "../", 3) == 0)
            input += 3;
        else if(strncmp(input, "./", 2) == 0)
            input += 2;

        // if the input buffer begins with a prefix of "/./" or "/.",
        // where "." is a complete path segment, then replace that
        // prefix with "/" in the input buffer; otherwise,
        else if(strncmp(input, "/./", 3) == 0)
            input += 2;
        else if(strncmp(input, "/.", 3) == 0)
            input[1] = '\0';

        // if the input buffer begins with a prefix of "/../" or "/..",
        // where ".." is a complete path segment, then replace that
        // prefix with "/" in the input buffer and remove the last
        // segment and its preceding "/" (if any) from the output
        // buffer; otherwise,
        else if(strncmp(input, "/../", 4) == 0)
        {
            input += 3;

            while(*output != '/' && output != result)
                *(output--) = '\0';

            *output = '\0';
        }
        else if(strncmp(input, "/..", 4) == 0)
        {
            input[1] = '\0';

            while(*output != '/' && output != result)
                *(output--) = '\0';

            *output = '\0';
        }

        // if the input buffer consists only of "." or "..", then remove
        // that from the input buffer; otherwise,
        else if(strcmp(input, ".") == 0)
            input += 1;
        else if(strcmp(input, "..") == 0)
            input += 2;

        // move the first path segment in the input buffer to the end of
        // the output buffer, including the initial "/" character (if
        // any) and any subsequent characters up to, but not including,
        // the next "/" character or the end of the input buffer.
        else
        {
            do
                *(output++) = *(input++);
            while(*input != '\0' && *input != '/');
        }
    }

    return result;
}


PG_FUNCTION_INFO_V1(iri_string);
Datum iri_string(PG_FUNCTION_ARGS)
{
    text *base_value = PG_GETARG_TEXT_PP(0);
    text *iri_value = PG_GETARG_TEXT_PP(1);

    if(!check_iri_reference(VARDATA_ANY(iri_value), VARSIZE_ANY_EXHDR(iri_value)))
        PG_RETURN_NULL();

    char *base_string = text_to_cstring(base_value);
    char *iri_string = text_to_cstring(iri_value);

    IriComponents base = iri_parse(base_string);
    IriComponents iri = iri_parse(iri_string);
    IriComponents result;

    if(iri.scheme != NULL)
    {
        result.scheme = iri.scheme;
        result.authority = iri.authority;
        result.path = iri_remove_dot_segments(iri.path);
        result.query = iri.query;
    }
    else
    {
        if(iri.authority != NULL)
        {
            result.authority = iri.authority;
            result.path = iri_remove_dot_segments(iri.path);
            result.query = iri.query;
        }
        else
        {
            if(iri.path[0] == '\0')
            {
                result.path = pstrdup(base.path);

                if(iri.query != NULL)
                    result.query = iri.query;
                else
                    result.query = base.query;
            }
            else
            {
                if(iri.path[0] == '/')
                {
                    result.path = iri_remove_dot_segments(iri.path);
                }
                else
                {
                    char *path = iri_merge_path((base.authority != NULL && base.path[0] == '\0') ? "/" : base.path, iri.path);
                    result.path = iri_remove_dot_segments(path);
                }

                result.query = iri.query;
            }

            result.authority = base.authority;
       }

       result.scheme = base.scheme;
    }

    result.fragment = iri.fragment;

    result.scheme = result.scheme != NULL ? result.scheme : "";
    result.authority = result.authority != NULL ? result.authority : "";
    result.path = result.path != NULL ? result.path : "";
    result.query = result.query != NULL ? result.query : "";
    result.fragment = result.fragment != NULL ? result.fragment : "";

    char *absolute = psprintf("%s%s%s%s%s", result.scheme, result.authority, result.path, result.query, result.fragment);
    Datum datum = PointerGetDatum(cstring_to_text(absolute));

    PG_RETURN_DATUM(datum);
}


PG_FUNCTION_INFO_V1(iri_rdfbox);
Datum iri_rdfbox(PG_FUNCTION_ARGS)
{
    Datum base = PG_GETARG_DATUM(0);
    RdfBox *box = PG_GETARG_RDFBOX_P(1);

    switch(box->type)
    {
        case XSD_STRING:
            PG_RETURN(NullableFunctionCall2(iri_string, base, PointerGetDatum(RdfBoxGetVarChar(box))));

        case IRI:
            PG_RETURN_VARCHAR_P(RdfBoxGetVarChar(box));

        default:
            PG_RETURN_NULL();
    }
}


PG_FUNCTION_INFO_V1(bnode);
Datum bnode(PG_FUNCTION_ARGS)
{
    static int32 bnode_id = 0;
    PG_RETURN_INT32(bnode_id++);
}


PG_FUNCTION_INFO_V1(strdt_string);
Datum strdt_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *type = PG_GETARG_VARCHAR_PP(1);

    char *data = VARDATA_ANY(value);
    int size = VARSIZE_ANY_EXHDR(value);

    char *type_data = VARDATA_ANY(type);
    int type_size = VARSIZE_ANY_EXHDR(type);

    RdfBox *result = NULL;


    PG_TRY_EX();
    {
        if(sizeof(XSD_BOOLEAN_IRI) == type_size + 1 && strncmp(XSD_BOOLEAN_IRI, type_data, type_size) == 0)
        {
            bool val = boolean_parse(data, size);
            char buffer[BOOLEAN_MAXLEN];

            if(boolean_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetBooleanRdfBox(val);
            else
                result = GetBooleanRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_SHORT_IRI) == type_size + 1 && strncmp(XSD_SHORT_IRI, type_data, type_size) == 0)
        {
            int16 val = short_parse(data, size);
            char buffer[SHORT_MAXLEN];

            if(short_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetShortRdfBox(val);
            else
                result = GetShortRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_INT_IRI) == type_size + 1 && strncmp(XSD_INT_IRI, type_data, type_size) == 0)
        {
            int32 val = int_parse(data, size);
            char buffer[INT_MAXLEN];

            if(int_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetIntRdfBox(val);
            else
                result = GetIntRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_LONG_IRI) == type_size + 1 && strncmp(XSD_LONG_IRI, type_data, type_size) == 0)
        {
            int64 val = long_parse(data, size);
            char buffer[LONG_MAXLEN];

            if(long_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetLongRdfBox(val);
            else
                result = GetLongRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_FLOAT_IRI) == type_size + 1 && strncmp(XSD_FLOAT_IRI, type_data, type_size) == 0)
        {
            float4 val = float_parse(data, size);
            char buffer[FLOAT_MAXLEN];

            if(float_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetFloatRdfBox(val);
            else
                result = GetFloatRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DOUBLE_IRI) == type_size + 1 && strncmp(XSD_DOUBLE_IRI, type_data, type_size) == 0)
        {
            float8 val = double_parse(data, size);
            char buffer[DOUBLE_MAXLEN];

            if(double_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetDoubleRdfBox(val);
            else
                result = GetDoubleRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_INTEGER_IRI) == type_size + 1 && strncmp(XSD_INTEGER_IRI, type_data, type_size) == 0)
        {
            Numeric val = integer_parse(data, size);

            if(varchar_equals(value, integer_as_varchar(val)))
                result = GetIntegerRdfBox(val);
            else
                result = GetIntegerRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DECIMAL_IRI) == type_size + 1 && strncmp(XSD_DECIMAL_IRI, type_data, type_size) == 0)
        {
            Numeric val = decimal_parse(data, size);

            if(varchar_equals(value, decimal_as_varchar(val)))
                result = GetDecimalRdfBox(val);
            else
                result = GetDecimalRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DATETIME_IRI) == type_size + 1 && strncmp(XSD_DATETIME_IRI, type_data, type_size) == 0)
        {
            ZonedDateTime *val = datetime_parse(data, size);
            char buffer[DATETIME_MAXLEN];

            if(datetime_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetDateTimeRdfBox(val);
            else
                result = GetDateTimeRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DATE_IRI) == type_size + 1 && strncmp(XSD_DATE_IRI, type_data, type_size) == 0)
        {
            ZonedDate val = date_parse(data, size);
            char buffer[DATE_MAXLEN];

            if(date_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetDateRdfBox(val);
            else
                result = GetDateRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_DAYTIMEDURATION_IRI) == type_size + 1 && strncmp(XSD_DAYTIMEDURATION_IRI, type_data, type_size) == 0)
        {
            int64 val = daytimeduration_parse(data, size);
            char buffer[DAYTIMEDURATION_MAXLEN];

            if(daytimeduration_print(val, buffer) == size && !memcmp(data, buffer, size))
                result = GetDayTimeDurationRdfBox(val);
            else
                result = GetDayTimeDurationRdfBoxWithLexical(val, data, size);
        }
        else if(sizeof(XSD_STRING_IRI) == type_size + 1 && strncmp(XSD_STRING_IRI, type_data, type_size) == 0)
        {
            result = GetStringRdfBox(data, size);
        }
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE && sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        result = GetTypedLiteralRdfBox(data, size, type_data, type_size);
    }
    PG_END_TRY_EX();

    if(result == NULL)
    {
        if(!check_iri(type_data, type_size))
            PG_RETURN_NULL();

        result = GetTypedLiteralRdfBox(data, size, type_data, type_size);
    }

    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(strlang_string);
Datum strlang_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *lang = PG_GETARG_VARCHAR_PP(1);

    if(!check_language_tag(VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)))
        PG_RETURN_NULL();

    Datum lcase_lang = CStringGetTextDatum(asc_tolower(VARDATA_ANY(lang), VARSIZE_ANY_EXHDR(lang)));
    PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), VARDATA_ANY(lcase_lang), VARSIZE_ANY_EXHDR(lcase_lang)));
}
