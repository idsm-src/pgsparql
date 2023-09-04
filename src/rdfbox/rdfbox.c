#include <postgres.h>
#include <inttypes.h>
#include <utils/builtins.h>
#include <libpq/pqformat.h>
#include "call.h"
#include "try-catch.h"
#include "rdfbox/rdfbox.h"
#include "rdfbox/syntax.h"
#include "rdfbox/promotion.h"
#include "types/float.h"
#include "types/double.h"
#include "types/daytimeduration.h"
#include "rdfbox/xsd.h"


#define IRI_BEGIN       "<"
#define IRI_END         ">"
#define LANG_DELIM      "@"
#define TYPE_DELIM      "^^"
#define VALUE_DELIM     "\""
#define BLKNODE_IPREFIX "_:i"
#define BLKNODE_SPREFIX "_:s"
#define PREFIX          VALUE_DELIM
#define SUFFIX(X)       VALUE_DELIM TYPE_DELIM IRI_BEGIN X IRI_END
#define STRLEN(X)       (sizeof(X) - 1)
#define PREFIX_SIZE     (STRLEN(PREFIX))
#define SUFFIX_SIZE(X)  (STRLEN(SUFFIX(X)))


static inline size_t strlen_escaped(const char *str, size_t size)
{
    size_t count = 0;

    for(size_t i = 0; i < size; i++)
        if(str[i] == '\\' || str[i] == '\t' || str[i] == '\b' || str[i] == '\n' || str[i] == '\r' || str[i] == '\f' || str[i] == '"')
            count++;

    return count + size;
}


static inline void memcpy_escaped(char *buffer, const char *str, size_t size)
{
    size_t pos = 0;

    for(size_t i = 0; i < size; i++)
    {
        if(str[i] == '\\')
        {
            buffer[pos++] = '\\';
            buffer[pos++] = '\\';
        }
        else if(str[i] == '\t')
        {
            buffer[pos++] = '\\';
            buffer[pos++] = 't';
        }
        else if(str[i] == '\b')
        {
            buffer[pos++] = '\\';
            buffer[pos++] = 'b';
        }
        else if(str[i] == '\n')
        {
            buffer[pos++] = '\\';
            buffer[pos++] = 'n';
        }
        else if(str[i] == '\r')
        {
            buffer[pos++] = '\\';
            buffer[pos++] = 'r';
        }
        else if(str[i] == '\f')
        {
            buffer[pos++] = '\\';
            buffer[pos++] = 'f';
        }
        else if(str[i] == '"')
        {
            buffer[pos++] = '\\';
            buffer[pos++] = '"';
        }
        else
        {
            buffer[pos++] = str[i];
        }
    }
}


PG_FUNCTION_INFO_V1(rdfbox_input);
Datum rdfbox_input(PG_FUNCTION_ARGS)
{
    char *str = PG_GETARG_CSTRING(0);
    size_t length = strlen(str);

    RdfBox *box = NULL;

    if(str[0] == '"' || str[0] == '\'')
    {
        char *buffer = palloc(length + 1);
        size_t pos = 0;

        char begin = str[0];
        bool simple = true;
        size_t i = 1;

        if(str[1] == begin && str[2] == begin)
        {
            simple = false;
            i += 2;
        }

        while(true)
        {
            char chr = str[i++];

            if(chr == begin)
            {
                if(simple)
                {
                    break;
                }
                else if(str[i] == begin && str[i + 1] == begin)
                {
                    i += 2;
                    break;
                }

                buffer[pos++] = chr;
            }
            else if(chr == '\\')
            {
                char esc = str[i++];

                if(esc == 't')
                    buffer[pos++] = '\t';
                else if(esc == 'b')
                    buffer[pos++] = '\b';
                else if(esc == 'n')
                    buffer[pos++] = '\n';
                else if(esc == 'r')
                    buffer[pos++] = '\r';
                else if(esc == 'f')
                    buffer[pos++] = '\f';
                else if(esc == '"')
                    buffer[pos++] = '"';
                else if(esc == '\'')
                    buffer[pos++] = '\'';
                else
                    ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("unknown escape sequence")));
            }
            else if(chr == '\0' || (simple && (chr == '\n' || chr == '\r')))
            {
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("unexpected end of string")));
            }
            else
            {
                buffer[pos++] = chr;
            }
        }

        buffer[pos] = '\0';

        if(str[i] == '\0')
        {
            box = GetStringRdfBox(buffer, pos);
        }
        else if(str[i] == '@')
        {
            char *lang = str + i + 1;
            size_t lang_size = length - i - 1;

            if(!check_language_tag(lang, lang_size))
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid language tag")));

            box = GetLangStringRdfBox(buffer, pos, lang, lang_size);
        }
        else if(str[i] == '^' && str[i + 1] == '^' && str[i + 2] == '<' && str[length - 1] == '>')
        {
            PG_TRY_EX();
            {
                if(strcmp(str + i + 2, IRI_BEGIN XSD_BOOLEAN_IRI IRI_END) == 0)
                {
                    char *data = buffer;
                    size_t size = pos;

                    while(size > 0 && isspace((unsigned char) *data))
                        size--, data++;

                    while(size > 0 && isspace((unsigned char) data[size - 1]))
                        size--;

                    bool value;

                    if((size == 4 && strncmp(data, "true", size) == 0) || (size == 1 && data[0] == '1'))
                        value = true;
                    else if((size == 5 && strncmp(data, "false", size) == 0) || (size == 1 && data[0] == '0'))
                        value = false;
                    else
                        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION)));

                    box = GetBooleanRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_SHORT_IRI IRI_END) == 0)
                {
                    int16 value = DatumGetInt16(DirectFunctionCall1(int2in, CStringGetDatum(buffer)));
                    box = GetShortRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_INT_IRI IRI_END) == 0)
                {
                    int32 value = DatumGetInt32(DirectFunctionCall1(int4in, CStringGetDatum(buffer)));
                    box = GetIntRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_LONG_IRI IRI_END) == 0)
                {
                    int64 value = DatumGetInt64(DirectFunctionCall1(int8in, CStringGetDatum(buffer)));
                    box = GetLongRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_FLOAT_IRI IRI_END) == 0)
                {
                    float4 value = DatumGetFloat4(DirectFunctionCall1(float_input, CStringGetDatum(buffer)));
                    box = GetFloatRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_DOUBLE_IRI IRI_END) == 0)
                {
                    float8 value = DatumGetFloat8(DirectFunctionCall1(double_input, CStringGetDatum(buffer)));
                    box = GetDoubleRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_INTEGER_IRI IRI_END) == 0)
                {
                    for(char *c = buffer; *c != '\0'; c++)
                        if(!isspace((unsigned char) *c) && !isdigit((unsigned char) *c) && *c != '+' && *c != '-')
                            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION)));

                    Numeric value = DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(buffer), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
                    box = GetIntegerRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_DECIMAL_IRI IRI_END) == 0)
                {
                    for(char *c = buffer; *c != '\0'; c++)
                        if(!isspace((unsigned char) *c) && !isdigit((unsigned char) *c) && *c != '+' && *c != '-' && *c != '.')
                            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION)));

                    Numeric value = DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(buffer), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
                    box = GetDecimalRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_DATETIME_IRI IRI_END) == 0)
                {
                    ZonedDateTime *value = DatumGetZonedDateTime(DirectFunctionCall1(zoneddatetime_input, CStringGetDatum(buffer)));
                    box = GetDateTimeRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_DATE_IRI IRI_END) == 0)
                {
                    ZonedDate value = DatumGetZonedDate(DirectFunctionCall1(zoneddate_input, CStringGetDatum(buffer)));
                    box = GetDateRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_DAYTIMEDURATION_IRI IRI_END) == 0)
                {
                    int64 value = DatumGetInt64(DirectFunctionCall1(daytimeduration_input, CStringGetDatum(buffer)));
                    box = GetDayTimeDurationRdfBox(value);
                }
                else if(strcmp(str + i + 2, IRI_BEGIN XSD_STRING_IRI IRI_END) == 0)
                {
                    box = GetStringRdfBox(buffer, pos);
                }
            }
            PG_CATCH_EX();
            {
                if(sqlerrcode != ERRCODE_INVALID_TEXT_REPRESENTATION && sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE && sqlerrcode != ERRCODE_DATETIME_VALUE_OUT_OF_RANGE)
                    PG_RE_THROW_EX();

                box = NULL;
            }
            PG_END_TRY_EX();

            if(box == NULL)
            {
                char *type = str + i + 3;
                int32 type_size = length - i - 4;

                if(!check_iri(type, type_size))
                    ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid datatype IRI")));

                box = GetTypedLiteralRdfBox(buffer, pos, type, type_size);
            }
        }
        else
        {
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid RDF literal")));
        }
    }
    else if(str[0] == '<' && str[length - 1] == '>')
    {
        if(!check_iri(str + 1, length - 2))
            ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid IRI")));

        box = GetIriRdfBox(str + 1, length - 2);
    }
    else if(str[0] == '_' && str[1] == ':' && str[2] == 'i' && length == 19)
    {
        for(int i = 3; i < 19; i++)
            if(!(str[i] >= '0' && str[i] <= '9') && !(str[i] >= 'a' && str[i] <= 'f'))
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid blank node")));

        int64 value;
        sscanf(str + 3, "%016" SCNx64, (uint64 *) &value);

        box = GetIBlankNodeRdfBox(value);
    }
    else if(str[0] == '_' && str[1] == ':' && str[2] == 's' && length > 11)
    {
        for(int i = 3; i < 11; i++)
            if(!(str[i] >= '0' && str[i] <= '9') && !(str[i] >= 'a' && str[i] <= 'f'))
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION)));

        char *buffer = palloc(length - 3);
        memcpy(buffer, str + 3, 8);
        size_t pos = 8;

        for(size_t i = 11; i < length; i++)
        {
            if(str[i] == '-')
            {
                for(int j = 1; j <= 2; j++)
                    if(!(str[i + j] >= '0' && str[i + j] <= '9') && !(str[i + j] >= 'a' && str[i + j] <= 'f'))
                        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid blank node")));

                unsigned char hi = str[i + 1] >= 'a' ? str[i + 1] - 'a' + 10 : str[i + 1] - '0';
                unsigned char lo = str[i + 2] >= 'a' ? str[i + 2] - 'a' + 10 : str[i + 2] - '0';
                char chr = hi * 16 + lo;

                if((chr >= 'a' && chr <= 'z') || (chr >= 'A' && chr <= 'Z') || (chr >= '0' && chr <= '9'))
                    ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION)));

                buffer[pos++] = chr;
                i += 2;
            }
            else if((str[i] >= 'a' && str[i] <= 'z') || (str[i] >= 'A' && str[i] <= 'Z') || (str[i] >= '0' && str[i] <= '9'))
            {
                buffer[pos++] = str[i];
            }
            else
            {
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid blank node")));
            }
        }

        box = GetSBlankNodeRdfBox(buffer, pos);
    }
    else
    {
        bool is_integer = true;
        bool is_decimal = true;
        bool is_double = true;

        for(size_t i = 0; i < length; i++)
        {
            if(str[i] == '.')
            {
                is_integer = false;
            }
            else if(str[i] == 'e')
            {
                is_integer = false;
                is_decimal = false;
            }
            else if(str[i] < '0' || str[i] > '9')
            {
                is_integer = false;
                is_decimal = false;
                is_double = false;
            }
        }

        if(is_integer)
        {
            Numeric value = DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(str), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
            box = GetIntegerRdfBox(value);
        }
        else if(is_decimal)
        {
            Numeric value = DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(str), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
            box = GetDecimalRdfBox(value);
        }
        else if(is_double)
        {
            float8 value = DatumGetFloat8(DirectFunctionCall1(double_input, CStringGetDatum(str)));
            box = GetDoubleRdfBox(value);
        }
        else
        {
            char *data = str;
            size_t size = length;

            while(size > 0 && isspace((unsigned char) *data))
                size--, data++;

            while(size > 0 && isspace((unsigned char) data[size - 1]))
                size--;

            bool value;

            if((size == 4 && strncmp(data, "true", size) == 0) || (size == 1 && data[0] == '1'))
                value = true;
            else if((size == 5 && strncmp(data, "false", size) == 0) || (size == 1 && data[0] == '0'))
                value = false;
            else
                ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid RDF term")));

            box = GetBooleanRdfBox(value);
        }
    }

    PG_RETURN_RDFBOX_P(box);
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
            bool value = RdfBoxGetBool(box);

            int buffsize = PREFIX_SIZE + (value ? 4 : 5) + SUFFIX_SIZE(XSD_BOOLEAN_IRI) + 1;
            result = (char *) palloc0(buffsize);

            if(value)
                snprintf(result, buffsize, PREFIX "true" SUFFIX(XSD_BOOLEAN_IRI));
            else
                snprintf(result, buffsize, PREFIX "false" SUFFIX(XSD_BOOLEAN_IRI));

            break;
        }

        case XSD_SHORT:
        {
            int16 value = RdfBoxGetInt16(box);

            int buffsize = PREFIX_SIZE + 6 + SUFFIX_SIZE(XSD_SHORT_IRI) + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, PREFIX "%" SCNi16 SUFFIX(XSD_SHORT_IRI), value);
            break;
        }

        case XSD_INT:
        {
            int32 value = RdfBoxGetInt32(box);

            int buffsize = PREFIX_SIZE + 11 + SUFFIX_SIZE(XSD_INT_IRI) + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, PREFIX "%" SCNi32 SUFFIX(XSD_INT_IRI), value);
            break;
        }

        case XSD_LONG:
        {
            int64 value = RdfBoxGetInt64(box);

            int buffsize = PREFIX_SIZE + 20 + SUFFIX_SIZE(XSD_LONG_IRI) + 1;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, PREFIX "%" SCNi64 SUFFIX(XSD_LONG_IRI), value);
            break;
        }

        case XSD_INTEGER:
        {
            Numeric value = RdfBoxGetNumeric(box);
            char *data = numeric_normalize(value);

            size_t size = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + size + SUFFIX_SIZE(XSD_INTEGER_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, size);
            memcpy(result + PREFIX_SIZE + size, SUFFIX(XSD_INTEGER_IRI), SUFFIX_SIZE(XSD_INTEGER_IRI));

            break;
        }

        case XSD_DECIMAL:
        {
            Numeric value = RdfBoxGetNumeric(box);
            char *data = numeric_normalize(value);

            size_t size = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + size + SUFFIX_SIZE(XSD_DECIMAL_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, size);
            memcpy(result + PREFIX_SIZE + size, SUFFIX(XSD_DECIMAL_IRI), SUFFIX_SIZE(XSD_DECIMAL_IRI));

            break;
        }

        case XSD_FLOAT:
        {
            float4 value = RdfBoxGetFloat4(box);
            char *data = DatumGetCString(DirectFunctionCall1(float_output, Float4GetDatum(value)));

            size_t size = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + size + SUFFIX_SIZE(XSD_FLOAT_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, size);
            memcpy(result + PREFIX_SIZE + size, SUFFIX(XSD_FLOAT_IRI), SUFFIX_SIZE(XSD_FLOAT_IRI));

            break;
        }

        case XSD_DOUBLE:
        {
            float8 value = RdfBoxGetFloat8(box);
            char *data = DatumGetCString(DirectFunctionCall1(double_output, Float8GetDatum(value)));

            size_t size = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + size + SUFFIX_SIZE(XSD_DOUBLE_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, size);
            memcpy(result + PREFIX_SIZE + size, SUFFIX(XSD_DOUBLE_IRI), SUFFIX_SIZE(XSD_DOUBLE_IRI));

            break;
        }

        case XSD_DATETIME:
        {
            ZonedDateTime *value = RdfBoxGetZonedDateTime(box);
            char *data = DatumGetCString(DirectFunctionCall1(zoneddatetime_output, ZonedDateTimeGetDatum(value)));

            size_t size = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + size + SUFFIX_SIZE(XSD_DATETIME_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, size);
            memcpy(result + PREFIX_SIZE + size, SUFFIX(XSD_DATETIME_IRI), SUFFIX_SIZE(XSD_DATETIME_IRI));

            break;
        }

        case XSD_DATE:
        {
            ZonedDate value = RdfBoxGetZonedDate(box);
            char *data = DatumGetCString(DirectFunctionCall1(zoneddate_output, ZonedDateGetDatum(value)));

            size_t size = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + size + SUFFIX_SIZE(XSD_DATE_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, size);
            memcpy(result + PREFIX_SIZE + size, SUFFIX(XSD_DATE_IRI), SUFFIX_SIZE(XSD_DATE_IRI));

            break;
        }

        case XSD_DAYTIMEDURATION:
        {
            int64 value = RdfBoxGetInt64(box);
            char *data = DatumGetCString(DirectFunctionCall1(daytimeduration_output, Int64GetDatum(value)));

            size_t size = strlen(data);
            result = (char *) palloc0(PREFIX_SIZE + size + SUFFIX_SIZE(XSD_DAYTIMEDURATION_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy(result + PREFIX_SIZE, data, size);
            memcpy(result + PREFIX_SIZE + size, SUFFIX(XSD_DAYTIMEDURATION_IRI), SUFFIX_SIZE(XSD_DAYTIMEDURATION_IRI));

            break;
        }

        case XSD_STRING:
        {
            VarChar *value = RdfBoxGetVarChar(box);

            int size = VARSIZE(value) - VARHDRSZ;
            int escaped_size = strlen_escaped(VARDATA(value), size);

            result = (char *) palloc0(PREFIX_SIZE + escaped_size + SUFFIX_SIZE(XSD_STRING_IRI) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy_escaped(result + PREFIX_SIZE, VARDATA(value), size);
            memcpy(result + PREFIX_SIZE + escaped_size, SUFFIX(XSD_STRING_IRI), SUFFIX_SIZE(XSD_STRING_IRI));

            break;
        }

        case RDF_LANGSTRING:
        {
            VarChar *value = RdfBoxGetVarChar(box);
            int size = VARSIZE(value);
            VarChar *lang = RdfBoxGetAttachment(box);

            int value_size = size - VARHDRSZ;
            int lang_size = VARSIZE(lang) - VARHDRSZ;
            int escaped_size = strlen_escaped(VARDATA(value), value_size);

            result = (char *) palloc0(PREFIX_SIZE + escaped_size + STRLEN(VALUE_DELIM LANG_DELIM) + lang_size + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy_escaped(result + PREFIX_SIZE, VARDATA(value), value_size);
            memcpy(result + PREFIX_SIZE + escaped_size, VALUE_DELIM LANG_DELIM, STRLEN(VALUE_DELIM LANG_DELIM));
            memcpy(result + PREFIX_SIZE + escaped_size + STRLEN(VALUE_DELIM LANG_DELIM), VARDATA(lang), lang_size);

            break;
        }

        case TYPED_LITERAL:
        {
            VarChar *value = RdfBoxGetVarChar(box);
            int size = VARSIZE(value);
            VarChar *type = RdfBoxGetAttachment(box);

            int value_size = size - VARHDRSZ;
            int type_size = VARSIZE(type) - VARHDRSZ;
            int escaped_size = strlen_escaped(VARDATA(value), value_size);

            result = (char *) palloc0(PREFIX_SIZE + escaped_size + STRLEN(VALUE_DELIM TYPE_DELIM IRI_BEGIN) + type_size + STRLEN(IRI_END) + 1);

            memcpy(result, PREFIX, PREFIX_SIZE);
            memcpy_escaped(result + PREFIX_SIZE, VARDATA(value), value_size);
            memcpy(result + PREFIX_SIZE + escaped_size, VALUE_DELIM TYPE_DELIM IRI_BEGIN, STRLEN(VALUE_DELIM TYPE_DELIM IRI_BEGIN));
            memcpy(result + PREFIX_SIZE + escaped_size + STRLEN(VALUE_DELIM TYPE_DELIM IRI_BEGIN), VARDATA(type), type_size);
            memcpy(result + PREFIX_SIZE + escaped_size + STRLEN(VALUE_DELIM TYPE_DELIM IRI_BEGIN) + type_size, IRI_END, STRLEN(IRI_END));

            break;
        }

        case IRI:
        {
            VarChar *value = RdfBoxGetVarChar(box);

            int size = VARSIZE(value) - VARHDRSZ;
            result = (char *) palloc0(STRLEN(IRI_BEGIN) + size + STRLEN(IRI_END) + 1);

            memcpy(result, IRI_BEGIN, STRLEN(IRI_BEGIN));
            memcpy(result + STRLEN(IRI_BEGIN), VARDATA(value), size);
            memcpy(result + STRLEN(IRI_BEGIN) + size, IRI_END, STRLEN(IRI_END));

            break;
        }

        case IBLANKNODE:
        {
            int64 value = RdfBoxGetInt64(box);

            int buffsize = STRLEN(BLKNODE_IPREFIX) + 21;
            result = (char *) palloc0(buffsize);

            snprintf(result, buffsize, BLKNODE_IPREFIX "%016" SCNx64, (uint64) value);
            break;
        }

        case SBLANKNODE:
        {
            static char table[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

            VarChar *value = RdfBoxGetVarChar(box);
            char *data = VARDATA(value);
            int32 size = VARSIZE(value) - VARHDRSZ;

            for(int32 i = 0; i < VARSIZE(value) - VARHDRSZ; i++)
                if((data[i] < '0' || data[i] > '9') && (data[i] < 'A' || data[i] > 'Z') && (data[i] < 'a' || data[i] > 'z'))
                    size += 2;

            result = (char *) palloc0(STRLEN(BLKNODE_SPREFIX) + size + 1);
            memcpy(result, BLKNODE_SPREFIX, STRLEN(BLKNODE_SPREFIX));

            char *out = result + STRLEN(BLKNODE_SPREFIX);

            for(int32 i = 0; i < VARSIZE(value) - VARHDRSZ; i++)
            {
                if((data[i] < '0' || data[i] > '9') && (data[i] < 'A' || data[i] > 'Z') && (data[i] < 'a' || data[i] > 'z'))
                {
                    *out++ = '-';
                    *out++ = table[(unsigned char) data[i] / 16];
                    *out++ = table[(unsigned char) data[i] % 16];
                }
                else
                {
                    *out++ = data[i];
                }
            }
        }
    }

    PG_RETURN_CSTRING(result);
}


PG_FUNCTION_INFO_V1(rdfbox_recv);
Datum rdfbox_recv(PG_FUNCTION_ARGS)
{
    StringInfo buf = (StringInfo) PG_GETARG_POINTER(0);

    uint type = pq_getmsgint(buf, sizeof(int32));
    RdfBox *box = NULL;

    switch(type)
    {
        case XSD_BOOLEAN:
        {
            box = GetBooleanRdfBox(pq_getmsgbyte(buf));
            break;
        }

        case XSD_SHORT:
        {
            box = GetShortRdfBox(pq_getmsgint(buf, sizeof(int16)));
            break;
        }

        case XSD_INT:
        {
            box = GetIntRdfBox(pq_getmsgint(buf, sizeof(int32)));
            break;
        }

        case XSD_LONG:
        {
            box = GetLongRdfBox(pq_getmsgint64(buf));
            break;
        }

        case XSD_INTEGER:
        {
            Numeric value = DatumGetNumeric(DirectFunctionCall3(numeric_recv, PointerGetDatum(buf), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
            box = GetIntegerRdfBox(value);
            break;
        }

        case XSD_DECIMAL:
        {
            Numeric value = DatumGetNumeric(DirectFunctionCall3(numeric_recv, PointerGetDatum(buf), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
            box = GetDecimalRdfBox(value);
            break;
        }

        case XSD_FLOAT:
        {
            box = GetFloatRdfBox(pq_getmsgfloat4(buf));
            break;
        }

        case XSD_DOUBLE:
        {
            box = GetDoubleRdfBox(pq_getmsgfloat8(buf));
            break;
        }

        case XSD_DATETIME:
        {
            Timestamp timestamp = (Timestamp) pq_getmsgint64(buf);
            int32 zone = pq_getmsgint(buf, sizeof(int32));

            if(!TIMESTAMP_NOT_FINITE(timestamp))
            {
                struct pg_tm tt;
                fsec_t fsec;

                if(timestamp2tm(timestamp, NULL, &tt, &fsec, NULL, NULL) != 0 || !IS_VALID_TIMESTAMP(timestamp))
                    ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("timestamp out of range")));
            }

            box = GetDateTimeRdfBox(&((ZonedDateTime) { .value = timestamp, .zone = zone}));
            break;
        }

        case XSD_DATE:
        {
            DateADT date = (DateADT) pq_getmsgint(buf, sizeof(DateADT));
            int32 zone = pq_getmsgint(buf, sizeof(int32));

            if(!DATE_NOT_FINITE(date) && !IS_VALID_DATE(date))
                    ereport(ERROR, (errcode(ERRCODE_DATETIME_VALUE_OUT_OF_RANGE), errmsg("date out of range")));

            box = GetDateRdfBox((ZonedDate) { .value = date, .zone = zone});
            break;
        }

        case XSD_DAYTIMEDURATION:
        {
            box = GetDayTimeDurationRdfBox(pq_getmsgint64(buf));
            break;
        }

        case XSD_STRING:
        {
            int32 size = pq_getmsgint(buf, sizeof(int32));
            char *value = buf->data + buf->cursor;
            buf->cursor += size;

            box = GetStringRdfBox(value, size);
            break;
        }

        case RDF_LANGSTRING:
        {
            int32 value_size = pq_getmsgint(buf, sizeof(int32));
            int32 lang_size = pq_getmsgint(buf, sizeof(int32));
            char *value = buf->data + buf->cursor;
            char *lang = buf->data + buf->cursor + value_size;
            buf->cursor += value_size + lang_size;

            box = GetLangStringRdfBox(value, value_size, lang, lang_size);
            break;
        }

        case TYPED_LITERAL:
        {
            int32 value_size = pq_getmsgint(buf, sizeof(int32));
            int32 type_size = pq_getmsgint(buf, sizeof(int32));
            char *value = buf->data + buf->cursor;
            char *type = buf->data + buf->cursor + value_size;
            buf->cursor += value_size + type_size;

            box = GetTypedLiteralRdfBox(value, value_size, type, type_size);
            break;
        }

        case IRI:
        {
            int32 size = pq_getmsgint(buf, sizeof(int32));
            char *value = buf->data + buf->cursor;
            buf->cursor += size;

            box = GetIriRdfBox(value, size);
            break;
        }

        case IBLANKNODE:
        {
            box = GetIBlankNodeRdfBox(pq_getmsgint64(buf));
            break;
        }

        case SBLANKNODE:
        {
            int32 size = pq_getmsgint(buf, sizeof(int32));
            char *value = buf->data + buf->cursor;
            buf->cursor += size;

            box = GetSBlankNodeRdfBox(value, size);
            break;
        }
    }

    PG_RETURN_RDFBOX_P(box);
}


PG_FUNCTION_INFO_V1(rdfbox_send);
Datum rdfbox_send(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint32(&buf, box->type);

    switch(box->type)
    {
        case XSD_BOOLEAN:
        {
            pq_sendbyte(&buf, RdfBoxGetBool(box) ? 1 : 0);
            break;
        }

        case XSD_SHORT:
        {
            pq_sendint16(&buf, RdfBoxGetInt16(box));
            break;
        }

        case XSD_INT:
        {
            pq_sendint32(&buf, RdfBoxGetInt32(box));
            break;
        }

        case XSD_LONG:
        {
            pq_sendint64(&buf, RdfBoxGetInt64(box));
            break;
        }

        case XSD_INTEGER:
        case XSD_DECIMAL:
        {
            Numeric num = RdfBoxGetNumeric(box);
            bytea *value = DatumGetByteaP(DirectFunctionCall3(numeric_send, NumericGetDatum(num), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
            appendBinaryStringInfoNT(&buf, VARDATA(value), VARSIZE(value) - VARHDRSZ);
            break;
        }

        case XSD_FLOAT:
        {
            pq_sendfloat4(&buf, RdfBoxGetFloat4(box));
            break;
        }

        case XSD_DOUBLE:
        {
            pq_sendfloat8(&buf, RdfBoxGetFloat8(box));
            break;
        }

        case XSD_DATETIME:
        {
            pq_sendint64(&buf, RdfBoxGetZonedDateTime(box)->value);
            pq_sendint32(&buf, RdfBoxGetZonedDateTime(box)->zone);
            break;
        }

        case XSD_DATE:
        {
            pq_sendint32(&buf, RdfBoxGetZonedDate(box).value);
            pq_sendint32(&buf, RdfBoxGetZonedDate(box).zone);
            break;
        }

        case XSD_DAYTIMEDURATION:
        {
            pq_sendint64(&buf, RdfBoxGetInt64(box));
            break;
        }

        case XSD_STRING:
        {
            VarChar *value = RdfBoxGetVarChar(box);
            pq_sendint32(&buf, VARSIZE(value) - VARHDRSZ);
            appendBinaryStringInfoNT(&buf, VARDATA(value), VARSIZE(value) - VARHDRSZ);
            break;
        }

        case RDF_LANGSTRING:
        {
            VarChar *value = RdfBoxGetVarChar(box);
            VarChar *lang = RdfBoxGetAttachment(box);
            pq_sendint32(&buf, VARSIZE(value) - VARHDRSZ);
            pq_sendint32(&buf, VARSIZE(lang) - VARHDRSZ);
            appendBinaryStringInfoNT(&buf, VARDATA(value), VARSIZE(value) - VARHDRSZ);
            appendBinaryStringInfoNT(&buf, VARDATA(lang), VARSIZE(lang) - VARHDRSZ);
            break;
        }

        case TYPED_LITERAL:
        {
            VarChar *value = RdfBoxGetVarChar(box);
            VarChar *type = RdfBoxGetAttachment(box);
            pq_sendint32(&buf, VARSIZE(value) - VARHDRSZ);
            pq_sendint32(&buf, VARSIZE(type) - VARHDRSZ);
            appendBinaryStringInfoNT(&buf, VARDATA(value), VARSIZE(value) - VARHDRSZ);
            appendBinaryStringInfoNT(&buf, VARDATA(type), VARSIZE(type) - VARHDRSZ);
            break;
        }

        case IRI:
        {
            VarChar *value = RdfBoxGetVarChar(box);
            pq_sendint32(&buf, VARSIZE(value) - VARHDRSZ);
            appendBinaryStringInfoNT(&buf, VARDATA(value), VARSIZE(value) - VARHDRSZ);
            break;
        }

        case IBLANKNODE:
        {
            pq_sendint64(&buf, RdfBoxGetInt64(box));
            break;
        }

        case SBLANKNODE:
        {
            VarChar *value = RdfBoxGetVarChar(box);
            pq_sendint32(&buf, VARSIZE(value) - VARHDRSZ);
            appendBinaryStringInfoNT(&buf, VARDATA(value), VARSIZE(value) - VARHDRSZ);
            break;
        }
    }

    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}
