#ifndef CONSTANTS_H_
#define CONSTANTS_H_

#include <postgres.h>
#include <utils/numeric.h>


Numeric get_zero();
Numeric get_half();
Numeric get_unsignedlong_max();
VarChar *get_empty_varchar();

#endif /* CONSTANTS_H_ */
