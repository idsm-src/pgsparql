#ifndef TYPES_DAYTIMEDURATION_H_
#define TYPES_DAYTIMEDURATION_H_

#include <postgres.h>
#include <fmgr.h>


Datum daytimeduration_input(PG_FUNCTION_ARGS);
Datum daytimeduration_output(PG_FUNCTION_ARGS);

#endif /* TYPES_DAYTIMEDURATION_H_ */
