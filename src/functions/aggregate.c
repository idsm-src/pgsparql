#include <postgres.h>
#include <utils/datum.h>
#include <utils/lsyscache.h>
#include <utils/typcache.h>
#include <utils/builtins.h>
#include <utils/numeric.h>
#include <libpq/pqformat.h>
#include "call.h"
#include "constants.h"
#include "try-catch.h"
#include "rdfbox/order.h"
#include "rdfbox/rdfbox.h"


typedef struct
{
    bool error;
    Datum numeric_state;
}
DecimalAggState;


typedef struct
{
    bool error;
    int64 count;
    float4 sum;
}
FloatAggState;


typedef struct
{
    bool error;
    int64 count;
    float8 sum;
}
DoubleAggState;


typedef struct
{
    bool error;
    int64 double_count;
    int64 float_count;
    int64 decimal_count;
    int64 integer_count;

    float8 double_sum;
    float4 float_sum;
    Datum numeric_state;
}
RdfBoxAggState;


typedef struct
{
    Oid type;
    Oid collation;
    int16 typlen;
    bool typbyval;
    FmgrInfo compare;

    bool error;
    bool has_value;
    Datum value;
}
MinAggState;


typedef struct
{
    bool error;
    int separator_size;
    StringInfoData buffer;
}
GroupConcatAggState;


static Datum create_numeric_state(FunctionCallInfo fcinfo)
{
    NullableDatum state = NullableAggFunctionCall2(fcinfo, numeric_avg_accum, NULL_DATUM, NULL_DATUM);

    if(state.isnull)
        elog(ERROR, "function numeric_avg_accum returned NULL");

    return state.value;
}


static Datum combine_numeric_states(FunctionCallInfo fcinfo, Datum state1, Datum state2)
{
    NullableDatum state = NullableAggFunctionCall2(fcinfo, numeric_avg_combine, NULLABLE_DATUM(state1), NULLABLE_DATUM(state2));

    if(state.isnull)
        elog(ERROR, "function numeric_avg_combine returned NULL");

    return state.value;
}


static void send_numeric_state(FunctionCallInfo fcinfo, StringInfo buf, Datum numeric_state)
{
    NullableDatum result = NullableAggFunctionCall1(fcinfo, numeric_avg_serialize, NULLABLE_DATUM(numeric_state));

    if(result.isnull)
        elog(ERROR, "function numeric_avg_serialize returned NULL");

    bytea *sstate = DatumGetByteaPP(result.value);

    pq_sendint32(buf, VARSIZE_ANY_EXHDR(sstate));
    pq_sendbytes(buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));
}


static Datum recv_numeric_state(FunctionCallInfo fcinfo, StringInfo buf)
{
    int32 size = pq_getmsgint(buf, sizeof(uint32));
    bytea *sstate = palloc(size + VARHDRSZ);
    SET_VARSIZE(sstate, size + VARHDRSZ);
    pq_copymsgbytes(buf, VARDATA(sstate), size);

    NullableDatum state = NullableAggFunctionCall1(fcinfo, numeric_avg_deserialize, NULLABLE_DATUM(PointerGetDatum(sstate)));

    if(state.isnull)
        elog(ERROR, "function numeric_avg_deserialize returned NULL");

    return state.value;
}


static bool finish_numeric_state(PGFunction func, Datum numeric_state, NullableDatum *result)
{
    volatile bool succeeded = true;

    *result = NULL_DATUM;

    PG_TRY_EX();
    {
        *result = NullableFunctionCall1(func, numeric_state);
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE)
            PG_RE_THROW_EX();

        succeeded = false;
    }
    PG_END_TRY_EX();

    return succeeded;
}


static MinAggState *create_min_state(Oid type, Oid collation)
{
    TypeCacheEntry *entry = lookup_type_cache(type, TYPECACHE_CMP_PROC_FINFO);

    if(!OidIsValid(entry->cmp_proc_finfo.fn_oid))
        ereport(ERROR, (errcode(ERRCODE_UNDEFINED_FUNCTION), errmsg("could not identify a comparison function for type %s", format_type_be(type))));

    MinAggState *state = palloc0(sizeof(MinAggState));

    state->type = type;
    state->collation = collation;
    state->typlen = entry->typlen;
    state->typbyval = entry->typbyval;
    fmgr_info_copy(&state->compare, &entry->cmp_proc_finfo, CurrentMemoryContext);

    return state;
}


static void forget_min_value(MinAggState *state)
{
    if(state->has_value && !state->typbyval)
        pfree(DatumGetPointer(state->value));

    state->has_value = false;
    state->value = (Datum) 0;
}


static void remember_min_value(MinAggState *state, Datum value, MemoryContext agg_context)
{
    MemoryContext old_context = MemoryContextSwitchTo(agg_context);
    Datum copy = datumCopy(value, state->typbyval, state->typlen);
    MemoryContextSwitchTo(old_context);

    forget_min_value(state);

    state->has_value = true;
    state->value = copy;
}


static bool is_less_than_min_value(MinAggState *state, Datum value)
{
    return !state->has_value || DatumGetInt32(FunctionCall2Coll(&state->compare, state->collation, value, state->value)) < 0;
}


PG_FUNCTION_INFO_V1(agg_decimal_accum);
Datum agg_decimal_accum(PG_FUNCTION_ARGS)
{
    DecimalAggState *state = PG_ARGISNULL(0) ? NULL : (DecimalAggState *) PG_GETARG_POINTER(0);

    if(state == NULL)
    {
        MemoryContext agg_context;

        if(!AggCheckCallContext(fcinfo, &agg_context))
            elog(ERROR, "aggregate function called in non-aggregate context");

        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state = palloc0(sizeof(DecimalAggState));
        MemoryContextSwitchTo(old_context);

        state->numeric_state = create_numeric_state(fcinfo);
    }

    if(PG_ARGISNULL(1))
        state->error = true;
    else
        DirectFunctionCall2(numeric_avg_accum, state->numeric_state, PG_GETARG_DATUM(1));

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(agg_decimal_combine);
Datum agg_decimal_combine(PG_FUNCTION_ARGS)
{
    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    DecimalAggState *state1 = PG_ARGISNULL(0) ? NULL : (DecimalAggState *) PG_GETARG_POINTER(0);
    DecimalAggState *state2 = PG_ARGISNULL(1) ? NULL : (DecimalAggState *) PG_GETARG_POINTER(1);

    if(state2 == NULL)
        PG_RETURN_POINTER(state1);

    if(state1 == NULL)
    {
        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state1 = palloc0(sizeof(DecimalAggState));
        MemoryContextSwitchTo(old_context);

        state1->numeric_state = create_numeric_state(fcinfo);
    }

    state1->error |= state2->error;
    state1->numeric_state = combine_numeric_states(fcinfo, state1->numeric_state, state2->numeric_state);

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(agg_decimal_serialize);
Datum agg_decimal_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    DecimalAggState *state = (DecimalAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint8(&buf, state->error);
    send_numeric_state(fcinfo, &buf, state->numeric_state);

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(agg_decimal_deserialize);
Datum agg_decimal_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    DecimalAggState *state = palloc(sizeof(DecimalAggState));

    state->error = pq_getmsgint(&buf, sizeof(uint8));
    state->numeric_state = recv_numeric_state(fcinfo, &buf);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(sum_integer_final);
Datum sum_integer_final(PG_FUNCTION_ARGS)
{
    DecimalAggState *state = PG_ARGISNULL(0) ? NULL : (DecimalAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
            PG_RETURN_NULL();

        NullableDatum result;

        if(!finish_numeric_state(numeric_sum, state->numeric_state, &result))
            PG_RETURN_NULL();

        if(!result.isnull)
            PG_RETURN_DATUM(result.value);
    }

    PG_RETURN_NUMERIC(get_zero());
}


PG_FUNCTION_INFO_V1(sum_decimal_final);
Datum sum_decimal_final(PG_FUNCTION_ARGS)
{
    DecimalAggState *state = PG_ARGISNULL(0) ? NULL : (DecimalAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
            PG_RETURN_NULL();

        NullableDatum result;

        if(!finish_numeric_state(numeric_sum, state->numeric_state, &result))
            PG_RETURN_NULL();

        if(!result.isnull)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(result.value)));
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_decimal_final);
Datum avg_decimal_final(PG_FUNCTION_ARGS)
{
    DecimalAggState *state = PG_ARGISNULL(0) ? NULL : (DecimalAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
            PG_RETURN_NULL();

        NullableDatum result;

        if(!finish_numeric_state(numeric_avg, state->numeric_state, &result))
            PG_RETURN_NULL();

        if(!result.isnull)
            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(result.value)));
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(agg_float_accum);
Datum agg_float_accum(PG_FUNCTION_ARGS)
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

    if(PG_ARGISNULL(1))
    {
        state->error = true;
    }
    else
    {
        state->count++;
        state->sum += PG_GETARG_FLOAT4(1);
    }

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(agg_float_combine);
Datum agg_float_combine(PG_FUNCTION_ARGS)
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

    state1->error |= state2->error;
    state1->count += state2->count;
    state1->sum += state2->sum;

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(agg_float_serialize);
Datum agg_float_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    FloatAggState *state = (FloatAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint8(&buf, state->error);
    pq_sendint64(&buf, state->count);
    pq_sendfloat4(&buf, state->sum);

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(agg_float_deserialize);
Datum agg_float_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    FloatAggState *state = palloc(sizeof(FloatAggState));

    state->error = pq_getmsgint(&buf, sizeof(uint8));
    state->count = pq_getmsgint64(&buf);
    state->sum = pq_getmsgfloat4(&buf);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(sum_float_final);
Datum sum_float_final(PG_FUNCTION_ARGS)
{
    FloatAggState *state = PG_ARGISNULL(0) ? NULL : (FloatAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
            PG_RETURN_NULL();

        if(state->count > 0)
            PG_RETURN_RDFBOX_P(GetFloatRdfBox(state->sum));
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_float_final);
Datum avg_float_final(PG_FUNCTION_ARGS)
{
    FloatAggState *state = PG_ARGISNULL(0) ? NULL : (FloatAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
            PG_RETURN_NULL();

        if(state->count > 0)
            PG_RETURN_RDFBOX_P(GetFloatRdfBox(state->sum / state->count));
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(agg_double_accum);
Datum agg_double_accum(PG_FUNCTION_ARGS)
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

    if(PG_ARGISNULL(1))
    {
        state->error = true;
    }
    else
    {
        state->count++;
        state->sum += PG_GETARG_FLOAT8(1);
    }

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(agg_double_combine);
Datum agg_double_combine(PG_FUNCTION_ARGS)
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

    state1->error |= state2->error;
    state1->count += state2->count;
    state1->sum += state2->sum;

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(agg_double_serialize);
Datum agg_double_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    DoubleAggState *state = (DoubleAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint8(&buf, state->error);
    pq_sendint64(&buf, state->count);
    pq_sendfloat8(&buf, state->sum);

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(agg_double_deserialize);
Datum agg_double_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    DoubleAggState *state = palloc(sizeof(DoubleAggState));

    state->error = pq_getmsgint(&buf, sizeof(uint8));
    state->count = pq_getmsgint64(&buf);
    state->sum = pq_getmsgfloat8(&buf);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(sum_double_final);
Datum sum_double_final(PG_FUNCTION_ARGS)
{
    DoubleAggState *state = PG_ARGISNULL(0) ? NULL : (DoubleAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
            PG_RETURN_NULL();

        if(state->count > 0)
            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(state->sum));
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_double_final);
Datum avg_double_final(PG_FUNCTION_ARGS)
{
    DoubleAggState *state = PG_ARGISNULL(0) ? NULL : (DoubleAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
            PG_RETURN_NULL();

        if(state->count > 0)
            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(state->sum / state->count));
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(agg_rdfbox_accum);
Datum agg_rdfbox_accum(PG_FUNCTION_ARGS)
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

        state->numeric_state = create_numeric_state(fcinfo);
    }

    if(PG_ARGISNULL(1))
    {
        state->error = true;
    }
    else
    {
        RdfBox *box = PG_GETARG_RDFBOX_P(1);

        switch(box->type)
        {
            case XSD_SHORT:
                state->integer_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_state, DirectFunctionCall1(int2_numeric, Int16GetDatum(RdfBoxGetInt16(box))));
                break;

            case XSD_INT:
                state->integer_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_state, DirectFunctionCall1(int4_numeric, Int32GetDatum(RdfBoxGetInt32(box))));
                break;

            case XSD_LONG:
                state->integer_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_state, DirectFunctionCall1(int8_numeric, Int64GetDatum(RdfBoxGetInt64(box))));
                break;

            case XSD_INTEGER:
                state->integer_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_state, NumericGetDatum(RdfBoxGetNumeric(box)));
                break;

            case XSD_DECIMAL:
                state->decimal_count++;
                DirectFunctionCall2(numeric_avg_accum, state->numeric_state, NumericGetDatum(RdfBoxGetNumeric(box)));
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
                state->error = true;
                break;
        }
    }

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(agg_rdfbox_combine);
Datum agg_rdfbox_combine(PG_FUNCTION_ARGS)
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

        state1->numeric_state = create_numeric_state(fcinfo);
    }

    state1->error |= state2->error;
    state1->double_count += state2->double_count;
    state1->float_count += state2->float_count;
    state1->decimal_count += state2->decimal_count;
    state1->integer_count += state2->integer_count;
    state1->double_sum += state2->double_sum;
    state1->float_sum += state2->float_sum;
    state1->numeric_state = combine_numeric_states(fcinfo, state1->numeric_state, state2->numeric_state);

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(agg_rdfbox_serialize);
Datum agg_rdfbox_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    RdfBoxAggState *state = (RdfBoxAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint8(&buf, state->error);
    pq_sendint64(&buf, state->double_count);
    pq_sendint64(&buf, state->float_count);
    pq_sendint64(&buf, state->decimal_count);
    pq_sendint64(&buf, state->integer_count);
    pq_sendfloat8(&buf, state->double_sum);
    pq_sendfloat4(&buf, state->float_sum);
    send_numeric_state(fcinfo, &buf, state->numeric_state);

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(agg_rdfbox_deserialize);
Datum agg_rdfbox_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    RdfBoxAggState *state = palloc(sizeof(RdfBoxAggState));

    state->error = pq_getmsgint(&buf, sizeof(uint8));
    state->double_count = pq_getmsgint64(&buf);
    state->float_count = pq_getmsgint64(&buf);
    state->decimal_count = pq_getmsgint64(&buf);
    state->integer_count = pq_getmsgint64(&buf);
    state->double_sum = pq_getmsgfloat8(&buf);
    state->float_sum = pq_getmsgfloat4(&buf);
    state->numeric_state = recv_numeric_state(fcinfo, &buf);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(sum_rdfbox_final);
Datum sum_rdfbox_final(PG_FUNCTION_ARGS)
{
    RdfBoxAggState *state = PG_ARGISNULL(0) ? NULL : (RdfBoxAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
        {
            PG_RETURN_NULL();
        }
        else if(state->double_count > 0)
        {
            float8 sum = state->double_sum + state->float_sum;

            if(state->decimal_count > 0 || state->integer_count > 0)
            {
                NullableDatum total;

                if(!finish_numeric_state(numeric_sum, state->numeric_state, &total) || total.isnull)
                    PG_RETURN_NULL();

                sum += strtod(DatumGetCString(DirectFunctionCall1(numeric_out, total.value)), NULL);
            }

            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(sum));
        }
        else if(state->float_count > 0)
        {
            float4 sum = state->float_sum;

            if(state->decimal_count > 0 || state->integer_count > 0)
            {
                NullableDatum total;

                if(!finish_numeric_state(numeric_sum, state->numeric_state, &total) || total.isnull)
                    PG_RETURN_NULL();

                sum += strtof(DatumGetCString(DirectFunctionCall1(numeric_out, total.value)), NULL);
            }

            PG_RETURN_RDFBOX_P(GetFloatRdfBox(sum));
        }
        else if(state->decimal_count > 0 || state->integer_count > 0)
        {
            NullableDatum total;

            if(!finish_numeric_state(numeric_sum, state->numeric_state, &total) || total.isnull)
                PG_RETURN_NULL();

            if(state->decimal_count > 0)
                PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(total.value)));
            else
                PG_RETURN_RDFBOX_P(GetIntegerRdfBox(DatumGetNumeric(total.value)));
        }
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(avg_rdfbox_final);
Datum avg_rdfbox_final(PG_FUNCTION_ARGS)
{
    RdfBoxAggState *state = PG_ARGISNULL(0) ? NULL : (RdfBoxAggState *) PG_GETARG_POINTER(0);

    if(state != NULL)
    {
        if(state->error)
        {
            PG_RETURN_NULL();
        }
        else if(state->double_count > 0)
        {
            float8 sum = state->double_sum + state->float_sum;

            if(state->decimal_count > 0 || state->integer_count > 0)
            {
                NullableDatum total;

                if(!finish_numeric_state(numeric_sum, state->numeric_state, &total) || total.isnull)
                    PG_RETURN_NULL();

                sum += strtod(DatumGetCString(DirectFunctionCall1(numeric_out, total.value)), NULL);
            }

            PG_RETURN_RDFBOX_P(GetDoubleRdfBox(sum / (state->double_count + state->float_count + state->decimal_count + state->integer_count)));
        }
        else if(state->float_count > 0)
        {
            float4 sum = state->float_sum;

            if(state->decimal_count > 0 || state->integer_count > 0)
            {
                NullableDatum total;

                if(!finish_numeric_state(numeric_sum, state->numeric_state, &total) || total.isnull)
                    PG_RETURN_NULL();

                sum += strtof(DatumGetCString(DirectFunctionCall1(numeric_out, total.value)), NULL);
            }

            PG_RETURN_RDFBOX_P(GetFloatRdfBox(sum / (state->float_count + state->decimal_count + state->integer_count)));
        }
        else if(state->decimal_count > 0 || state->integer_count > 0)
        {
            NullableDatum average;

            if(!finish_numeric_state(numeric_avg, state->numeric_state, &average) || average.isnull)
                PG_RETURN_NULL();

            PG_RETURN_RDFBOX_P(GetDecimalRdfBox(DatumGetNumeric(average.value)));
        }
    }

    PG_RETURN_RDFBOX_P(GetIntegerRdfBox(get_zero()));
}


PG_FUNCTION_INFO_V1(min_accum);
Datum min_accum(PG_FUNCTION_ARGS)
{
    MinAggState *state = PG_ARGISNULL(0) ? NULL : (MinAggState *) PG_GETARG_POINTER(0);

    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    if(state == NULL)
    {
        Oid type = get_fn_expr_argtype(fcinfo->flinfo, 1);

        if(!OidIsValid(type))
            elog(ERROR, "could not determine input data type");

        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state = create_min_state(type, PG_GET_COLLATION());
        MemoryContextSwitchTo(old_context);
    }

    if(PG_ARGISNULL(1))
    {
        state->error = true;
        forget_min_value(state);
    }
    else if(!state->error && is_less_than_min_value(state, PG_GETARG_DATUM(1)))
    {
        remember_min_value(state, PG_GETARG_DATUM(1), agg_context);
    }

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(min_combine);
Datum min_combine(PG_FUNCTION_ARGS)
{
    MemoryContext agg_context;

    if(!AggCheckCallContext(fcinfo, &agg_context))
        elog(ERROR, "aggregate function called in non-aggregate context");

    MinAggState *state1 = PG_ARGISNULL(0) ? NULL : (MinAggState *) PG_GETARG_POINTER(0);
    MinAggState *state2 = PG_ARGISNULL(1) ? NULL : (MinAggState *) PG_GETARG_POINTER(1);

    if(state2 == NULL)
        PG_RETURN_POINTER(state1);

    if(state1 == NULL)
    {
        MemoryContext old_context = MemoryContextSwitchTo(agg_context);
        state1 = create_min_state(state2->type, state2->collation);
        MemoryContextSwitchTo(old_context);
    }

    state1->error |= state2->error;

    if(state1->error)
        forget_min_value(state1);
    else if(state2->has_value && is_less_than_min_value(state1, state2->value))
        remember_min_value(state1, state2->value, agg_context);

    PG_RETURN_POINTER(state1);
}


PG_FUNCTION_INFO_V1(min_serialize);
Datum min_serialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    MinAggState *state = (MinAggState *) PG_GETARG_POINTER(0);

    StringInfoData buf;
    pq_begintypsend(&buf);

    pq_sendint32(&buf, state->type);
    pq_sendint32(&buf, state->collation);
    pq_sendint8(&buf, state->error);

    Size size = datumEstimateSpace(state->value, !state->has_value, state->typbyval, state->typlen);
    char *data = palloc(size);
    char *cursor = data;

    datumSerialize(state->value, !state->has_value, state->typbyval, state->typlen, &cursor);

    pq_sendint32(&buf, size);
    pq_sendbytes(&buf, data, size);

    pfree(data);

    bytea *result = pq_endtypsend(&buf);
    PG_RETURN_BYTEA_P(result);
}


PG_FUNCTION_INFO_V1(min_deserialize);
Datum min_deserialize(PG_FUNCTION_ARGS)
{
    if(!AggCheckCallContext(fcinfo, NULL))
        elog(ERROR, "aggregate function called in non-aggregate context");

    bytea *sstate = PG_GETARG_BYTEA_PP(0);

    StringInfoData buf;
    initStringInfo(&buf);
    appendBinaryStringInfo(&buf, VARDATA_ANY(sstate), VARSIZE_ANY_EXHDR(sstate));

    Oid type = pq_getmsgint(&buf, sizeof(int32));
    Oid collation = pq_getmsgint(&buf, sizeof(int32));

    MinAggState *state = create_min_state(type, collation);

    state->error = pq_getmsgint(&buf, sizeof(uint8));

    int32 size = pq_getmsgint(&buf, sizeof(int32));
    char *cursor = (char *) pq_getmsgbytes(&buf, size);
    bool isnull;

    state->value = datumRestore(&cursor, &isnull);
    state->has_value = !isnull;

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(min_final);
Datum min_final(PG_FUNCTION_ARGS)
{
    MinAggState *state = PG_ARGISNULL(0) ? NULL : (MinAggState *) PG_GETARG_POINTER(0);

    if(state == NULL || state->error || !state->has_value)
        PG_RETURN_NULL();

    PG_RETURN_DATUM(datumCopy(state->value, state->typbyval, state->typlen));
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

    VarChar *value = PG_ARGISNULL(1) ? NULL : PG_GETARG_VARCHAR_PP(1);
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

    if(value == NULL)
    {
        state->error = true;
    }
    else
    {
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
    }

    MemoryContextSwitchTo(old_context);

    PG_RETURN_POINTER(state);
}


PG_FUNCTION_INFO_V1(group_concat_final);
Datum group_concat_final(PG_FUNCTION_ARGS)
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

    RdfBox *box = PG_ARGISNULL(1) ? NULL : PG_GETARG_RDFBOX_P(1);
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

    if(box != NULL && (box->type == RDF_LANGSTRING || box->type == XSD_STRING))
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
        state1 = palloc0(sizeof(GroupConcatAggState));
        initStringInfo(&state1->buffer);
    }

    state1->error |= state2->error;
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
