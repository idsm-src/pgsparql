#ifndef TYPES_INTEGER_H_
#define TYPES_INTEGER_H_

#include <postgres.h>
#include <utils/numeric.h>
#include <utils/builtins.h>


/*
 * The types derived from xsd:integer by a bound are represented by a numeric in SQL, so a constructor may be handed
 * a value that is not an integer or lies outside of the bound. It is the responsibility of the caller not to do so;
 * the checks are compiled in only with --enable-extra-checks.
 */
#ifdef PGSPARQL_EXTRA_CHECKS
Numeric checked_nonpositiveinteger(Numeric value);
Numeric checked_negativeinteger(Numeric value);
Numeric checked_nonnegativeinteger(Numeric value);
Numeric checked_positiveinteger(Numeric value);
#else
#define checked_nonpositiveinteger(x)    (x)
#define checked_negativeinteger(x)       (x)
#define checked_nonnegativeinteger(x)    (x)
#define checked_positiveinteger(x)       (x)
#endif


Numeric integer_parse(char *data, int size);
Numeric nonpositiveinteger_parse(char *data, int size);
Numeric negativeinteger_parse(char *data, int size);
Numeric nonnegativeinteger_parse(char *data, int size);
Numeric positiveinteger_parse(char *data, int size);

int integer_sign(Numeric value);


static inline VarChar *integer_as_varchar(Numeric value)
{
    return (VarChar *) cstring_to_text(numeric_normalize(value));
}

#endif /* TYPES_INTEGER_H_ */
