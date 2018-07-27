#include <postgres.h>
#include "rdfbox.h"


PG_FUNCTION_INFO_V1(same_term_rdfbox);
Datum same_term_rdfbox(PG_FUNCTION_ARGS)
{
    RdfBox *left = PG_GETARG_RDFBOX_P(0);
    RdfBox *right = PG_GETARG_RDFBOX_P(1);

    Datum result = result = BoolGetDatum(memcmp(left, right, Min(VARSIZE(left), VARSIZE(right))) == 0);

    PG_FREE_IF_COPY(left, 0);
    PG_FREE_IF_COPY(right, 1);

    PG_RETURN_DATUM(result);
}
