/**
 * @file
 * The string blank nodes, a varchar whose first eight characters are the segment written as lower-case hexadecimal
 * digits and whose rest is the value within it. Segments keep apart the blank nodes that come from different
 * sources, so equal values in different segments are different blank nodes.
 */
#ifndef TYPES_SBLANKNODE_H_
#define TYPES_SBLANKNODE_H_

#include <postgres.h>
#include <fmgr.h>


void write_sblanknode_segment(char *buffer, uint32 value);
bool is_sblanknode_value(const char *data, int32 size);

Datum sblanknode_create(PG_FUNCTION_ARGS);
Datum sblanknode_get_value(PG_FUNCTION_ARGS);
Datum sblanknode_get_value_of_segment(PG_FUNCTION_ARGS);
Datum sblanknode_get_segment(PG_FUNCTION_ARGS);

#endif /* TYPES_SBLANKNODE_H_ */
