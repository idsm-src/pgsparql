#include <postgres.h>
#include <utils/datum.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <libpq/pqformat.h>
#include "call.h"
#include "constants.h"
#include "compare.h"
#include "rdfbox/order.h"
#include "rdfbox/rdfbox.h"


typedef struct
{
    int64 count;
    float4 sum;
}
FloatAggState;


typedef struct
{
    int64 count;
    float8 sum;
}
DoubleAggState;


typedef struct
{
    int64 double_count;
    int64 float_count;
    int64 decimal_count;
    int64 integer_count;
    int64 error_count;

    float8 double_sum;
    float4 float_sum;
    Datum numeric_sum;
}
RdfBoxAggState;


typedef struct
{
    bool error;
    VarChar *lang;
    int separator_size;
    StringInfoData buffer;
}
GroupConcatAggState;


PG_FUNCTION_INFO_V1(sum_integer_final);
Datum sum_integer_final(PG_FUNCTION_ARGS)
{
    if(!PG_ARGISNULL(0))
    {
        NullableDatum result = NullableFunctionCall1(numeric_sum, PG_GETARG_DATUM(0));

        if(!result.isnull)
            PG_RETURN_DATUM(result.value);
    }

    PG_RETURN_NUMERIC(get_zero());
}


PG_FUNCTION_INFO_V1(sum_decimal_final);
Datum sum_decimal_final(PG_FUNCTION_ARGS)
{
    if(!PG_ARGISNULL(0))
    {
        NullableDatum result = NullableFunctionCall1(numeric_sum, PG_GETARG_DATUM(0));

        if(!result.isnull)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(result.value)));
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(sum_float_accum);
Datum sum_float_accum(PG_FUNCTION_ARGS)
{
    if(!PG_ARGISNULL(0) && !PG_ARGISNULL(1))
        PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0) + PG_GETARG_FLOAT4(1));
    else if(!PG_ARGISNULL(0))
        PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(0));
    else if(!PG_ARGISNULL(1))
        PG_RETURN_FLOAT4(PG_GETARG_FLOAT4(1));
    else
        PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(sum_float_final);
Datum sum_float_final(PG_FUNCTION_ARGS)
{
    if(!PG_ARGISNULL(0))
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(PG_GETARG_FLOAT4(0)));
    else
        PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(sum_double_accum);
Datum sum_double_accum(PG_FUNCTION_ARGS)
{
    if(!PG_ARGISNULL(0) && !PG_ARGISNULL(1))
        PG_RETURN_FLOAT8(PG_GETARG_FLOAT8(0) + PG_GETARG_FLOAT8(1));
    else if(!PG_ARGISNULL(0))
        PG_RETURN_FLOAT8(PG_GETARG_FLOAT8(0));
    else if(!PG_ARGISNULL(1))
        PG_RETURN_FLOAT8(PG_GETARG_FLOAT8(1));
    else
        PG_RETURN_NULL();
}


PG_FUNCTION_INFO_V1(sum_double_final);
Datum sum_double_final(PG_FUNCTION_ARGS)
{
    if(!PG_ARGISNULL(0))
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(PG_GETARG_FLOAT8(0)));
    else
        PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(sum_rdfbox_final);
Datum sum_rdfbox_final(PG_FUNCTION_ARGS)
{
    RdfBoxAggState *state = PG_ARGISNULL(0) ? NULL : (RdfBoxAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error_count > 0)
        {
            PG_RETURN_NULL();
        }
        else if(state->double_count > 0)
        {
            float8 sum = state->double_sum + state->float_sum;

            if(state->decimal_count > 0 || state->integer_count > 0)
                sum += strtod(DatumGetCString(DirectFunctionCall1(numeric_out, DirectFunctionCall1(numeric_sum, state->numeric_sum))), NULL);

            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(sum));
        }
        else if(state->float_count > 0)
        {
            float4 sum = state->float_sum;

            if(state->decimal_count > 0 || state->integer_count > 0)
                sum += strtof(DatumGetCString(DirectFunctionCall1(numeric_out, DirectFunctionCall1(numeric_sum, state->numeric_sum))), NULL);

            PG_RETURN_RDFBOX_P(GetFloatRdfBox(sum));
        }
        else if(state->decimal_count > 0)
        {
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(DirectFunctionCall1(numeric_sum, state->numeric_sum))));
        }
        else if(state->integer_count > 0)
        {
            PG_RETURN_RDFBOX_P(GetIntegerRdfBox(DatumGetNumeric(DirectFunctionCall1(numeric_sum, state->numeric_sum))));
        }
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_decimal_final);
Datum avg_decimal_final(PG_FUNCTION_ARGS)
{
    if(!PG_ARGISNULL(0))
    {
        NullableDatum result = NullableFunctionCall1(numeric_avg, PG_GETARG_DATUM(0));

        if(!result.isnull)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(result.value)));
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_float_accum);
Datum avg_float_accum(PG_FUNCTION_ARGS)
{
    FloatAggState *state = PG_ARGISNULL(0) ? NULL : (FloatAggState *) PG_GETARG_POINTER(0);

    if(state == NULL)
    {
        MemoryContext agg_context;

        if(!AggCheckCallContext(fcinfo, &agg_context))
            elog(ERROR, "aggregate function called in non-aggregate context");

        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state = palloc0(sizeof(FloatAggState));
        MemoryContextSwitchTo(old_context);
    }

    if(!PG_ARGISNULL(1))
    {
        state->count++;
        state->sum += PG_GETARG_FLOAT4(1);
    }

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(avg_float_final);
Datum avg_float_final(PG_FUNCTION_ARGS)
{
    FloatAggState *state = PG_ARGISNULL(0) ? NULL : (FloatAggState *) PG_GETARG_POINTER(0);

    if(state != NULL && state->count > 0)
        PG_RETURN_RDFBOX_P(GetFloatRdfBox(state->sum / state->count));

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_float_combine);
Datum avg_float_combine(PG_FUNCTION_ARGS)
{
    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    FloatAggState *state1 = PG_ARGISNULL(0) ? NULL : (FloatAggState *) PG_GETARG_POINTER(0);
    FloatAggState *state2 = PG_ARGISNULL(1) ? NULL : (FloatAggState *) PG_GETARG_POINTER(1);

    if(state2 == NULL)
        PG_RETURN_POINTER(state1);

    if(state1 == NULL)
    {
        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state1 = palloc0(sizeof(FloatAggState));
        MemoryContextSwitchTo(old_context);
    }

    state1->count += state2->count;
    state1->sum += state2->sum;

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(avg_float_serialize);
Datum avg_float_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    FloatAggState *state = (FloatAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint64(&buf, state->count);
    pq_sendfloat4(&buf, state->sum);

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(avg_float_deserialize);
Datum avg_float_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    FloatAggState *state = palloc(sizeof(FloatAggState));

    state->count = pq_getmsgint64(&buf);
    state->sum = pq_getmsgfloat4(&buf);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(avg_double_accum);
Datum avg_double_accum(PG_FUNCTION_ARGS)
{
    DoubleAggState *state = PG_ARGISNULL(0) ? NULL : (DoubleAggState *) PG_GETARG_POINTER(0);

    if(state == NULL)
    {
        MemoryContext agg_context;

        if(!AggCheckCallContext(fcinfo, &agg_context))
            elog(ERROR, "aggregate function called in non-aggregate context");

        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state = palloc0(sizeof(DoubleAggState));
        MemoryContextSwitchTo(old_context);
    }

    if(!PG_ARGISNULL(1))
    {
        state->count++;
        state->sum += PG_GETARG_FLOAT8(1);
    }

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(avg_double_final);
Datum avg_double_final(PG_FUNCTION_ARGS)
{
    DoubleAggState *state = PG_ARGISNULL(0) ? NULL : (DoubleAggState *) PG_GETARG_POINTER(0);

    if(state != NULL && state->count > 0)
        PG_RETURN_RDFBOX_P(GetDoubleRdfBox(state->sum / state->count));

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_double_combine);
Datum avg_double_combine(PG_FUNCTION_ARGS)
{
    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    DoubleAggState *state1 = PG_ARGISNULL(0) ? NULL : (DoubleAggState *) PG_GETARG_POINTER(0);
    DoubleAggState *state2 = PG_ARGISNULL(1) ? NULL : (DoubleAggState *) PG_GETARG_POINTER(1);

    if(state2 == NULL)
        PG_RETURN_POINTER(state1);

    if(state1 == NULL)
    {
        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state1 = palloc0(sizeof(DoubleAggState));
        MemoryContextSwitchTo(old_context);
    }

    state1->count += state2->count;
    state1->sum += state2->sum;

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(avg_double_serialize);
Datum avg_double_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    DoubleAggState *state = (DoubleAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint64(&buf, state->count);
    pq_sendfloat8(&buf, state->sum);

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(avg_double_deserialize);
Datum avg_double_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    DoubleAggState *state = palloc(sizeof(DoubleAggState));

    state->count = pq_getmsgint64(&buf);
    state->sum = pq_getmsgfloat8(&buf);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(avg_rdfbox_accum);
Datum avg_rdfbox_accum(PG_FUNCTION_ARGS)
{
    RdfBoxAggState *state = PG_ARGISNULL(0) ? NULL : (RdfBoxAggState *) PG_GETARG_POINTER(0);

    if(state == NULL)
    {
        MemoryContext agg_context;

        if(!AggCheckCallContext(fcinfo, &agg_context))
            elog(ERROR, "aggregate function called in non-aggregate context");

        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state = palloc0(sizeof(RdfBoxAggState));
        MemoryContextSwitchTo(old_context);

        LOCAL_FCINFO(subfcinfo, 2);
        InitFunctionCallInfoData(*subfcinfo, NULL, 2, InvalidOid, fcinfo->context, NULL);
        subfcinfo->args[0].isnull = true;
        subfcinfo->args[1].isnull = true;
        state->numeric_sum = (*numeric_avg_accum) (subfcinfo);

        if(subfcinfo->isnull)
            elog(ERROR, "function numeric_avg_accum returned NULL");
    }

    if(!PG_ARGISNULL(1))
    {
        RdfBox *box = PG_GETARG_RDFBOX_P(1);

        switch(box->type)
        {
            case XSD_SHORT:
                state->integer_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_sum, DirectFunctionCall1(int2_numeric, Int16GetDatum(RdfBoxGetInt16(box))));
                break;

            case XSD_INT:
                state->integer_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_sum, DirectFunctionCall1(int4_numeric, Int32GetDatum(RdfBoxGetInt32(box))));
                break;

            case XSD_LONG:
                state->integer_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_sum, DirectFunctionCall1(int8_numeric, Int64GetDatum(RdfBoxGetInt64(box))));
                break;

            case XSD_INTEGER:
                state->integer_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_sum, NumericGetDatum(RdfBoxGetNumeric(box)));
                break;

            case XSD_DECIMAL:
                state->decimal_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_sum, NumericGetDatum(RdfBoxGetNumeric(box)));
                break;

            case XSD_FLOAT:
                state->float_count++;
                state->float_sum += RdfBoxGetFloat4(box);
                break;

            case XSD_DOUBLE:
                state->double_count++;
                state->double_sum += RdfBoxGetFloat8(box);
                break;

            default:
                state->error_count++;
                break;
        }
    }

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(avg_rdfbox_final);
Datum avg_rdfbox_final(PG_FUNCTION_ARGS)
{
    RdfBoxAggState *state = PG_ARGISNULL(0) ? NULL : (RdfBoxAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error_count > 0)
        {
            PG_RETURN_NULL();
        }
        else if(state->double_count > 0)
        {
            float8 sum = state->double_sum + state->float_sum;

            if(state->decimal_count > 0 || state->integer_count > 0)
                sum += strtod(DatumGetCString(DirectFunctionCall1(numeric_out, DirectFunctionCall1(numeric_sum, state->numeric_sum))), NULL);

            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(sum / (state->double_count + state->float_count + state->decimal_count + state->integer_count)));
        }
        else if(state->float_count > 0)
        {
            float4 sum = state->float_sum;

            if(state->decimal_count > 0 || state->integer_count > 0)
                sum += strtof(DatumGetCString(DirectFunctionCall1(numeric_out, DirectFunctionCall1(numeric_sum, state->numeric_sum))), NULL);

            PG_RETURN_RDFBOX_P(GetFloatRdfBox(sum / (state->float_count + state->decimal_count + state->integer_count)));
        }
        else if(state->decimal_count > 0 || state->integer_count > 0)
        {
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(DirectFunctionCall1(numeric_avg, state->numeric_sum))));
        }
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_rdfbox_combine);
Datum avg_rdfbox_combine(PG_FUNCTION_ARGS)
{
    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    RdfBoxAggState *state1 = PG_ARGISNULL(0) ? NULL : (RdfBoxAggState *) PG_GETARG_POINTER(0);
    RdfBoxAggState *state2 = PG_ARGISNULL(1) ? NULL : (RdfBoxAggState *) PG_GETARG_POINTER(1);

    if(state2 == NULL)
        PG_RETURN_POINTER(state1);

    if(state1 == NULL)
    {
        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state1 = palloc0(sizeof(RdfBoxAggState));
        MemoryContextSwitchTo(old_context);
    }

    state1->error_count += state2->error_count;
    state1->double_count += state2->double_count;
    state1->float_count += state2->float_count;
    state1->decimal_count += state2->decimal_count;
    state1->integer_count += state2->integer_count;
    state1->double_sum += state2->double_sum;
    state1->float_sum += state2->float_sum;

    LOCAL_FCINFO(subfcinfo, 2);
    InitFunctionCallInfoData(*subfcinfo, NULL, 2, InvalidOid, fcinfo->context, NULL);
    subfcinfo->args[0].isnull = false;
    subfcinfo->args[0].value = state1->numeric_sum;
    subfcinfo->args[1].isnull = false;
    subfcinfo->args[1].value = state2->numeric_sum;
    state1->numeric_sum = (*numeric_avg_combine) (subfcinfo);

    if(subfcinfo->isnull)
        elog(ERROR, "function numeric_avg_accum returned NULL");

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(avg_rdfbox_serialize);
Datum avg_rdfbox_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    RdfBoxAggState *state = (RdfBoxAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint64(&buf, state->error_count);
    pq_sendint64(&buf, state->double_count);
    pq_sendint64(&buf, state->float_count);
    pq_sendint64(&buf, state->decimal_count);
    pq_sendint64(&buf, state->integer_count);
    pq_sendfloat8(&buf, state->double_sum);
    pq_sendfloat4(&buf, state->float_sum);

    LOCAL_FCINFO(subfcinfo, 1);
    InitFunctionCallInfoData(*subfcinfo, NULL, 1, InvalidOid, fcinfo->context, NULL);
    subfcinfo->args[0].isnull = false;
    subfcinfo->args[0].value = state->numeric_sum;
    bytea *numeric_sstate = DatumGetByteaPP((*numeric_avg_serialize) (subfcinfo));

    if(subfcinfo->isnull)
        elog(ERROR, "function numeric_avg_serialize returned NULL");

    pq_sendint32(&buf, VARSIZE_ANY_EXHDR(numeric_sstate));
    pq_sendbytes(&buf, VARDATA_ANY(numeric_sstate), VARSIZE_ANY_EXHDR(numeric_sstate));

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(avg_rdfbox_deserialize);
Datum avg_rdfbox_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    RdfBoxAggState *state = palloc(sizeof(RdfBoxAggState));

    state->error_count = pq_getmsgint64(&buf);
    state->double_count = pq_getmsgint64(&buf);
    state->float_count = pq_getmsgint64(&buf);
    state->decimal_count = pq_getmsgint64(&buf);
    state->integer_count = pq_getmsgint64(&buf);
    state->double_sum = pq_getmsgfloat8(&buf);
    state->float_sum = pq_getmsgfloat4(&buf);

    int32 size = pq_getmsgint(&buf, sizeof(uint32));
    bytea *numeric_sstate = palloc(size + VARHDRSZ);
    SET_VARSIZE(numeric_sstate, size + VARHDRSZ);
    pq_copymsgbytes(&buf, VARDATA(numeric_sstate), size);

    LOCAL_FCINFO(subfcinfo, 1);
    InitFunctionCallInfoData(*subfcinfo, NULL, 1, InvalidOid, fcinfo->context, NULL);
    subfcinfo->args[0].isnull = false;
    subfcinfo->args[0].value = PointerGetDatum(numeric_sstate);
    state->numeric_sum = (*numeric_avg_deserialize) (subfcinfo);

    if(subfcinfo->isnull)
        elog(ERROR, "function numeric_avg_deserialize returned NULL");

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(min_rdfbox);
Datum min_rdfbox(PG_FUNCTION_ARGS)
{
    Datum box1 = PG_GETARG_DATUM(0);
    Datum box2 = PG_GETARG_DATUM(1);

    if(DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, box1, box2)) < 0)
        PG_RETURN_DATUM(box1);
    else
        PG_RETURN_DATUM(box2);
}


PG_FUNCTION_INFO_V1(max_rdfbox);
Datum max_rdfbox(PG_FUNCTION_ARGS)
{
    Datum box1 = PG_GETARG_DATUM(0);
    Datum box2 = PG_GETARG_DATUM(1);

    if(DatumGetInt32(DirectFunctionCall2(rdfbox_order_compare, box1, box2)) > 0)
        PG_RETURN_DATUM(box1);
    else
        PG_RETURN_DATUM(box2);
}


PG_FUNCTION_INFO_V1(group_concat_string);
Datum group_concat_string(PG_FUNCTION_ARGS)
{
    VarChar *state = PG_GETARG_VARCHAR_PP(0);
    VarChar *value = PG_GETARG_VARCHAR_PP(1);
    VarChar *delim = PG_GETARG_VARCHAR_PP(2);

    int state_size = VARSIZE_ANY_EXHDR(state);
    int value_size = VARSIZE_ANY_EXHDR(value);
    int delim_size = VARSIZE_ANY_EXHDR(delim);

    VarChar *merged = (VarChar *) palloc(VARHDRSZ + state_size + delim_size + value_size);
    SET_VARSIZE(merged, VARHDRSZ + state_size + delim_size + value_size);

    memcpy(VARDATA(merged), VARDATA_ANY(state), state_size);
    memcpy(VARDATA(merged) + state_size, VARDATA_ANY(delim), delim_size);
    memcpy(VARDATA(merged) + state_size + delim_size, VARDATA_ANY(value), value_size);

    PG_RETURN_VARCHAR_P(merged);
}


PG_FUNCTION_INFO_V1(group_concat_string_accum);
Datum group_concat_string_accum(PG_FUNCTION_ARGS)
{
    GroupConcatAggState *state = PG_ARGISNULL(0) ? NULL : (GroupConcatAggState *) PG_GETARG_POINTER(0);

    if(PG_ARGISNULL(1))
        PG_RETURN_POINTER(state);

    VarChar *value = PG_GETARG_VARCHAR_PP(1);
    VarChar *separator = (PG_NARGS() < 3 || PG_ARGISNULL(2)) ? NULL : PG_GETARG_VARCHAR_PP(2);

    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    MemoryContext old_context = MemoryContextSwitchTo(agg_context);

    if(state == NULL)
    {
        state = palloc0(sizeof(GroupConcatAggState));
        initStringInfo(&state->buffer);
    }

    appendBinaryStringInfo(&state->buffer, VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value));

    if(separator != NULL)
    {
        state->separator_size = VARSIZE_ANY_EXHDR(separator);
        appendBinaryStringInfo(&state->buffer, VARDATA_ANY(separator), state->separator_size);
    }
    else
    {
        state->separator_size = 1;
        appendStringInfoChar(&state->buffer, ' ');
    }

    MemoryContextSwitchTo(old_context);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(group_concat_string_final);
Datum group_concat_string_final(PG_FUNCTION_ARGS)
{
    GroupConcatAggState *state = PG_ARGISNULL(0) ? NULL : (GroupConcatAggState *) PG_GETARG_POINTER(0);

    if(state == NULL)
    {
        VarChar *result = (VarChar *) palloc0(VARHDRSZ);
        SET_VARSIZE(result, VARHDRSZ);
        PG_RETURN_VARCHAR_P(result);
    }
    else if(state->error)
    {
        PG_RETURN_NULL();
    }
    else
    {
        int size = state->buffer.len - state->separator_size;

        VarChar *result = (VarChar *) palloc0(VARHDRSZ + size);
        SET_VARSIZE(result, VARHDRSZ + size);
        memcpy(VARDATA(result), state->buffer.data, size);
        PG_RETURN_VARCHAR_P(result);
    }
}


PG_FUNCTION_INFO_V1(group_concat_rdfbox_accum);
Datum group_concat_rdfbox_accum(PG_FUNCTION_ARGS)
{
    GroupConcatAggState *state = PG_ARGISNULL(0) ? NULL : (GroupConcatAggState *) PG_GETARG_POINTER(0);

    if(PG_ARGISNULL(1))
        PG_RETURN_POINTER(state);

    RdfBox *box = PG_GETARG_RDFBOX_P(1);
    VarChar *separator = (PG_NARGS() < 3 || PG_ARGISNULL(2)) ? NULL : PG_GETARG_VARCHAR_PP(2);

    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    MemoryContext old_context = MemoryContextSwitchTo(agg_context);

    if(state == NULL)
    {
        state = palloc0(sizeof(GroupConcatAggState));

        initStringInfo(&state->buffer);

        if(box->type == RDF_LANGSTRING)
        {
            VarChar *lang = RdfBoxGetAttachment(box);
            state->lang = palloc(VARSIZE(lang));
            memcpy(state->lang, lang, VARSIZE(lang));
        }
    }
    else if(state->lang != NULL)
    {
        if(box->type == XSD_STRING || (box->type == RDF_LANGSTRING && !varchar_eq(state->lang, RdfBoxGetAttachment(box))))
        {
            pfree(state->lang);
            state->lang = NULL;
        }
    }

    if(box->type == RDF_LANGSTRING || box->type == XSD_STRING)
    {
        VarChar *value = RdfBoxGetVarChar(box);
        appendBinaryStringInfo(&state->buffer, VARDATA(value), VARSIZE(value) - VARHDRSZ);

        if(separator != NULL)
        {
            state->separator_size = VARSIZE_ANY_EXHDR(separator);
            appendBinaryStringInfo(&state->buffer, VARDATA_ANY(separator), state->separator_size);
        }
        else
        {
            state->separator_size = 1;
            appendStringInfoChar(&state->buffer, ' ');
        }
    }
    else
    {
        state->error = true;
    }

    MemoryContextSwitchTo(old_context);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(group_concat_rdfbox_final);
Datum group_concat_rdfbox_final(PG_FUNCTION_ARGS)
{
    GroupConcatAggState *state = PG_ARGISNULL(0) ? NULL : (GroupConcatAggState *) PG_GETARG_POINTER(0);

    if(state == NULL)
        PG_RETURN_RDFBOX_P(GetStringRdfBox(NULL, 0));
    else if(state->error)
        PG_RETURN_NULL();
    else if(state->lang == NULL)
        PG_RETURN_RDFBOX_P(GetStringRdfBox(state->buffer.data, state->buffer.len - state->separator_size));
    else
        PG_RETURN_RDFBOX_P(GetLangStringRdfBox(state->buffer.data, state->buffer.len - state->separator_size, VARDATA(state->lang), VARSIZE(state->lang) - VARHDRSZ));
}


PG_FUNCTION_INFO_V1(group_concat_combine);
Datum group_concat_combine(PG_FUNCTION_ARGS)
{
    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    GroupConcatAggState *state1 = PG_ARGISNULL(0) ? NULL : (GroupConcatAggState *) PG_GETARG_POINTER(0);
    GroupConcatAggState *state2 = PG_ARGISNULL(1) ? NULL : (GroupConcatAggState *) PG_GETARG_POINTER(1);

    if(state2 == NULL)
        PG_RETURN_POINTER(state1);

    MemoryContext old_context = MemoryContextSwitchTo(agg_context);

    if(state1 == NULL)
    {
        state1 = palloc(sizeof(GroupConcatAggState));

        state1->error = state2->error;

        if(state2->lang != NULL)
        {
            state1->lang = palloc(VARSIZE(state2->lang));
            memcpy(state1->lang, state2->lang, VARSIZE(state2->lang));
        }
        else
        {
            state1->lang = NULL;
        }

        initStringInfo(&state1->buffer);
    }
    else
    {
        state1->error |= state2->error;

        if(state1->lang != NULL && (state2->lang == NULL || !varchar_eq(state1->lang, state2->lang)))
        {
            pfree(state1->lang);
            state1->lang = NULL;
        }
    }

    state1->separator_size = state2->separator_size;

    appendBinaryStringInfo(&state1->buffer, state2->buffer.data, state2->buffer.len);

    MemoryContextSwitchTo(old_context);

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(group_concat_serialize);
Datum group_concat_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    GroupConcatAggState *state = (GroupConcatAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint8(&buf, state->error);
    pq_sendint32(&buf, state->separator_size);

    if(state->lang == NULL)
    {
        pq_sendint32(&buf, 0);
    }
    else
    {
        pq_sendint32(&buf, VARSIZE(state->lang));
        pq_sendbytes(&buf, VARDATA(state->lang), VARSIZE(state->lang) - VARHDRSZ);
    }

    appendBinaryStringInfo(&buf, state->buffer.data, state->buffer.len);

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(group_concat_deserialize);
Datum group_concat_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    GroupConcatAggState *state = palloc(sizeof(GroupConcatAggState));

    state->error = pq_getmsgint(&buf, sizeof(uint8));
    state->separator_size = pq_getmsgint(&buf, sizeof(uint32));

    int lang_size = pq_getmsgint(&buf, sizeof(uint32));

    if(lang_size == 0)
    {
        state->lang = NULL;
    }
    else
    {
        state->lang = palloc0(lang_size);
        SET_VARSIZE(state->lang, lang_size);
        pq_copymsgbytes(&buf, VARDATA(state->lang), lang_size - VARHDRSZ);
    }

    initStringInfo(&state->buffer);
    appendBinaryStringInfo(&state->buffer, buf.data + buf.cursor, buf.len - buf.cursor);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(sample);
Datum sample(PG_FUNCTION_ARGS)
{
    Datum datum = PG_GETARG_DATUM(0);
    PG_RETURN_DATUM(datum);
}
