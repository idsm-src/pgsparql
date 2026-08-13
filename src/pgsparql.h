#ifndef PGSPARQL_H_
#define PGSPARQL_H_

#include <postgres.h>
#include <utils/builtins.h>


#if PG_VERSION_NUM < 150000
#include <utils/int8.h>

static inline int64 pg_strtoint64(const char *s)
{
    int64 result;
    scanint8(s, false, &result);
    return result;
}
#endif


#if PG_VERSION_NUM < 180000
static inline bool
pg_neg_u16_overflow(uint16 a, int16 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
        return __builtin_sub_overflow(0, a, result);
#else
        int32           res = -((int32) a);

        if (unlikely(res < PG_INT16_MIN))
        {
                *result = 0x5EED;               /* to avoid spurious warnings */
                return true;
        }
        *result = res;
        return false;
#endif
}

static inline bool
pg_neg_u32_overflow(uint32 a, int32 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
        return __builtin_sub_overflow(0, a, result);
#else
        int64           res = -((int64) a);

        if (unlikely(res < PG_INT32_MIN))
        {
                *result = 0x5EED;               /* to avoid spurious warnings */
                return true;
        }
        *result = res;
        return false;
#endif
}

static inline bool
pg_neg_u64_overflow(uint64 a, int64 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
        return __builtin_sub_overflow(0, a, result);
#elif defined(HAVE_INT128)
        int128          res = -((int128) a);

        if (unlikely(res < PG_INT64_MIN))
        {
                *result = 0x5EED;               /* to avoid spurious warnings */
                return true;
        }
        *result = res;
        return false;
#else
        if (unlikely(a > (uint64) PG_INT64_MAX + 1))
        {
                *result = 0x5EED;               /* to avoid spurious warnings */
                return true;
        }
        if (unlikely(a == (uint64) PG_INT64_MAX + 1))
                *result = PG_INT64_MIN;
        else
                *result = -((int64) a);
        return false;
#endif
}
#endif

#endif /* PGSPARQL_H_ */
