#ifndef RDFBOX_H_
#define RDFBOX_H_

#include <postgres.h>
#include "date/date.h"
#include "date/datetime.h"


typedef enum
{
    XSD_BOOLEAN,
    XSD_SHORT,
    XSD_INT,
    XSD_LONG,
    XSD_FLOAT,
    XSD_DOUBLE,
    XSD_INTEGER,
    XSD_DECIMAL,
    XSD_DATETIME,
    XSD_DATE,
    XSD_DAYTIMEDURATION,
    XSD_STRING,
    RDF_LANGSTRING,
    TYPED_LITERAL,
    IRI,
    BLANKNODE_INT,
    BLANKNODE_STR
} RdfType;


typedef struct
{
    char vl_len_[4];
    RdfType type;
} RdfBox;


typedef struct
{
    RdfBox header;
    bool value;
} RdfBoxBoolean;


typedef struct
{
    RdfBox header;
    int16 value;
} RdfBoxShort;


typedef struct
{
    RdfBox header;
    int32 value;
} RdfBoxInt;


typedef struct
{
    RdfBox header;
    int64 value;
} RdfBoxLong;


typedef struct
{
    RdfBox header;
    float4 value;
} RdfBoxFloat;


typedef struct
{
    RdfBox header;
    float8 value;
} RdfBoxDouble;


typedef struct
{
    RdfBox header;
    char value[];
} RdfBoxDecinal;


typedef struct
{
    RdfBox header;
    ZonedDateTime value;
} RdfBoxDateTime;


typedef struct
{
    RdfBox header;
    ZonedDate value;
} RdfBoxDate;


typedef struct
{
    RdfBox header;
    int64 value;
} RdfBoxDayTimeDuration;


typedef struct
{
    RdfBox header;
    char value[];
} RdfBoxString;


typedef struct
{
    RdfBox header;
    char value[];
} RdfBoxLangString;


typedef struct
{
    RdfBox header;
    char value[];
} RdfBoxTypedLiteral;


typedef struct
{
    RdfBox header;
    char value[];
} RdfBoxIri;


typedef struct
{
    RdfBox header;
    int32 value;
} RdfBoxBlankNodeInt;


typedef struct
{
    RdfBox header;
    char value[];
} RdfBoxBlankNodeStr;


#define DatumGetRdfBox(X)       ((RdfBox *) PG_DETOAST_DATUM(X))
#define RdfBoxGetDatum(X)       PointerGetDatum(X)
#define PG_GETARG_RDFBOX_P(n)   DatumGetRdfBox(PG_GETARG_DATUM(n))
#define PG_RETURN_RDFBOX_P(x)	return RdfBoxGetDatum(x)


static inline bool rdfbox_is_numeric(RdfBox *rdfbox)
{
    return rdfbox->type >= XSD_SHORT && rdfbox->type <=  XSD_DECIMAL;
}

#endif /* RDFBOX_H_ */
