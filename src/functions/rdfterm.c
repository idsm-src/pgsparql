#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "cast/cast.h"
#include "call.h"
#include "rdfbox.h"
#include "xsd.h"


static const char *rdfbox_types[] = {
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
        "http://www.w3.org/1999/02/22-rdf-syntax-ns#langString" };


PG_FUNCTION_INFO_V1(is_iri_rdfbox);
Datum is_iri_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = box->type == IRI;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(is_blank_rdfbox);
Datum is_blank_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = box->type == BLANKNODE_INT || box->type == BLANKNODE_STR;
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(is_literal_rdfbox);
Datum is_literal_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_literal(box);
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(is_numeric_rdfbox);
Datum is_numeric_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    bool result = rdfbox_is_numeric(box);
    PG_FREE_IF_COPY(box, 0);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(str_rdfbox);
Datum str_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isNull = false };

    switch(box->type)
    {
        case XSD_BOOLEAN:
            result = NullableFunctionCall1(cast_as_string_from_boolean, BoolGetDatum(((RdfBoxBoolean *) box)->value));
            break;

        case XSD_SHORT:
            result = NullableFunctionCall1(cast_as_string_from_short, Int16GetDatum(((RdfBoxShort *) box)->value));
            break;

        case XSD_INT:
            result = NullableFunctionCall1(cast_as_string_from_int, Int32GetDatum(((RdfBoxInt *) box)->value));
            break;

        case XSD_LONG:
            result = NullableFunctionCall1(cast_as_string_from_long, Int64GetDatum(((RdfBoxLong *) box)->value));
            break;

        case XSD_FLOAT:
            result = NullableFunctionCall1(cast_as_string_from_float, Float4GetDatum(((RdfBoxFloat *) box)->value));
            break;

        case XSD_DOUBLE:
            result = NullableFunctionCall1(cast_as_string_from_double, Float8GetDatum(((RdfBoxDouble *) box)->value));
            break;

        case XSD_INTEGER:
        case XSD_DECIMAL:
            result = NullableFunctionCall1(cast_as_string_from_decimal, NumericGetDatum(((RdfBoxDecinal *) box)->value));
            break;

        case XSD_DATETIME:
            result = NullableFunctionCall1(cast_as_string_from_datetime, ZonedDateTimeGetDatum(&((RdfBoxDateTime *) box)->value));
            break;

        case XSD_DATE:
            result = NullableFunctionCall1(cast_as_string_from_date, ZonedDateGetDatum(((RdfBoxDate *) box)->value));
            break;

        case XSD_DAYTIMEDURATION:
            result = NullableFunctionCall1(cast_as_string_from_daytimeduration, Int64GetDatum(((RdfBoxDayTimeDuration *) box)->value));
            break;

        case XSD_STRING:
        {
            VarChar *value = (VarChar *) ((RdfBoxString *) box)->value;
            size_t length = VARSIZE(value);

            VarChar *copy = palloc(length);
            memcpy(copy, value, length);
            result.datum = PointerGetDatum(copy);
            break;
        }

        case RDF_LANGSTRING:
        {
            VarChar *value = (VarChar *) ((RdfBoxLangString *) box)->value;
            size_t length = VARSIZE(value);

            VarChar *copy = palloc(length);
            memcpy(copy, value, length);
            result.datum = PointerGetDatum(copy);
            break;
        }

        case TYPED_LITERAL:
        {
            VarChar *value = (VarChar *) ((RdfBoxTypedLiteral *) box)->value;
            size_t length = VARSIZE(value);

            VarChar *copy = palloc(length);
            memcpy(copy, value, length);
            result.datum = PointerGetDatum(copy);
            break;
        }

        case IRI:
        {
            VarChar *value = (VarChar *) ((RdfBoxIri *) box)->value;
            size_t length = VARSIZE(value);

            VarChar *copy = palloc(length);
            memcpy(copy, value, length);
            result.datum = PointerGetDatum(copy);
            break;
        }

        default:
            result.isNull = true;
            break;
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(lang_rdfbox);
Datum lang_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    Datum result;
    bool isNull = false;

    if(box->type == RDF_LANGSTRING)
    {
        VarChar *value = (VarChar *) ((RdfBoxLangString *) box)->value;
        VarChar *lang = (VarChar *) (((RdfBoxLangString *) box)->value + VARSIZE(value));

        VarChar *copy = palloc(VARSIZE(lang));
        memcpy(copy, lang, VARSIZE(lang));

        result = PointerGetDatum(copy);
    }
    else if(rdfbox_is_literal(box))
    {
        VarChar *copy = palloc(VARHDRSZ);
        SET_VARSIZE(copy, VARHDRSZ);
        result = PointerGetDatum(copy);
    }
    else
    {
        isNull = true;
    }

    PG_FREE_IF_COPY(box, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(datatype_rdfbox);
Datum datatype_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    Datum result;
    bool isNull = false;

    if(box->type == TYPED_LITERAL)
    {
        VarChar *value = (VarChar *) ((RdfBoxTypedLiteral *) box)->value;
        VarChar *type = (VarChar *) (((RdfBoxTypedLiteral *) box)->value + VARSIZE(value));

        VarChar *copy = palloc(VARSIZE(type));
        memcpy(copy, type, VARSIZE(type));

        result = PointerGetDatum(copy);
    }
    else if(rdfbox_is_literal(box))
    {
        result = PointerGetDatum(cstring_to_text(rdfbox_types[box->type]));
    }
    else
    {
        isNull = true;
    }

    PG_FREE_IF_COPY(box, 0);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


typedef struct
{
    char *scheme;
    char *authority;
    char *path;
    char *query;
    char *fragment;
} IriComponents;


static void iri_free(IriComponents *iri)
{
    if(iri->scheme != NULL)
        pfree(iri->scheme);

    if(iri->authority != NULL)
        pfree(iri->authority);

    if(iri->path != NULL)
        pfree(iri->path);

    if(iri->query != NULL)
        pfree(iri->query);

    if(iri->fragment != NULL)
        pfree(iri->fragment);
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

    pfree(data);
    return result;
}


PG_FUNCTION_INFO_V1(iri_string);
Datum iri_string(PG_FUNCTION_ARGS)
{
    text *baseArg = PG_GETARG_TEXT_P(0);
    text *iriArg = PG_GETARG_TEXT_P(1);

    char *baseString = text_to_cstring(baseArg);
    char *iriString = text_to_cstring(iriArg);

    IriComponents base = iri_parse(baseString);
    IriComponents iri = iri_parse(iriString);
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
                    pfree(path);
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

    char *absolute =  psprintf("%s%s%s%s%s", result.scheme, result.authority, result.path, result.query, result.fragment);
    Datum datum = PointerGetDatum(cstring_to_text(absolute));


    iri_free(&base);
    iri_free(&iri);
    pfree(baseString);
    pfree(iriString);
    pfree(result.path);
    pfree(absolute);
    PG_FREE_IF_COPY(baseArg, 0);
    PG_FREE_IF_COPY(iriArg, 1);

    PG_RETURN_DATUM(datum);
}


PG_FUNCTION_INFO_V1(iri_rdfbox);
Datum iri_rdfbox(PG_FUNCTION_ARGS)
{
    text *base = PG_GETARG_TEXT_P(0);
    RdfBox *box = PG_GETARG_RDFBOX_P(1);

    bool isNull = false;
    Datum result;

    switch(box->type)
    {
        case XSD_STRING:
        {
            VarChar *value = (VarChar *) ((RdfBoxString *) box)->value;
            result = DirectFunctionCall2(iri_string, PointerGetDatum(base), PointerGetDatum(value));
            break;
        }

        case IRI:
        {
            VarChar *value = (VarChar *) ((RdfBoxIri *) box)->value;
            size_t length = VARSIZE(value);

            VarChar *copy = palloc(length);
            memcpy(copy, value, length);
            result = PointerGetDatum(copy);
            break;
        }

        default:
            isNull = true;
    }

    PG_FREE_IF_COPY(base, 0);
    PG_FREE_IF_COPY(box, 1);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(bnode);
Datum bnode(PG_FUNCTION_ARGS)
{
    static int32 bnode_id = 0;
    PG_RETURN_INT32(bnode_id++);
}
