/**
 * @file
 * The syntax checks of IRIs, IRI references and language tags by regular expressions.
 *
 * The expressions of IRIs are built from macros that follow the grammar of RFC 3987, which extends that of RFC 3986;
 * the expression of language tags follows BCP 47. Each expression is compiled on its first use and kept, together
 * with its match data, for the lifetime of the backend.
 *
 * @see https://www.rfc-editor.org/rfc/rfc3987#section-2.2
 * @see https://www.rfc-editor.org/rfc/rfc3986#appendix-A
 * @see https://www.rfc-editor.org/rfc/bcp/bcp47.txt
 */
#include <postgres.h>
#include <pcre2.h>
#include "rdfbox/syntax.h"


/** RFC 3986 `ALPHA`: an ASCII letter. */
#define ALPHA           "[a-zA-Z]"
/** RFC 3986 `DIGIT`: a decimal digit. */
#define DIGIT           "[0-9]"
/** RFC 3986 `HEXDIG`, restricted to the upper-case hexadecimal digits. */
#define HEXDIG          "[0-9A-F]"

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
/** RFC 3986 `IPvFuture`. */
#define IPV_FUTURE      "(" "v" HEXDIG "+" "\\." "(" UNRESERVED "|" SUB_DELIMS "|" ":" ")+" ")"
/** RFC 3986 `IP-literal`: an IPv6 or a future address in square brackets. */
#define IP_LITERAL      "(" "\\[" "(" IPV6_ADDRESS "|" IPV_FUTURE  ")" "\\]" ")"
/** RFC 3986 `port`. */
#define PORT            "(" DIGIT "*" ")"
/** RFC 3986 `scheme`. */
#define SCHEME          "(" ALPHA "(" ALPHA "|" DIGIT "|" "[+-.]" ")*" ")"
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


static pcre2_code *iri_regex = NULL;                    /**< the compiled #iri_pattern, NULL before its first use */
static pcre2_match_data *iri_match_data = NULL;         /**< the match data of #iri_regex */
static const char *iri_pattern = "^" IRI "$";           /**< the expression of an absolute IRI */

static pcre2_code *iriref_regex = NULL;                 /**< the compiled #iriref_pattern, NULL before its first use */
static pcre2_match_data *iriref_match_data = NULL;      /**< the match data of #iriref_regex */
static const char *iriref_pattern = "^" IRI_REFERENCE "$";  /**< the expression of an IRI reference */

static pcre2_code *tag_regex = NULL;                    /**< the compiled #tag_pattern, NULL before its first use */
static pcre2_match_data *tag_match_data = NULL;         /**< the match data of #tag_regex */

/**
 * The expression of a language tag: BCP 47 `Language-Tag`, that is a `langtag`, a `privateuse` tag or one of the
 * irregular grandfathered tags, matched regardless of case.
 */
static const char *tag_pattern = "^(([A-Za-z]{2,3}(-[A-Za-z]{3}){0,3}|[A-Za-z]{4,8})"
        "(-[A-Za-z]{4})?(-([A-Za-z]{2}|[0-9]{3}))?(-([A-Za-z0-9]{5,8}|[0-9][A-Za-z0-9]{3}))*"
        "(-[0-9A-WY-Za-wy-z](-[A-Za-z0-9]{2,8})+)*(-x(-[A-Za-z0-9]{1,8})+)?|x(-[A-Za-z0-9]{1,8})+"
        "|i-ami|i-bnn|i-default|i-enochian|i-hak|i-klingon|i-lux|i-mingo|i-navajo|i-pwn"
        "|i-tao|i-tay|i-tsu|sgn-BE-FR|sgn-BE-NL|sgn-CH-DE)$";


/**
 * Tests whether a string is an absolute IRI, RFC 3987 `IRI`.
 *
 * @param iri the string in UTF-8, not necessarily terminated by a zero byte; invalid UTF-8 raises an error
 * @param length the length of the string in bytes
 * @return true if the string is an IRI
 */
bool check_iri(const char *iri, size_t length)
{
    int errornumber;
    PCRE2_SIZE erroroffset;

    if(iri_regex == NULL && (iri_regex = pcre2_compile((const unsigned char *) iri_pattern, strlen(iri_pattern), PCRE2_UTF, &errornumber, &erroroffset, NULL)) == NULL)
        elog(ERROR, "cannot compile iri pattern");

    if(iri_match_data == NULL && (iri_match_data = pcre2_match_data_create_from_pattern(iri_regex, NULL)) == NULL)
        elog(ERROR, "cannot create iri match data");

    int rc = pcre2_match(iri_regex, (unsigned char *) iri, length, 0, 0, iri_match_data, NULL);

    if(rc < PCRE2_ERROR_NOMATCH)
        elog(ERROR, "iri match failed");

    return rc != PCRE2_ERROR_NOMATCH;
}


/**
 * Tests whether a string is an IRI reference, RFC 3987 `IRI-reference`: an absolute or a relative IRI.
 *
 * @param iri the string in UTF-8, not necessarily terminated by a zero byte; invalid UTF-8 raises an error
 * @param length the length of the string in bytes
 * @return true if the string is an IRI reference
 */
bool check_iri_reference(const char *iri, size_t length)
{
    int errornumber;
    PCRE2_SIZE erroroffset;

    if(iriref_regex == NULL && (iriref_regex = pcre2_compile((const unsigned char *) iriref_pattern, strlen(iriref_pattern), PCRE2_UTF, &errornumber, &erroroffset, NULL)) == NULL)
        elog(ERROR, "cannot compile iri reference pattern");

    if(iriref_match_data == NULL && (iriref_match_data = pcre2_match_data_create_from_pattern(iriref_regex, NULL)) == NULL)
        elog(ERROR, "cannot create iri reference match data");

    int rc = pcre2_match(iriref_regex, (unsigned char *) iri, length, 0, 0, iriref_match_data, NULL);

    if(rc < PCRE2_ERROR_NOMATCH)
        elog(ERROR, "iri reference match failed");

    return rc != PCRE2_ERROR_NOMATCH;
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
    int errornumber;
    PCRE2_SIZE erroroffset;

    if(tag_regex == NULL && (tag_regex = pcre2_compile((const unsigned char *) tag_pattern, strlen(tag_pattern), PCRE2_CASELESS, &errornumber, &erroroffset, NULL)) == NULL)
        elog(ERROR, "cannot compile language tag pattern");

    if(tag_match_data == NULL && (tag_match_data = pcre2_match_data_create_from_pattern(tag_regex, NULL)) == NULL)
        elog(ERROR, "cannot create language tag match data");

    int rc = pcre2_match(tag_regex, (unsigned char *) lang, length, 0, 0, tag_match_data, NULL);

    if(rc < PCRE2_ERROR_NOMATCH)
        elog(ERROR, "language tag match failed");

    return rc != PCRE2_ERROR_NOMATCH;
}
