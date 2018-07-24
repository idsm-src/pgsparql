#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include "rdfbox.h"
#include "cast/cast.h"


PG_FUNCTION_INFO_V1(equal_rdfbox);
Datum equal_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    bool isNull = false;
    Datum result;

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        result = BoolGetDatum(((RdfBoxBoolean *) left)->value == ((RdfBoxBoolean *) right)->value);
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(left)));
            float8 r = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l == r);
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(left)));
            float4 r = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l == r);
        }
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(left)));
            Numeric r = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(right)));
            result = DirectFunctionCall2(numeric_eq, NumericGetDatum(l), NumericGetDatum(r));

            pfree(l);
            pfree(r);
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
        {
            int64 l = DatumGetInt64(DirectFunctionCall1(cast_as_long_from_rdfbox, RdfBoxGetDatum(left)));
            int64 r = DatumGetInt64(DirectFunctionCall1(cast_as_long_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l == r);
        }
        else if(left->type == XSD_INT || right->type == XSD_INT)
        {
            int32 l = DatumGetInt32(DirectFunctionCall1(cast_as_int_from_rdfbox, RdfBoxGetDatum(left)));
            int32 r = DatumGetInt32(DirectFunctionCall1(cast_as_int_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l == r);
        }
        else //if(left->type == XSD_SHORT || right->type == XSD_SHORT)
        {
            int16 l = DatumGetInt16(DirectFunctionCall1(cast_as_short_from_rdfbox, RdfBoxGetDatum(left)));
            int16 r = DatumGetInt16(DirectFunctionCall1(cast_as_short_from_rdfbox, RdfBoxGetDatum(right)));
            result = BoolGetDatum(l == r);
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = &((RdfBoxDateTime *) left)->value;
        ZonedDateTime *r = &((RdfBoxDateTime *) right)->value;
        result = DirectFunctionCall2(zoneddatetime_equal, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = ((RdfBoxDate *) left)->value;
        ZonedDate r = ((RdfBoxDate *) right)->value;
        result = DirectFunctionCall2(zoneddate_equal, ZonedDateGetDatum(l), ZonedDateGetDatum(r));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = ((RdfBoxDayTimeDuration *) left)->value;
        int64 r = ((RdfBoxDayTimeDuration *) right)->value;
        result = BoolGetDatum(l == r);
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        result = BoolGetDatum(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == RDF_LANGSTRING && right->type == RDF_LANGSTRING)
    {
        result = BoolGetDatum(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == TYPED_LITERAL && right->type == TYPED_LITERAL)
    {
        if(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0)
            result = BoolGetDatum(true);
        else
            isNull = true;
    }
    else if(rdfbox_is_literal(left) && rdfbox_is_literal(right))
    {
        isNull = true;
    }
    else if(left->type == IRI && right->type == IRI)
    {
        result = BoolGetDatum(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else if(left->type == BLANKNODE_INT && right->type == BLANKNODE_INT)
    {
        RdfBoxBlankNodeInt *l = (RdfBoxBlankNodeInt *) left;
        RdfBoxBlankNodeInt *r = (RdfBoxBlankNodeInt *) right;
        result = BoolGetDatum(l->space == r->space && l->value == r->value);
    }
    else if(left->type == BLANKNODE_STR && right->type == BLANKNODE_STR)
    {
        result = BoolGetDatum(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);
    }
    else
    {
        result = BoolGetDatum(false);
    }

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    if(isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result);
}
