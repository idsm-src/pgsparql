#include <postgres.h>
#include <utils/builtins.h>
#include <utils/datetime.h>
#include <utils/numeric.h>
#include <inttypes.h>
#include <miscadmin.h>
#include "rdfbox.h"
#include "xsd.h"


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
            Numeric numeric = DatumGetNumeric(DirectFunctionCall1(float4_numeric, Float4GetDatum(value)));
            char *data = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(numeric)));

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_FLOAT_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_FLOAT_IRI), SUFFIX_SIZE(XSD_FLOAT_IRI));

            pfree(data);
            pfree(numeric);
            break;
        }

        case XSD_DOUBLE:
        {
            float8 value = ((RdfBoxDouble *) box)->value;
            Numeric numeric = DatumGetNumeric(DirectFunctionCall1(float8_numeric, Float8GetDatum(value)));
            char *data = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(numeric)));

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DOUBLE_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DOUBLE_IRI), SUFFIX_SIZE(XSD_DOUBLE_IRI));

            pfree(data);
            pfree(numeric);
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
            Datum datum = PointerGetDatum(((RdfBoxString *) box)->value);

            size_t length = VARSIZE(datum) - VARHDRSZ;
            result = (char *) palloc0(STRLEN(IRI_BEGIN) + length + STRLEN(IRI_END) + 1);

            memcpy(result, IRI_BEGIN, STRLEN(IRI_BEGIN));
            memcpy(result + STRLEN(IRI_BEGIN), VARDATA(datum), length);
            memcpy(result + STRLEN(IRI_BEGIN) + length, IRI_END, STRLEN(IRI_END));

            break;
        }

        case BLANKNODE_INT:
        {
            int32 space = ((RdfBoxBlankNodeInt *) box)->space;
            int32 value = ((RdfBoxBlankNodeInt *) box)->value;

            size_t buffsize = STRLEN(BLKNODE_PREFIX) + 11 + 1 + 11 + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, BLKNODE_PREFIX "%" SCNi32 "_%" SCNi32, space, value);
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
