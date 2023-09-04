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


#if PG_VERSION_NUM < 130000
#define pg_ultostr_zeropad(str, value, width) pg_ltostr_zeropad(str, value, width)
#define pg_ultostr(str, value) pg_ltostr(str, value)
#endif

#endif /* PGSPARQL_H_ */
