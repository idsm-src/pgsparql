/**
 * @file
 * Direct calls of version-1 functions whose result may be NULL.
 *
 * DirectFunctionCall1() and its siblings raise an error when the called function returns NULL. The functions here
 * hand the result over as a NullableDatum instead, so that an SQL-callable function can call another one and pass
 * its NULL result on, typically by PG_RETURN().
 */
#ifndef CALL_H_
#define CALL_H_

#include <postgres.h>
#include <fmgr.h>


/**
 * Returns a NullableDatum from a version-1 function: NULL if it is null, its value otherwise.
 *
 * @param result the NullableDatum to return
 */
#define PG_RETURN(result)       do { NullableDatum x = result; if(x.isnull) PG_RETURN_NULL(); else PG_RETURN_DATUM(x.value); } while(0)

/**
 * A null NullableDatum.
 */
#define NULL_DATUM              ((NullableDatum) { .value = (Datum) 0, .isnull = true })

/**
 * A NullableDatum that is not null.
 *
 * @param datum the value
 * @return the NullableDatum holding @a datum
 */
#define NULLABLE_DATUM(datum)   ((NullableDatum) { .value = (datum), .isnull = false })


/**
 * Calls a version-1 function with one argument the way DirectFunctionCall1() does, but hands a NULL result back
 * instead of raising an error.
 *
 * @param func the function
 * @param arg1 the argument, which is not null
 * @return the result of the function, null if the function returned NULL
 */
static inline NullableDatum NullableFunctionCall1(PGFunction func, Datum arg1)
{
    LOCAL_FCINFO(fcinfo, 1);
    InitFunctionCallInfoData(*fcinfo, NULL, 1, InvalidOid, NULL, NULL);

    fcinfo->args[0].value = arg1;
    fcinfo->args[0].isnull = false;

    NullableDatum result;

    result.value = (*func) (fcinfo);
    result.isnull = fcinfo->isnull;

    return result;
}


/**
 * Calls a version-1 function with two arguments the way DirectFunctionCall2() does, but hands a NULL result back
 * instead of raising an error.
 *
 * @param func the function
 * @param arg1 the first argument, which is not null
 * @param arg2 the second argument, which is not null
 * @return the result of the function, null if the function returned NULL
 */
static inline NullableDatum NullableFunctionCall2(PGFunction func, Datum arg1, Datum arg2)
{
    LOCAL_FCINFO(fcinfo, 2);
    InitFunctionCallInfoData(*fcinfo, NULL, 2, InvalidOid, NULL, NULL);

    fcinfo->args[0].value = arg1;
    fcinfo->args[0].isnull = false;

    fcinfo->args[1].value = arg2;
    fcinfo->args[1].isnull = false;

    NullableDatum result;

    result.value = (*func) (fcinfo);
    result.isnull = fcinfo->isnull;

    return result;
}


/**
 * Calls a version-1 function with three arguments the way DirectFunctionCall3() does, but hands a NULL result back
 * instead of raising an error.
 *
 * @param func the function
 * @param arg1 the first argument, which is not null
 * @param arg2 the second argument, which is not null
 * @param arg3 the third argument, which is not null
 * @return the result of the function, null if the function returned NULL
 */
static inline NullableDatum NullableFunctionCall3(PGFunction func, Datum arg1, Datum arg2, Datum arg3)
{
    LOCAL_FCINFO(fcinfo, 3);
    InitFunctionCallInfoData(*fcinfo, NULL, 3, InvalidOid, NULL, NULL);

    fcinfo->args[0].value = arg1;
    fcinfo->args[0].isnull = false;

    fcinfo->args[1].value = arg2;
    fcinfo->args[1].isnull = false;

    fcinfo->args[2].value = arg3;
    fcinfo->args[2].isnull = false;

    NullableDatum result;

    result.value = (*func) (fcinfo);
    result.isnull = fcinfo->isnull;

    return result;
}


/**
 * Calls a support function of an aggregate with one argument in the aggregate context of the calling function, so
 * that the called function can use AggCheckCallContext() and the memory context of the aggregate.
 *
 * @param fcinfo the call information of the calling aggregate support function, whose context is passed on
 * @param func the function
 * @param arg1 the argument, which may be null
 * @return the result of the function, null if the function returned NULL
 */
static inline NullableDatum NullableAggFunctionCall1(FunctionCallInfo fcinfo, PGFunction func, NullableDatum arg1)
{
    LOCAL_FCINFO(subfcinfo, 1);
    InitFunctionCallInfoData(*subfcinfo, NULL, 1, InvalidOid, fcinfo->context, NULL);

    subfcinfo->args[0] = arg1;

    NullableDatum result;

    result.value = (*func) (subfcinfo);
    result.isnull = subfcinfo->isnull;

    return result;
}


/**
 * Calls a support function of an aggregate with two arguments in the aggregate context of the calling function, so
 * that the called function can use AggCheckCallContext() and the memory context of the aggregate.
 *
 * @param fcinfo the call information of the calling aggregate support function, whose context is passed on
 * @param func the function
 * @param arg1 the first argument, which may be null
 * @param arg2 the second argument, which may be null
 * @return the result of the function, null if the function returned NULL
 */
static inline NullableDatum NullableAggFunctionCall2(FunctionCallInfo fcinfo, PGFunction func, NullableDatum arg1, NullableDatum arg2)
{
    LOCAL_FCINFO(subfcinfo, 2);
    InitFunctionCallInfoData(*subfcinfo, NULL, 2, InvalidOid, fcinfo->context, NULL);

    subfcinfo->args[0] = arg1;
    subfcinfo->args[1] = arg2;

    NullableDatum result;

    result.value = (*func) (subfcinfo);
    result.isnull = subfcinfo->isnull;

    return result;
}

#endif /* CALL_H_ */
