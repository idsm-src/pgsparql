#ifndef COMPARE_H_
#define COMPARE_H_

#include <postgres.h>
#include <utils/varlena.h>
#include <catalog/pg_collation.h>


#define compare(a,b)    (((a)==(b)) ? 0 : (((a)<(b)) ? -1 : 1))


static inline bool varchar_eq(VarChar *arg1, VarChar *arg2)
{
    if(VARSIZE_ANY_EXHDR(arg1) != VARSIZE_ANY_EXHDR(arg2))
        return false;

    return memcmp(VARDATA_ANY(arg1), VARDATA_ANY(arg2), VARSIZE_ANY_EXHDR(arg1)) == 0;
}


static inline int varchar_cmp(VarChar *arg1, VarChar *arg2)
{
    int length1 = VARSIZE_ANY_EXHDR(arg1);
    int length2 = VARSIZE_ANY_EXHDR(arg2);

    int result = memcmp(VARDATA_ANY(arg1), VARDATA_ANY(arg2), Min(length1, length2));

    if(result != 0 || length1 == length2)
        return result;

    return length1 < length2 ? -1 : 1;
}

#endif /* COMPARE_H_ */
