#ifndef TYPES_FLOAT_H_
#define TYPES_FLOAT_H_

#include <postgres.h>
#include <fmgr.h>


Datum float_input(PG_FUNCTION_ARGS);
Datum float_output(PG_FUNCTION_ARGS);

#endif /* TYPES_FLOAT_H_ */
