/**
 * @file
 * The syntax checks of IRIs, IRI references and language tags by regular expressions.
 *
 * The expressions of IRIs are built from macros that follow the grammar of RFC 3987, which extends that of RFC 3986;
 * the expression of language tags follows BCP 47. Each expression is anchored by `^` and `\z` to the whole string,
 * so that a trailing newline, which `$` would let through, is rejected like any other character. Each expression is
 * compiled on its first use and kept, together with its match data, for the lifetime of the backend.
 *
 * A check only asks whether the whole string matches, so the groups of the expressions do not capture
 * (`PCRE2_NO_AUTO_CAPTURE`), which makes matching several times faster. The expressions are also compiled into machine
 * code by the JIT compiler of PCRE2, which matches them several times faster than the interpreter of PCRE2.
 *
 * @see https://www.rfc-editor.org/rfc/rfc3987#section-2.2
 * @see https://www.rfc-editor.org/rfc/rfc3986#appendix-A
 * @see https://www.rfc-editor.org/rfc/bcp/bcp47.txt
 */
#include <postgres.h>
#include <mb/pg_wchar.h>
#include <pcre2.h>
#include "rdfbox/syntax.h"


/** RFC 3986 `ALPHA`: an ASCII letter. */
#define ALPHA           "[a-zA-Z]"
/** RFC 3986 `DIGIT`: a decimal digit. */
#define DIGIT           "[0-9]"
/** RFC 3986 `HEXDIG`: a hexadecimal digit in either case, as the strings of the ABNF of RFC 5234 are. */
#define HEXDIG          "[0-9A-Fa-f]"

/** RFC 3986 `sub-delims`. */
#define SUB_DELIMS      "[!$&'()*+,;=]"
/** RFC 3986 `gen-delims`. */
#define GEN_DELIMS      "[][:/?#@]"
/** RFC 3986 `reserved`. */
#define RESERVED        "(" GEN_DELIMS "|" SUB_DELIMS ")"
/** RFC 3986 `unreserved`. */
#define UNRESERVED      "(" ALPHA "|" DIGIT "|" "[-._~]" ")"
/** RFC 3986 `pct-encoded`: a percent-encoded octet. */
#define PCT_ENCODED     "(" "%" HEXDIG HEXDIG ")"
/** RFC 3986 `dec-octet`: a decimal number from 0 to 255. */
#define DEC_OCTET       "(" DIGIT "|" "[1-9]" DIGIT "|" "1" DIGIT DIGIT "|" "2" "[0-4]" DIGIT "|" "25" "[0-5]" ")"
/** RFC 3986 `IPv4address`. */
#define IPV4_ADDRESS    "(" DEC_OCTET "\\." DEC_OCTET "\\." DEC_OCTET "\\." DEC_OCTET ")"
/** RFC 3986 `h16`: 16 bits of an IPv6 address in hexadecimal. */
#define H16             "(" HEXDIG "{1,4}" ")"
/** RFC 3986 `ls32`: the least significant 32 bits of an IPv6 address. */
#define LS32            "(" H16 ":" H16 "|" IPV4_ADDRESS ")"
/** RFC 3986 `IPv6address`. */
#define IPV6_ADDRESS    "("                                            "(" H16 ":" "){6}" LS32 \
                            "|"                                   "::" "(" H16 ":" "){5}" LS32 \
                            "|" "("                      H16 ")?" "::" "(" H16 ":" "){4}" LS32 \
                            "|" "(" "(" H16 ":" "){0,1}" H16 ")?" "::" "(" H16 ":" "){3}" LS32 \
                            "|" "(" "(" H16 ":" "){0,2}" H16 ")?" "::" "(" H16 ":" "){2}" LS32 \
                            "|" "(" "(" H16 ":" "){0,3}" H16 ")?" "::"    H16 ":"         LS32 \
                            "|" "(" "(" H16 ":" "){0,4}" H16 ")?" "::"                    LS32 \
                            "|" "(" "(" H16 ":" "){0,5}" H16 ")?" "::"                    H16  \
                            "|" "(" "(" H16 ":" "){0,6}" H16 ")?" "::" ")"
/** RFC 3986 `IPvFuture`; its version flag `v` matches in either case like the other ABNF strings. */
#define IPV_FUTURE      "(" "[vV]" HEXDIG "+" "\\." "(" UNRESERVED "|" SUB_DELIMS "|" ":" ")+" ")"
/** RFC 3986 `IP-literal`: an IPv6 or a future address in square brackets. */
#define IP_LITERAL      "(" "\\[" "(" IPV6_ADDRESS "|" IPV_FUTURE  ")" "\\]" ")"
/** RFC 3986 `port`. */
#define PORT            "(" DIGIT "*" ")"
/** RFC 3986 `scheme`. */
#define SCHEME          "(" ALPHA "(" ALPHA "|" DIGIT "|" "[+.-]" ")*" ")"
/** RFC 3987 `iprivate`: the private use characters allowed in a query. */
#define IPRIVATE        "[\\N{U+E000}-\\N{U+F8FF}\\N{U+F0000}-\\N{U+FFFFD}\\N{U+100000}-\\N{U+10FFFD}]"
/** RFC 3987 `ucschar`: the non-ASCII characters allowed in an IRI. */
#define UCSCHAR         "[" \
                            "\\N{U+000A0}-\\N{U+0D7FF}\\N{U+0F900}-\\N{U+0FDCF}\\N{U+0FDF0}-\\N{U+0FFEF}" \
                            "\\N{U+10000}-\\N{U+1FFFD}\\N{U+20000}-\\N{U+2FFFD}\\N{U+30000}-\\N{U+3FFFD}" \
                            "\\N{U+40000}-\\N{U+4FFFD}\\N{U+50000}-\\N{U+5FFFD}\\N{U+60000}-\\N{U+6FFFD}" \
                            "\\N{U+70000}-\\N{U+7FFFD}\\N{U+80000}-\\N{U+8FFFD}\\N{U+90000}-\\N{U+9FFFD}" \
                            "\\N{U+A0000}-\\N{U+AFFFD}\\N{U+B0000}-\\N{U+BFFFD}\\N{U+C0000}-\\N{U+CFFFD}" \
                            "\\N{U+D0000}-\\N{U+DFFFD}\\N{U+E1000}-\\N{U+EFFFD}" "]"
/** RFC 3987 `iunreserved`. */
#define IUNRESERVED     "(" ALPHA "|" DIGIT "|" "[._~-]" "|" UCSCHAR ")"
/** RFC 3987 `ipchar`. */
#define IPCHAR          "(" IUNRESERVED "|" PCT_ENCODED "|" SUB_DELIMS "|" "[:@]" ")"
/** RFC 3987 `ifragment`. */
#define IFRAGMENT       "(" "(" IPCHAR "|" "[/?]" ")*" ")"
/** RFC 3987 `iquery`. */
#define IQUERY          "(" "(" IPCHAR "|" IPRIVATE "|" "[/?]" ")*" ")"
/** RFC 3987 `isegment-nz-nc`: a non-empty segment without a colon. */
#define ISEGMENT_NZ_NC  "(" "(" IUNRESERVED "|" PCT_ENCODED "|" SUB_DELIMS "|" "@" ")+" ")"
/** RFC 3987 `isegment-nz`: a non-empty segment. */
#define ISEGMENT_NZ     "(" "(" IPCHAR ")+" ")"
/** RFC 3987 `isegment`. */
#define ISEGMENT        "(" "(" IPCHAR ")*" ")"
/** RFC 3987 `ipath-empty`. */
#define IPATH_EMPTY     ""
/** RFC 3987 `ipath-rootless`. */
#define IPATH_ROOTLESS  "(" ISEGMENT_NZ "(" "/" ISEGMENT ")*" ")"
/** RFC 3987 `ipath-noscheme`. */
#define IPATH_NOSCHEME  "(" ISEGMENT_NZ_NC "(" "/" ISEGMENT ")*" ")"
/** RFC 3987 `ipath-absolute`. */
#define IPATH_ABSOLUTE  "(" "/" "(" ISEGMENT_NZ "(" "/" ISEGMENT ")*" ")?" ")"
/** RFC 3987 `ipath-abempty`. */
#define IPATH_ABEMPTY   "(" "(" "/" ISEGMENT ")*" ")"
/** RFC 3987 `ipath`. */
#define IPATH           "(" IPATH_ABEMPTY "|" IPATH_ABSOLUTE "|" IPATH_NOSCHEME "|" IPATH_ROOTLESS "|" IPATH_EMPTY ")"
/** RFC 3987 `ireg-name`. */
#define IREG_NAME       "(" "(" IUNRESERVED "|" PCT_ENCODED "|" SUB_DELIMS ")*" ")"
/** RFC 3987 `ihost`. */
#define IHOST           "(" IP_LITERAL "|" IPV4_ADDRESS "|" IREG_NAME ")"
/** RFC 3987 `iuserinfo`. */
#define IUSERINFO       "(" "(" IUNRESERVED "|" PCT_ENCODED "|" SUB_DELIMS "|" ":" ")*" ")"
/** RFC 3987 `iauthority`. */
#define IAUTHORITY      "(" "(" IUSERINFO "@" ")?" IHOST "(" ":" PORT ")?" ")"
/** RFC 3987 `ihier-part`. */
#define IHIER_PART      "(" "//" IAUTHORITY IPATH_ABEMPTY "|" IPATH_ABSOLUTE "|" IPATH_ROOTLESS "|" IPATH_EMPTY ")"
/** RFC 3987 `IRI`: an absolute IRI with an optional fragment. */
#define IRI             "(" SCHEME ":" IHIER_PART "(" "\\?" IQUERY ")?" "(" "#" IFRAGMENT ")?" ")"
/** RFC 3987 `irelative-part`. */
#define IRELATIVE_PART  "(" "//" IAUTHORITY IPATH_ABEMPTY "|" IPATH_ABSOLUTE  "|"  IPATH_NOSCHEME "|" IPATH_EMPTY ")"
/** RFC 3987 `irelative-ref`: a relative IRI reference. */
#define IRELATIVE_REF   "(" IRELATIVE_PART "(" "\\?" IQUERY ")?" "(" "#" IFRAGMENT ")?" ")"
/** RFC 3987 `IRI-reference`: an IRI or a relative reference. */
#define IRI_REFERENCE   "(" IRI "|" IRELATIVE_REF ")"


/**
 * The expression of a syntax check, which is compiled on its first use and kept, together with its match data, for the
 * lifetime of the backend.
 */
typedef struct
{
    const char *name;               /**< what the expression matches, for the error messages */
    const char *pattern;            /**< the expression */
    uint32 options;                 /**< the options of pcre2_compile() besides `PCRE2_NO_AUTO_CAPTURE` */
    pcre2_code *code;               /**< the compiled expression, NULL before its first use */
    pcre2_match_data *match_data;   /**< the match data of the compiled expression, NULL before its first use */
}
Regex;


static const char iri_pattern[] = "^" IRI "\\z";               /**< the expression of an absolute IRI */
static const char iriref_pattern[] = "^" IRI_REFERENCE "\\z";   /**< the expression of an IRI reference */

/**
 * The expression of a language tag: BCP 47 `Language-Tag`, that is a `langtag`, a `privateuse` tag or one of the
 * irregular grandfathered tags, matched regardless of case.
 */
static const char tag_pattern[] = "^(([A-Za-z]{2,3}(-[A-Za-z]{3}){0,3}|[A-Za-z]{4,8})"
        "(-[A-Za-z]{4})?(-([A-Za-z]{2}|[0-9]{3}))?(-([A-Za-z0-9]{5,8}|[0-9][A-Za-z0-9]{3}))*"
        "(-[0-9A-WY-Za-wy-z](-[A-Za-z0-9]{2,8})+)*(-x(-[A-Za-z0-9]{1,8})+)?|x(-[A-Za-z0-9]{1,8})+"
        "|i-ami|i-bnn|i-default|i-enochian|i-hak|i-klingon|i-lux|i-mingo|i-navajo|i-pwn"
        "|i-tao|i-tay|i-tsu|sgn-BE-FR|sgn-BE-NL|sgn-CH-DE)\\z";

static Regex iri_regex = { .name = "iri", .pattern = iri_pattern, .options = PCRE2_UTF };                   /**< the check of #iri_pattern */
static Regex iriref_regex = { .name = "iri reference", .pattern = iriref_pattern, .options = PCRE2_UTF };   /**< the check of #iriref_pattern */
static Regex tag_regex = { .name = "language tag", .pattern = tag_pattern, .options = PCRE2_CASELESS };     /**< the check of #tag_pattern */


/**
 * Tests whether a whole string matches the expression of a syntax check, which is compiled on the first call.
 *
 * The expression is matched by its machine code if PCRE2 has the JIT compiler and the compilation succeeds, and by the
 * interpreter of PCRE2 otherwise. The stack of the machine code, 32 KiB by default, does not suffice for a string
 * longer than some hundreds of characters, which the interpreter then matches instead. In a database in UTF-8, the
 * string is not checked to be valid UTF-8 again, because PostgreSQL ensures that every string is valid in the server
 * encoding.
 *
 * @param regex the check
 * @param subject the string, valid in the server encoding and not necessarily terminated by a zero byte
 * @param length the length of the string in bytes
 * @return true if the string matches; a string that is not valid UTF-8 for an expression in UTF-8, which is possible
 *         only in a database of another encoding, raises an error
 */
static bool match(Regex *regex, const char *subject, size_t length)
{
    if(regex->code == NULL)
    {
        int errornumber;
        PCRE2_SIZE erroroffset;

        if((regex->code = pcre2_compile((PCRE2_SPTR) regex->pattern, PCRE2_ZERO_TERMINATED, regex->options | PCRE2_NO_AUTO_CAPTURE, &errornumber, &erroroffset, NULL)) == NULL)
            elog(ERROR, "cannot compile %s pattern", regex->name);

        /* without the machine code, the expression is matched by the interpreter */
        (void) pcre2_jit_compile(regex->code, PCRE2_JIT_COMPLETE);
    }

    if(regex->match_data == NULL && (regex->match_data = pcre2_match_data_create_from_pattern(regex->code, NULL)) == NULL)
        elog(ERROR, "cannot create %s match data", regex->name);

    uint32 options = (regex->options & PCRE2_UTF) && GetDatabaseEncoding() == PG_UTF8 ? PCRE2_NO_UTF_CHECK : 0;
    int rc = pcre2_match(regex->code, (PCRE2_SPTR) subject, length, 0, options, regex->match_data, NULL);

    /* a string too long for the stack of the machine code */
    if(rc == PCRE2_ERROR_JIT_STACKLIMIT)
        rc = pcre2_match(regex->code, (PCRE2_SPTR) subject, length, 0, options | PCRE2_NO_JIT, regex->match_data, NULL);

    if(rc < PCRE2_ERROR_NOMATCH)
        elog(ERROR, "%s match failed", regex->name);

    return rc != PCRE2_ERROR_NOMATCH;
}


/**
 * Tests whether a string is an absolute IRI, RFC 3987 `IRI`.
 *
 * @param iri the string, valid in the server encoding and not necessarily terminated by a zero byte; in a database of
 *            another encoding than UTF-8, a string that is not valid UTF-8 raises an error
 * @param length the length of the string in bytes
 * @return true if the string is an IRI
 */
bool check_iri(const char *iri, size_t length)
{
    return match(&iri_regex, iri, length);
}


/**
 * Tests whether a string is an IRI reference, RFC 3987 `IRI-reference`: an absolute or a relative IRI.
 *
 * @param iri the string, valid in the server encoding and not necessarily terminated by a zero byte; in a database of
 *            another encoding than UTF-8, a string that is not valid UTF-8 raises an error
 * @param length the length of the string in bytes
 * @return true if the string is an IRI reference
 */
bool check_iri_reference(const char *iri, size_t length)
{
    return match(&iriref_regex, iri, length);
}


/**
 * Tests whether a string is a well-formed language tag of BCP 47, regardless of case.
 *
 * @param lang the string, not necessarily terminated by a zero byte
 * @param length the length of the string in bytes
 * @return true if the string is a language tag
 */
bool check_language_tag(const char *lang, size_t length)
{
    return match(&tag_regex, lang, length);
}
