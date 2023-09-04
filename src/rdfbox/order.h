#ifndef RDFBOX_ORDER_H_
#define RDFBOX_ORDER_H_

#include <postgres.h>
#include <fmgr.h>


Datum rdfbox_order_compare(PG_FUNCTION_ARGS);

#endif /* RDFBOX_ORDER_H_ */
