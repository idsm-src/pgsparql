/**
 * @file
 * The layout of the rdfbox type, which holds any RDF term, and the inline functions that build a box and read it.
 *
 * A box is a varlena: the 4-byte length word, then the type tag (::RdfType) and the lexical bit (::RdfBox), so that
 * the value begins at offset 8. The value is a fixed-size scalar for most types (::RdfBoxBool, ::RdfBoxInt16, ...,
 * ::RdfBoxDate) and a sequence of varlenas for the others (::RdfBoxVarlena). A literal of a handled datatype whose
 * lexical form is not the canonical form of its value keeps that form after the value as a varchar; the lexical bit
 * tells whether it is there (the *WithLexical structures). The parts that follow a varlena begin at a 4-byte
 * boundary, see align_size(), except for the parts of a triple term, which are MAXALIGNed.
 */
#ifndef RDFBOX_RDFBOX_H_
#define RDFBOX_RDFBOX_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/float.h>
#include <utils/fmgrprotos.h>
#include <utils/numeric.h>
#include "types/date.h"
#include "types/datetime.h"
#include "types/ubox.h"


/**
 * The type of the term held by a box, stored in the box as its type tag.
 *
 * The order of the types is semantic:
 *
 *   - XSD_BOOLEAN .. TYPED_LITERAL are the literals (rdfbox_is_literal), XSD_BYTE .. XSD_DOUBLE the numbers among
 *     them (rdfbox_is_numeric) and XSD_STRING .. RDF_RTL_LANGSTRING the string literals among them
 *     (rdfbox_is_string_literal), of which RDF_LANGSTRING .. RDF_RTL_LANGSTRING are language-tagged
 *     (rdfbox_is_langstring) and RDF_LTR_LANGSTRING .. RDF_RTL_LANGSTRING have a base direction
 *     (rdfbox_is_dirlangstring); IBLANKNODE .. SBLANKNODE are the blank nodes (rdfbox_is_blanknode),
 *
 *   - the numeric types are listed so that for each promotion target (xsd:short, xsd:int, xsd:long, xsd:integer,
 *     xsd:decimal, xsd:float and xsd:double) the types from XSD_BYTE up to the target are exactly those whose values
 *     the SQL type of the target represents; rdfbox/derivate.c and rdfbox/promotion.h rely on it,
 *
 *   - the values of XSD_BYTE .. XSD_LONG are held in an integer of at most 64 bits, the value of XSD_UNSIGNEDLONG in
 *     a uint64 and the values of XSD_INTEGER .. XSD_DECIMAL in a numeric; rdfbox/order.c relies on it,
 *
 *   - rdfbox/order.c orders numbers of the same value by their types and the other terms by the reversed order of
 *     their types: blank nodes, then IRIs, then literals, then triple terms, which is why TRIPLE_TERM comes first,
 *
 *   - functions/rdfterm.c indexes the table of datatype IRIs by the type,
 *
 *   - the type is a part of the stored representation and of the binary format read by rdfbox_recv().
 */
typedef enum
{
    TRIPLE_TERM = 0,              /**< a triple term `<<( s p o )>>`, held by an ::RdfBoxVarlena */
    XSD_BOOLEAN = 1,              /**< xsd:boolean, held by an ::RdfBoxBool */
    XSD_BYTE = 2,                 /**< xsd:byte, held by an ::RdfBoxInt16 */
    XSD_UNSIGNEDBYTE = 3,         /**< xsd:unsignedByte, held by an ::RdfBoxInt16 */
    XSD_SHORT = 4,                /**< xsd:short, held by an ::RdfBoxInt16 */
    XSD_UNSIGNEDSHORT = 5,        /**< xsd:unsignedShort, held by an ::RdfBoxInt32 */
    XSD_INT = 6,                  /**< xsd:int, held by an ::RdfBoxInt32 */
    XSD_UNSIGNEDINT = 7,          /**< xsd:unsignedInt, held by an ::RdfBoxUInt32 */
    XSD_LONG = 8,                 /**< xsd:long, held by an ::RdfBoxInt64 */
    XSD_UNSIGNEDLONG = 9,         /**< xsd:unsignedLong, held by an ::RdfBoxUInt64 */
    XSD_INTEGER = 10,             /**< xsd:integer, a numeric held by an ::RdfBoxVarlena */
    XSD_NONPOSITIVEINTEGER = 11,  /**< xsd:nonPositiveInteger, a numeric held by an ::RdfBoxVarlena */
    XSD_NEGATIVEINTEGER = 12,     /**< xsd:negativeInteger, a numeric held by an ::RdfBoxVarlena */
    XSD_NONNEGATIVEINTEGER = 13,  /**< xsd:nonNegativeInteger, a numeric held by an ::RdfBoxVarlena */
    XSD_POSITIVEINTEGER = 14,     /**< xsd:positiveInteger, a numeric held by an ::RdfBoxVarlena */
    XSD_DECIMAL = 15,             /**< xsd:decimal, a numeric held by an ::RdfBoxVarlena */
    XSD_FLOAT = 16,               /**< xsd:float, held by an ::RdfBoxFloat4 */
    XSD_DOUBLE = 17,              /**< xsd:double, held by an ::RdfBoxFloat8 */
    XSD_DATETIME = 18,            /**< xsd:dateTime, held by an ::RdfBoxDateTime */
    XSD_DATE = 19,                /**< xsd:date, held by an ::RdfBoxDate */
    XSD_DAYTIMEDURATION = 20,     /**< xsd:dayTimeDuration in microseconds, held by an ::RdfBoxInt64 */
    XSD_STRING = 21,              /**< xsd:string, a varchar held by an ::RdfBoxVarlena */
    RDF_LANGSTRING = 22,          /**< a language-tagged string without a base direction, `"v"@tag` */
    RDF_LTR_LANGSTRING = 23,      /**< a language-tagged string with the base direction ltr, `"v"@tag--ltr` */
    RDF_RTL_LANGSTRING = 24,      /**< a language-tagged string with the base direction rtl, `"v"@tag--rtl` */
    USER_LITERAL = 25,            /**< a user literal, a ::UBox and the datatype IRI held by an ::RdfBoxVarlena */
    TYPED_LITERAL = 26,           /**< a literal of another datatype or with an invalid lexical form */
    IRI = 27,                     /**< an IRI, a varchar held by an ::RdfBoxVarlena */
    IBLANKNODE = 28,              /**< a blank node identified by an int64, printed as `_:i` and 16 hex digits */
    SBLANKNODE = 29               /**< a blank node identified by a string, printed as `_:s` and the escaped string */
}
RdfType;


/* the base directions of the directional language-tagged strings, as LANGDIR() returns them */
#define RDF_LTR_DIRECTION   "ltr"       /**< the base direction left-to-right */
#define RDF_RTL_DIRECTION   "rtl"       /**< the base direction right-to-left */


/**
 * The header of a box, which every structure of a box begins with.
 *
 * The header takes 8 bytes, so that the value that follows it is aligned for any scalar type, given that the box
 * itself is MAXALIGNed, as rdfbox is declared with `alignment = double`.
 */
typedef struct
{
    char vl_len_[4];        /**< the varlena header */
    RdfType type : 31;      /**< the type of the term */
    bool lexical : 1;       /**< whether the lexical form of a literal follows its value */
}
RdfBox;


/**
 * A box of an xsd:boolean without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    bool value;             /**< the value */
}
RdfBoxBool;


/**
 * A box of an xsd:byte, an xsd:unsignedByte or an xsd:short without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    int16 value;            /**< the value */
}
RdfBoxInt16;


/**
 * A box of an xsd:unsignedShort or an xsd:int without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    int32 value;            /**< the value */
}
RdfBoxInt32;


/**
 * A box of an xsd:unsignedInt without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    uint32 value;           /**< the value */
}
RdfBoxUInt32;


/**
 * A box of an xsd:long or an xsd:dayTimeDuration without a lexical form, or of a blank node identified by an int64.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    int64 value;            /**< the value */
}
RdfBoxInt64;


/**
 * A box of an xsd:unsignedLong without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    uint64 value;           /**< the value */
}
RdfBoxUInt64;


/**
 * A box of an xsd:float without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    float4 value;           /**< the value */
}
RdfBoxFloat4;


/**
 * A box of an xsd:double without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    float8 value;           /**< the value */
}
RdfBoxFloat8;


/**
 * A box of an xsd:dateTime without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    ZonedDateTime value;    /**< the value */
}
RdfBoxDateTime;


/**
 * A box of an xsd:date without a lexical form.
 */
typedef struct
{
    RdfBox header;          /**< the header */
    ZonedDate value;        /**< the value */
}
RdfBoxDate;


/**
 * A box whose value is a sequence of varlenas, each beginning at a 4-byte boundary (see align_size()):
 *
 * - xsd:integer, its subtypes and xsd:decimal: the numeric and, if the box keeps one, the lexical form,
 * - xsd:string, an IRI and a blank node identified by a string: the varchar,
 * - a language-tagged string: the lexical form and the language tag,
 * - a typed literal: the lexical form and the datatype IRI,
 * - a user literal: the ::UBox, the datatype IRI and, if the box keeps one, the lexical form,
 * - a triple term: the subject box, the predicate IRI as a varchar and the object box, each MAXALIGNed instead.
 */
typedef struct
{
    RdfBox header;                                              /**< the header */
    char value[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);  /**< the first varlena of the value */
}
RdfBoxVarlena;


/**
 * A box of an xsd:boolean that keeps its lexical form.
 */
typedef struct
{
    RdfBoxBool box;                                                /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxBoolWithLexical;


/**
 * A box of an xsd:byte, an xsd:unsignedByte or an xsd:short that keeps its lexical form.
 */
typedef struct
{
    RdfBoxInt16 box;                                               /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxInt16WithLexical;


/**
 * A box of an xsd:unsignedShort or an xsd:int that keeps its lexical form.
 */
typedef struct
{
    RdfBoxInt32 box;                                               /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxInt32WithLexical;


/**
 * A box of an xsd:unsignedInt that keeps its lexical form.
 */
typedef struct
{
    RdfBoxUInt32 box;                                              /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxUInt32WithLexical;


/**
 * A box of an xsd:long or an xsd:dayTimeDuration that keeps its lexical form.
 */
typedef struct
{
    RdfBoxInt64 box;                                               /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxInt64WithLexical;


/**
 * A box of an xsd:unsignedLong that keeps its lexical form.
 */
typedef struct
{
    RdfBoxUInt64 box;                                              /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxUInt64WithLexical;


/**
 * A box of an xsd:float that keeps its lexical form.
 */
typedef struct
{
    RdfBoxFloat4 box;                                              /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxFloat4WithLexical;


/**
 * A box of an xsd:double that keeps its lexical form.
 */
typedef struct
{
    RdfBoxFloat8 box;                                              /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxFloat8WithLexical;


/**
 * A box of an xsd:dateTime that keeps its lexical form.
 */
typedef struct
{
    RdfBoxDateTime box;                                            /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxDateTimeWithLexical;


/**
 * A box of an xsd:date that keeps its lexical form.
 */
typedef struct
{
    RdfBoxDate box;                                                /**< the box with the value */
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);   /**< the lexical form as a varchar */
}
RdfBoxDateWithLexical;


/**
 * Converts a Datum to a box, detoasting it.
 *
 * @param X the Datum
 * @return the box, a MAXALIGNed copy with a 4-byte header if the Datum was toasted, compressed or had a short header
 */
#define DatumGetRdfBox(X)       ((RdfBox *) PG_DETOAST_DATUM(X))

/**
 * Converts a box to a Datum.
 *
 * @param X the box
 * @return the Datum
 */
#define RdfBoxGetDatum(X)       PointerGetDatum(X)

/**
 * Fetches an rdfbox argument of a version-1 function, detoasting it.
 *
 * @param n the number of the argument
 * @return the box
 */
#define PG_GETARG_RDFBOX_P(n)   DatumGetRdfBox(PG_GETARG_DATUM(n))

/**
 * Returns a box from a version-1 function.
 *
 * @param x the box
 */
#define PG_RETURN_RDFBOX_P(x)   return RdfBoxGetDatum(x)


/**
 * The boxes that a getter accepts according to whether they keep a lexical form.
 */
typedef enum
{
    LEXICAL_BOTH,       /**< any box */
    LEXICAL_TRUE,       /**< only a box that keeps a lexical form */
    LEXICAL_FALSE       /**< only a box that keeps no lexical form */
}
LexicalFlag;


/**
 * Fetches the optional last bool argument of a getter, which restricts the boxes it accepts.
 *
 * @param n the number of the argument, which equals PG_NARGS() if the argument is not given
 * @return #LEXICAL_BOTH if the argument is not given, #LEXICAL_TRUE if it is true and #LEXICAL_FALSE if it is false
 */
#define PG_GETARG_LEXICAL_FLAG(n)  ((n) == PG_NARGS() ? LEXICAL_BOTH : (PG_GETARG_BOOL(n) ? LEXICAL_TRUE : LEXICAL_FALSE))


/**
 * Tests whether a box is accepted by a getter according to whether it keeps a lexical form.
 *
 * @param box the box
 * @param flag the restriction of the getter
 * @return true if @a flag is #LEXICAL_BOTH or the lexical bit of the box agrees with it
 */
static inline bool RdfBoxCheckLexicalFlag(RdfBox *box, LexicalFlag flag)
{
    if(flag == LEXICAL_BOTH)
        return true;

    return box->lexical == (flag == LEXICAL_TRUE);
}


/**
 * Rounds a size up to a multiple of 4, the offset of the varlena that follows a varlena of that size in a box.
 *
 * @param n the size
 * @return the least multiple of 4 that is not less than @a n
 */
static inline uint32 align_size(uint32 n)
{
    return (n + 3) & 0xFFFFFFFC;
}


/**
 * Returns the value of an xsd:boolean.
 *
 * @param box the box, of the type #XSD_BOOLEAN
 * @return the value
 */
static inline bool RdfBoxGetBool(RdfBox *box)
{
    return ((RdfBoxBool *) box)->value;
}


/**
 * Returns the value of an xsd:byte.
 *
 * @param box the box, of the type #XSD_BYTE
 * @return the value
 */
static inline int8 RdfBoxGetInt8(RdfBox *box)
{
    return (int8) ((RdfBoxInt16 *) box)->value;
}


/**
 * Returns the value of an xsd:unsignedByte.
 *
 * @param box the box, of the type #XSD_UNSIGNEDBYTE
 * @return the value
 */
static inline uint8 RdfBoxGetUInt8(RdfBox *box)
{
    return (uint8) ((RdfBoxInt16 *) box)->value;
}


/**
 * Returns the int16 that holds the value of an xsd:short, an xsd:byte or an xsd:unsignedByte.
 *
 * @param box the box, of the type #XSD_SHORT, #XSD_BYTE or #XSD_UNSIGNEDBYTE
 * @return the value
 */
static inline int16 RdfBoxGetInt16(RdfBox *box)
{
    return ((RdfBoxInt16 *) box)->value;
}


/**
 * Returns the value of an xsd:unsignedShort.
 *
 * @param box the box, of the type #XSD_UNSIGNEDSHORT
 * @return the value
 */
static inline uint16 RdfBoxGetUInt16(RdfBox *box)
{
    return (uint16) ((RdfBoxInt32 *) box)->value;
}


/**
 * Returns the int32 that holds the value of an xsd:int or an xsd:unsignedShort.
 *
 * @param box the box, of the type #XSD_INT or #XSD_UNSIGNEDSHORT
 * @return the value
 */
static inline int32 RdfBoxGetInt32(RdfBox *box)
{
    return ((RdfBoxInt32 *) box)->value;
}


/**
 * Returns the value of an xsd:unsignedInt.
 *
 * @param box the box, of the type #XSD_UNSIGNEDINT
 * @return the value
 */
static inline uint32 RdfBoxGetUInt32(RdfBox *box)
{
    return ((RdfBoxUInt32 *) box)->value;
}


/**
 * Returns the int64 that holds the value of an xsd:long, of an xsd:dayTimeDuration (in microseconds) or of a
 * blank node identified by an int64.
 *
 * @param box the box, of the type #XSD_LONG, #XSD_DAYTIMEDURATION or #IBLANKNODE
 * @return the value
 */
static inline int64 RdfBoxGetInt64(RdfBox *box)
{
    return ((RdfBoxInt64 *) box)->value;
}


/**
 * Returns the value of an xsd:unsignedLong.
 *
 * @param box the box, of the type #XSD_UNSIGNEDLONG
 * @return the value
 */
static inline uint64 RdfBoxGetUInt64(RdfBox *box)
{
    return ((RdfBoxUInt64 *) box)->value;
}


/**
 * Returns the value of an xsd:integer, of one of its subtypes or of an xsd:decimal.
 *
 * @param box the box, of the type one of #XSD_INTEGER .. #XSD_DECIMAL
 * @return the numeric, which points into the box
 */
static inline Numeric RdfBoxGetNumeric(RdfBox *box)
{
    return (Numeric) ((RdfBoxVarlena *) box)->value;
}


/**
 * Returns the value of an xsd:float.
 *
 * @param box the box, of the type #XSD_FLOAT
 * @return the value
 */
static inline float4 RdfBoxGetFloat4(RdfBox *box)
{
    return ((RdfBoxFloat4 *) box)->value;
}


/**
 * Returns the value of an xsd:double.
 *
 * @param box the box, of the type #XSD_DOUBLE
 * @return the value
 */
static inline float8 RdfBoxGetFloat8(RdfBox *box)
{
    return ((RdfBoxFloat8 *) box)->value;
}


/**
 * Returns the value of an xsd:dateTime.
 *
 * @param box the box, of the type #XSD_DATETIME
 * @return the value, which points into the box
 */
static inline ZonedDateTime *RdfBoxGetZonedDateTime(RdfBox *box)
{
    return &((RdfBoxDateTime *) box)->value;
}


/**
 * Returns the value of an xsd:date.
 *
 * @param box the box, of the type #XSD_DATE
 * @return the value
 */
static inline ZonedDate RdfBoxGetZonedDate(RdfBox *box)
{
    return ((RdfBoxDate *) box)->value;
}


/**
 * Returns the first varchar of a box: the value of an xsd:string, the lexical form of a language-tagged string or of
 * a typed literal, an IRI or the identifier of a blank node identified by a string.
 *
 * @param box the box, of the type one of #XSD_STRING .. #RDF_RTL_LANGSTRING, #TYPED_LITERAL, @c IRI or #SBLANKNODE
 * @return the varchar, which points into the box
 */
static inline VarChar *RdfBoxGetVarChar(RdfBox *box)
{
    return (VarChar *) ((RdfBoxVarlena *) box)->value;
}


/**
 * Returns the varchar that follows the first varlena of a box: the language tag of a language-tagged string, the
 * datatype IRI of a typed literal or the lexical form of a number held by a numeric.
 *
 * @param box the box: a language-tagged string, a typed literal or, with the lexical bit set, a box of one of the
 *            types #XSD_INTEGER .. #XSD_DECIMAL
 * @return the varchar, which points into the box
 */
static inline VarChar *RdfBoxGetAttachment(RdfBox *box)
{
    VarChar *value = (VarChar *) ((RdfBoxVarlena *) box)->value;
    return (VarChar *) (((RdfBoxVarlena *) box)->value + align_size(VARSIZE(value)));
}


/**
 * Returns the value of a user literal.
 *
 * @param box the box, of the type #USER_LITERAL
 * @return the ubox, which points into the box
 */
static inline UBox *RdfBoxGetUBox(RdfBox *box)
{
    return (UBox *) ((RdfBoxVarlena *) box)->value;
}


/*
 * A triple term holds its subject and its object as whole boxes and its predicate as a varchar, one after another.
 * The embedded boxes have to be aligned like a box handed out by PG_DETOAST_DATUM(), because their values are read
 * in place (an int64, a double, a boxed value of a user literal), so each part is padded to a multiple of MAXALIGN:
 * the value of a box begins at offset 8 and the box itself is MAXALIGNed, see types/ubox.h.
 */

/**
 * Returns the subject of a triple term.
 *
 * @param box the box, of the type #TRIPLE_TERM
 * @return the subject box, which points into the box
 */
static inline RdfBox *RdfBoxGetTripleTermSubject(RdfBox *box)
{
    return (RdfBox *) ((RdfBoxVarlena *) box)->value;
}


/**
 * Returns the predicate of a triple term.
 *
 * @param box the box, of the type #TRIPLE_TERM
 * @return the predicate IRI as a varchar, which points into the box
 */
static inline VarChar *RdfBoxGetTripleTermPredicate(RdfBox *box)
{
    char *subject = ((RdfBoxVarlena *) box)->value;
    return (VarChar *) (subject + MAXALIGN(VARSIZE(subject)));
}


/**
 * Returns the object of a triple term.
 *
 * @param box the box, of the type #TRIPLE_TERM
 * @return the object box, which points into the box
 */
static inline RdfBox *RdfBoxGetTripleTermObject(RdfBox *box)
{
    char *subject = ((RdfBoxVarlena *) box)->value;
    char *predicate = subject + MAXALIGN(VARSIZE(subject));
    return (RdfBox *) (predicate + MAXALIGN(VARSIZE(predicate)));
}


/**
 * Returns the lexical form kept by an xsd:boolean.
 *
 * @param box the box, of the type #XSD_BOOLEAN, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetBoolLexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxBoolWithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:short, an xsd:byte or an xsd:unsignedByte.
 *
 * @param box the box, of the type #XSD_SHORT, #XSD_BYTE or #XSD_UNSIGNEDBYTE, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetInt16Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxInt16WithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:int or an xsd:unsignedShort.
 *
 * @param box the box, of the type #XSD_INT or #XSD_UNSIGNEDSHORT, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetInt32Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxInt32WithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:unsignedInt.
 *
 * @param box the box, of the type #XSD_UNSIGNEDINT, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetUInt32Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxUInt32WithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:long or an xsd:dayTimeDuration.
 *
 * @param box the box, of the type #XSD_LONG or #XSD_DAYTIMEDURATION, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetInt64Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxInt64WithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:unsignedLong.
 *
 * @param box the box, of the type #XSD_UNSIGNEDLONG, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetUInt64Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxUInt64WithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:float.
 *
 * @param box the box, of the type #XSD_FLOAT, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetFloat4Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxFloat4WithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:double.
 *
 * @param box the box, of the type #XSD_DOUBLE, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetFloat8Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxFloat8WithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:dateTime.
 *
 * @param box the box, of the type #XSD_DATETIME, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetZonedDateTimeLexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxDateTimeWithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by an xsd:date.
 *
 * @param box the box, of the type #XSD_DATE, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetZonedDateLexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxDateWithLexical *) box)->lexical;
}


/**
 * Returns the lexical form kept by a user literal.
 *
 * @param box the box, of the type #USER_LITERAL, with the lexical bit set
 * @return the lexical form, which points into the box
 */
static inline VarChar *RdfBoxGetUserLiteralLexical(RdfBox *box)
{
    char *value = ((RdfBoxVarlena *) box)->value;
    char *type = value + align_size(VARSIZE(value));

    return (VarChar *) (type + align_size(VARSIZE(type)));
}


/**
 * Returns the lexical form kept by a literal of any type that can keep one: a handled datatype other than xsd:string
 * and the language-tagged strings, or a user literal.
 *
 * @param box the box, with the lexical bit set
 * @return the lexical form, which points into the box; a box of a type that keeps no lexical form raises an error
 */
static inline VarChar *RdfBoxGetLexical(RdfBox *box)
{
    switch(box->type)
    {
        case XSD_BOOLEAN:
            return RdfBoxGetBoolLexical(box);

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            return RdfBoxGetInt16Lexical(box);

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            return RdfBoxGetInt32Lexical(box);

        case XSD_UNSIGNEDINT:
            return RdfBoxGetUInt32Lexical(box);

        case XSD_LONG:
        case XSD_DAYTIMEDURATION:
            return RdfBoxGetInt64Lexical(box);

        case XSD_UNSIGNEDLONG:
            return RdfBoxGetUInt64Lexical(box);

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        case XSD_DECIMAL:
            return RdfBoxGetAttachment(box);

        case XSD_FLOAT:
            return RdfBoxGetFloat4Lexical(box);

        case XSD_DOUBLE:
            return RdfBoxGetFloat8Lexical(box);

        case XSD_DATETIME:
            return RdfBoxGetZonedDateTimeLexical(box);

        case XSD_DATE:
            return RdfBoxGetZonedDateLexical(box);

        case USER_LITERAL:
            return RdfBoxGetUserLiteralLexical(box);

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}


/**
 * Builds a box of an xsd:boolean without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetBooleanRdfBox(bool value)
{
    RdfBoxBool *result = (RdfBoxBool *) palloc0(sizeof(RdfBoxBool));
    SET_VARSIZE(result, sizeof(RdfBoxBool));
    result->header.type = XSD_BOOLEAN;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:byte without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetByteRdfBox(int8 value)
{
    RdfBoxInt16 *result = (RdfBoxInt16 *) palloc0(sizeof(RdfBoxInt16));
    SET_VARSIZE(result, sizeof(RdfBoxInt16));
    result->header.type = XSD_BYTE;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:unsignedByte without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetUnsignedByteRdfBox(uint8 value)
{
    RdfBoxInt16 *result = (RdfBoxInt16 *) palloc0(sizeof(RdfBoxInt16));
    SET_VARSIZE(result, sizeof(RdfBoxInt16));
    result->header.type = XSD_UNSIGNEDBYTE;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:short without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetShortRdfBox(int16 value)
{
    RdfBoxInt16 *result = (RdfBoxInt16 *) palloc0(sizeof(RdfBoxInt16));
    SET_VARSIZE(result, sizeof(RdfBoxInt16));
    result->header.type = XSD_SHORT;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:unsignedShort without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetUnsignedShortRdfBox(uint16 value)
{
    RdfBoxInt32 *result = (RdfBoxInt32 *) palloc0(sizeof(RdfBoxInt32));
    SET_VARSIZE(result, sizeof(RdfBoxInt32));
    result->header.type = XSD_UNSIGNEDSHORT;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:int without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetIntRdfBox(int32 value)
{
    RdfBoxInt32 *result = (RdfBoxInt32 *) palloc0(sizeof(RdfBoxInt32));
    SET_VARSIZE(result, sizeof(RdfBoxInt32));
    result->header.type = XSD_INT;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:unsignedInt without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetUnsignedIntRdfBox(uint32 value)
{
    RdfBoxUInt32 *result = (RdfBoxUInt32 *) palloc0(sizeof(RdfBoxUInt32));
    SET_VARSIZE(result, sizeof(RdfBoxUInt32));
    result->header.type = XSD_UNSIGNEDINT;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:long without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetLongRdfBox(int64 value)
{
    RdfBoxInt64 *result = (RdfBoxInt64 *) palloc0(sizeof(RdfBoxInt64));
    SET_VARSIZE(result, sizeof(RdfBoxInt64));
    result->header.type = XSD_LONG;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:unsignedLong without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetUnsignedLongRdfBox(uint64 value)
{
    RdfBoxUInt64 *result = (RdfBoxUInt64 *) palloc0(sizeof(RdfBoxUInt64));
    SET_VARSIZE(result, sizeof(RdfBoxUInt64));
    result->header.type = XSD_UNSIGNEDLONG;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Copies a numeric with the least scale that holds its value, which is how a box keeps the value of an xsd:integer, of
 * a type derived from it or of an xsd:decimal.
 *
 * A numeric keeps the scale it was written or computed with, such as 1 for 1.0 and 2 for 1.00. The canonical lexical
 * form of a box does not show the scale and the operator `@=` takes such boxes as identical, so they have to be built
 * identically: the default B-tree operator class of rdfbox declares that identical boxes have identical
 * representations, and numeric_div() chooses the scale of a quotient by the scales of its operands.
 *
 * @param value the value, a detoasted numeric
 * @return the palloc'd numeric
 */
static inline Numeric canonical_numeric(Numeric value)
{
    return DatumGetNumeric(DirectFunctionCall1(numeric_trim_scale, NumericGetDatum(value)));
}


/**
 * Builds a box of an xsd:integer without a lexical form.
 *
 * @param value the value, a detoasted integral numeric, which is copied with the least scale that holds it; it is not
 *              checked
 * @return the palloc'd box
 */
static inline RdfBox *GetIntegerRdfBox(Numeric value)
{
    Numeric canonical = canonical_numeric(value);
    int size = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_INTEGER;
    memcpy(result->value, canonical, size);
    pfree(canonical);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:nonPositiveInteger without a lexical form.
 *
 * @param value the value, a detoasted integral numeric not greater than 0, which is copied with the least scale that
 *              holds it; it is not checked
 * @return the palloc'd box
 */
static inline RdfBox *GetNonPositiveIntegerRdfBox(Numeric value)
{
    Numeric canonical = canonical_numeric(value);
    int size = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_NONPOSITIVEINTEGER;
    memcpy(result->value, canonical, size);
    pfree(canonical);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:negativeInteger without a lexical form.
 *
 * @param value the value, a detoasted integral numeric less than 0, which is copied with the least scale that holds it;
 *              it is not checked
 * @return the palloc'd box
 */
static inline RdfBox *GetNegativeIntegerRdfBox(Numeric value)
{
    Numeric canonical = canonical_numeric(value);
    int size = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_NEGATIVEINTEGER;
    memcpy(result->value, canonical, size);
    pfree(canonical);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:nonNegativeInteger without a lexical form.
 *
 * @param value the value, a detoasted integral numeric not less than 0, which is copied with the least scale that holds
 *              it; it is not checked
 * @return the palloc'd box
 */
static inline RdfBox *GetNonNegativeIntegerRdfBox(Numeric value)
{
    Numeric canonical = canonical_numeric(value);
    int size = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_NONNEGATIVEINTEGER;
    memcpy(result->value, canonical, size);
    pfree(canonical);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:positiveInteger without a lexical form.
 *
 * @param value the value, a detoasted integral numeric greater than 0, which is copied with the least scale that holds
 *              it; it is not checked
 * @return the palloc'd box
 */
static inline RdfBox *GetPositiveIntegerRdfBox(Numeric value)
{
    Numeric canonical = canonical_numeric(value);
    int size = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_POSITIVEINTEGER;
    memcpy(result->value, canonical, size);
    pfree(canonical);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:decimal without a lexical form.
 *
 * @param value the value, a detoasted numeric, which is copied with the least scale that holds it
 * @return the palloc'd box
 */
static inline RdfBox *GetDecimalRdfBox(Numeric value)
{
    Numeric canonical = canonical_numeric(value);
    int size = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_DECIMAL;
    memcpy(result->value, canonical, size);
    pfree(canonical);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:float without a lexical form.
 *
 * @param value the value; a NaN is stored as the NaN of get_float4_nan(), so that all NaNs are built identically
 * @return the palloc'd box
 */
static inline RdfBox *GetFloatRdfBox(float4 value)
{
    RdfBoxFloat4 *result = (RdfBoxFloat4 *) palloc0(sizeof(RdfBoxFloat4));
    SET_VARSIZE(result, sizeof(RdfBoxFloat4));
    result->header.type = XSD_FLOAT;
    result->value = isnan(value) ? get_float4_nan() : value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:double without a lexical form.
 *
 * @param value the value; a NaN is stored as the NaN of get_float8_nan(), so that all NaNs are built identically
 * @return the palloc'd box
 */
static inline RdfBox *GetDoubleRdfBox(float8 value)
{
    RdfBoxFloat8 *result = (RdfBoxFloat8 *) palloc0(sizeof(RdfBoxFloat8));
    SET_VARSIZE(result, sizeof(RdfBoxFloat8));
    result->header.type = XSD_DOUBLE;
    result->value = isnan(value) ? get_float8_nan() : value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:dateTime without a lexical form.
 *
 * @param value the value, which is copied
 * @return the palloc'd box
 */
static inline RdfBox *GetDateTimeRdfBox(ZonedDateTime *value)
{
    RdfBoxDateTime *result = (RdfBoxDateTime *) palloc0(sizeof(RdfBoxDateTime));
    SET_VARSIZE(result, sizeof(RdfBoxDateTime));
    result->header.type = XSD_DATETIME;
    result->value = *value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:date without a lexical form.
 *
 * @param value the value
 * @return the palloc'd box
 */
static inline RdfBox *GetDateRdfBox(ZonedDate value)
{
    RdfBoxDate *result = (RdfBoxDate *) palloc0(sizeof(RdfBoxDate));
    SET_VARSIZE(result, sizeof(RdfBoxDate));
    result->header.type = XSD_DATE;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:dayTimeDuration without a lexical form.
 *
 * @param value the value in microseconds
 * @return the palloc'd box
 */
static inline RdfBox *GetDayTimeDurationRdfBox(int64 value)
{
    RdfBoxInt64 *result = (RdfBoxInt64 *) palloc0(sizeof(RdfBoxInt64));
    SET_VARSIZE(result, sizeof(RdfBoxInt64));
    result->header.type = XSD_DAYTIMEDURATION;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:string.
 *
 * @param data the string, not necessarily terminated by a zero byte
 * @param size the length of the string in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetStringRdfBox(const char *data, int size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    result->header.type = XSD_STRING;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of a language-tagged string without a base direction.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @param lang the language tag, not necessarily terminated by a zero byte; it is not checked
 * @param lang_size the length of the language tag in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetLangStringRdfBox(const char *data, int size, const char *lang, int lang_size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(size + VARHDRSZ) + lang_size + VARHDRSZ);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(size + VARHDRSZ) + lang_size + VARHDRSZ);
    result->header.type = RDF_LANGSTRING;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    SET_VARSIZE(result->value + align_size(size + VARHDRSZ), lang_size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(size + VARHDRSZ)), lang, lang_size);
    return (RdfBox *) result;
}


/**
 * Builds a box of a language-tagged string with the base direction ltr.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @param lang the language tag, not necessarily terminated by a zero byte; it is not checked
 * @param lang_size the length of the language tag in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetLtrLangStringRdfBox(const char *data, int size, const char *lang, int lang_size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(size + VARHDRSZ) + lang_size + VARHDRSZ);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(size + VARHDRSZ) + lang_size + VARHDRSZ);
    result->header.type = RDF_LTR_LANGSTRING;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    SET_VARSIZE(result->value + align_size(size + VARHDRSZ), lang_size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(size + VARHDRSZ)), lang, lang_size);
    return (RdfBox *) result;
}


/**
 * Builds a box of a language-tagged string with the base direction rtl.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @param lang the language tag, not necessarily terminated by a zero byte; it is not checked
 * @param lang_size the length of the language tag in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetRtlLangStringRdfBox(const char *data, int size, const char *lang, int lang_size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(size + VARHDRSZ) + lang_size + VARHDRSZ);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(size + VARHDRSZ) + lang_size + VARHDRSZ);
    result->header.type = RDF_RTL_LANGSTRING;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    SET_VARSIZE(result->value + align_size(size + VARHDRSZ), lang_size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(size + VARHDRSZ)), lang, lang_size);
    return (RdfBox *) result;
}


/**
 * Builds a string literal of the same kind as the given one -- of the same type and, for a language-tagged string,
 * with the same language tag -- but with the given lexical form. The string functions build their results this way,
 * as SPARQL 1.2 has them return a literal of the same kind as their first argument.
 *
 * @param box the string literal whose kind the result takes
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box; a box that is not a string literal raises an error
 */
static inline RdfBox *GetDerivedStringLiteralRdfBox(RdfBox *box, const char *data, int size)
{
    switch(box->type)
    {
        case XSD_STRING:
            return GetStringRdfBox(data, size);

        case RDF_LANGSTRING:
        {
            VarChar *lang = RdfBoxGetAttachment(box);
            return GetLangStringRdfBox(data, size, VARDATA(lang), VARSIZE(lang) - VARHDRSZ);
        }

        case RDF_LTR_LANGSTRING:
        {
            VarChar *lang = RdfBoxGetAttachment(box);
            return GetLtrLangStringRdfBox(data, size, VARDATA(lang), VARSIZE(lang) - VARHDRSZ);
        }

        case RDF_RTL_LANGSTRING:
        {
            VarChar *lang = RdfBoxGetAttachment(box);
            return GetRtlLangStringRdfBox(data, size, VARDATA(lang), VARSIZE(lang) - VARHDRSZ);
        }

        default:
            elog(ERROR, "unexpected rdfbox type");
    }
}


/**
 * Builds a box of a user literal without a lexical form.
 *
 * @param value the value, a detoasted ubox, which is copied
 * @param type the datatype IRI, not necessarily terminated by a zero byte
 * @param type_size the length of the datatype IRI in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetUserLiteralRdfBox(UBox *value, const char *type, int type_size)
{
    int size = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(size) + type_size + VARHDRSZ);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(size) + type_size + VARHDRSZ);
    result->header.type = USER_LITERAL;
    memcpy(result->value, value, size);
    SET_VARSIZE(result->value + align_size(size), type_size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(size)), type, type_size);
    return (RdfBox *) result;
}


/**
 * Builds a box of a typed literal, a literal of a datatype that is not handled or whose lexical form is not valid.
 *
 * @param data the lexical form, not necessarily terminated by a zero byte
 * @param size the length of the lexical form in bytes
 * @param type the datatype IRI, not necessarily terminated by a zero byte
 * @param type_size the length of the datatype IRI in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetTypedLiteralRdfBox(const char *data, int size, const char *type, int type_size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(size + VARHDRSZ) + type_size + VARHDRSZ);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(size + VARHDRSZ) + type_size + VARHDRSZ);
    result->header.type = TYPED_LITERAL;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    SET_VARSIZE(result->value + align_size(size + VARHDRSZ), type_size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(size + VARHDRSZ)), type, type_size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:boolean that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetBooleanRdfBoxWithLexical(bool value, const char *data, int size)
{
    RdfBoxBoolWithLexical *result = (RdfBoxBoolWithLexical *) palloc0(sizeof(RdfBoxBoolWithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxBoolWithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_BOOLEAN;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:byte that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetByteRdfBoxWithLexical(int8 value, const char *data, int size)
{
    RdfBoxInt16WithLexical *result = (RdfBoxInt16WithLexical *) palloc0(sizeof(RdfBoxInt16WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxInt16WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_BYTE;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:unsignedByte that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetUnsignedByteRdfBoxWithLexical(uint8 value, const char *data, int size)
{
    RdfBoxInt16WithLexical *result = (RdfBoxInt16WithLexical *) palloc0(sizeof(RdfBoxInt16WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxInt16WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_UNSIGNEDBYTE;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:short that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetShortRdfBoxWithLexical(int16 value, const char *data, int size)
{
    RdfBoxInt16WithLexical *result = (RdfBoxInt16WithLexical *) palloc0(sizeof(RdfBoxInt16WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxInt16WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_SHORT;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:unsignedShort that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetUnsignedShortRdfBoxWithLexical(uint16 value, const char *data, int size)
{
    RdfBoxInt32WithLexical *result = (RdfBoxInt32WithLexical *) palloc0(sizeof(RdfBoxInt32WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxInt32WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_UNSIGNEDSHORT;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:int that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetIntRdfBoxWithLexical(int32 value, const char *data, int size)
{
    RdfBoxInt32WithLexical *result = (RdfBoxInt32WithLexical *) palloc0(sizeof(RdfBoxInt32WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxInt32WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_INT;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:unsignedInt that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetUnsignedIntRdfBoxWithLexical(uint32 value, const char *data, int size)
{
    RdfBoxUInt32WithLexical *result = (RdfBoxUInt32WithLexical *) palloc0(sizeof(RdfBoxUInt32WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxUInt32WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_UNSIGNEDINT;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:long that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetLongRdfBoxWithLexical(int64 value, const char *data, int size)
{
    RdfBoxInt64WithLexical *result = (RdfBoxInt64WithLexical *) palloc0(sizeof(RdfBoxInt64WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxInt64WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_LONG;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:unsignedLong that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetUnsignedLongRdfBoxWithLexical(uint64 value, const char *data, int size)
{
    RdfBoxUInt64WithLexical *result = (RdfBoxUInt64WithLexical *) palloc0(sizeof(RdfBoxUInt64WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxUInt64WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_UNSIGNEDLONG;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:integer that keeps a lexical form.
 *
 * @param value the value, a detoasted integral numeric, which is copied with the least scale that holds it; it is not
 *              checked
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    Numeric canonical = canonical_numeric(value);
    int nsize = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_INTEGER;
    result->header.lexical = true;
    memcpy(result->value, canonical, nsize);
    pfree(canonical);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:nonPositiveInteger that keeps a lexical form.
 *
 * @param value the value, a detoasted integral numeric not greater than 0, which is copied with the least scale that
 *              holds it; it is not checked
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetNonPositiveIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    Numeric canonical = canonical_numeric(value);
    int nsize = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_NONPOSITIVEINTEGER;
    result->header.lexical = true;
    memcpy(result->value, canonical, nsize);
    pfree(canonical);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:negativeInteger that keeps a lexical form.
 *
 * @param value the value, a detoasted integral numeric less than 0, which is copied with the least scale that holds it;
 *              it is not checked
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetNegativeIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    Numeric canonical = canonical_numeric(value);
    int nsize = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_NEGATIVEINTEGER;
    result->header.lexical = true;
    memcpy(result->value, canonical, nsize);
    pfree(canonical);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:nonNegativeInteger that keeps a lexical form.
 *
 * @param value the value, a detoasted integral numeric not less than 0, which is copied with the least scale that holds
 *              it; it is not checked
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetNonNegativeIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    Numeric canonical = canonical_numeric(value);
    int nsize = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_NONNEGATIVEINTEGER;
    result->header.lexical = true;
    memcpy(result->value, canonical, nsize);
    pfree(canonical);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:positiveInteger that keeps a lexical form.
 *
 * @param value the value, a detoasted integral numeric greater than 0, which is copied with the least scale that holds
 *              it; it is not checked
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetPositiveIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    Numeric canonical = canonical_numeric(value);
    int nsize = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_POSITIVEINTEGER;
    result->header.lexical = true;
    memcpy(result->value, canonical, nsize);
    pfree(canonical);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:decimal that keeps a lexical form.
 *
 * @param value the value, a detoasted numeric, which is copied with the least scale that holds it
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetDecimalRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    Numeric canonical = canonical_numeric(value);
    int nsize = VARSIZE(canonical);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_DECIMAL;
    result->header.lexical = true;
    memcpy(result->value, canonical, nsize);
    pfree(canonical);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:float that keeps a lexical form.
 *
 * @param value the value; a NaN is stored as the NaN of get_float4_nan(), so that all NaNs are built identically
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetFloatRdfBoxWithLexical(float4 value, const char *data, int size)
{
    RdfBoxFloat4WithLexical *result = (RdfBoxFloat4WithLexical *) palloc0(sizeof(RdfBoxFloat4WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxFloat4WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_FLOAT;
    result->box.header.lexical = true;
    result->box.value = isnan(value) ? get_float4_nan() : value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:double that keeps a lexical form.
 *
 * @param value the value; a NaN is stored as the NaN of get_float8_nan(), so that all NaNs are built identically
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetDoubleRdfBoxWithLexical(float8 value, const char *data, int size)
{
    RdfBoxFloat8WithLexical *result = (RdfBoxFloat8WithLexical *) palloc0(sizeof(RdfBoxFloat8WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxFloat8WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_DOUBLE;
    result->box.header.lexical = true;
    result->box.value = isnan(value) ? get_float8_nan() : value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:dateTime that keeps a lexical form.
 *
 * @param value the value, which is copied
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetDateTimeRdfBoxWithLexical(ZonedDateTime *value, const char *data, int size)
{
    RdfBoxDateTimeWithLexical *result = (RdfBoxDateTimeWithLexical *) palloc0(sizeof(RdfBoxDateTimeWithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxDateTimeWithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_DATETIME;
    result->box.header.lexical = true;
    result->box.value = *value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:date that keeps a lexical form.
 *
 * @param value the value
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetDateRdfBoxWithLexical(ZonedDate value, const char *data, int size)
{
    RdfBoxDateWithLexical *result = (RdfBoxDateWithLexical *) palloc0(sizeof(RdfBoxDateWithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxDateWithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_DATE;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an xsd:dayTimeDuration that keeps a lexical form.
 *
 * @param value the value in microseconds
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetDayTimeDurationRdfBoxWithLexical(int64 value, const char *data, int size)
{
    RdfBoxInt64WithLexical *result = (RdfBoxInt64WithLexical *) palloc0(sizeof(RdfBoxInt64WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxInt64WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_DAYTIMEDURATION;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of a user literal that keeps a lexical form.
 *
 * @param value the value, a detoasted ubox, which is copied
 * @param type the datatype IRI, not necessarily terminated by a zero byte
 * @param type_size the length of the datatype IRI in bytes
 * @param data the lexical form, not necessarily terminated by a zero byte; it is not checked to denote the value
 * @param size the length of the lexical form in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetUserLiteralRdfBoxWithLexical(UBox *value, const char *type, int type_size, const char *data, int size)
{
    int vsize = VARSIZE(value);
    int tsize = type_size + VARHDRSZ;
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(vsize) + align_size(tsize) + size + VARHDRSZ);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(vsize) + align_size(tsize) + size + VARHDRSZ);
    result->header.type = USER_LITERAL;
    result->header.lexical = true;
    memcpy(result->value, value, vsize);
    SET_VARSIZE(result->value + align_size(vsize), tsize);
    memcpy(VARDATA(result->value + align_size(vsize)), type, type_size);
    SET_VARSIZE(result->value + align_size(vsize) + align_size(tsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(vsize) + align_size(tsize)), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of an IRI.
 *
 * @param data the IRI, not necessarily terminated by a zero byte; it is not checked
 * @param size the length of the IRI in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetIriRdfBox(const char *data, int size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    result->header.type = IRI;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of a blank node identified by an int64.
 *
 * @param value the identifier
 * @return the palloc'd box
 */
static inline RdfBox *GetIBlankNodeRdfBox(int64 value)
{
    RdfBoxInt64 *result = (RdfBoxInt64 *) palloc0(sizeof(RdfBoxInt64));
    SET_VARSIZE(result, sizeof(RdfBoxInt64));
    result->header.type = IBLANKNODE;
    result->value = value;
    return (RdfBox *) result;
}


/**
 * Builds a box of a blank node identified by a string.
 *
 * @param data the identifier, not necessarily terminated by a zero byte; it is not checked
 * @param size the length of the identifier in bytes
 * @return the palloc'd box
 */
static inline RdfBox *GetSBlankNodeRdfBox(const char *data, int size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    result->header.type = SBLANKNODE;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    return (RdfBox *) result;
}


/**
 * Builds a box of a triple term, which embeds copies of its subject and object boxes.
 *
 * @param subject the detoasted subject box, which is copied; it is not checked to be an IRI or a blank node
 * @param predicate the predicate IRI, not necessarily terminated by a zero byte; it is not checked
 * @param predicate_size the length of the predicate IRI in bytes
 * @param object the detoasted object box, which is copied
 * @return the palloc'd box
 */
static inline RdfBox *GetTripleTermRdfBox(RdfBox *subject, const char *predicate, int predicate_size, RdfBox *object)
{
    int ssize = VARSIZE(subject);
    int psize = predicate_size + VARHDRSZ;
    int osize = VARSIZE(object);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + MAXALIGN(ssize) + MAXALIGN(psize) + osize);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + MAXALIGN(ssize) + MAXALIGN(psize) + osize);
    result->header.type = TRIPLE_TERM;
    memcpy(result->value, subject, ssize);
    SET_VARSIZE(result->value + MAXALIGN(ssize), psize);
    memcpy(VARDATA(result->value + MAXALIGN(ssize)), predicate, predicate_size);
    memcpy(result->value + MAXALIGN(ssize) + MAXALIGN(psize), object, osize);
    return (RdfBox *) result;
}


/**
 * Tests whether a box holds a literal of a numeric datatype, one of #XSD_BYTE .. #XSD_DOUBLE.
 *
 * @param box the box
 * @return true if it does
 */
static inline bool rdfbox_is_numeric(RdfBox *box)
{
    return box->type >= XSD_BYTE && box->type <= XSD_DOUBLE;
}


/**
 * Tests whether a box holds a literal, one of #XSD_BOOLEAN .. #TYPED_LITERAL.
 *
 * @param box the box
 * @return true if it does
 */
static inline bool rdfbox_is_literal(RdfBox *box)
{
    return box->type >= XSD_BOOLEAN && box->type <= TYPED_LITERAL;
}


/**
 * Tests whether a box holds a string literal, an xsd:string or a language-tagged string.
 *
 * @param box the box
 * @return true if it does
 */
static inline bool rdfbox_is_string_literal(RdfBox *box)
{
    return box->type >= XSD_STRING && box->type <= RDF_RTL_LANGSTRING;
}


/**
 * Tests whether a box holds a language-tagged string, with or without a base direction.
 *
 * @param box the box
 * @return true if it does
 */
static inline bool rdfbox_is_langstring(RdfBox *box)
{
    return box->type >= RDF_LANGSTRING && box->type <= RDF_RTL_LANGSTRING;
}


/**
 * Tests whether a box holds a language-tagged string with a base direction.
 *
 * @param box the box
 * @return true if it does
 */
static inline bool rdfbox_is_dirlangstring(RdfBox *box)
{
    return box->type >= RDF_LTR_LANGSTRING && box->type <= RDF_RTL_LANGSTRING;
}


/**
 * Tests whether a box holds a blank node.
 *
 * @param box the box
 * @return true if it does
 */
static inline bool rdfbox_is_blanknode(RdfBox *box)
{
    return box->type >= IBLANKNODE && box->type <= SBLANKNODE;
}

#endif /* RDFBOX_RDFBOX_H_ */
