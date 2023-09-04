#include <postgres.h>
#include <pcre2.h>
#include "rdfbox/syntax.h"


#define ALPHA           "[a-zA-Z]"
#define DIGIT           "[0-9]"
#define HEXDIG          "[0-9A-F]"

#define SUB_DELIMS      "[!$&'()*+,;=]"
#define GEN_DELIMS      "[][:/?#@]"
#define RESERVED        "(" GEN_DELIMS "|" SUB_DELIMS ")"
#define UNRESERVED      "(" ALPHA "|" DIGIT "|" "[-._~]" ")"
#define PCT_ENCODED     "(" "%" HEXDIG HEXDIG ")"
#define DEC_OCTET       "(" DIGIT "|" "[1-9]" DIGIT "|" "1" DIGIT DIGIT "|" "2" "[0-4]" DIGIT "|" "25" "[0-5]" ")"
#define IPV4_ADDRESS    "(" DEC_OCTET "\\." DEC_OCTET "\\." DEC_OCTET "\\." DEC_OCTET ")"
#define H16             "(" HEXDIG "{1,4}" ")"
#define LS32            "(" H16 ":" H16 "|" IPV4_ADDRESS ")"
#define IPV6_ADDRESS    "("                                            "(" H16 ":" "){6}" LS32 \
                            "|"                                   "::" "(" H16 ":" "){5}" LS32 \
                            "|" "("                      H16 ")?" "::" "(" H16 ":" "){4}" LS32 \
                            "|" "(" "(" H16 ":" "){0,1}" H16 ")?" "::" "(" H16 ":" "){3}" LS32 \
                            "|" "(" "(" H16 ":" "){0,2}" H16 ")?" "::" "(" H16 ":" "){2}" LS32 \
                            "|" "(" "(" H16 ":" "){0,3}" H16 ")?" "::"    H16 ":"         LS32 \
                            "|" "(" "(" H16 ":" "){0,4}" H16 ")?" "::"                    LS32 \
                            "|" "(" "(" H16 ":" "){0,5}" H16 ")?" "::"                    H16  \
                            "|" "(" "(" H16 ":" "){0,6}" H16 ")?" "::" ")"
#define IPV_FUTURE      "(" "v" HEXDIG "+" "\\." "(" UNRESERVED "|" SUB_DELIMS "|" ":" ")+" ")"
#define IP_LITERAL      "(" "\\[" "(" IPV6_ADDRESS "|" IPV_FUTURE  ")" "\\]" ")"
#define PORT            "(" DIGIT "*" ")"
#define SCHEME          "(" ALPHA "(" ALPHA "|" DIGIT "|" "[+-.]" ")*" ")"
#define IPRIVATE        "[\\N{U+E000}-\\N{U+F8FF}\\N{U+F0000}-\\N{U+FFFFD}\\N{U+100000}-\\N{U+10FFFD}]"
#define UCSCHAR         "[" \
                            "\\N{U+000A0}-\\N{U+0D7FF}\\N{U+0F900}-\\N{U+0FDCF}\\N{U+0FDF0}-\\N{U+0FFEF}" \
                            "\\N{U+10000}-\\N{U+1FFFD}\\N{U+20000}-\\N{U+2FFFD}\\N{U+30000}-\\N{U+3FFFD}" \
                            "\\N{U+40000}-\\N{U+4FFFD}\\N{U+50000}-\\N{U+5FFFD}\\N{U+60000}-\\N{U+6FFFD}" \
                            "\\N{U+70000}-\\N{U+7FFFD}\\N{U+80000}-\\N{U+8FFFD}\\N{U+90000}-\\N{U+9FFFD}" \
                            "\\N{U+A0000}-\\N{U+AFFFD}\\N{U+B0000}-\\N{U+BFFFD}\\N{U+C0000}-\\N{U+CFFFD}" \
                            "\\N{U+D0000}-\\N{U+DFFFD}\\N{U+E1000}-\\N{U+EFFFD}" "]"
#define IUNRESERVED     "(" ALPHA "|" DIGIT "|" "[._~-]" "|" UCSCHAR ")"
#define IPCHAR          "(" IUNRESERVED "|" PCT_ENCODED "|" SUB_DELIMS "|" "[:@]" ")"
#define IFRAGMENT       "(" "(" IPCHAR "|" "[/?]" ")*" ")"
#define IQUERY          "(" "(" IPCHAR "|" IPRIVATE "|" "[/?]" ")*" ")"
#define ISEGMENT_NZ_NC  "(" "(" IUNRESERVED "|" PCT_ENCODED "|" SUB_DELIMS "|" "@" ")+" ")"
#define ISEGMENT_NZ     "(" "(" IPCHAR ")+" ")"
#define ISEGMENT        "(" "(" IPCHAR ")*" ")"
#define IPATH_EMPTY     ""
#define IPATH_ROOTLESS  "(" ISEGMENT_NZ "(" "/" ISEGMENT ")*" ")"
#define IPATH_NOSCHEME  "(" ISEGMENT_NZ_NC "(" "/" ISEGMENT ")*" ")"
#define IPATH_ABSOLUTE  "(" "/" "(" ISEGMENT_NZ "(" "/" ISEGMENT ")*" ")?" ")"
#define IPATH_ABEMPTY   "(" "(" "/" ISEGMENT ")*" ")"
#define IPATH           "(" IPATH_ABEMPTY "|" IPATH_ABSOLUTE "|" IPATH_NOSCHEME "|" IPATH_ROOTLESS "|" IPATH_EMPTY ")"
#define IREG_NAME       "(" "(" IUNRESERVED "|" PCT_ENCODED "|" SUB_DELIMS ")*" ")"
#define IHOST           "(" IP_LITERAL "|" IPV4_ADDRESS "|" IREG_NAME ")"
#define IUSERINFO       "(" "(" IUNRESERVED "|" PCT_ENCODED "|" SUB_DELIMS "|" ":" ")*" ")"
#define IAUTHORITY      "(" "(" IUSERINFO "@" ")?" IHOST "(" ":" PORT ")?" ")"
#define IHIER_PART      "(" "//" IAUTHORITY IPATH_ABEMPTY "|" IPATH_ABSOLUTE "|" IPATH_ROOTLESS "|" IPATH_EMPTY ")"
#define IRI             "(" SCHEME ":" IHIER_PART "(" "\\?" IQUERY ")?" "(" "#" IFRAGMENT ")?" ")"
#define IRELATIVE_PART  "(" "//" IAUTHORITY IPATH_ABEMPTY "|" IPATH_ABSOLUTE  "|"  IPATH_NOSCHEME "|" IPATH_EMPTY ")"
#define IRELATIVE_REF   "(" IRELATIVE_PART "(" "\\?" IQUERY ")?" "(" "#" IFRAGMENT ")?" ")"
#define IRI_REFERENCE   "(" IRI "|" IRELATIVE_REF ")"


static pcre2_code *iri_regex = NULL;
static pcre2_match_data *iri_match_data = NULL;
static const char *iri_pattern = "^" IRI "$";

static pcre2_code *iriref_regex = NULL;
static pcre2_match_data *iriref_match_data = NULL;
static const char *iriref_pattern = "^" IRI_REFERENCE "$";

static pcre2_code *tag_regex = NULL;
static pcre2_match_data *tag_match_data = NULL;
static const char *tag_pattern = "^(([A-Za-z]{2,3}(-[A-Za-z]{3}){0,3}|[A-Za-z]{4,8})"
        "(-[A-Za-z]{4})?(-([A-Za-z]{2}|[0-9]{3}))?(-([A-Za-z0-9]{5,8}|[0-9][A-Za-z0-9]{3}))*"
        "(-[0-9A-WY-Za-wy-z](-[A-Za-z0-9]{2,8})+)*(-x(-[A-Za-z0-9]{1,8})+)?|x(-[A-Za-z0-9]{1,8})+"
        "|i-ami|i-bnn|i-default|i-enochian|i-hak|i-klingon|i-lux|i-mingo|i-navajo|i-pwn"
        "|i-tao|i-tay|i-tsu|sgn-BE-FR|sgn-BE-NL|sgn-CH-DE)$";


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
