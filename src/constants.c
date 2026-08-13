#include <postgres.h>
#include <utils/memutils.h>
#include <utils/builtins.h>
#include "constants.h"


static Numeric zero = NULL;
static VarChar *empty = NULL;


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


VarChar *get_empty_varchar()
{
    if(empty == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        empty = (VarChar *) cstring_to_text("");
        MemoryContextSwitchTo(old);
    }

    return empty;
}


static __attribute__((destructor)) void destroy_constants()
{
    if(zero != NULL)
        pfree(zero);

    if(empty != NULL)
        pfree(empty);
}
