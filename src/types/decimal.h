#ifndef TYPES_DECIMAL_H_
#define TYPES_DECIMAL_H_

#include <postgres.h>
#include <string.h>
#include <utils/numeric.h>
#include <utils/builtins.h>


Numeric decimal_parse(char *data, int size);


static inline VarChar *decimal_as_varchar(Numeric value)
{
    char *result = numeric_normalize(value);

    if(strchr(result, '.'))
        return (VarChar *) cstring_to_text(result);
    else
        return (VarChar *) cstring_to_text(psprintf("%s.0", result));
}

#endif /* TYPES_DECIMAL_H_ */
