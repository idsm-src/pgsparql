#include <postgres.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "create.h"


RdfBox *rdfbox_from_boolean(bool value)
{
    RdfBoxBoolean *result = (RdfBoxBoolean *) palloc0(sizeof(RdfBoxBoolean));

    SET_VARSIZE(result, sizeof(RdfBoxBoolean));
    result->header.type = XSD_BOOLEAN;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_short(int16 value)
{
    RdfBoxShort *result = (RdfBoxShort *) palloc0(sizeof(RdfBoxShort));

    SET_VARSIZE(result, sizeof(RdfBoxShort));
    result->header.type = XSD_SHORT;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_int(int32 value)
{
    RdfBoxInt *result = (RdfBoxInt *) palloc0(sizeof(RdfBoxInt));

    SET_VARSIZE(result, sizeof(RdfBoxInt));
    result->header.type = XSD_INT;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_long(int64 value)
{
    RdfBoxLong *result = (RdfBoxLong *) palloc0(sizeof(RdfBoxLong));

    SET_VARSIZE(result, sizeof(RdfBoxLong));
    result->header.type = XSD_LONG;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_float(float4 value)
{
    RdfBoxFloat *result = (RdfBoxFloat *) palloc0(sizeof(RdfBoxFloat));

    SET_VARSIZE(result, sizeof(RdfBoxFloat));
    result->header.type = XSD_FLOAT;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_double(float8 value)
{
    RdfBoxDouble *result = (RdfBoxDouble *) palloc0(sizeof(RdfBoxDouble));

    SET_VARSIZE(result, sizeof(RdfBoxDouble));
    result->header.type = XSD_DOUBLE;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_integer(Numeric value)
{
    int32 size = VARSIZE(value);

    RdfBoxDecinal *result = (RdfBoxDecinal *) palloc0(sizeof(RdfBoxDecinal) + size);

    SET_VARSIZE(result, sizeof(RdfBoxDecinal) + size);
    result->header.type = XSD_INTEGER;
    memcpy(result->value, value, size);

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_decimal(Numeric value)
{
    int32 size = VARSIZE(value);

    RdfBoxDecinal *result = (RdfBoxDecinal *) palloc0(sizeof(RdfBoxDecinal) + size);

    SET_VARSIZE(result, sizeof(RdfBoxDecinal) + size);
    result->header.type = XSD_DECIMAL;
    memcpy(result->value, value, size);

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_datetime(ZonedDateTime *value)
{
    RdfBoxDateTime *result = (RdfBoxDateTime *) palloc0(sizeof(RdfBoxDateTime));

    SET_VARSIZE(result, sizeof(RdfBoxDateTime));
    result->header.type = XSD_DATETIME;
    result->value = *value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_date(ZonedDate value)
{
    RdfBoxDate *result = (RdfBoxDate *) palloc0(sizeof(RdfBoxDate));

    SET_VARSIZE(result, sizeof(RdfBoxDate));
    result->header.type = XSD_DATE;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_daytimeduration(int64 value)
{
    RdfBoxDayTimeDuration *result = (RdfBoxDayTimeDuration *) palloc0(sizeof(RdfBoxDayTimeDuration));

    SET_VARSIZE(result, sizeof(RdfBoxDayTimeDuration));
    result->header.type = XSD_DAYTIMEDURATION;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_string(VarChar *value)
{
    int32 size = VARSIZE(value);

    RdfBoxString *result = (RdfBoxString *) palloc0(sizeof(RdfBoxString) + size);

    SET_VARSIZE(result, sizeof(RdfBoxString) + size);
    result->header.type = XSD_STRING;
    memcpy(result->value, value, size);

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_iri(VarChar *value)
{
    int32 size = VARSIZE(value);

    RdfBoxIri *result = (RdfBoxIri *) palloc0(sizeof(RdfBoxIri) + size);

    SET_VARSIZE(result, sizeof(RdfBoxIri) + size);
    result->header.type = IRI;
    memcpy(result->value, value, size);

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_lang_string(VarChar *value, VarChar *lang)
{
    int32 valueSize = VARSIZE(value);
    int32 langSize = VARSIZE(lang);

    RdfBoxLangString *result = (RdfBoxLangString *) palloc0(sizeof(RdfBoxLangString) + valueSize + langSize);

    SET_VARSIZE(result, sizeof(RdfBoxLangString) + valueSize + langSize);
    result->header.type = RDF_LANGSTRING;
    memcpy(result->value, value, valueSize);
    memcpy(result->value + valueSize, lang, langSize);

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_typed_literal(VarChar *value, VarChar *type)
{
    int32 valueSize = VARSIZE(value);
    int32 typeSize = VARSIZE(type);

    RdfBoxTypedLiteral *result = (RdfBoxTypedLiteral *) palloc0(sizeof(RdfBoxTypedLiteral) + valueSize + typeSize);

    SET_VARSIZE(result, sizeof(RdfBoxTypedLiteral) + valueSize + typeSize);
    result->header.type = TYPED_LITERAL;
    memcpy(result->value, value, valueSize);
    memcpy(result->value + valueSize, type, typeSize);

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_int_blanknode(int64 value)
{
    RdfBoxBlankNodeInt *result = (RdfBoxBlankNodeInt *) palloc0(sizeof(RdfBoxBlankNodeInt));

    SET_VARSIZE(result, sizeof(RdfBoxBlankNodeInt));
    result->header.type = BLANKNODE_INT;
    result->value = value;

    return (RdfBox *) result;
}


RdfBox *rdfbox_from_typed_str_blanknode(VarChar *value)
{
    int32 size = VARSIZE(value);

    RdfBoxBlankNodeStr *result = (RdfBoxBlankNodeStr *) palloc0(sizeof(RdfBoxBlankNodeStr) + size);

    SET_VARSIZE(result, sizeof(RdfBoxBlankNodeStr) + size);
    result->header.type = BLANKNODE_STR;
    memcpy(result->value, value, size);

    return (RdfBox *) result;
}
