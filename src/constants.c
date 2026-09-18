#include <postgres.h>
#include <utils/memutils.h>
#include <utils/builtins.h>
#include "constants.h"


/*
 * The constants live in TopMemoryContext for as long as the backend does and
 * are never freed as PostgreSQL never unloads a loadable module.
 */
static Numeric zero = NULL;
static Numeric half = NULL;
static Numeric unsignedlong_max = NULL;
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


Numeric get_half()
{
    if(half == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        half = DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum("0.5"), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
        MemoryContextSwitchTo(old);
    }

    return half;
}


Numeric get_unsignedlong_max()
{
    if(unsignedlong_max == NULL)
    {
        MemoryContext old = MemoryContextSwitchTo(TopMemoryContext);
        unsignedlong_max = DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum("18446744073709551615"), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
        MemoryContextSwitchTo(old);
    }

    return unsignedlong_max;
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
