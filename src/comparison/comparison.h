#ifndef COMPARISON_COMPARISON_H_
#define COMPARISON_COMPARISON_H_

#include <postgres.h>


Datum equal_rdfbox(PG_FUNCTION_ARGS);
Datum not_equal_rdfbox(PG_FUNCTION_ARGS);
Datum less_than_rdfbox(PG_FUNCTION_ARGS);
Datum greater_than_rdfbox(PG_FUNCTION_ARGS);
Datum not_less_than_rdfbox(PG_FUNCTION_ARGS);
Datum not_greater_than_rdfbox(PG_FUNCTION_ARGS);

#endif /* COMPARISON_COMPARISON_H_ */
