#ifndef CREATE_H_
#define CREATE_H_

#include <utils/numeric.h>
#include "rdfbox.h"


RdfBox *rdfbox_from_boolean(bool value);
RdfBox *rdfbox_from_short(int16 value);
RdfBox *rdfbox_from_int(int32 value);
RdfBox *rdfbox_from_long(int64 value);
RdfBox *rdfbox_from_float(float4 value);
RdfBox *rdfbox_from_double(float8 value);
RdfBox *rdfbox_from_integer(Numeric value);
RdfBox *rdfbox_from_decimal(Numeric value);
RdfBox *rdfbox_from_string(VarChar *value);

#endif /* CREATE_H_ */
