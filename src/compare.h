/**
 * @file
 * Three-way comparison of scalars and byte-wise comparison of varchars.
 */
#ifndef COMPARE_H_
#define COMPARE_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <utils/varlena.h>
#include <catalog/pg_collation.h>


/**
 * Compares two scalar values.
 *
 * @param a the left value
 * @param b the right value
 * @return 0 if the values are equal, -1 if @a a is less and 1 if it is greater
 */
#define compare(a,b)    (((a)==(b)) ? 0 : (((a)<(b)) ? -1 : 1))


/**
 * Tests two varchars for byte-wise equality.
 *
 * @param arg1 the left varchar
 * @param arg2 the right varchar
 * @return true if both have the same bytes
 */
static inline bool varchar_eq(VarChar *arg1, VarChar *arg2)
{
    if(VARSIZE_ANY_EXHDR(arg1) != VARSIZE_ANY_EXHDR(arg2))
        return false;

    return memcmp(VARDATA_ANY(arg1), VARDATA_ANY(arg2), VARSIZE_ANY_EXHDR(arg1)) == 0;
}


/**
 * Compares two varchars byte-wise, so that the strings in UTF-8 are ordered by their code points.
 *
 * @param arg1 the left varchar
 * @param arg2 the right varchar
 * @return a negative number, zero or a positive number if @a arg1 is less than, equal to or greater than @a arg2
 */
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
