#include <postgres.h>
#include <utils/builtins.h>
#include <utils/datetime.h>
#include <utils/numeric.h>
#include <inttypes.h>
#include <miscadmin.h>
#include "rdfbox.h"
#include "xsd.h"
#include "cast/cast.h"


#define IRI_BEGIN       "<"
#define IRI_END         ">"
#define LANG_DELIM      "@"
#define TYPE_DELIM      "^^"
#define VALUE_DELIM     "\""
#define BLKNODE_PREFIX  "_:"
#define PREFIX          VALUE_DELIM
#define SUFFIX(X)       VALUE_DELIM TYPE_DELIM IRI_BEGIN X IRI_END
#define STRLEN(X)       (sizeof(X) - 1)
#define PREFIX_SIZE     (STRLEN(PREFIX))
#define SUFFIX_SIZE(X)  (STRLEN(SUFFIX(X)))

#define compare(a,b)        (((a)==(b)) ? 0 : (((a)<(b)) ? -1 : 1))


PG_FUNCTION_INFO_V1(rdfbox_input);
Datum rdfbox_input(PG_FUNCTION_ARGS)
{
    ereport(ERROR, (errcode(ERRCODE_DATA_EXCEPTION), errmsg("rdfbox input function is not implemented")));
}


PG_FUNCTION_INFO_V1(rdfbox_output);
Datum rdfbox_output(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    char *result = NULL;


    switch(box->type)
    {
        case XSD_BOOLEAN:
        {
            bool value = ((RdfBoxBoolean *) box)->value;

            size_t buffsize = PREFIX_SIZE + (value ? 4 : 5) + SUFFIX_SIZE(XSD_BOOLEAN_IRI) + 1;
            result = (char *) palloc0(buffsize);

            if(value)
                snprintf(result, buffsize, PREFIX "true" SUFFIX(XSD_BOOLEAN_IRI));
            else
                snprintf(result, buffsize, PREFIX "false" SUFFIX(XSD_BOOLEAN_IRI));

            break;
        }

        case XSD_SHORT:
        {
            int16 value = ((RdfBoxShort *) box)->value;

            size_t buffsize = PREFIX_SIZE + 6 + SUFFIX_SIZE(XSD_SHORT_IRI) + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, PREFIX "%" SCNi16 SUFFIX(XSD_SHORT_IRI), value);
            break;
        }

        case XSD_INT:
        {
            int32 value = ((RdfBoxInt *) box)->value;

            size_t buffsize = PREFIX_SIZE + 11 + SUFFIX_SIZE(XSD_INT_IRI) + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, PREFIX "%" SCNi32 SUFFIX(XSD_INT_IRI), value);
            break;
        }

        case XSD_LONG:
        {
            int64 value = ((RdfBoxLong *) box)->value;

            size_t buffsize = PREFIX_SIZE + 20 + SUFFIX_SIZE(XSD_LONG_IRI) + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, PREFIX "%" SCNi64 SUFFIX(XSD_LONG_IRI), value);
            break;
        }

        case XSD_FLOAT:
        {
            float4 value = ((RdfBoxFloat *) box)->value;

            if(!isinf(value))
            {
                Numeric numeric = DatumGetNumeric(DirectFunctionCall1(float4_numeric, Float4GetDatum(value)));
                char *data = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(numeric)));

                size_t length = strlen(data);
                result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_FLOAT_IRI) + 1);

                memcpy(result, PREFIX, PREFIX_SIZE);
                memcpy(result + PREFIX_SIZE, data, length);
                memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_FLOAT_IRI), SUFFIX_SIZE(XSD_FLOAT_IRI));

                pfree(data);
                pfree(numeric);
            }
            else if(value > 0)
            {
                result = pstrdup(PREFIX "INF" SUFFIX(XSD_FLOAT_IRI));
            }
            else
            {
                result = pstrdup(PREFIX "-INF" SUFFIX(XSD_FLOAT_IRI) );
            }

            break;
        }

        case XSD_DOUBLE:
        {
            float8 value = ((RdfBoxDouble *) box)->value;

            if(!isinf(value))
            {
                Numeric numeric = DatumGetNumeric(DirectFunctionCall1(float8_numeric, Float8GetDatum(value)));
                char *data = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(numeric)));

                size_t length = strlen(data);
                result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DOUBLE_IRI) + 1);

                memcpy(result, PREFIX, PREFIX_SIZE);
                memcpy(result + PREFIX_SIZE, data, length);
                memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DOUBLE_IRI), SUFFIX_SIZE(XSD_DOUBLE_IRI));

                pfree(data);
                pfree(numeric);
            }
            else if(value > 0)
            {
                result = pstrdup(PREFIX "INF" SUFFIX(XSD_DOUBLE_IRI));
            }
            else
            {
                result = pstrdup(PREFIX "-INF" SUFFIX(XSD_DOUBLE_IRI));
            }

            break;
        }

        case XSD_INTEGER:
        {
            Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
            char *data = numeric_normalize(value);

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_INTEGER_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_INTEGER_IRI), SUFFIX_SIZE(XSD_INTEGER_IRI));

            pfree(data);
            break;
        }

        case XSD_DECIMAL:
        {
            Numeric value = (Numeric) ((RdfBoxDecinal *) box)->value;
            char *data = numeric_normalize(value);

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DECIMAL_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DECIMAL_IRI), SUFFIX_SIZE(XSD_DECIMAL_IRI));

            pfree(data);
            break;
        }

        case XSD_DATETIME:
        {
            ZonedDateTime *value = &((RdfBoxDateTime *) box)->value;
            char *data = DatumGetCString(DirectFunctionCall1(zoneddatetime_output, ZonedDateTimeGetDatum(value)));

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DATETIME_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DATETIME_IRI), SUFFIX_SIZE(XSD_DATETIME_IRI));

            pfree(data);
            break;
        }

        case XSD_DATE:
        {
            ZonedDate value = ((RdfBoxDate *) box)->value;
            char *data = DatumGetCString(DirectFunctionCall1(zoneddate_output, ZonedDateGetDatum(value)));

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DATE_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DATE_IRI), SUFFIX_SIZE(XSD_DATE_IRI));

            pfree(data);
            break;
        }

        case XSD_DAYTIMEDURATION:
        {
            int64 value = ((RdfBoxDayTimeDuration *) box)->value;
            char *data = DatumGetCString(DirectFunctionCall1(daytimeduration_output, Int64GetDatum(value)));

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DAYTIMEDURATION_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DAYTIMEDURATION_IRI), SUFFIX_SIZE(XSD_DAYTIMEDURATION_IRI));

            pfree(data);
            break;
        }

        case XSD_STRING:
        {
            Datum datum = PointerGetDatum(((RdfBoxString *) box)->value);

            size_t length = VARSIZE(datum) - VARHDRSZ;
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_STRING_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, VARDATA(datum), length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_STRING_IRI), SUFFIX_SIZE(XSD_STRING_IRI));

            break;
        }

        case RDF_LANGSTRING:
        {
            VarChar *value = (VarChar *) ((RdfBoxLangString *) box)->value;
            size_t size = VARSIZE(value);
            VarChar *lang = (VarChar *) (((RdfBoxLangString *) box)->value + size);

            int32 valueLength = size - VARHDRSZ;
            int32 langLength = VARSIZE(lang) - VARHDRSZ;

            result = (char *) palloc0(PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM LANG_DELIM) + langLength + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, VARDATA(value), valueLength);
            memcpy(result + PREFIX_SIZE + valueLength, VALUE_DELIM LANG_DELIM, STRLEN(VALUE_DELIM LANG_DELIM));
            memcpy(result + PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM LANG_DELIM), VARDATA(lang), langLength);

            break;
        }

        case TYPED_LITERAL:
        {
            VarChar *value = (VarChar *) ((RdfBoxTypedLiteral *) box)->value;
            size_t size = VARSIZE(value);
            VarChar *type = (VarChar *) (((RdfBoxTypedLiteral *) box)->value + size);

            int32 valueLength = size - VARHDRSZ;
            int32 typeLength = VARSIZE(type) - VARHDRSZ;

            result = (char *) palloc0(PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM TYPE_DELIM IRI_BEGIN) + typeLength + STRLEN(IRI_END) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, VARDATA(value), valueLength);
            memcpy(result + PREFIX_SIZE + valueLength, VALUE_DELIM TYPE_DELIM IRI_BEGIN, STRLEN(VALUE_DELIM TYPE_DELIM IRI_BEGIN));
            memcpy(result + PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM TYPE_DELIM IRI_BEGIN), VARDATA(type), typeLength);
            memcpy(result + PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM TYPE_DELIM IRI_BEGIN) + typeLength, IRI_END, STRLEN(IRI_END));

            break;
        }

        case IRI:
        {
            Datum datum = PointerGetDatum(((RdfBoxIri *) box)->value);

            size_t length = VARSIZE(datum) - VARHDRSZ;
            result = (char *) palloc0(STRLEN(IRI_BEGIN) + length + STRLEN(IRI_END) + 1);

            memcpy(result, IRI_BEGIN, STRLEN(IRI_BEGIN));
            memcpy(result + STRLEN(IRI_BEGIN), VARDATA(datum), length);
            memcpy(result + STRLEN(IRI_BEGIN) + length, IRI_END, STRLEN(IRI_END));

            break;
        }

        case BLANKNODE_INT:
        {
            int64 value = ((RdfBoxBlankNodeInt *) box)->value;

            size_t buffsize = STRLEN(BLKNODE_PREFIX) + 11 + 1 + 11 + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, BLKNODE_PREFIX "%" SCNi64, value);
            break;
        }

        case BLANKNODE_STR:
        {
            Datum datum = PointerGetDatum(((RdfBoxBlankNodeStr *) box)->value);

            size_t length = VARSIZE(datum) - VARHDRSZ;
            result = (char *) palloc0(STRLEN(BLKNODE_PREFIX VALUE_DELIM) + length + STRLEN(VALUE_DELIM) + 1);

            memcpy(result, BLKNODE_PREFIX VALUE_DELIM, STRLEN(BLKNODE_PREFIX VALUE_DELIM));
            memcpy(result + STRLEN(BLKNODE_PREFIX VALUE_DELIM), VARDATA(datum), length);
            memcpy(result + STRLEN(BLKNODE_PREFIX VALUE_DELIM) + length, VALUE_DELIM, STRLEN(VALUE_DELIM));

            break;
        }
    }

    PG_FREE_IF_COPY(box, 0);

    if(result)
        PG_RETURN_CSTRING(result);
    else
        PG_RETURN_NULL();
}


static int32 varchar_compare(VarChar *l, VarChar *r)
{
        int v = memcmp(VARDATA(l), VARDATA(r), Min(VARSIZE(l), VARSIZE(r)) - VARHDRSZ);

        if(v != 0)
            return v;

        return VARSIZE(l) - VARSIZE(r);
}


PG_FUNCTION_INFO_V1(rdfbox_order_compare);
Datum rdfbox_order_compare(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    Datum result;

    if(left->type == XSD_BOOLEAN && right->type == XSD_BOOLEAN)
    {
        result = Int32GetDatum(compare(((RdfBoxBoolean *) left)->value, ((RdfBoxBoolean *) right)->value));
    }
    else if(rdfbox_is_numeric(left) && rdfbox_is_numeric(right))
    {
        if(left->type == XSD_DOUBLE || right->type == XSD_DOUBLE)
        {
            float8 l = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(left)));
            float8 r = DatumGetFloat8(DirectFunctionCall1(cast_as_double_from_rdfbox, RdfBoxGetDatum(right)));

            if(isnan(l) && isnan(r))
                result = Int32GetDatum(0);
            else if(isnan(l))
                result = Int32GetDatum(1);
            else if(isnan(r))
                result = Int32GetDatum(-1);
            else
                result = Int32GetDatum(compare(l, r));
        }
        else if(left->type == XSD_FLOAT || right->type == XSD_FLOAT)
        {
            float4 l = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(left)));
            float4 r = DatumGetFloat4(DirectFunctionCall1(cast_as_float_from_rdfbox, RdfBoxGetDatum(right)));

            if(isnanf(l) && isnanf(r))
                result = Int32GetDatum(0);
            else if(isnanf(l))
                result = Int32GetDatum(1);
            else if(isnanf(r))
                result = Int32GetDatum(-1);
            else
                result = Int32GetDatum(compare(l, r));
        }
        else if(left->type == XSD_INTEGER || left->type == XSD_DECIMAL || right->type == XSD_INTEGER || right->type == XSD_DECIMAL)
        {
            Numeric l = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(left)));
            Numeric r = DatumGetNumeric(DirectFunctionCall1(cast_as_decimal_from_rdfbox, RdfBoxGetDatum(right)));
            result = DirectFunctionCall2(numeric_cmp, NumericGetDatum(l), NumericGetDatum(r));

            pfree(l);
            pfree(r);
        }
        else if(left->type == XSD_LONG || right->type == XSD_LONG)
        {
            int64 l = DatumGetInt64(DirectFunctionCall1(cast_as_long_from_rdfbox, RdfBoxGetDatum(left)));
            int64 r = DatumGetInt64(DirectFunctionCall1(cast_as_long_from_rdfbox, RdfBoxGetDatum(right)));
            result = Int32GetDatum(compare(l, r));
        }
        else if(left->type == XSD_INT || right->type == XSD_INT)
        {
            int32 l = DatumGetInt32(DirectFunctionCall1(cast_as_int_from_rdfbox, RdfBoxGetDatum(left)));
            int32 r = DatumGetInt32(DirectFunctionCall1(cast_as_int_from_rdfbox, RdfBoxGetDatum(right)));
            result = Int32GetDatum(compare(l, r));
        }
        else //if(left->type == XSD_SHORT || right->type == XSD_SHORT)
        {
            int16 l = DatumGetInt16(DirectFunctionCall1(cast_as_short_from_rdfbox, RdfBoxGetDatum(left)));
            int16 r = DatumGetInt16(DirectFunctionCall1(cast_as_short_from_rdfbox, RdfBoxGetDatum(right)));
            result = Int32GetDatum(compare(l, r));
        }
    }
    else if(left->type == XSD_DATETIME && right->type == XSD_DATETIME)
    {
        ZonedDateTime *l = &((RdfBoxDateTime *) left)->value;
        ZonedDateTime *r = &((RdfBoxDateTime *) right)->value;
        result = DirectFunctionCall2(zoneddatetime_compare, ZonedDateTimeGetDatum(l), ZonedDateTimeGetDatum(r));
    }
    else if(left->type == XSD_DATE && right->type == XSD_DATE)
    {
        ZonedDate l = ((RdfBoxDate *) left)->value;
        ZonedDate r = ((RdfBoxDate *) right)->value;
        result = DirectFunctionCall2(zoneddate_compare, ZonedDateGetDatum(l), ZonedDateGetDatum(r));
    }
    else if(left->type == XSD_DAYTIMEDURATION && right->type == XSD_DAYTIMEDURATION)
    {
        int64 l = ((RdfBoxDayTimeDuration *) left)->value;
        int64 r = ((RdfBoxDayTimeDuration *) right)->value;
        result = Int32GetDatum(compare(l, r));
    }
    else if(left->type == XSD_STRING && right->type == XSD_STRING)
    {
        VarChar *l = (VarChar *) ((RdfBoxString *) left)->value;
        VarChar *r = (VarChar *) ((RdfBoxString *) right)->value;

        result = Int32GetDatum(varchar_compare(l, r));
    }
    else if(left->type == RDF_LANGSTRING && right->type == RDF_LANGSTRING)
    {
        VarChar *l = (VarChar *) ((RdfBoxLangString *) left)->value;
        VarChar *r = (VarChar *) ((RdfBoxLangString *) right)->value;

        VarChar *lLang = (VarChar *) (((RdfBoxLangString *) left)->value + VARSIZE(l));
        VarChar *rLang = (VarChar *) (((RdfBoxLangString *) right)->value + VARSIZE(r));

        result = Int32GetDatum(varchar_compare(l, r));

        if(result == Int32GetDatum(0))
            result = Int32GetDatum(varchar_compare(lLang, rLang));
    }
    else if(left->type == TYPED_LITERAL && right->type == TYPED_LITERAL)
    {
        VarChar *l = (VarChar *) ((RdfBoxTypedLiteral *) left)->value;
        VarChar *r = (VarChar *) ((RdfBoxTypedLiteral *) right)->value;

        VarChar *lType = (VarChar *) (((RdfBoxTypedLiteral *) left)->value + VARSIZE(l));
        VarChar *rType = (VarChar *) (((RdfBoxTypedLiteral *) right)->value + VARSIZE(r));

        result = Int32GetDatum(varchar_compare(l, r));

        if(result == Int32GetDatum(0))
            result = Int32GetDatum(varchar_compare(lType, rType));
    }
    else if(left->type == IRI && right->type == IRI)
    {
        VarChar *l = (VarChar *) ((RdfBoxIri *) left)->value;
        VarChar *r = (VarChar *) ((RdfBoxIri *) right)->value;

        result = Int32GetDatum(varchar_compare(l, r));
    }
    else if(left->type == BLANKNODE_INT && right->type == BLANKNODE_INT)
    {
        RdfBoxBlankNodeInt *l = (RdfBoxBlankNodeInt *) left;
        RdfBoxBlankNodeInt *r = (RdfBoxBlankNodeInt *) right;

        result = Int32GetDatum(compare(l->value, r->value));
    }
    else if(left->type == BLANKNODE_STR && right->type == BLANKNODE_STR)
    {
        VarChar *l = (VarChar *) ((RdfBoxBlankNodeStr *) left)->value;
        VarChar *r = (VarChar *) ((RdfBoxBlankNodeStr *) right)->value;

        result = Int32GetDatum(varchar_compare(l, r));
    }
    else
    {
        result = Int32GetDatum(compare(right->type, left->type));
    }

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(rdfbox_order_equal);
Datum rdfbox_order_equal(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result == 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_not_equal);
Datum rdfbox_order_not_equal(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result != 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_less_than);
Datum rdfbox_order_less_than(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result < 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_greater_than);
Datum rdfbox_order_greater_than(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result > 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_not_less_than);
Datum rdfbox_order_not_less_than(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result >= 0);
}


PG_FUNCTION_INFO_V1(rdfbox_order_not_greater_than);
Datum rdfbox_order_not_greater_than(PG_FUNCTION_ARGS)
{
    int32 result = DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1)));
    PG_RETURN_BOOL(result <= 0);
}
