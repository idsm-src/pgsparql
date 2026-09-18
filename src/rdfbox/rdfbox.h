#ifndef RDFBOX_RDFBOX_H_
#define RDFBOX_RDFBOX_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/numeric.h>
#include "types/date.h"
#include "types/datetime.h"
#include "types/ubox.h"


/*
 * The order of the types is semantic:
 *
 *   - XSD_BOOLEAN .. TYPED_LITERAL are the literals (rdfbox_is_literal) and XSD_BYTE .. XSD_DOUBLE the numbers
 *     among them (rdfbox_is_numeric),
 *
 *   - the numeric types are listed so that for each promotion target (xsd:short, xsd:int, xsd:long, xsd:integer,
 *     xsd:decimal, xsd:float and xsd:double) the types from XSD_BYTE up to the target are exactly those whose values
 *     the SQL type of the target represents; rdfbox/derivate.c and rdfbox/promotion.h rely on it,
 *
 *   - the values of XSD_BYTE .. XSD_LONG are held in an integer of at most 64 bits, the value of XSD_UNSIGNEDLONG in
 *     a uint64 and the values of XSD_INTEGER .. XSD_DECIMAL in a numeric; rdfbox/order.c relies on it,
 *
 *   - rdfbox/order.c orders numbers of the same value by their types and blank nodes, IRIs and literals by the
 *     reversed order of their types,
 *
 *   - functions/rdfterm.c indexes the table of datatype IRIs by the type,
 *
 *   - the type is a part of the stored representation and of the binary format read by rdfbox_recv().
 */
typedef enum
{
    XSD_BOOLEAN = 0,
    XSD_BYTE = 1,
    XSD_UNSIGNEDBYTE = 2,
    XSD_SHORT = 3,
    XSD_UNSIGNEDSHORT = 4,
    XSD_INT = 5,
    XSD_UNSIGNEDINT = 6,
    XSD_LONG = 7,
    XSD_UNSIGNEDLONG = 8,
    XSD_INTEGER = 9,
    XSD_NONPOSITIVEINTEGER = 10,
    XSD_NEGATIVEINTEGER = 11,
    XSD_NONNEGATIVEINTEGER = 12,
    XSD_POSITIVEINTEGER = 13,
    XSD_DECIMAL = 14,
    XSD_FLOAT = 15,
    XSD_DOUBLE = 16,
    XSD_DATETIME = 17,
    XSD_DATE = 18,
    XSD_DAYTIMEDURATION = 19,
    XSD_STRING = 20,
    RDF_LANGSTRING = 21,
    USER_LITERAL = 22,
    TYPED_LITERAL = 23,
    IRI = 24,
    IBLANKNODE = 25,
    SBLANKNODE = 26
}
RdfType;


typedef struct
{
    char vl_len_[4];
    RdfType type : 31;
    bool lexical : 1;
}
RdfBox;


typedef struct
{
    RdfBox header;
    bool value;
}
RdfBoxBool;


typedef struct
{
    RdfBox header;
    int16 value;
}
RdfBoxInt16;


typedef struct
{
    RdfBox header;
    int32 value;
}
RdfBoxInt32;


typedef struct
{
    RdfBox header;
    uint32 value;
}
RdfBoxUInt32;


typedef struct
{
    RdfBox header;
    int64 value;
}
RdfBoxInt64;


typedef struct
{
    RdfBox header;
    uint64 value;
}
RdfBoxUInt64;


typedef struct
{
    RdfBox header;
    float4 value;
}
RdfBoxFloat4;


typedef struct
{
    RdfBox header;
    float8 value;
}
RdfBoxFloat8;


typedef struct
{
    RdfBox header;
    ZonedDateTime value;
}
RdfBoxDateTime;


typedef struct
{
    RdfBox header;
    ZonedDate value;
}
RdfBoxDate;


typedef struct
{
    RdfBox header;
    char value[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxVarlena;


typedef struct
{
    RdfBoxBool box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxBoolWithLexical;


typedef struct
{
    RdfBoxInt16 box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxInt16WithLexical;


typedef struct
{
    RdfBoxInt32 box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxInt32WithLexical;


typedef struct
{
    RdfBoxUInt32 box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxUInt32WithLexical;


typedef struct
{
    RdfBoxInt64 box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxInt64WithLexical;


typedef struct
{
    RdfBoxUInt64 box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxUInt64WithLexical;


typedef struct
{
    RdfBoxFloat4 box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxFloat4WithLexical;


typedef struct
{
    RdfBoxFloat8 box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxFloat8WithLexical;


typedef struct
{
    RdfBoxDateTime box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxDateTimeWithLexical;


typedef struct
{
    RdfBoxDate box;
    char lexical[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
RdfBoxDateWithLexical;


#define DatumGetRdfBox(X)       ((RdfBox *) PG_DETOAST_DATUM(X))
#define RdfBoxGetDatum(X)       PointerGetDatum(X)
#define PG_GETARG_RDFBOX_P(n)   DatumGetRdfBox(PG_GETARG_DATUM(n))
#define PG_RETURN_RDFBOX_P(x)   return RdfBoxGetDatum(x)


typedef enum
{
    LEXICAL_BOTH,
    LEXICAL_TRUE,
    LEXICAL_FALSE
}
LexicalFlag;


#define PG_GETARG_LEXICAL_FLAG(n)  ((n) == PG_NARGS() ? LEXICAL_BOTH : (PG_GETARG_BOOL(n) ? LEXICAL_TRUE : LEXICAL_FALSE))


static inline bool RdfBoxCheckLexicalFlag(RdfBox *box, LexicalFlag flag)
{
    if(flag == LEXICAL_BOTH)
        return true;

    return box->lexical == (flag == LEXICAL_TRUE);
}


static inline uint32 align_size(uint32 n)
{
    return (n + 3) & 0xFFFFFFFC;
}


static inline bool RdfBoxGetBool(RdfBox *box)
{
    return ((RdfBoxBool *) box)->value;
}


static inline int8 RdfBoxGetInt8(RdfBox *box)
{
    return (int8) ((RdfBoxInt16 *) box)->value;
}


static inline uint8 RdfBoxGetUInt8(RdfBox *box)
{
    return (uint8) ((RdfBoxInt16 *) box)->value;
}


static inline int16 RdfBoxGetInt16(RdfBox *box)
{
    return ((RdfBoxInt16 *) box)->value;
}


static inline uint16 RdfBoxGetUInt16(RdfBox *box)
{
    return (uint16) ((RdfBoxInt32 *) box)->value;
}


static inline int32 RdfBoxGetInt32(RdfBox *box)
{
    return ((RdfBoxInt32 *) box)->value;
}


static inline uint32 RdfBoxGetUInt32(RdfBox *box)
{
    return ((RdfBoxUInt32 *) box)->value;
}


static inline int64 RdfBoxGetInt64(RdfBox *box)
{
    return ((RdfBoxInt64 *) box)->value;
}


static inline uint64 RdfBoxGetUInt64(RdfBox *box)
{
    return ((RdfBoxUInt64 *) box)->value;
}


static inline Numeric RdfBoxGetNumeric(RdfBox *box)
{
    return (Numeric) ((RdfBoxVarlena *) box)->value;
}


static inline float4 RdfBoxGetFloat4(RdfBox *box)
{
    return ((RdfBoxFloat4 *) box)->value;
}


static inline float8 RdfBoxGetFloat8(RdfBox *box)
{
    return ((RdfBoxFloat8 *) box)->value;
}


static inline ZonedDateTime *RdfBoxGetZonedDateTime(RdfBox *box)
{
    return &((RdfBoxDateTime *) box)->value;
}


static inline ZonedDate RdfBoxGetZonedDate(RdfBox *box)
{
    return ((RdfBoxDate *) box)->value;
}


static inline VarChar *RdfBoxGetVarChar(RdfBox *box)
{
    return (VarChar *) ((RdfBoxVarlena *) box)->value;
}


static inline VarChar *RdfBoxGetAttachment(RdfBox *box)
{
    VarChar *value = (VarChar *) ((RdfBoxVarlena *) box)->value;
    return (VarChar *) (((RdfBoxVarlena *) box)->value + align_size(VARSIZE(value)));
}


static inline UBox *RdfBoxGetUBox(RdfBox *box)
{
    return (UBox *) ((RdfBoxVarlena *) box)->value;
}


static inline VarChar *RdfBoxGetBoolLexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxBoolWithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetInt16Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxInt16WithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetInt32Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxInt32WithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetUInt32Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxUInt32WithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetInt64Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxInt64WithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetUInt64Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxUInt64WithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetFloat4Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxFloat4WithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetFloat8Lexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxFloat8WithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetZonedDateTimeLexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxDateTimeWithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetZonedDateLexical(RdfBox *box)
{
    return (VarChar *) ((RdfBoxDateWithLexical *) box)->lexical;
}


static inline VarChar *RdfBoxGetUserLiteralLexical(RdfBox *box)
{
    char *value = ((RdfBoxVarlena *) box)->value;
    char *type = value + align_size(VARSIZE(value));

    return (VarChar *) (type + align_size(VARSIZE(type)));
}


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


static inline RdfBox *GetBooleanRdfBox(bool value)
{
    RdfBoxBool *result = (RdfBoxBool *) palloc0(sizeof(RdfBoxBool));
    SET_VARSIZE(result, sizeof(RdfBoxBool));
    result->header.type = XSD_BOOLEAN;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetByteRdfBox(int8 value)
{
    RdfBoxInt16 *result = (RdfBoxInt16 *) palloc0(sizeof(RdfBoxInt16));
    SET_VARSIZE(result, sizeof(RdfBoxInt16));
    result->header.type = XSD_BYTE;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetUnsignedByteRdfBox(uint8 value)
{
    RdfBoxInt16 *result = (RdfBoxInt16 *) palloc0(sizeof(RdfBoxInt16));
    SET_VARSIZE(result, sizeof(RdfBoxInt16));
    result->header.type = XSD_UNSIGNEDBYTE;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetShortRdfBox(int16 value)
{
    RdfBoxInt16 *result = (RdfBoxInt16 *) palloc0(sizeof(RdfBoxInt16));
    SET_VARSIZE(result, sizeof(RdfBoxInt16));
    result->header.type = XSD_SHORT;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetUnsignedShortRdfBox(uint16 value)
{
    RdfBoxInt32 *result = (RdfBoxInt32 *) palloc0(sizeof(RdfBoxInt32));
    SET_VARSIZE(result, sizeof(RdfBoxInt32));
    result->header.type = XSD_UNSIGNEDSHORT;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetIntRdfBox(int32 value)
{
    RdfBoxInt32 *result = (RdfBoxInt32 *) palloc0(sizeof(RdfBoxInt32));
    SET_VARSIZE(result, sizeof(RdfBoxInt32));
    result->header.type = XSD_INT;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetUnsignedIntRdfBox(uint32 value)
{
    RdfBoxUInt32 *result = (RdfBoxUInt32 *) palloc0(sizeof(RdfBoxUInt32));
    SET_VARSIZE(result, sizeof(RdfBoxUInt32));
    result->header.type = XSD_UNSIGNEDINT;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetLongRdfBox(int64 value)
{
    RdfBoxInt64 *result = (RdfBoxInt64 *) palloc0(sizeof(RdfBoxInt64));
    SET_VARSIZE(result, sizeof(RdfBoxInt64));
    result->header.type = XSD_LONG;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetUnsignedLongRdfBox(uint64 value)
{
    RdfBoxUInt64 *result = (RdfBoxUInt64 *) palloc0(sizeof(RdfBoxUInt64));
    SET_VARSIZE(result, sizeof(RdfBoxUInt64));
    result->header.type = XSD_UNSIGNEDLONG;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetIntegerRdfBox(Numeric value)
{
    int size = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_INTEGER;
    memcpy(result->value, value, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetNonPositiveIntegerRdfBox(Numeric value)
{
    int size = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_NONPOSITIVEINTEGER;
    memcpy(result->value, value, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetNegativeIntegerRdfBox(Numeric value)
{
    int size = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_NEGATIVEINTEGER;
    memcpy(result->value, value, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetNonNegativeIntegerRdfBox(Numeric value)
{
    int size = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_NONNEGATIVEINTEGER;
    memcpy(result->value, value, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetPositiveIntegerRdfBox(Numeric value)
{
    int size = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_POSITIVEINTEGER;
    memcpy(result->value, value, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetDecimalRdfBox(Numeric value)
{
    int size = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + size);
    result->header.type = XSD_DECIMAL;
    memcpy(result->value, value, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetFloatRdfBox(float4 value)
{
    RdfBoxFloat4 *result = (RdfBoxFloat4 *) palloc0(sizeof(RdfBoxFloat4));
    SET_VARSIZE(result, sizeof(RdfBoxFloat4));
    result->header.type = XSD_FLOAT;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetDoubleRdfBox(float8 value)
{
    RdfBoxFloat8 *result = (RdfBoxFloat8 *) palloc0(sizeof(RdfBoxFloat8));
    SET_VARSIZE(result, sizeof(RdfBoxFloat8));
    result->header.type = XSD_DOUBLE;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetDateTimeRdfBox(ZonedDateTime *value)
{
    RdfBoxDateTime *result = (RdfBoxDateTime *) palloc0(sizeof(RdfBoxDateTime));
    SET_VARSIZE(result, sizeof(RdfBoxDateTime));
    result->header.type = XSD_DATETIME;
    result->value = *value;
    return (RdfBox *) result;
}


static inline RdfBox *GetDateRdfBox(ZonedDate value)
{
    RdfBoxDate *result = (RdfBoxDate *) palloc0(sizeof(RdfBoxDate));
    SET_VARSIZE(result, sizeof(RdfBoxDate));
    result->header.type = XSD_DATE;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetDayTimeDurationRdfBox(int64 value)
{
    RdfBoxInt64 *result = (RdfBoxInt64 *) palloc0(sizeof(RdfBoxInt64));
    SET_VARSIZE(result, sizeof(RdfBoxInt64));
    result->header.type = XSD_DAYTIMEDURATION;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetStringRdfBox(const char *data, int size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    result->header.type = XSD_STRING;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    return (RdfBox *) result;
}


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


static inline RdfBox *GetIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    int nsize = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_INTEGER;
    result->header.lexical = true;
    memcpy(result->value, value, nsize);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetNonPositiveIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    int nsize = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_NONPOSITIVEINTEGER;
    result->header.lexical = true;
    memcpy(result->value, value, nsize);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetNegativeIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    int nsize = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_NEGATIVEINTEGER;
    result->header.lexical = true;
    memcpy(result->value, value, nsize);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetNonNegativeIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    int nsize = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_NONNEGATIVEINTEGER;
    result->header.lexical = true;
    memcpy(result->value, value, nsize);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetPositiveIntegerRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    int nsize = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_POSITIVEINTEGER;
    result->header.lexical = true;
    memcpy(result->value, value, nsize);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetDecimalRdfBoxWithLexical(Numeric value, const char *data, int size)
{
    int nsize = VARSIZE(value);
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + align_size(nsize) + VARHDRSZ + size);
    result->header.type = XSD_DECIMAL;
    result->header.lexical = true;
    memcpy(result->value, value, nsize);
    SET_VARSIZE(result->value + align_size(nsize), size + VARHDRSZ);
    memcpy(VARDATA(result->value + align_size(nsize)), data, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetFloatRdfBoxWithLexical(float4 value, const char *data, int size)
{
    RdfBoxFloat4WithLexical *result = (RdfBoxFloat4WithLexical *) palloc0(sizeof(RdfBoxFloat4WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxFloat4WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_FLOAT;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetDoubleRdfBoxWithLexical(float8 value, const char *data, int size)
{
    RdfBoxFloat8WithLexical *result = (RdfBoxFloat8WithLexical *) palloc0(sizeof(RdfBoxFloat8WithLexical) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxFloat8WithLexical) + VARHDRSZ + size);
    result->box.header.type = XSD_DOUBLE;
    result->box.header.lexical = true;
    result->box.value = value;
    SET_VARSIZE(result->lexical, size + VARHDRSZ);
    memcpy(VARDATA(result->lexical), data, size);
    return (RdfBox *) result;
}


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


static inline RdfBox *GetIriRdfBox(const char *data, int size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    result->header.type = IRI;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    return (RdfBox *) result;
}


static inline RdfBox *GetIBlankNodeRdfBox(int64 value)
{
    RdfBoxInt64 *result = (RdfBoxInt64 *) palloc0(sizeof(RdfBoxInt64));
    SET_VARSIZE(result, sizeof(RdfBoxInt64));
    result->header.type = IBLANKNODE;
    result->value = value;
    return (RdfBox *) result;
}


static inline RdfBox *GetSBlankNodeRdfBox(const char *data, int size)
{
    RdfBoxVarlena *result = (RdfBoxVarlena *) palloc0(sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    SET_VARSIZE(result, sizeof(RdfBoxVarlena) + VARHDRSZ + size);
    result->header.type = SBLANKNODE;
    SET_VARSIZE(result->value, size + VARHDRSZ);
    memcpy(VARDATA(result->value), data, size);
    return (RdfBox *) result;
}


static inline bool rdfbox_is_numeric(RdfBox *box)
{
    return box->type >= XSD_BYTE && box->type <= XSD_DOUBLE;
}


static inline bool rdfbox_is_literal(RdfBox *box)
{
    return box->type >= XSD_BOOLEAN && box->type <= TYPED_LITERAL;
}

#endif /* RDFBOX_RDFBOX_H_ */
