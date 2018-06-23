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
            Numeric value = (Numeric) ((RdfBoxInteger *) box)->value;
            char *data = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(value)));

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
            char *data = DatumGetCString(DirectFunctionCall1(numeric_out, NumericGetDatum(value)));

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
            Timestamp value = ((RdfBoxDateTime *) box)->value;
            int32 zone = ((RdfBoxDateTime *) box)->zone;

            fsec_t fsec;
            struct pg_tm tm;
            int tz;
            const char *tzn;

            pg_tz *timezone = pg_tzset_offset(zone != PG_INT32_MIN ? -zone * (long) SECS_PER_MINUTE : 0);
            timestamp2tm(value, &tz, &tm, &fsec, &tzn, timezone);

            char data[MAXDATELEN + 1];
            EncodeDateTime(&tm, fsec, zone != PG_INT32_MIN, tz, tzn, USE_XSD_DATES, data);

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DATETIME_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DATETIME_IRI), SUFFIX_SIZE(XSD_DATETIME_IRI));

            break;
        }

        case XSD_DATE:
        {
            DateADT value = ((RdfBoxDate *) box)->value;
            int32 zone = ((RdfBoxDate *) box)->zone;

            struct pg_tm tm;
            j2date(value + POSTGRES_EPOCH_JDATE, &(tm.tm_year), &(tm.tm_mon), &(tm.tm_mday));

            char data[MAXDATELEN + 1];
            EncodeDateOnly(&tm, DateStyle, data);

            if(zone != PG_INT32_MIN)
            {
                char *str = data + strlen(data);
                *str++ = (zone >= 0 ? '+' : '-');
                str = pg_ltostr_zeropad(str, abs(zone) / MINS_PER_HOUR, 2);
                *str++ = ':';
                str = pg_ltostr_zeropad(str, abs(zone) % MINS_PER_HOUR, 2);
                *str++ = '\0';
            }

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DATE_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DATE_IRI), SUFFIX_SIZE(XSD_DATE_IRI));

            break;
        }

        case XSD_DAYTIMEDURATION:
        {
            int64 value = ((RdfBoxDayTimeDuration *) box)->value;

            char data[32];
            char *str = data;

            if(value == PG_INT64_MIN)
            {
                sprintf(str, "-P106751991DT4H54.775808S");
            }
            else if (value == 0)
            {
                sprintf(str, "PT0S");
            }
            else
            {
                int64 time = labs(value);

                int64 mday = time / USECS_PER_DAY;
                time -= mday * USECS_PER_DAY;
                int64 hour = time / USECS_PER_HOUR;
                time -= hour * USECS_PER_HOUR;
                int64 min = time / USECS_PER_MINUTE;
                time -= min * USECS_PER_MINUTE;
                int64 sec = time / USECS_PER_SEC;
                int64 fsec = time - (sec * USECS_PER_SEC);

                if(value < 0)
                    *str++ = '-';

                *str++ = 'P';

                if(mday)
                {
                    sprintf(str, "%ldD", mday);
                    str += strlen(str);
                }

                if (hour != 0 || min != 0 || sec != 0 || fsec != 0)
                    *str++ = 'T';

                if(hour)
                {
                    sprintf(str, "%ldH", hour);
                    str += strlen(str);
                }

                if(min)
                {
                    sprintf(str, "%ldM", min);
                    str += strlen(str);
                }

                if (sec != 0 || fsec != 0)
                {
                    str = pg_ltostr(str, sec);

                    if (fsec)
                    {
                        *str++ = '.';
                        str = pg_ltostr_zeropad(str, fsec, 6);

                        while(*(str - 1) == '0')
                            --str;
                    }

                    *str++ = 'S';
                    *str++ = '\0';
                }
            }

            size_t length = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + length + SUFFIX_SIZE(XSD_DAYTIMEDURATION_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, length);
            memcpy(result + PREFIX_SIZE + length, SUFFIX(XSD_DAYTIMEDURATION_IRI), SUFFIX_SIZE(XSD_DAYTIMEDURATION_IRI));

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
            Datum datum = PointerGetDatum(((RdfBoxLangString *) box)->value);
            size_t size = VARSIZE(datum);
            Datum lang = PointerGetDatum(((RdfBoxLangString *) box)->value + size);

            size_t valueLength = size - VARHDRSZ;
            size_t langLength = VARSIZE(lang) - VARHDRSZ;
            result = (char *) palloc0(PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM LANG_DELIM) + langLength + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, VARDATA(datum), valueLength);
            memcpy(result + PREFIX_SIZE + valueLength, VALUE_DELIM LANG_DELIM, STRLEN(VALUE_DELIM LANG_DELIM));
            memcpy(result + PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM LANG_DELIM), VARDATA(lang), langLength);

            break;
        }

        case TYPED_LITERAL:
        {
            Datum datum = PointerGetDatum(((RdfBoxTypedLiteral *) box)->value);
            size_t size = VARSIZE(datum);
            Datum lang = PointerGetDatum(((RdfBoxTypedLiteral *) box)->value + size);

            size_t valueLength = size - VARHDRSZ;
            size_t langLength = VARSIZE(lang) - VARHDRSZ;
            result = (char *) palloc0(PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM IRI_BEGIN) + langLength + STRLEN(IRI_END) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, VARDATA(datum), valueLength);
            memcpy(result + PREFIX_SIZE + valueLength, VALUE_DELIM IRI_BEGIN, STRLEN(VALUE_DELIM IRI_BEGIN));
            memcpy(result + PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM IRI_BEGIN), VARDATA(lang), langLength);
            memcpy(result + PREFIX_SIZE + valueLength + STRLEN(VALUE_DELIM IRI_BEGIN) + langLength, IRI_END, STRLEN(IRI_END));

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
            int32 value = ((RdfBoxBlankNodeInt *) box)->value;

            size_t buffsize = STRLEN(BLKNODE_PREFIX) + 11 + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, BLKNODE_PREFIX "%" SCNi32, value);
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
