#ifndef CALL_H_
#define CALL_H_

#include <postgres.h>
#include <fmgr.h>


#if PG_VERSION_NUM < 120000
typedef struct
{
    Datum value;
    bool isnull;
} NullableDatum;
#endif


static inline NullableDatum NullableFunctionCall1(PGFunction func, Datum arg1)
{
    #if PG_VERSION_NUM < 120000
    FunctionCallInfoData fcinfo;
    InitFunctionCallInfoData(fcinfo, NULL, 1, InvalidOid, NULL, NULL);

    fcinfo.arg[0] = arg1;
    fcinfo.argnull[0] = false;
    #elif PG_VERSION_NUM < 130000
    FunctionCallInfoBaseData fcinfo;
    InitFunctionCallInfoData(fcinfo, NULL, 1, InvalidOid, NULL, NULL);

    fcinfo.args[0].value = arg1;
    fcinfo.args[0].isnull = false;
    #else
    LOCAL_FCINFO(fcinfo, 1);
    InitFunctionCallInfoData(*fcinfo, NULL, 1, InvalidOid, NULL, NULL);

    fcinfo->args[0].value = arg1;
    fcinfo->args[0].isnull = false;
    #endif

    NullableDatum result;

    #if PG_VERSION_NUM < 130000
    result.value = (*func) (&fcinfo);
    result.isnull = fcinfo.isnull;
    #else
    result.value = (*func) (fcinfo);
    result.isnull = fcinfo->isnull;
    #endif

    return result;
}


static inline NullableDatum NullableFunctionCall2(PGFunction func, Datum arg1, Datum arg2)
{
    #if PG_VERSION_NUM < 120000
    FunctionCallInfoData fcinfo;
    InitFunctionCallInfoData(fcinfo, NULL, 2, InvalidOid, NULL, NULL);

    fcinfo.arg[0] = arg1;
    fcinfo.argnull[0] = false;

    fcinfo.arg[1] = arg2;
    fcinfo.argnull[1] = false;
    #elif PG_VERSION_NUM < 130000
    FunctionCallInfoBaseData fcinfo;
    InitFunctionCallInfoData(fcinfo, NULL, 2, InvalidOid, NULL, NULL);

    fcinfo.args[0].value = arg1;
    fcinfo.args[0].isnull = false;

    fcinfo.args[1].value = arg2;
    fcinfo.args[1].isnull = false;
    #else
    LOCAL_FCINFO(fcinfo, 2);
    InitFunctionCallInfoData(*fcinfo, NULL, 2, InvalidOid, NULL, NULL);

    fcinfo->args[0].value = arg1;
    fcinfo->args[0].isnull = false;

    fcinfo->args[1].value = arg2;
    fcinfo->args[1].isnull = false;
    #endif

    NullableDatum result;

    #if PG_VERSION_NUM < 130000
    result.value = (*func) (&fcinfo);
    result.isnull = fcinfo.isnull;
    #else
    result.value = (*func) (fcinfo);
    result.isnull = fcinfo->isnull;
    #endif

    return result;
}

#endif /* CALL_H_ */
