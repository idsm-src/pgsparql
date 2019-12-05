#include <postgres.h>
#include <fmgr.h>
#include <utils/memutils.h>
#include "rdfbox.h"

#define PCRE2_CODE_UNIT_WIDTH 8
#include <pcre2.h>


static pcre2_general_context *generalContext = NULL;
static pcre2_compile_context *compileContext = NULL;
static pcre2_match_context *matchContext = NULL;


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
    if(generalContext == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        generalContext = pcre2_general_context_create(pcre2_malloc, pcre2_free, NULL);
        MemoryContextSwitchTo(old);

        if(generalContext == NULL)
            elog(ERROR, "cannot create pcre2 general context");
    }

    return generalContext;
}


static pcre2_compile_context *get_compile_context()
{
    if(compileContext == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        compileContext = pcre2_compile_context_create(get_general_context());
        MemoryContextSwitchTo(old);

        if(compileContext == NULL)
            elog(ERROR, "cannot create pcre2 compile context");
    }

    return compileContext;
}


static pcre2_match_context *get_match_context()
{
    if(matchContext == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        matchContext = pcre2_match_context_create(get_general_context());
        MemoryContextSwitchTo(old);

        if(matchContext == NULL)
            elog(ERROR, "cannot create pcre2 match context");
    }

    return matchContext;
}


static __attribute__((destructor)) void destroy_contexts()
{
    if(matchContext != NULL)
        pcre2_match_context_free(matchContext);

    if(compileContext != NULL)
        pcre2_compile_context_free(compileContext);

    if(generalContext != NULL)
        pcre2_general_context_free(generalContext);
}


static bool parse_flags(VarChar *flags, uint32_t *options)
{
    char *data = VARDATA(flags);
    *options = PCRE2_UTF;

    for(int i = 0; i < VARSIZE(flags) - VARHDRSZ; i++)
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
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_P(1);
    VarChar *flags = PG_GETARG_VARCHAR_P(2);

    bool result;
    bool isNull = true;
    uint32_t options;

    if(parse_flags(flags, &options))
    {
        int errornumber;
        PCRE2_SIZE erroroffset;
        pcre2_code *re = pcre2_compile(VARDATA(pattern), VARSIZE(pattern) - VARHDRSZ, options, &errornumber, &erroroffset, get_compile_context());

        if(re != NULL)
        {
            pcre2_match_data *matchData = pcre2_match_data_create_from_pattern(re, get_general_context());

            if(matchData != NULL)
            {
                int rc = pcre2_match(re, VARDATA(value), VARSIZE(value) - VARHDRSZ, 0, 0, matchData, get_match_context());

                result = rc > 0;
                isNull = rc < 0 && rc != PCRE2_ERROR_NOMATCH;

                pcre2_match_data_free(matchData);
            }

            pcre2_code_free(re);
        }
    }

    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(pattern, 1);
    PG_FREE_IF_COPY(flags, 2);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(regex_rdfbox);
Datum regex_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_P(1);
    VarChar *flags = PG_GETARG_VARCHAR_P(2);

    bool result;
    bool isNull = true;
    uint32_t options;

    if(parse_flags(flags, &options) && (box->type == XSD_STRING || box->type == RDF_LANGSTRING))
    {
        int errornumber;
        PCRE2_SIZE erroroffset;
        pcre2_code *re = pcre2_compile(VARDATA(pattern), VARSIZE(pattern) - VARHDRSZ, options, &errornumber, &erroroffset, get_compile_context());

        if(re != NULL)
        {
            pcre2_match_data *matchData = pcre2_match_data_create_from_pattern(re, get_general_context());

            if(matchData != NULL)
            {
                VarChar *value = (VarChar *) (box->type == XSD_STRING ? ((RdfBoxString *) box)->value : ((RdfBoxLangString *) box)->value);
                int rc = pcre2_match(re, VARDATA(value), VARSIZE(value) - VARHDRSZ, 0, 0, matchData, get_match_context());

                result = rc > 0;
                isNull = rc < 0 && rc != PCRE2_ERROR_NOMATCH;

                pcre2_match_data_free(matchData);
            }

            pcre2_code_free(re);
        }
    }

    PG_FREE_IF_COPY(box, 0);
    PG_FREE_IF_COPY(pattern, 1);
    PG_FREE_IF_COPY(flags, 2);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(replace_string);
Datum replace_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_P(1);
    VarChar *replacement = PG_GETARG_VARCHAR_P(2);
    VarChar *flags = PG_GETARG_VARCHAR_P(3);

    VarChar *result = NULL;
    bool isNull = true;
    uint32_t options;

    if(parse_flags(flags, &options))
    {
        int errornumber;
        PCRE2_SIZE erroroffset;
        pcre2_code *re = pcre2_compile(VARDATA(pattern), VARSIZE(pattern) - VARHDRSZ, options, &errornumber, &erroroffset, get_compile_context());

        if(re != NULL)
        {
            uint32_t options = PCRE2_SUBSTITUTE_GLOBAL | PCRE2_SUBSTITUTE_UNSET_EMPTY;
            PCRE2_SIZE size = (4 * 1024 - VARHDRSZ);
            result = palloc(size + VARHDRSZ);

            int rc = pcre2_substitute(re, VARDATA(value), VARSIZE(value) - VARHDRSZ,  0, options | PCRE2_SUBSTITUTE_OVERFLOW_LENGTH,
                    NULL, get_match_context(), VARDATA(replacement), VARSIZE(replacement) - VARHDRSZ, VARDATA(result), &size);

            if(rc == PCRE2_ERROR_NOMEMORY)
            {
                pfree(result);
                result = palloc(size + VARHDRSZ);

                rc = pcre2_substitute(re, VARDATA(value), VARSIZE(value) - VARHDRSZ,  0, options,
                        NULL, get_match_context(), VARDATA(replacement), VARSIZE(replacement) - VARHDRSZ, VARDATA(result), &size);
            }

            SET_VARSIZE(result, size + VARHDRSZ);
            isNull = rc < 0;

            if(isNull)
                pfree(result);

            pcre2_code_free(re);
        }
    }

    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(pattern, 1);
    PG_FREE_IF_COPY(replacement, 2);
    PG_FREE_IF_COPY(flags, 3);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_POINTER(result);
}


PG_FUNCTION_INFO_V1(replace_rdfbox);
Datum replace_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_P(1);
    VarChar *replacement = PG_GETARG_VARCHAR_P(2);
    VarChar *flags = PG_GETARG_VARCHAR_P(3);

    RdfBox *result = NULL;
    bool isNull = true;
    uint32_t options;

    if(parse_flags(flags, &options) && (box->type == XSD_STRING || box->type == RDF_LANGSTRING))
    {
        int errornumber;
        PCRE2_SIZE erroroffset;
        pcre2_code *re = pcre2_compile(VARDATA(pattern), VARSIZE(pattern) - VARHDRSZ, options, &errornumber, &erroroffset, get_compile_context());

        if(re != NULL)
        {
            VarChar *value = NULL;
            size_t headerSize = 0;
            size_t langSize = 0;

            if(box->type == RDF_LANGSTRING)
            {
                value = (VarChar *) ((RdfBoxLangString *) box)->value;
                headerSize = sizeof(RdfBoxLangString);
                langSize = VARSIZE(((RdfBoxLangString *) box)->value + VARSIZE(value));
            }
            else
            {
                value = (VarChar *) ((RdfBoxString *) box)->value;
                headerSize = sizeof(RdfBoxString);
            }

            uint32_t options = PCRE2_SUBSTITUTE_GLOBAL | PCRE2_SUBSTITUTE_UNSET_EMPTY;
            PCRE2_SIZE size = 4 * 1024 - headerSize - VARHDRSZ - langSize;
            result = palloc(headerSize + VARHDRSZ + size + langSize);

            int rc = pcre2_substitute(re, VARDATA(value), VARSIZE(value) - VARHDRSZ,  0, options | PCRE2_SUBSTITUTE_OVERFLOW_LENGTH,
                    NULL, get_match_context(), VARDATA(replacement), VARSIZE(replacement) - VARHDRSZ, VARDATA(((char *) result) + headerSize), &size);

            if(rc == PCRE2_ERROR_NOMEMORY)
            {
                pfree(result);
                result = palloc(headerSize + VARHDRSZ + size + langSize);

                rc = pcre2_substitute(re, VARDATA(value), VARSIZE(value) - VARHDRSZ,  0, options,
                        NULL, get_match_context(), VARDATA(replacement), VARSIZE(replacement) - VARHDRSZ, VARDATA(((char *) result) + headerSize), &size);
            }

            result->type = box->type;
            SET_VARSIZE(result, headerSize + VARHDRSZ + size + langSize);
            SET_VARSIZE(((char *) result) + headerSize, VARHDRSZ + size);

            if(box->type == RDF_LANGSTRING)
                memcpy(((char *) result) + headerSize + VARHDRSZ + size, ((RdfBoxLangString *) box)->value + VARSIZE(value), langSize);

            isNull = rc < 0;

            if(isNull)
                pfree(result);

            pcre2_code_free(re);
        }
    }

    PG_FREE_IF_COPY(box, 0);
    PG_FREE_IF_COPY(pattern, 1);
    PG_FREE_IF_COPY(replacement, 2);
    PG_FREE_IF_COPY(flags, 3);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_POINTER(result);
}
