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

    RdfBoxInteger *result = (RdfBoxInteger *) palloc0(sizeof(RdfBoxInteger) + size);

    SET_VARSIZE(result, sizeof(RdfBoxInteger) + size);
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


RdfBox *rdfbox_from_string(VarChar *value)
{
    int32 size = VARSIZE(value);

    RdfBoxString *result = (RdfBoxString *) palloc0(sizeof(RdfBoxString) + size);

    SET_VARSIZE(result, sizeof(RdfBoxString) + size);
    result->header.type = XSD_STRING;
    memcpy(result->value, value, size);

    return (RdfBox *) result;
}
