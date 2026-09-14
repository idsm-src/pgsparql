#ifndef RDFBOX_ORDER_H_
#define RDFBOX_ORDER_H_

#include <postgres.h>
#include <fmgr.h>
#include "rdfbox/rdfbox.h"


int rdfbox_compare_terms(RdfBox *left, RdfBox *right);
bool rdfbox_same_terms(RdfBox *left, RdfBox *right);

Datum rdfbox_order_compare(PG_FUNCTION_ARGS);

#endif /* RDFBOX_ORDER_H_ */
