#ifndef CALL_H_
#define CALL_H_

#include <postgres.h>
#include <fmgr.h>


typedef struct
{
    Datum datum;
    bool isNull;
} NullableDatum;


static inline NullableDatum NullableFunctionCall1(PGFunction func, Datum arg1)
{
    FunctionCallInfoData fcinfo;
    InitFunctionCallInfoData(fcinfo, NULL, 1, InvalidOid, NULL, NULL);

    fcinfo.arg[0] = arg1;
    fcinfo.argnull[0] = false;

    NullableDatum result;
    result.datum = (*func) (&fcinfo);
    result.isNull = fcinfo.isnull;

    return result;
}

#endif /* CALL_H_ */
