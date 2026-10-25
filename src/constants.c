/**
 * @file
 * Constant values that are built on their first use and kept for the lifetime of the backend.
 */
#include <postgres.h>
#include <utils/memutils.h>
#include <utils/builtins.h>
#include "constants.h"


/*
 * The constants live in TopMemoryContext for as long as the backend does and
 * are never freed as PostgreSQL never unloads a loadable module.
 */
static Numeric zero = NULL;                 /**< the numeric 0, NULL before its first use */
static Numeric half = NULL;                 /**< the numeric 0.5, NULL before its first use */
static Numeric unsignedlong_max = NULL;     /**< the greatest xsd:unsignedLong, NULL before its first use */
static VarChar *empty = NULL;               /**< the empty varchar, NULL before its first use */


/**
 * Returns the numeric 0.
 *
 * @return the shared numeric 0, which must not be modified or freed
 */
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


/**
 * Returns the numeric 0.5.
 *
 * @return the shared numeric 0.5, which must not be modified or freed
 */
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


/**
 * Returns the greatest value of xsd:unsignedLong, 18446744073709551615.
 *
 * @return the shared numeric, which must not be modified or freed
 */
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


/**
 * Returns the empty varchar.
 *
 * @return the shared empty varchar, which must not be modified or freed
 */
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
