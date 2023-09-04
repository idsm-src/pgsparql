#ifndef TYPES_IBLANKNODE_H_
#define TYPES_IBLANKNODE_H_

#include <postgres.h>
#include <fmgr.h>


Datum iblanknode_create(PG_FUNCTION_ARGS);
Datum iblanknode_get_value(PG_FUNCTION_ARGS);
Datum iblanknode_get_value_of_segment(PG_FUNCTION_ARGS);
Datum iblanknode_get_segment(PG_FUNCTION_ARGS);

#endif /* TYPES_IBLANKNODE_H_ */
