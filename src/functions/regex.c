#include <postgres.h>
#include <fmgr.h>
#include <pcre2.h>
#include <utils/datum.h>
#include <utils/memutils.h>
#include "call.h"
#include "rdfbox/rdfbox.h"


static pcre2_general_context *general_context = NULL;
static pcre2_compile_context *compile_context = NULL;
static pcre2_match_context *match_context = NULL;


static void *pcre2_malloc(PCRE2_SIZE size, void *data)
{
    return palloc_extended(size, MCXT_ALLOC_NO_OOM);
}


static void pcre2_free(void *ptr, void *data)
{
    if(ptr != NULL)
        pfree(ptr);
}


static pcre2_general_context *get_general_context()
{
    if(general_context == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        general_context = pcre2_general_context_create(pcre2_malloc, pcre2_free, NULL);
        MemoryContextSwitchTo(old);

        if(general_context == NULL)
            elog(ERROR, "cannot create pcre2 general context");
    }

    return general_context;
}


static pcre2_compile_context *get_compile_context()
{
    if(compile_context == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        compile_context = pcre2_compile_context_create(get_general_context());
        MemoryContextSwitchTo(old);

        if(compile_context == NULL)
            elog(ERROR, "cannot create pcre2 compile context");
    }

    return compile_context;
}


static pcre2_match_context *get_match_context()
{
    if(match_context == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        match_context = pcre2_match_context_create(get_general_context());
        MemoryContextSwitchTo(old);

        if(match_context == NULL)
            elog(ERROR, "cannot create pcre2 match context");
    }

    return match_context;
}


static __attribute__((destructor)) void destroy_contexts()
{
    if(match_context != NULL)
        pcre2_match_context_free(match_context);

    if(compile_context != NULL)
        pcre2_compile_context_free(compile_context);

    if(general_context != NULL)
        pcre2_general_context_free(general_context);
}


static bool parse_flags(VarChar *flags, uint32_t *options)
{
    char *data = VARDATA_ANY(flags);
    *options = PCRE2_UTF;

    for(int32 i = 0; i < VARSIZE_ANY_EXHDR(flags); i++)
    {
        switch(data[i])
        {
            case 's':
                *options |= PCRE2_DOTALL;
                break;

            case 'm':
                *options |= PCRE2_MULTILINE;
                break;

            case 'i':
                *options |= PCRE2_CASELESS;
                break;

            case 'x':
                *options |= PCRE2_EXTENDED;
                break;

            case 'q':
                *options |= PCRE2_LITERAL;
                break;

            default:
                return false;
        }
    }

    if(*options & PCRE2_LITERAL)
            *options &= (PCRE2_LITERAL | PCRE2_CASELESS);

    return true;
}


PG_FUNCTION_INFO_V1(regex_string);
Datum regex_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *pattern = PG_GETARG_VARCHAR_PP(1);
    VarChar *flags = PG_GETARG_VARCHAR_PP(2);

    bool result;
    bool isnull = true;
    uint32_t options;

    if(parse_flags(flags, &options))
    {
        int errornumber;
        PCRE2_SIZE erroroffset;
        pcre2_code *re = pcre2_compile((unsigned char *) VARDATA_ANY(pattern), VARSIZE_ANY_EXHDR(pattern), options, &errornumber, &erroroffset, get_compile_context());

        if(re != NULL)
        {
            pcre2_match_data *match_data = pcre2_match_data_create_from_pattern(re, get_general_context());

            if(match_data != NULL)
            {
                int rc = pcre2_match(re, (unsigned char *) VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), 0, 0, match_data, get_match_context());

                result = rc > 0;
                isnull = rc < 0 && rc != PCRE2_ERROR_NOMATCH;

                pcre2_match_data_free(match_data);
            }

            pcre2_code_free(re);
        }
    }

    if(isnull)
        PG_RETURN_NULL();

    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(regex_rdfbox);
Datum regex_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_PP(1);
    VarChar *flags = PG_GETARG_VARCHAR_PP(2);

    bool result;
    bool isnull = true;
    uint32_t options;

    if(parse_flags(flags, &options) && (box->type == XSD_STRING || box->type == RDF_LANGSTRING))
    {
        int errornumber;
        PCRE2_SIZE erroroffset;
        pcre2_code *re = pcre2_compile((unsigned char *) VARDATA_ANY(pattern), VARSIZE_ANY_EXHDR(pattern), options, &errornumber, &erroroffset, get_compile_context());

        if(re != NULL)
        {
            pcre2_match_data *match_data = pcre2_match_data_create_from_pattern(re, get_general_context());

            if(match_data != NULL)
            {
                VarChar *value = RdfBoxGetVarChar(box);
                int rc = pcre2_match(re, (unsigned char *) VARDATA(value), VARSIZE(value) - VARHDRSZ, 0, 0, match_data, get_match_context());

                result = rc > 0;
                isnull = rc < 0 && rc != PCRE2_ERROR_NOMATCH;

                pcre2_match_data_free(match_data);
            }

            pcre2_code_free(re);
        }
    }

    if(isnull)
        PG_RETURN_NULL();

    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(replace_string);
Datum replace_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *pattern = PG_GETARG_VARCHAR_PP(1);
    VarChar *replacement = PG_GETARG_VARCHAR_PP(2);
    VarChar *flags = PG_GETARG_VARCHAR_PP(3);

    VarChar *result = NULL;
    bool isnull = true;
    uint32_t options;

    if(parse_flags(flags, &options))
    {
        int errornumber;
        PCRE2_SIZE erroroffset;
        pcre2_code *re = pcre2_compile((unsigned char *) VARDATA_ANY(pattern), VARSIZE_ANY_EXHDR(pattern), options, &errornumber, &erroroffset, get_compile_context());

        if(re != NULL)
        {
            uint32_t options = PCRE2_SUBSTITUTE_GLOBAL | PCRE2_SUBSTITUTE_UNSET_EMPTY;
            PCRE2_SIZE size = (4 * 1024 - VARHDRSZ);
            result = palloc(size + VARHDRSZ);

            int rc = pcre2_substitute(re, (unsigned char *) VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value),  0, options | PCRE2_SUBSTITUTE_OVERFLOW_LENGTH,
                    NULL, get_match_context(), (unsigned char *) VARDATA_ANY(replacement), VARSIZE_ANY_EXHDR(replacement), (unsigned char *) VARDATA(result), &size);

            if(rc == PCRE2_ERROR_NOMEMORY)
            {
                result = palloc(size + VARHDRSZ);

                rc = pcre2_substitute(re, (unsigned char *) VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value),  0, options,
                        NULL, get_match_context(), (unsigned char *) VARDATA_ANY(replacement), VARSIZE_ANY_EXHDR(replacement), (unsigned char *) VARDATA(result), &size);
            }

            SET_VARSIZE(result, size + VARHDRSZ);
            isnull = rc < 0;

            pcre2_code_free(re);
        }
    }

    if(isnull)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(replace_rdfbox);
Datum replace_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_PP(1);
    VarChar *replacement = PG_GETARG_VARCHAR_PP(2);
    VarChar *flags = PG_GETARG_VARCHAR_PP(3);

    uint32_t options;

    if((box->type == XSD_STRING || box->type == RDF_LANGSTRING) && parse_flags(flags, &options))
    {
        int errornumber;
        PCRE2_SIZE erroroffset;
        pcre2_code *re = pcre2_compile((unsigned char *) VARDATA_ANY(pattern), VARSIZE_ANY_EXHDR(pattern), options, &errornumber, &erroroffset, get_compile_context());

        if(re != NULL)
        {
            VarChar *value = RdfBoxGetVarChar(box);

            uint32_t options = PCRE2_SUBSTITUTE_GLOBAL | PCRE2_SUBSTITUTE_UNSET_EMPTY;
            PCRE2_SIZE size = 4 * 1024;
            char *buffer = palloc(size);

            int rc = pcre2_substitute(re, (unsigned char *) VARDATA(value), VARSIZE(value) - VARHDRSZ,  0, options | PCRE2_SUBSTITUTE_OVERFLOW_LENGTH,
                    NULL, get_match_context(), (unsigned char *) VARDATA_ANY(replacement), VARSIZE_ANY_EXHDR(replacement), (unsigned char *) buffer, &size);

            if(rc == PCRE2_ERROR_NOMEMORY)
            {
                buffer = repalloc(buffer, size);

                rc = pcre2_substitute(re, (unsigned char *) VARDATA(value), VARSIZE(value) - VARHDRSZ,  0, options,
                        NULL, get_match_context(), (unsigned char *) VARDATA_ANY(replacement), VARSIZE_ANY_EXHDR(replacement), (unsigned char *) buffer, &size);
            }

            pcre2_code_free(re);

            if(rc < 0)
            {
                PG_RETURN_NULL();
            }
            else if(box->type != RDF_LANGSTRING)
            {
                PG_RETURN_RDFBOX_P(GetStringRdfBox(buffer, size));
            }
            else
            {
                VarChar *lang = RdfBoxGetAttachment(box);
                PG_RETURN_RDFBOX_P(GetLangStringRdfBox(buffer, size, VARDATA(lang), VARSIZE(lang) - VARHDRSZ));
            }
        }
    }

    PG_RETURN_NULL();
}
