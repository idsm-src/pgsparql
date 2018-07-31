#include <postgres.h>
#include <utils/memutils.h>
#include <utils/fmgrprotos.h>
#include "constants.h"


static Numeric zero = NULL;


Numeric get_zero()
{
    if(zero == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        zero = DatumGetNumeric(DirectFunctionCall1(int4_numeric, Int32GetDatum(0)));
        MemoryContextSwitchTo(old);
    }

    return zero;
}


static __attribute__((destructor)) void destroy_constants()
{
    if(zero != NULL)
        pfree(zero);
}
