#ifndef DATE_DAYTIMEDURATION_H_
#define DATE_DAYTIMEDURATION_H_

#include <postgres.h>
#include <fmgr.h>


Datum daytimeduration_input(PG_FUNCTION_ARGS);
Datum daytimeduration_output(PG_FUNCTION_ARGS);

#endif /* DATE_DAYTIMEDURATION_H_ */
