#ifndef TYPES_DOUBLE_H_
#define TYPES_DOUBLE_H_

#include <postgres.h>
#include <fmgr.h>


Datum double_input(PG_FUNCTION_ARGS);
Datum double_output(PG_FUNCTION_ARGS);

#endif /* TYPES_DOUBLE_H__ */
