#ifndef CALL_H_
#define CALL_H_

#include <postgres.h>
#include <fmgr.h>


#define PG_RETURN(result)       do { NullableDatum x = result; if(x.isnull) PG_RETURN_NULL(); else PG_RETURN_DATUM(x.value); } while(0)
#define NULL_DATUM              ((NullableDatum) { .value = (Datum) 0, .isnull = true })
#define NULLABLE_DATUM(datum)   ((NullableDatum) { .value = (datum), .isnull = false })


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
