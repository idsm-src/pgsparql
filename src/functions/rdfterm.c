#include <postgres.h>
#include <pcre2.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <utils/formatting.h>
#include "call.h"
#include "cast/cast.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/syntax.h"
#include "rdfbox/xsd.h"


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


PG_FUNCTION_INFO_V1(str_rdfbox);
Datum str_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    switch(box->type)
    {
        case XSD_BOOLEAN:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_boolean, BoolGetDatum(RdfBoxGetBool(box))));

        case XSD_SHORT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_short, Int16GetDatum(RdfBoxGetInt16(box))));

        case XSD_INT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_int, Int32GetDatum(RdfBoxGetInt32(box))));

        case XSD_LONG:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_long, Int64GetDatum(RdfBoxGetInt64(box))));

        case XSD_INTEGER:
        case XSD_DECIMAL:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_decimal, NumericGetDatum(RdfBoxGetNumeric(box))));

        case XSD_FLOAT:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_float, Float4GetDatum(RdfBoxGetFloat4(box))));

        case XSD_DOUBLE:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_double, Float8GetDatum(RdfBoxGetFloat8(box))));

        case XSD_DATETIME:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_datetime, ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box))));

        case XSD_DATE:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_date, ZonedDateGetDatum(RdfBoxGetZonedDate(box))));

        case XSD_DAYTIMEDURATION:
            PG_RETURN(NullableFunctionCall1(cast_as_string_from_daytimeduration, Int64GetDatum(RdfBoxGetInt64(box))));

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

    char *type_data = VARDATA_ANY(type);
    int type_size = VARSIZE_ANY_EXHDR(type);

    RdfBox *result = NULL;

    if(sizeof(XSD_BOOLEAN_IRI) == type_size + 1 && strncmp(XSD_BOOLEAN_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_boolean_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetBooleanRdfBox(DatumGetBool(retval.value));
    }
    else if(sizeof(XSD_SHORT_IRI) == type_size + 1 && strncmp(XSD_SHORT_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_short_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetShortRdfBox(DatumGetInt16(retval.value));
    }
    else if(sizeof(XSD_INT_IRI) == type_size + 1 && strncmp(XSD_INT_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_int_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetIntRdfBox(DatumGetInt32(retval.value));
    }
    else if(sizeof(XSD_LONG_IRI) == type_size + 1 && strncmp(XSD_LONG_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_long_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetLongRdfBox(DatumGetInt64(retval.value));
    }
    else if(sizeof(XSD_FLOAT_IRI) == type_size + 1 && strncmp(XSD_FLOAT_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_float_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetFloatRdfBox(DatumGetFloat4(retval.value));
    }
    else if(sizeof(XSD_DOUBLE_IRI) == type_size + 1 && strncmp(XSD_DOUBLE_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_double_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetDoubleRdfBox(DatumGetFloat8(retval.value));
    }
    else if(sizeof(XSD_INTEGER_IRI) == type_size + 1 && strncmp(XSD_INTEGER_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_integer_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetIntegerRdfBox(DatumGetNumeric(retval.value));
    }
    else if(sizeof(XSD_DECIMAL_IRI) == type_size + 1 && strncmp(XSD_DECIMAL_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_decimal_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetDecimalRdfBox(DatumGetNumeric(retval.value));
    }
    else if(sizeof(XSD_DATETIME_IRI) == type_size + 1 && strncmp(XSD_DATETIME_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_datetime_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetDateTimeRdfBox(DatumGetZonedDateTime(retval.value));
    }
    else if(sizeof(XSD_DATE_IRI) == type_size + 1 && strncmp(XSD_DATE_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_date_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetDateRdfBox(DatumGetZonedDate(retval.value));
    }
    else if(sizeof(XSD_DAYTIMEDURATION_IRI) == type_size + 1 && strncmp(XSD_DAYTIMEDURATION_IRI, type_data, type_size) == 0)
    {
        NullableDatum retval = NullableFunctionCall1(cast_as_daytimeduration_from_string, PointerGetDatum(value));

        if(retval.isnull == false)
            result = GetDayTimeDurationRdfBox(DatumGetInt64(retval.value));
    }
    else if(sizeof(XSD_STRING_IRI) == type_size + 1 && strncmp(XSD_STRING_IRI, type_data, type_size) == 0)
    {
        result = GetStringRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value));
    }

    if(result == NULL)
    {
        if(!check_iri(type_data, type_size))
            PG_RETURN_NULL();

        result = GetTypedLiteralRdfBox(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), type_data, type_size);
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
