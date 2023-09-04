#ifndef TYPES_SBLANKNODE_H_
#define TYPES_SBLANKNODE_H_

#include <postgres.h>
#include <fmgr.h>

void write_sblanknode_segment(char *buffer, uint32 value);

Datum sblanknode_create(PG_FUNCTION_ARGS);
Datum sblanknode_get_value(PG_FUNCTION_ARGS);
Datum sblanknode_get_value_of_segment(PG_FUNCTION_ARGS);
Datum sblanknode_get_segment(PG_FUNCTION_ARGS);

#endif /* TYPES_SBLANKNODE_H_ */
