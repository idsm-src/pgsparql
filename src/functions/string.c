#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <utils/formatting.h>
#include <catalog/pg_collation.h>
#include "cast/cast.h"
#include "rdfbox.h"
#include "call.h"
#include "constants.h"
#include "try-catch.h"


static VarChar *rdfbox_get_string(RdfBox *box)
{
    if(box->type == XSD_STRING)
        return (VarChar *) ((RdfBoxString *) box)->value;

    if(box->type == RDF_LANGSTRING)
        return (VarChar *) ((RdfBoxLangString *) box)->value;

    return NULL;
}


static VarChar *rdfbox_get_lang(RdfBox *box)
{
    if(box->type == RDF_LANGSTRING)
    {
        VarChar *value = (VarChar *) ((RdfBoxLangString *) box)->value;
        return (VarChar *) (((RdfBoxLangString *) box)->value + VARSIZE(value));
    }

    return NULL;
}


static bool rdfbox_are_strings_compatible(RdfBox *left, RdfBox *right)
{
    if(left->type == RDF_LANGSTRING && right->type == RDF_LANGSTRING)
    {
        VarChar *leftLang = rdfbox_get_lang(left);
        VarChar *rightLang = rdfbox_get_lang(right);
        return memcmp(leftLang, rightLang, Min(VARSIZE(leftLang), VARSIZE(rightLang))) == 0;
    }

    return (left->type == XSD_STRING || left->type == RDF_LANGSTRING) && right->type == XSD_STRING;
}


static NullableDatum varchar_translate_and_free(VarChar *value, VarChar *lang)
{
    NullableDatum result;

    if(lang == NULL)
        result = NullableFunctionCall1(cast_as_rdfbox_from_string, PointerGetDatum(value));
    else
        result = NullableFunctionCall2(cast_as_rdfbox_from_lang_string, PointerGetDatum(value), PointerGetDatum(lang));

    pfree(value);
    return result;
}


static int32 varchar_contains(VarChar *value, VarChar *searched)
{
    for(int i = 0; i <= (int) (VARSIZE(value) - VARSIZE(searched)); i++)
    {
        bool result = true;

        for(int j = 0; result && j < VARSIZE(searched) - VARHDRSZ; j++)
            result = VARDATA(value)[i + j] == VARDATA(searched)[j];

        if(result)
            return i;
    }

    return -1;
}


static int32 positive_numeric_to_int(Numeric value)
{
    int32 result = PG_INT32_MAX;

    PG_TRY_EX();
    {
        result = DatumGetInt32(DirectFunctionCall1(numeric_int4, NumericGetDatum(value)));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();
    }
    PG_END_TRY_EX();

    return result;
}


PG_FUNCTION_INFO_V1(strlen_string);
Datum strlen_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    Datum length = DirectFunctionCall1(textlen, PointerGetDatum(value));
    Datum result = DirectFunctionCall1(cast_as_decimal_from_int, length);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(strlen_rdfbox);
Datum strlen_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        result = NullableFunctionCall1(strlen_string, PointerGetDatum(value));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(substr_no_len_string);
Datum substr_no_len_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    Numeric start = PG_GETARG_NUMERIC(1);

    int32 begin = 1;

    if(DatumGetBool(DirectFunctionCall2(numeric_gt, NumericGetDatum(start), NumericGetDatum(get_zero()))))
        begin = positive_numeric_to_int(start);

    Datum result = DirectFunctionCall2(text_substr_no_len, PointerGetDatum(value), Int32GetDatum(begin));

    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(start, 1);

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(substr_no_len_rdfbox);
Datum substr_no_len_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum start = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *substr = (VarChar *) DatumGetPointer(DirectFunctionCall2(substr_no_len_string, PointerGetDatum(value), start));
        result = varchar_translate_and_free(substr, rdfbox_get_lang(box));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(substr_string);
Datum substr_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    Numeric start = PG_GETARG_NUMERIC(1);
    Numeric length = PG_GETARG_NUMERIC(2);

    int32 begin = 0;
    int32 limit = 0;

    if(DatumGetBool(DirectFunctionCall2(numeric_gt, NumericGetDatum(start), NumericGetDatum(get_zero()))))
    {
        begin = positive_numeric_to_int(start);
    }
    else
    {
        Numeric sum = DatumGetNumeric(DirectFunctionCall2(numeric_add, NumericGetDatum(length), NumericGetDatum(start)));
        PG_FREE_IF_COPY(length, 1);
        length = sum;
    }

    if(DatumGetBool(DirectFunctionCall2(numeric_gt, NumericGetDatum(length), NumericGetDatum(get_zero()))))
        limit = positive_numeric_to_int(length);

    if(begin + limit < begin)
        limit = PG_INT32_MAX - begin; // to avoid the error: 'negative substring length not allowed'

    Datum result = DirectFunctionCall3(text_substr, PointerGetDatum(value), Int32GetDatum(begin), Int32GetDatum(limit));

    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(start, 1);
    PG_FREE_IF_COPY(length, 2);

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(substr_rdfbox);
Datum substr_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum start = PG_GETARG_DATUM(1);
    Datum length = PG_GETARG_DATUM(2);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *substr = (VarChar *) DatumGetPointer(DirectFunctionCall3(substr_string, PointerGetDatum(value), start, length));
        result = varchar_translate_and_free(substr, rdfbox_get_lang(box));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(ucase_string);
Datum ucase_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    char *ucase = str_toupper(VARDATA(value), VARSIZE(value) - VARHDRSZ, DEFAULT_COLLATION_OID);
    Datum result = PointerGetDatum(cstring_to_text(ucase));
    pfree(ucase);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(ucase_rdfbox);
Datum ucase_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum searched = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *ucase = (VarChar *) DatumGetPointer(DirectFunctionCall2(ucase_string, PointerGetDatum(value), searched));
        result = varchar_translate_and_free(ucase, rdfbox_get_lang(box));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(lcase_string);
Datum lcase_string(PG_FUNCTION_ARGS)
{
    text *value = PG_GETARG_TEXT_P(0);
    char *lcase = str_tolower(VARDATA(value), VARSIZE(value) - VARHDRSZ, DEFAULT_COLLATION_OID);
    Datum result = PointerGetDatum(cstring_to_text(lcase));
    pfree(lcase);
    PG_FREE_IF_COPY(value, 0);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(lcase_rdfbox);
Datum lcase_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum searched = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *lcase = (VarChar *) DatumGetPointer(DirectFunctionCall2(lcase_string, PointerGetDatum(value), searched));
        result = varchar_translate_and_free(lcase, rdfbox_get_lang(box));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(strstarts_string_string);
Datum strstarts_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *start = PG_GETARG_VARCHAR_P(1);
    bool result = (VARSIZE(start) <= VARSIZE(value) && !memcmp(VARDATA(value), VARDATA(start), VARSIZE(start) - VARHDRSZ));
    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(start, 1);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(strstarts_rdfbox_string);
Datum strstarts_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum start = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        result = NullableFunctionCall2(strstarts_string_string, PointerGetDatum(value), start);
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(strstarts_rdfbox_rdfbox);
Datum strstarts_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *start = PG_GETARG_RDFBOX_P(1);
    NullableDatum result = { .isNull = true };

    if(rdfbox_are_strings_compatible(box, start))
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *begin = rdfbox_get_string(start);
        result = NullableFunctionCall2(strstarts_string_string, PointerGetDatum(value), PointerGetDatum(begin));
    }

    PG_FREE_IF_COPY(box, 0);
    PG_FREE_IF_COPY(start, 1);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(strends_string_string);
Datum strends_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *end = PG_GETARG_VARCHAR_P(1);
    bool result = (VARSIZE(end) <= VARSIZE(value) && !memcmp(VARDATA(value) + VARSIZE(value) - VARSIZE(end), VARDATA(end), VARSIZE(end) - VARHDRSZ));
    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(end, 1);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(strends_rdfbox_string);
Datum strends_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum end = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        result = NullableFunctionCall2(strends_string_string, PointerGetDatum(value), end);
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(strends_rdfbox_rdfbox);
Datum strends_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *end = PG_GETARG_RDFBOX_P(1);
    NullableDatum result = { .isNull = true };

    if(rdfbox_are_strings_compatible(box, end))
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *stop = rdfbox_get_string(end);
        result = NullableFunctionCall2(strends_string_string, PointerGetDatum(value), PointerGetDatum(stop));
    }

    PG_FREE_IF_COPY(box, 0);
    PG_FREE_IF_COPY(end, 1);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(contains_string_string);
Datum contains_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *searched = PG_GETARG_VARCHAR_P(1);
    bool result = varchar_contains(value, searched) != -1;
    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(searched, 1);
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(contains_rdfbox_string);
Datum contains_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum searched = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        result = NullableFunctionCall2(contains_string_string, PointerGetDatum(value), searched);
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(contains_rdfbox_rdfbox);
Datum contains_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *searched = PG_GETARG_RDFBOX_P(1);
    NullableDatum result = { .isNull = true };

    if(rdfbox_are_strings_compatible(box, searched))
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *string = rdfbox_get_string(searched);
        result = NullableFunctionCall2(contains_string_string, PointerGetDatum(value), PointerGetDatum(string));
    }

    PG_FREE_IF_COPY(box, 0);
    PG_FREE_IF_COPY(searched, 1);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(strbefore_string_string);
Datum strbefore_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *searched = PG_GETARG_VARCHAR_P(1);

    int32 pos = varchar_contains(value, searched);
    int32 length = pos != -1 ? pos : 0;

    VarChar *result = (VarChar *) palloc(VARHDRSZ + length);
    SET_VARSIZE(result, VARHDRSZ + length);
    memcpy(VARDATA(result), VARDATA(value), length);

    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(searched, 1);

    PG_RETURN_POINTER(result);
}


PG_FUNCTION_INFO_V1(strbefore_rdfbox_string);
Datum strbefore_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum searched = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *substr = (VarChar *) DatumGetPointer(DirectFunctionCall2(strbefore_string_string, PointerGetDatum(value), searched));
        result = varchar_translate_and_free(substr, rdfbox_get_lang(box));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(strbefore_rdfbox_rdfbox);
Datum strbefore_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *searched = PG_GETARG_RDFBOX_P(1);
    NullableDatum result = { .isNull = true };

    if(rdfbox_are_strings_compatible(box, searched))
    {
        VarChar *string = rdfbox_get_string(searched);
        result = NullableFunctionCall2(strbefore_rdfbox_string, RdfBoxGetDatum(box), PointerGetDatum(string));
    }

    PG_FREE_IF_COPY(box, 0);
    PG_FREE_IF_COPY(searched, 1);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(strafter_string_string);
Datum strafter_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_P(0);
    VarChar *searched = PG_GETARG_VARCHAR_P(1);

    int32 pos = varchar_contains(value, searched);
    int32 start = pos + VARSIZE(searched) - VARHDRSZ;
    int32 length = pos != -1 ? VARSIZE(value) - VARHDRSZ - start : 0;

    VarChar *result = (VarChar *) palloc(VARHDRSZ + length);
    SET_VARSIZE(result, VARHDRSZ + length);
    memcpy(VARDATA(result), VARDATA(value) + start, length);

    PG_FREE_IF_COPY(value, 0);
    PG_FREE_IF_COPY(searched, 1);

    PG_RETURN_POINTER(result);
}


PG_FUNCTION_INFO_V1(strafter_rdfbox_string);
Datum strafter_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum searched = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *substr = (VarChar *) DatumGetPointer(DirectFunctionCall2(strafter_string_string, PointerGetDatum(value), searched));
        result = varchar_translate_and_free(substr, rdfbox_get_lang(box));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(strafter_rdfbox_rdfbox);
Datum strafter_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *searched = PG_GETARG_RDFBOX_P(1);
    NullableDatum result = { .isNull = true };

    if(rdfbox_are_strings_compatible(box, searched))
    {
        VarChar *string = rdfbox_get_string(searched);
        result = NullableFunctionCall2(strafter_rdfbox_string, RdfBoxGetDatum(box), PointerGetDatum(string));
    }

    PG_FREE_IF_COPY(box, 0);
    PG_FREE_IF_COPY(searched, 1);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(encode_for_uri_string);
Datum encode_for_uri_string(PG_FUNCTION_ARGS)
{
    static char table[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

    VarChar *value = PG_GETARG_VARCHAR_P(0);
    char *data = VARDATA(value);
    int32 size = VARSIZE(value);

    for(int i = 0; i < VARSIZE(value) - VARHDRSZ; i++)
        if((data[i] < '0' || data[i] > '9') && (data[i] < 'A' || data[i] > 'Z') && (data[i] < 'a' || data[i] > 'z') &&
                data[i] != '-' && data[i] != '_' && data[i] != '.' && data[i] != '~')
            size += 2;

    VarChar *result = (VarChar *) palloc(size);
    SET_VARSIZE(result, size);
    char *out = VARDATA(result);

    for(int i = 0; i < VARSIZE(value) - VARHDRSZ; i++)
    {
        if((data[i] < '0' || data[i] > '9') && (data[i] < 'A' || data[i] > 'Z') && (data[i] < 'a' || data[i] > 'z') &&
                data[i] != '-' && data[i] != '_' && data[i] != '.' && data[i] != '~')
        {
            *out++ = '%';
            *out++ = table[(unsigned char) data[i] / 16];
            *out++ = table[(unsigned char) data[i] % 16];
        }
        else
        {
            *out++ = data[i];
        }
    }

    PG_FREE_IF_COPY(value, 0);

    PG_RETURN_POINTER(result);
}


PG_FUNCTION_INFO_V1(encode_for_uri_rdfbox);
Datum encode_for_uri_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        result = NullableFunctionCall1(encode_for_uri_string, PointerGetDatum(value));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(concat_string_string);
Datum concat_string_string(PG_FUNCTION_ARGS)
{
    VarChar *begin = PG_GETARG_VARCHAR_P(0);
    VarChar *end = PG_GETARG_VARCHAR_P(1);
    int32 beginSize = VARSIZE(begin) - VARHDRSZ;
    int32 endSize = VARSIZE(end) - VARHDRSZ;

    VarChar *result = (VarChar *) palloc(VARHDRSZ + beginSize + endSize);
    SET_VARSIZE(result, VARHDRSZ + beginSize + endSize);
    memcpy(VARDATA(result), VARDATA(begin), beginSize);
    memcpy(VARDATA(result) + beginSize, VARDATA(end), endSize);

    PG_FREE_IF_COPY(begin, 0);
    PG_FREE_IF_COPY(end, 1);

    PG_RETURN_RDFBOX_P(result);
}


PG_FUNCTION_INFO_V1(concat_rdfbox_string);
Datum concat_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum append = PG_GETARG_DATUM(1);
    NullableDatum result = { .isNull = true };

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = rdfbox_get_string(box);
        VarChar *merged = (VarChar *) DatumGetPointer(DirectFunctionCall2(concat_string_string, PointerGetDatum(value), append));
        result = varchar_translate_and_free(merged, rdfbox_get_lang(box));
    }

    PG_FREE_IF_COPY(box, 0);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(concat_rdfbox_rdfbox);
Datum concat_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *append = PG_GETARG_RDFBOX_P(1);
    NullableDatum result = { .isNull = true };

    if(rdfbox_are_strings_compatible(box, append))
    {
        VarChar *string = rdfbox_get_string(append);
        result = NullableFunctionCall2(concat_rdfbox_string, RdfBoxGetDatum(box), PointerGetDatum(string));
    }

    PG_FREE_IF_COPY(box, 0);
    PG_FREE_IF_COPY(append, 1);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}


PG_FUNCTION_INFO_V1(langmatches_string_string);
Datum langmatches_string_string(PG_FUNCTION_ARGS)
{
    VarChar *lang = PG_GETARG_VARCHAR_P(0);
    VarChar *pattern = PG_GETARG_VARCHAR_P(1);
    bool result = false;

    if(VARSIZE(pattern) == 1 + VARHDRSZ && *VARDATA(pattern) == '*')
    {
        result = true;
    }
    else if(VARSIZE(pattern) <= VARSIZE(lang))
    {
        char *uLang = str_toupper(VARDATA(lang), VARSIZE(lang) - VARHDRSZ, DEFAULT_COLLATION_OID);
        char *uPattern = str_toupper(VARDATA(pattern), VARSIZE(pattern) - VARHDRSZ, DEFAULT_COLLATION_OID);

        int32 length = strlen(uPattern);
        result = strncmp(uLang, uPattern, length) == 0 && (uLang[length] == '\0' || uLang[length] == '-');

        pfree(uLang);
        pfree(uPattern);
    }

    PG_FREE_IF_COPY(lang, 0);
    PG_FREE_IF_COPY(pattern, 1);

    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(langmatches_rdfbox_rdfbox);
Datum langmatches_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *lang = PG_GETARG_RDFBOX_P(0);
    RdfBox *pattern = PG_GETARG_RDFBOX_P(1);
    NullableDatum result = { .isNull = true };

    if(lang->type == XSD_STRING && pattern->type == XSD_STRING)
        result = NullableFunctionCall2(langmatches_string_string, PointerGetDatum(rdfbox_get_string(lang)),
                PointerGetDatum(rdfbox_get_string(pattern)));

    PG_FREE_IF_COPY(lang, 0);
    PG_FREE_IF_COPY(pattern, 1);

    if(result.isNull)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(result.datum);
}
