/**
 * @file
 * The SPARQL functions REGEX and REPLACE, evaluated by PCRE2.
 *
 * The pattern is compiled in the UTF mode of PCRE2, so it is read in the syntax of PCRE2 rather than in that of XPath
 * regular expressions; the replacement string of REPLACE, on the other hand, is read in the syntax of fn:replace and
 * translated into the substitution syntax of PCRE2.
 *
 * A function in a filter is called once per row, nearly always with the same pattern, so the compiled patterns are
 * cached for the life of the backend (see #RegexCacheEntry): a pattern is compiled on its first use, compiled into
 * machine code by the JIT compiler of PCRE2 on its second use, when the compilation pays off, and dropped when the
 * cache grows past the size the setting `pgsparql.regex_cache_size` allows and the pattern is the least recently used
 * one. The cache lives in a memory context of its own under TopMemoryContext, in which PCRE2 allocates the compiled
 * patterns too; the match data of a call is allocated by PCRE2 in the current memory context instead, because the
 * heap frames of a match, which PCRE2 keeps in the match data, must be freed with the call.
 *
 * @see https://www.w3.org/TR/sparql12-query/#func-regex
 * @see https://www.w3.org/TR/sparql12-query/#func-replace
 */
#include <postgres.h>
#include <fmgr.h>
#include <pcre2.h>
#include <common/hashfn.h>
#include <lib/ilist.h>
#include <lib/stringinfo.h>
#include <mb/pg_wchar.h>
#include <utils/guc.h>
#include <utils/hsearch.h>
#include <utils/memutils.h>
#include "call.h"
#include "functions/regex.h"
#include "rdfbox/rdfbox.h"


/**
 * The key of a cached pattern: the hash, the length and the compile options of the pattern. The pattern itself is
 * compared when the key is found, because two patterns may hash alike.
 */
typedef struct
{
    uint32 hash;      /**< the hash of the pattern, hash_bytes() */
    uint32 options;   /**< the options of pcre2_compile(), see parse_flags() */
    int32 length;     /**< the length of the pattern in bytes */
}
RegexCacheKey;


/**
 * A cached pattern: an entry of the hash table #regex_cache, linked into #regex_cache_lru.
 */
typedef struct
{
    RegexCacheKey key;   /**< the key, which dynahash requires first */
    char *pattern;       /**< the pattern, not terminated by a zero byte */
    pcre2_code *code;    /**< the compiled pattern, NULL if the pattern does not compile */
    uint32 groups;       /**< the number of capture groups of the pattern */
    int uses;            /**< 1 after the first use, 2 from the second use on, which compiles the machine code */
    size_t size;         /**< the memory the entry takes in bytes, as counted into #regex_cache_used */
    dlist_node lru;      /**< the link in #regex_cache_lru */
}
RegexCacheEntry;


/*
 * The contexts live in TopMemoryContext for as long as the backend does and
 * are never freed as PostgreSQL never unloads a loadable module.
 */
static pcre2_general_context *general_context = NULL;   /**< the general context of PCRE2 allocating in the current memory context, NULL before its first use */
static pcre2_match_context *match_context = NULL;       /**< the match context of PCRE2, NULL before its first use */

static int regex_cache_size = 4 * 1024;                           /**< the setting `pgsparql.regex_cache_size`, the memory the cache may take in kilobytes */
static MemoryContext regex_cache_context = NULL;                  /**< the memory context of the cache, NULL before its first use */
static pcre2_compile_context *regex_cache_compile_context = NULL; /**< the compile context of PCRE2 allocating in #regex_cache_context, NULL before its first use */
static HTAB *regex_cache = NULL;                                  /**< the cached patterns by their keys, NULL before the first use of the cache */
static dlist_head regex_cache_lru;                                /**< the cached patterns from the most recently used one to the least recently used one */
static size_t regex_cache_used = 0;                               /**< the memory the cached patterns take in bytes */


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
 * Allocates memory for PCRE2 in the memory context of the cache. Unlike pcre2_malloc(), it raises the error of
 * PostgreSQL when the memory cannot be allocated, so that the cache never holds a pattern that failed to compile for
 * the lack of memory as one that does not compile.
 *
 * @param size the number of bytes
 * @param data the memory data of the general context, unused
 * @return the memory
 */
static void *pcre2_cache_malloc(PCRE2_SIZE size, void *data)
{
    return MemoryContextAlloc(regex_cache_context, size);
}


/**
 * Frees memory allocated by pcre2_malloc() or pcre2_cache_malloc().
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
 * Drops the least recently used patterns from the cache until it fits into a limit. The most recently used pattern
 * is never dropped, so that the one in use stays, whatever the limit.
 *
 * @param limit the memory the cache may take in bytes
 */
static void trim_cache(size_t limit)
{
    while(regex_cache_used > limit && dlist_has_next(&regex_cache_lru, dlist_head_node(&regex_cache_lru)))
    {
        RegexCacheEntry *entry = dlist_container(RegexCacheEntry, lru, dlist_tail_node(&regex_cache_lru));

        dlist_delete(&entry->lru);
        regex_cache_used -= entry->size;
        pcre2_code_free(entry->code);
        pfree(entry->pattern);
        hash_search(regex_cache, &entry->key, HASH_REMOVE, NULL);
    }
}


/**
 * Applies the setting `pgsparql.regex_cache_size`: trims the cache to the new value.
 *
 * @param newval the new value in kilobytes
 * @param extra the extra data of the setting, unused
 */
static void assign_regex_cache_size(int newval, void *extra)
{
    if(regex_cache != NULL)
        trim_cache((size_t) newval * 1024);
}


/**
 * Defines the setting `pgsparql.regex_cache_size`; called when PostgreSQL loads the module.
 */
void regex_cache_init(void)
{
    DefineCustomIntVariable("pgsparql.regex_cache_size", "Sets the memory the cache of compiled regular expressions may take.", "The patterns of REGEX and REPLACE are compiled once per backend and kept for the life of the backend, the least recently used ones being dropped when the cache grows past this size; the most recently used pattern is always kept.", &regex_cache_size, 4 * 1024, 0, MAX_KILOBYTES, PGC_USERSET, GUC_UNIT_KB, NULL, assign_regex_cache_size, NULL);
}


/**
 * Creates the cache: its memory context, the compile context of PCRE2 allocating in it, the hash table and the list
 * of the entries.
 */
static void create_cache(void)
{
    regex_cache_context = AllocSetContextCreate(TopMemoryContext, "pgsparql regex cache", ALLOCSET_DEFAULT_SIZES);

    pcre2_general_context *cache_general_context = pcre2_general_context_create(pcre2_cache_malloc, pcre2_free, NULL);

    if(cache_general_context == NULL || (regex_cache_compile_context = pcre2_compile_context_create(cache_general_context)) == NULL)
        elog(ERROR, "cannot create pcre2 compile context");

    HASHCTL info = { .keysize = sizeof(RegexCacheKey), .entrysize = sizeof(RegexCacheEntry), .hcxt = regex_cache_context };
    regex_cache = hash_create("pgsparql regex cache hash", 64, &info, HASH_ELEM | HASH_BLOBS | HASH_CONTEXT);
    dlist_init(&regex_cache_lru);
}


/**
 * Compiles a cached pattern into machine code if PCRE2 has the JIT compiler and the compilation succeeds; the
 * pattern is matched by the interpreter of PCRE2 otherwise.
 *
 * @param entry the pattern, which compiles
 */
static void compile_machine_code(RegexCacheEntry *entry)
{
    if(pcre2_jit_compile(entry->code, PCRE2_JIT_COMPLETE) == 0)
    {
        size_t size;
        pcre2_pattern_info(entry->code, PCRE2_INFO_JITSIZE, &size);
        entry->size += size;
        regex_cache_used += size;
        trim_cache((size_t) regex_cache_size * 1024);
    }
}


/**
 * Returns a pattern from the cache, compiling it on its first use and into machine code on its second use (see
 * compile_machine_code()); the pattern becomes the most recently used one.
 *
 * @param pattern the pattern
 * @param options the options of pcre2_compile(), see parse_flags()
 * @return the cached pattern, whose code is NULL if the pattern does not compile
 */
static RegexCacheEntry *get_cache_entry(VarChar *pattern, uint32 options)
{
    const char *data = VARDATA_ANY(pattern);
    int32 length = VARSIZE_ANY_EXHDR(pattern);
    RegexCacheKey key = { .hash = hash_bytes((const unsigned char *) data, length), .options = options, .length = length };

    if(regex_cache == NULL)
        create_cache();

    RegexCacheEntry *entry = hash_search(regex_cache, &key, HASH_FIND, NULL);

    if(entry != NULL && memcmp(entry->pattern, data, length) == 0)
    {
        /* the most recently used pattern is never dropped, so it is moved first, before the machine code is counted */
        dlist_move_head(&regex_cache_lru, &entry->lru);

        if(entry->uses == 1)
        {
            entry->uses = 2;

            if(entry->code != NULL)
                compile_machine_code(entry);
        }

        return entry;
    }

    /* another pattern of the same key gives way, just as if it were the least recently used one */
    if(entry != NULL)
    {
        dlist_delete(&entry->lru);
        regex_cache_used -= entry->size;
        pcre2_code_free(entry->code);
        pfree(entry->pattern);
        hash_search(regex_cache, &key, HASH_REMOVE, NULL);
    }

    /*
     * The pattern is copied and compiled before its entry is created, so that an error of an allocation leaves no
     * entry behind, and the entry is linked and counted before anything else can raise an error.
     */
    char *copy = MemoryContextAlloc(regex_cache_context, length);
    memcpy(copy, data, length);

    int errornumber;
    PCRE2_SIZE erroroffset;
    pcre2_code *code = pcre2_compile((PCRE2_SPTR) copy, length, options, &errornumber, &erroroffset, regex_cache_compile_context);

    entry = hash_search(regex_cache, &key, HASH_ENTER, NULL);
    entry->pattern = copy;
    entry->code = code;
    entry->groups = 0;
    entry->uses = 1;
    entry->size = sizeof(RegexCacheEntry) + length;
    dlist_push_head(&regex_cache_lru, &entry->lru);
    regex_cache_used += entry->size;

    if(code != NULL)
    {
        size_t size;
        pcre2_pattern_info(code, PCRE2_INFO_SIZE, &size);
        pcre2_pattern_info(code, PCRE2_INFO_CAPTURECOUNT, &entry->groups);
        entry->size += size;
        regex_cache_used += size;
    }

    trim_cache((size_t) regex_cache_size * 1024);
    return entry;
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
 * Returns the options of a match: in a database in UTF-8, the subject is not checked to be valid UTF-8 again,
 * because PostgreSQL ensures that every string is valid in the server encoding.
 *
 * @return the options of pcre2_match() and pcre2_substitute()
 */
static uint32 match_options(void)
{
    return GetDatabaseEncoding() == PG_UTF8 ? PCRE2_NO_UTF_CHECK : 0;
}


/**
 * Matches a cached pattern against a subject, by the machine code of the pattern if it has one, and by the
 * interpreter of PCRE2 otherwise or when the stack of the machine code, 32 KiB by default, does not suffice for the
 * subject.
 *
 * @param entry the pattern, which compiles
 * @param subject the subject, valid in the server encoding and not necessarily terminated by a zero byte
 * @param length the length of the subject in bytes
 * @param match_data the match data created from the pattern
 * @return the result of pcre2_match()
 */
static int match(RegexCacheEntry *entry, const char *subject, size_t length, pcre2_match_data *match_data)
{
    int rc = pcre2_match(entry->code, (PCRE2_SPTR) subject, length, 0, match_options(), match_data, get_match_context());

    /* a subject too long for the stack of the machine code */
    if(rc == PCRE2_ERROR_JIT_STACKLIMIT)
        rc = pcre2_match(entry->code, (PCRE2_SPTR) subject, length, 0, match_options() | PCRE2_NO_JIT, match_data, get_match_context());

    return rc;
}


/**
 * Tests whether a pattern matches a part of a text, the SPARQL function REGEX behind regex_string() and
 * regex_rdfbox().
 *
 * @param text the text in UTF-8
 * @param size the length of the text in bytes
 * @param pattern the pattern, in the syntax of PCRE2
 * @param flags the flags (see parse_flags())
 * @return true if the pattern matches a part of the text; NULL if the flags are invalid, the pattern does not compile
 *         or the matching fails, for example on a limit of PCRE2
 */
static NullableDatum regex(const char *text, size_t size, VarChar *pattern, VarChar *flags)
{
    uint32 options;

    if(!parse_flags(flags, &options))
        return NULL_DATUM;

    RegexCacheEntry *entry = get_cache_entry(pattern, options);

    if(entry->code == NULL)
        return NULL_DATUM;

    pcre2_match_data *match_data = pcre2_match_data_create_from_pattern(entry->code, get_general_context());

    if(match_data == NULL)
        return NULL_DATUM;

    int rc = match(entry, text, size, match_data);
    pcre2_match_data_free(match_data);

    if(rc < 0 && rc != PCRE2_ERROR_NOMATCH)
        return NULL_DATUM;

    return NULLABLE_DATUM(BoolGetDatum(rc != PCRE2_ERROR_NOMATCH));
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

    PG_RETURN(regex(VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), pattern, flags));
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

    if(!rdfbox_is_string_literal(box))
        PG_RETURN_NULL();

    VarChar *value = RdfBoxGetVarChar(box);

    PG_RETURN(regex(VARDATA(value), VARSIZE(value) - VARHDRSZ, pattern, flags));
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
 * Replaces every match of a cached pattern in a text by a translated replacement, by the machine code of the pattern
 * if it has one, and by the interpreter of PCRE2 otherwise or when the stack of the machine code does not suffice for
 * the text, as match() does.
 *
 * @param entry the pattern, which compiles
 * @param text the text in UTF-8
 * @param size the length of the text in bytes
 * @param replacement the replacement, in the substitution syntax of PCRE2 (see translate_replacement())
 * @param match_data the match data created from the pattern
 * @return the palloc'd result; NULL if the substitution fails
 */
static VarChar *substitute(RegexCacheEntry *entry, const char *text, size_t size, StringInfo replacement, pcre2_match_data *match_data)
{
    uint32 options = match_options() | PCRE2_SUBSTITUTE_GLOBAL | PCRE2_SUBSTITUTE_UNSET_EMPTY;
    PCRE2_SIZE length = 4 * 1024 - VARHDRSZ;
    VarChar *result = palloc(VARHDRSZ + length);

    int rc = pcre2_substitute(entry->code, (PCRE2_SPTR) text, size, 0, options | PCRE2_SUBSTITUTE_OVERFLOW_LENGTH, match_data, get_match_context(), (PCRE2_SPTR) replacement->data, replacement->len, (PCRE2_UCHAR *) VARDATA(result), &length);

    /* a text too long for the stack of the machine code */
    if(rc == PCRE2_ERROR_JIT_STACKLIMIT)
    {
        options |= PCRE2_NO_JIT;
        length = 4 * 1024 - VARHDRSZ;
        rc = pcre2_substitute(entry->code, (PCRE2_SPTR) text, size, 0, options | PCRE2_SUBSTITUTE_OVERFLOW_LENGTH, match_data, get_match_context(), (PCRE2_SPTR) replacement->data, replacement->len, (PCRE2_UCHAR *) VARDATA(result), &length);
    }

    if(rc == PCRE2_ERROR_NOMEMORY)
    {
        result = repalloc(result, VARHDRSZ + length);
        rc = pcre2_substitute(entry->code, (PCRE2_SPTR) text, size, 0, options, match_data, get_match_context(), (PCRE2_SPTR) replacement->data, replacement->len, (PCRE2_UCHAR *) VARDATA(result), &length);
    }

    if(rc < 0)
    {
        pfree(result);
        return NULL;
    }

    SET_VARSIZE(result, VARHDRSZ + length);
    return result;
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
    uint32 options;

    if(!parse_flags(flags, &options))
        return NULL;

    RegexCacheEntry *entry = get_cache_entry(pattern, options);

    if(entry->code == NULL)
        return NULL;

    pcre2_match_data *match_data = pcre2_match_data_create_from_pattern(entry->code, get_general_context());

    if(match_data == NULL)
        return NULL;

    VarChar *result = NULL;

    if(match(entry, "", 0, match_data) == PCRE2_ERROR_NOMATCH)
    {
        StringInfoData translated;
        initStringInfo(&translated);

        if(translate_replacement(VARDATA_ANY(replacement), VARSIZE_ANY_EXHDR(replacement), entry->groups, (options & PCRE2_LITERAL) != 0, &translated))
            result = substitute(entry, text, size, &translated, match_data);

        pfree(translated.data);
    }

    pcre2_match_data_free(match_data);

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
