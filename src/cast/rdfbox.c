#include <postgres.h>
#include "rdfbox.h"
#include "create.h"


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_boolean);
Datum cast_as_rdfbox_from_boolean(PG_FUNCTION_ARGS)
{
    bool value = PG_GETARG_BOOL(0);
    RdfBox *result = rdfbox_from_boolean(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_short);
Datum cast_as_rdfbox_from_short(PG_FUNCTION_ARGS)
{
    int16 value = PG_GETARG_INT16(0);
    RdfBox *result = rdfbox_from_short(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_int);
Datum cast_as_rdfbox_from_int(PG_FUNCTION_ARGS)
{
    int32 value = PG_GETARG_INT32(0);
    RdfBox *result = rdfbox_from_int(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_long);
Datum cast_as_rdfbox_from_long(PG_FUNCTION_ARGS)
{
    int64 value = PG_GETARG_INT64(0);
    RdfBox *result = rdfbox_from_long(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_float);
Datum cast_as_rdfbox_from_float(PG_FUNCTION_ARGS)
{
    float4 value = PG_GETARG_FLOAT4(0);
    RdfBox *result = rdfbox_from_float(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_double);
Datum cast_as_rdfbox_from_double(PG_FUNCTION_ARGS)
{
    float8 value = PG_GETARG_FLOAT8(0);
    RdfBox *result = rdfbox_from_double(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_integer);
Datum cast_as_rdfbox_from_integer(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    RdfBox *result = rdfbox_from_integer(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_decimal);
Datum cast_as_rdfbox_from_decimal(PG_FUNCTION_ARGS)
{
    Numeric value = PG_GETARG_NUMERIC(0);
    RdfBox *result = rdfbox_from_decimal(value);
    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(cast_as_rdfbox_from_string);
Datum cast_as_rdfbox_from_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    RdfBox *result = rdfbox_from_string(value);
    PG_RETURN_RDFBOX_P(result);
}
