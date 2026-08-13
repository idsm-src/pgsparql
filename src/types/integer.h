#ifndef TYPES_INTEGER_H_
#define TYPES_INTEGER_H_

#include <postgres.h>
#include <utils/numeric.h>
#include <utils/builtins.h>


Numeric integer_parse(char *data, int size);


static inline VarChar *integer_as_varchar(Numeric value)
{
    return (VarChar *) cstring_to_text(numeric_normalize(value));
}

#endif /* TYPES_INTEGER_H_ */
