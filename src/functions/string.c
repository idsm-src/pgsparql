#include <postgres.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <utils/formatting.h>
#include <catalog/pg_collation.h>
#include "call.h"
#include "compare.h"
#include "constants.h"
#include "try-catch.h"
#include "rdfbox/rdfbox.h"


static bool are_compatible(RdfBox *left, RdfBox *right)
{
    if(left->type == RDF_LANGSTRING && right->type == RDF_LANGSTRING)
        return varchar_eq(RdfBoxGetAttachment(left), RdfBoxGetAttachment(right));

    return (left->type == XSD_STRING || left->type == RDF_LANGSTRING) && right->type == XSD_STRING;
}


static int varchar_contains(VarChar *value, VarChar *searched)
{
    char *value_data = VARDATA_ANY(value);
    char *searched_data = VARDATA_ANY(searched);

    int value_size = VARSIZE_ANY_EXHDR(value);
    int searched_size = VARSIZE_ANY_EXHDR(searched);

    if(value_size < searched_size)
        return -1;

    for(int i = 0; i <= value_size - searched_size; i++)
    {
        bool result = true;

        for(int j = 0; result && j < searched_size; j++)
            result = value_data[i + j] == searched_data[j];

        if(result)
            return i;
    }

    return -1;
}


static int positive_numeric_to_int(Numeric value)
{
    int result = PG_INT32_MAX;

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
    Datum value = PG_GETARG_DATUM(0);
    Datum length = DirectFunctionCall1(textlen, value);
    Datum result = DirectFunctionCall1(int4_numeric, length);
    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(strlen_rdfbox);
Datum strlen_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type == XSD_STRING || box->type ==  RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        PG_RETURN(NullableFunctionCall1(strlen_string, PointerGetDatum(value)));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(substr_no_len_string);
Datum substr_no_len_string(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    Numeric start = PG_GETARG_NUMERIC(1);

    int begin = 1;

    if(DatumGetBool(DirectFunctionCall2(numeric_gt, NumericGetDatum(start), NumericGetDatum(get_zero()))))
        begin = positive_numeric_to_int(start);

    Datum result = DirectFunctionCall2(text_substr_no_len, value, Int32GetDatum(begin));

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(substr_no_len_rdfbox);
Datum substr_no_len_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum start = PG_GETARG_DATUM(1);

    if(box->type == XSD_STRING || box->type ==  RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        VarChar *lang = box->type == RDF_LANGSTRING ? RdfBoxGetAttachment(box) : NULL;
        VarChar *substr = (VarChar *) DatumGetPointer(DirectFunctionCall2(substr_no_len_string, PointerGetDatum(value), start));

        if(lang == NULL)
            PG_RETURN_RDFBOX_P(GetStringRdfBox(VARDATA(substr), VARSIZE(substr) - VARHDRSZ));
        else
            PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA(substr), VARSIZE(substr) - VARHDRSZ, VARDATA(lang), VARSIZE(lang) - VARHDRSZ));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(substr_string);
Datum substr_string(PG_FUNCTION_ARGS)
{
    Datum value = PG_GETARG_DATUM(0);
    Numeric start = PG_GETARG_NUMERIC(1);
    Numeric length = PG_GETARG_NUMERIC(2);

    int begin = 0;
    int limit = 0;

    if(DatumGetBool(DirectFunctionCall2(numeric_gt, NumericGetDatum(start), NumericGetDatum(get_zero()))))
    {
        begin = positive_numeric_to_int(start);
    }
    else
    {
        Numeric sum = DatumGetNumeric(DirectFunctionCall2(numeric_add, NumericGetDatum(length), NumericGetDatum(start)));
        length = sum;
    }

    if(DatumGetBool(DirectFunctionCall2(numeric_gt, NumericGetDatum(length), NumericGetDatum(get_zero()))))
        limit = positive_numeric_to_int(length);

    if(begin + limit < begin)
        limit = PG_INT32_MAX - begin; // to avoid the error: 'negative substring length not allowed'

    Datum result = DirectFunctionCall3(text_substr, value, Int32GetDatum(begin), Int32GetDatum(limit));

    PG_RETURN_DATUM(result);
}


PG_FUNCTION_INFO_V1(substr_rdfbox);
Datum substr_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum start = PG_GETARG_DATUM(1);
    Datum length = PG_GETARG_DATUM(2);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        VarChar *lang = box->type == RDF_LANGSTRING ? RdfBoxGetAttachment(box) : NULL;
        VarChar *substr = (VarChar *) DatumGetPointer(DirectFunctionCall3(substr_string, PointerGetDatum(value), start, length));

        if(lang == NULL)
            PG_RETURN_RDFBOX_P(GetStringRdfBox(VARDATA(substr), VARSIZE(substr) - VARHDRSZ));
        else
            PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA(substr), VARSIZE(substr) - VARHDRSZ, VARDATA(lang), VARSIZE(lang) - VARHDRSZ));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(ucase_rdfbox);
Datum ucase_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        VarChar *lang = box->type == RDF_LANGSTRING ? RdfBoxGetAttachment(box) : NULL;
        char *ucase = str_toupper(VARDATA(value), VARSIZE(value) - VARHDRSZ, DEFAULT_COLLATION_OID);

        if(lang == NULL)
            PG_RETURN_RDFBOX_P(GetStringRdfBox(ucase, strlen(ucase)));
        else
            PG_RETURN_RDFBOX_P(GetLangStringRdfBox(ucase, strlen(ucase), VARDATA(lang), VARSIZE(lang) - VARHDRSZ));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(lcase_rdfbox);
Datum lcase_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        VarChar *lang = box->type == RDF_LANGSTRING ? RdfBoxGetAttachment(box) : NULL;
        char *lcase = str_tolower(VARDATA(value), VARSIZE(value) - VARHDRSZ, DEFAULT_COLLATION_OID);

        if(lang == NULL)
            PG_RETURN_RDFBOX_P(GetStringRdfBox(lcase, strlen(lcase)));
        else
            PG_RETURN_RDFBOX_P(GetLangStringRdfBox(lcase, strlen(lcase), VARDATA(lang), VARSIZE(lang) - VARHDRSZ));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(strstarts_string_string);
Datum strstarts_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *start = PG_GETARG_VARCHAR_PP(1);

    int value_size = VARSIZE_ANY_EXHDR(value);
    int start_size = VARSIZE_ANY_EXHDR(start);

    bool result = (start_size <= value_size && !memcmp(VARDATA_ANY(value), VARDATA_ANY(start), start_size));
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(strstarts_rdfbox_string);
Datum strstarts_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum start = PG_GETARG_DATUM(1);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        PG_RETURN(NullableFunctionCall2(strstarts_string_string, PointerGetDatum(value), start));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(strstarts_rdfbox_rdfbox);
Datum strstarts_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *start = PG_GETARG_RDFBOX_P(1);

    if(!are_compatible(box, start))
        PG_RETURN_NULL();

    VarChar *value = RdfBoxGetVarChar(box);
    VarChar *begin = RdfBoxGetVarChar(start);
    PG_RETURN(NullableFunctionCall2(strstarts_string_string, PointerGetDatum(value), PointerGetDatum(begin)));
}


PG_FUNCTION_INFO_V1(strends_string_string);
Datum strends_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *end = PG_GETARG_VARCHAR_PP(1);

    int value_size = VARSIZE_ANY_EXHDR(value);
    int end_size = VARSIZE_ANY_EXHDR(end);

    bool result = (end_size <= value_size && !memcmp(VARDATA_ANY(value) + value_size - end_size, VARDATA_ANY(end), end_size));
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(strends_rdfbox_string);
Datum strends_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum end = PG_GETARG_DATUM(1);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        PG_RETURN(NullableFunctionCall2(strends_string_string, PointerGetDatum(value), end));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(strends_rdfbox_rdfbox);
Datum strends_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *end = PG_GETARG_RDFBOX_P(1);

    if(!are_compatible(box, end))
        PG_RETURN_NULL();

    VarChar *value = RdfBoxGetVarChar(box);
    VarChar *stop = RdfBoxGetVarChar(end);
    PG_RETURN(NullableFunctionCall2(strends_string_string, PointerGetDatum(value), PointerGetDatum(stop)));
}


PG_FUNCTION_INFO_V1(contains_string_string);
Datum contains_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *searched = PG_GETARG_VARCHAR_PP(1);
    bool result = varchar_contains(value, searched) != -1;
    PG_RETURN_BOOL(result);
}


PG_FUNCTION_INFO_V1(contains_rdfbox_string);
Datum contains_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    Datum searched = PG_GETARG_DATUM(1);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        PG_RETURN(NullableFunctionCall2(contains_string_string, PointerGetDatum(value), searched));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(contains_rdfbox_rdfbox);
Datum contains_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *searched = PG_GETARG_RDFBOX_P(1);

    if(!are_compatible(box, searched))
        PG_RETURN_NULL();

    VarChar *value = RdfBoxGetVarChar(box);
    VarChar *string = RdfBoxGetVarChar(searched);
    PG_RETURN(NullableFunctionCall2(contains_string_string, PointerGetDatum(value), PointerGetDatum(string)));
}


PG_FUNCTION_INFO_V1(strbefore_string_string);
Datum strbefore_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *searched = PG_GETARG_VARCHAR_PP(1);

    int pos = varchar_contains(value, searched);
    int length = pos != -1 ? pos : 0;

    VarChar *result = (VarChar *) palloc(VARHDRSZ + length);
    SET_VARSIZE(result, VARHDRSZ + length);
    memcpy(VARDATA(result), VARDATA_ANY(value), length);

    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(strbefore_rdfbox_string);
Datum strbefore_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *searched = PG_GETARG_VARCHAR_PP(1);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        VarChar *lang = box->type == RDF_LANGSTRING ? RdfBoxGetAttachment(box) : NULL;

        int length = varchar_contains(value, searched);

        if(length == -1)
        {
            length = 0;
            lang = NULL;
        }

        if(lang == NULL)
            PG_RETURN_RDFBOX_P(GetStringRdfBox(VARDATA(value), length));
        else
            PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA(value), length, VARDATA(lang), VARSIZE(lang) - VARHDRSZ));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(strbefore_rdfbox_rdfbox);
Datum strbefore_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *searched = PG_GETARG_RDFBOX_P(1);

    if(!are_compatible(box, searched))
        PG_RETURN_NULL();

    VarChar *string = RdfBoxGetVarChar(searched);
    PG_RETURN(NullableFunctionCall2(strbefore_rdfbox_string, RdfBoxGetDatum(box), PointerGetDatum(string)));
}


PG_FUNCTION_INFO_V1(strafter_string_string);
Datum strafter_string_string(PG_FUNCTION_ARGS)
{
    VarChar *value = PG_GETARG_VARCHAR_PP(0);
    VarChar *searched = PG_GETARG_VARCHAR_PP(1);

    int pos = varchar_contains(value, searched);
    int start = pos + VARSIZE_ANY_EXHDR(searched);
    int length = pos != -1 ? VARSIZE_ANY_EXHDR(value) - start : 0;

    VarChar *result = (VarChar *) palloc(VARHDRSZ + length);
    SET_VARSIZE(result, VARHDRSZ + length);
    memcpy(VARDATA(result), VARDATA_ANY(value) + start, length);

    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(strafter_rdfbox_string);
Datum strafter_rdfbox_string(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    VarChar *searched = PG_GETARG_VARCHAR_PP(1);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        VarChar *lang = box->type == XSD_STRING ? NULL : RdfBoxGetAttachment(box);

        int pos = varchar_contains(value, searched);
        int start = pos + VARSIZE_ANY_EXHDR(searched);
        int length = pos != -1 ? VARSIZE(value) - VARHDRSZ - start : 0;

        if(pos == -1)
            lang = NULL;

        if(lang == NULL)
            PG_RETURN_RDFBOX_P(GetStringRdfBox(VARDATA(value) + start, length));
        else
            PG_RETURN_RDFBOX_P(GetLangStringRdfBox(VARDATA(value) + start, length, VARDATA(lang), VARSIZE(lang) - VARHDRSZ));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(strafter_rdfbox_rdfbox);
Datum strafter_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    RdfBox *searched = PG_GETARG_RDFBOX_P(1);

    if(!are_compatible(box, searched))
        PG_RETURN_NULL();

    VarChar *string = RdfBoxGetVarChar(searched);
    PG_RETURN(NullableFunctionCall2(strafter_rdfbox_string, RdfBoxGetDatum(box), PointerGetDatum(string)));
}


PG_FUNCTION_INFO_V1(encode_for_uri_string);
Datum encode_for_uri_string(PG_FUNCTION_ARGS)
{
    static char table[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};

    VarChar *value = PG_GETARG_VARCHAR_PP(0);

    char *data = VARDATA_ANY(value);
    int size = VARSIZE_ANY_EXHDR(value);
    int result_size = size + VARHDRSZ;

    for(int i = 0; i < size; i++)
        if((data[i] < '0' || data[i] > '9') && (data[i] < 'A' || data[i] > 'Z') && (data[i] < 'a' || data[i] > 'z') &&
                data[i] != '-' && data[i] != '_' && data[i] != '.' && data[i] != '~')
            result_size += 2;

    VarChar *result = (VarChar *) palloc(result_size);
    SET_VARSIZE(result, result_size);
    char *out = VARDATA(result);

    for(int i = 0; i < size; i++)
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

    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(encode_for_uri_rdfbox);
Datum encode_for_uri_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    if(box->type == XSD_STRING || box->type == RDF_LANGSTRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        PG_RETURN(NullableFunctionCall1(encode_for_uri_string, PointerGetDatum(value)));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(concat_rdfbox_rdfbox);
Datum concat_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *begin_box = PG_GETARG_RDFBOX_P(0);
    RdfBox *end_box = PG_GETARG_RDFBOX_P(1);

    if((begin_box->type == XSD_STRING || begin_box->type == RDF_LANGSTRING) && (end_box->type == XSD_STRING || end_box->type == RDF_LANGSTRING))
    {
        VarChar *begin = RdfBoxGetVarChar(begin_box);
        VarChar *end = RdfBoxGetVarChar(end_box);
        VarChar *lang = NULL;

        if(begin_box->type == RDF_LANGSTRING && end_box->type == RDF_LANGSTRING)
        {
            VarChar *begin_lang = RdfBoxGetAttachment(begin_box);
            VarChar *end_lang = RdfBoxGetAttachment(end_box);

            if(varchar_eq(begin_lang, end_lang))
                lang = begin_lang;
        }


        int begin_size = VARSIZE(begin) - VARHDRSZ;
        int end_size = VARSIZE(end) - VARHDRSZ;

        char *buffer = palloc(begin_size + end_size);
        memcpy(buffer, VARDATA(begin), begin_size);
        memcpy(buffer + begin_size, VARDATA(end), end_size);

        if(lang == NULL)
            PG_RETURN_RDFBOX_P(GetStringRdfBox(buffer, begin_size + end_size));
        else
            PG_RETURN_RDFBOX_P(GetLangStringRdfBox(buffer, begin_size + end_size, VARDATA(lang), VARSIZE(lang) - VARHDRSZ));
    }

    PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(langmatches_string_string);
Datum langmatches_string_string(PG_FUNCTION_ARGS)
{
    VarChar *lang = PG_GETARG_VARCHAR_PP(0);
    VarChar *pattern = PG_GETARG_VARCHAR_PP(1);

    int lang_size = VARSIZE_ANY_EXHDR(lang);
    int pattern_size = VARSIZE_ANY_EXHDR(pattern);

    if(pattern_size == 1 && *VARDATA_ANY(pattern) == '*')
    {
        PG_RETURN_BOOL(true);
    }
    else if(pattern_size <= lang_size)
    {
        char *lang_lower = str_tolower(VARDATA_ANY(lang), lang_size, DEFAULT_COLLATION_OID);
        char *pattern_lower = str_tolower(VARDATA_ANY(pattern), pattern_size, DEFAULT_COLLATION_OID);

        int length = strlen(pattern_lower);
        PG_RETURN_BOOL(strncmp(lang_lower, pattern_lower, length) == 0 && (lang_lower[length] == '\0' || lang_lower[length] == '-'));
    }
    else
    {
        PG_RETURN_BOOL(false);
    }
}


PG_FUNCTION_INFO_V1(langmatches_rdfbox_rdfbox);
Datum langmatches_rdfbox_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *lang = PG_GETARG_RDFBOX_P(0);
    RdfBox *pattern = PG_GETARG_RDFBOX_P(1);

    if(lang->type == XSD_STRING && pattern->type == XSD_STRING)
        PG_RETURN(NullableFunctionCall2(langmatches_string_string, PointerGetDatum(RdfBoxGetVarChar(lang)), PointerGetDatum(RdfBoxGetVarChar(pattern))));

    PG_RETURN_NULL();
}
