/**
 * @file
 * The SPARQL functions REGEX and REPLACE, evaluated by PCRE2.
 *
 * The pattern is compiled for each call in the UTF mode of PCRE2, so it is read in the syntax of PCRE2 rather than
 * in that of XPath regular expressions; the replacement string of REPLACE, on the other hand, is read in the syntax
 * of fn:replace and translated into the substitution syntax of PCRE2.
 * PCRE2 allocates its memory by palloc() in the current memory context.
 *
 * @see https://www.w3.org/TR/sparql12-query/#func-regex
 * @see https://www.w3.org/TR/sparql12-query/#func-replace
 */
#include <postgres.h>
#include <fmgr.h>
#include <pcre2.h>
#include <lib/stringinfo.h>
#include <utils/datum.h>
#include <utils/memutils.h>
#include "call.h"
#include "rdfbox/rdfbox.h"


/*
 * The constants live in TopMemoryContext for as long as the backend does and
 * are never freed as PostgreSQL never unloads a loadable module.
 */
static pcre2_general_context *general_context = NULL;   /**< the general context of PCRE2, NULL before its first use */
static pcre2_compile_context *compile_context = NULL;   /**< the compile context of PCRE2, NULL before its first use */
static pcre2_match_context *match_context = NULL;       /**< the match context of PCRE2, NULL before its first use */


/**
 * Allocates memory for PCRE2 in the current memory context.
 *
 * @param size the number of bytes
 * @param data the memory data of the general context, unused
 * @return the memory, NULL if it cannot be allocated, as PCRE2 expects instead of an error
 */
static void *pcre2_malloc(PCRE2_SIZE size, void *data)
{
    return palloc_extended(size, MCXT_ALLOC_NO_OOM);
}


/**
 * Frees memory allocated by pcre2_malloc().
 *
 * @param ptr the memory, or NULL
 * @param data the memory data of the general context, unused
 */
static void pcre2_free(void *ptr, void *data)
{
    if(ptr != NULL)
        pfree(ptr);
}


/**
 * Returns the general context of PCRE2, which makes PCRE2 allocate by pcre2_malloc() and pcre2_free(); it is created
 * in TopMemoryContext on the first call.
 *
 * @return the general context; a failure to create it raises an error
 */
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


/**
 * Returns the compile context of PCRE2, created in TopMemoryContext on the first call.
 *
 * @return the compile context; a failure to create it raises an error
 */
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


/**
 * Returns the match context of PCRE2, created in TopMemoryContext on the first call.
 *
 * @return the match context; a failure to create it raises an error
 */
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

/**
 * Translates the flags of a regular expression into the options of PCRE2: `s` into PCRE2_DOTALL, `m` into
 * PCRE2_MULTILINE, `i` into PCRE2_CASELESS, `x` into PCRE2_EXTENDED and `q` into PCRE2_LITERAL, with which only the
 * flag `i` stays in effect, as XPath has it.
 *
 * @param flags the flags
 * @param options receives the options, which always include PCRE2_UTF
 * @return false if the flags contain an unknown character
 */
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
        *options &= (PCRE2_LITERAL | PCRE2_CASELESS | PCRE2_UTF);

    return true;
}


/**
 * The SPARQL function REGEX of a simple literal.
 *
 * @param fcinfo the varchar text, the varchar pattern and the varchar flags, empty by default
 * @return true if the pattern matches a part of the text; NULL if the flags are invalid, the pattern does not
 *         compile or the matching fails, for example on a limit of PCRE2
 */
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


/**
 * The SPARQL function REGEX of an RDF term.
 *
 * @param fcinfo the rdfbox text, the varchar pattern and the varchar flags, empty by default
 * @return true if the pattern matches a part of the text; NULL if the text is not a string literal, the flags are
 *         invalid, the pattern does not compile or the matching fails
 */
PG_FUNCTION_INFO_V1(regex_rdfbox);
Datum regex_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_PP(1);
    VarChar *flags = PG_GETARG_VARCHAR_PP(2);

    bool result;
    bool isnull = true;
    uint32_t options;

    if(parse_flags(flags, &options) && rdfbox_is_string_literal(box))
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


/**
 * Translates a replacement string of the XPath function fn:replace, by which SPARQL defines REPLACE, into the
 * substitution syntax of PCRE2.
 *
 * In the replacement, `$` followed by digits refers to a capture group: the digits are read as a number N, `$0`
 * stands for the whole match, an N between 1 and the number of groups for that group (empty if it did not take part
 * in the match), a greater N of at most 9 for the empty string, and otherwise the last digit is a literal character
 * and the rest is read again. `\$` is a literal `$` and `\\` a literal `\`; any other `\` or `$` is an error. With
 * the flag `q`, the whole replacement is literal.
 *
 * @param replacement the replacement in the syntax of fn:replace
 * @param size the length of the replacement in bytes
 * @param groups the number of capture groups of the pattern
 * @param literal whether the replacement is literal, as the flag `q` makes it
 * @param result receives the translated replacement, a group written as `${N}` and a literal `$` as `$$`, so that
 *               the digits following a group are not taken for a part of its number
 * @return false if the replacement is invalid: a `\` not followed by `\` or `$`, or a `$` not followed by a digit
 */
static bool translate_replacement(const char *replacement, size_t size, uint32_t groups, bool literal, StringInfo result)
{
    for(size_t i = 0; i < size; i++)
    {
        char c = replacement[i];

        if(literal)
        {
            appendStringInfoChar(result, c);

            if(c == '$')
                appendStringInfoChar(result, '$');
        }
        else if(c == '\\')
        {
            if(i + 1 < size && replacement[i + 1] == '\\')
                appendStringInfoChar(result, '\\');
            else if(i + 1 < size && replacement[i + 1] == '$')
                appendStringInfoString(result, "$$");
            else
                return false;

            i++;
        }
        else if(c == '$')
        {
            size_t start = i + 1;
            size_t end = start;

            while(end < size && replacement[end] >= '0' && replacement[end] <= '9')
                end++;

            if(end == start)
                return false;

            /*
             * As long as the number names no group and is greater than nine, its last digit is a literal character
             * and the rest is read again; the number saturates far above any count of groups, so that a long run of
             * digits cannot overflow it.
             */
            size_t count = end - start;
            uint32_t number;

            for(;;)
            {
                number = 0;

                for(size_t j = 0; j < count; j++)
                    number = Min(number * 10 + (replacement[start + j] - '0'), (uint32_t) 1000000);

                if(number <= 9 || number <= groups)
                    break;

                count--;
            }

            if(number <= groups)
                appendStringInfo(result, "${%u}", number);

            appendBinaryStringInfo(result, replacement + start + count, end - start - count);
            i = end - 1;
        }
        else
        {
            appendStringInfoChar(result, c);
        }
    }

    return true;
}


/**
 * Replaces every match of a pattern in a text by a replacement, the SPARQL function REPLACE behind replace_string()
 * and replace_rdfbox().
 *
 * @param text the text in UTF-8
 * @param size the length of the text in bytes
 * @param pattern the pattern, in the syntax of PCRE2
 * @param replacement the replacement, in the syntax of fn:replace (see translate_replacement())
 * @param flags the flags (see parse_flags())
 * @return the palloc'd result; NULL if the flags are invalid, the pattern does not compile or matches the empty
 *         string, which fn:replace takes for an error, the replacement is invalid or the substitution fails
 */
static VarChar *replace(const char *text, size_t size, VarChar *pattern, VarChar *replacement, VarChar *flags)
{
    uint32_t options;

    if(!parse_flags(flags, &options))
        return NULL;

    int errornumber;
    PCRE2_SIZE erroroffset;
    pcre2_code *re = pcre2_compile((unsigned char *) VARDATA_ANY(pattern), VARSIZE_ANY_EXHDR(pattern), options, &errornumber, &erroroffset, get_compile_context());

    if(re == NULL)
        return NULL;

    VarChar *result = NULL;
    pcre2_match_data *match_data = pcre2_match_data_create(1, get_general_context());

    if(match_data != NULL)
    {
        int rc = pcre2_match(re, (const unsigned char *) "", 0, 0, 0, match_data, get_match_context());
        uint32_t groups;

        if(rc == PCRE2_ERROR_NOMATCH && pcre2_pattern_info(re, PCRE2_INFO_CAPTURECOUNT, &groups) == 0)
        {
            StringInfoData translated;
            initStringInfo(&translated);

            if(translate_replacement(VARDATA_ANY(replacement), VARSIZE_ANY_EXHDR(replacement), groups, (options & PCRE2_LITERAL) != 0, &translated))
            {
                uint32_t suboptions = PCRE2_SUBSTITUTE_GLOBAL | PCRE2_SUBSTITUTE_UNSET_EMPTY;
                PCRE2_SIZE length = 4 * 1024 - VARHDRSZ;
                result = palloc(VARHDRSZ + length);

                rc = pcre2_substitute(re, (const unsigned char *) text, size, 0, suboptions | PCRE2_SUBSTITUTE_OVERFLOW_LENGTH, NULL, get_match_context(), (const unsigned char *) translated.data, translated.len, (unsigned char *) VARDATA(result), &length);

                if(rc == PCRE2_ERROR_NOMEMORY)
                {
                    result = repalloc(result, VARHDRSZ + length);
                    rc = pcre2_substitute(re, (const unsigned char *) text, size, 0, suboptions, NULL, get_match_context(), (const unsigned char *) translated.data, translated.len, (unsigned char *) VARDATA(result), &length);
                }

                if(rc < 0)
                {
                    pfree(result);
                    result = NULL;
                }
                else
                {
                    SET_VARSIZE(result, VARHDRSZ + length);
                }
            }

            pfree(translated.data);
        }

        pcre2_match_data_free(match_data);
    }

    pcre2_code_free(re);

    return result;
}


/**
 * The SPARQL function REPLACE of a simple literal: replaces every match of the pattern by the replacement, which is
 * read in the syntax of fn:replace (see translate_replacement()).
 *
 * @param fcinfo the varchar text, the varchar pattern, the varchar replacement and the varchar flags, empty by
 *               default
 * @return the varchar result; NULL if the flags are invalid, the pattern does not compile or matches the empty
 *         string, the replacement is invalid or the substitution fails
 */
PG_FUNCTION_INFO_V1(replace_string);
Datum replace_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *pattern = PG_GETARG_VARCHAR_PP(1);
    VarChar *replacement = PG_GETARG_VARCHAR_PP(2);
    VarChar *flags = PG_GETARG_VARCHAR_PP(3);

    VarChar *result = replace(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), pattern, replacement, flags);

    if(result == NULL)
        PG_RETURN_NULL();

    PG_RETURN_VARCHAR_P(result);
}


/**
 * The SPARQL function REPLACE of an RDF term, see replace_string().
 *
 * @param fcinfo the rdfbox text, the varchar pattern, the varchar replacement and the varchar flags, empty by
 *               default
 * @return the rdfbox result, a string literal of the same kind as the text; NULL if the text is not a string
 *         literal or if replace_string() would give NULL
 */
PG_FUNCTION_INFO_V1(replace_rdfbox);
Datum replace_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_PP(1);
    VarChar *replacement = PG_GETARG_VARCHAR_PP(2);
    VarChar *flags = PG_GETARG_VARCHAR_PP(3);

    if(!rdfbox_is_string_literal(box))
        PG_RETURN_NULL();

    VarChar *value = RdfBoxGetVarChar(box);
    VarChar *result = replace(VARDATA(value), VARSIZE(value) - VARHDRSZ, pattern, replacement, flags);

    if(result == NULL)
        PG_RETURN_NULL();

    PG_RETURN_RDFBOX_P(GetDerivedStringLiteralRdfBox(box, VARDATA(result), VARSIZE(result) - VARHDRSZ));
}
