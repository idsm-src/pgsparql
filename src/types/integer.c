#include <postgres.h>
#include <utils/numeric.h>
#include "types/parser.h"
#include "types/integer.h"


Numeric integer_parse(char *data, int size)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    int begin = pos;

    if(pos < size && (data[pos] == '-' || data[pos] == '+'))
        pos++;

    if(pos == size || !xsd_isdigit(data[pos]))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:integer literal")));

    while(pos < size && xsd_isdigit(data[pos]))
        pos++;

    char *cstring = palloc(pos - begin + 1);
    memcpy(cstring, data + begin, pos - begin);
    cstring[pos - begin] = '\0';

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:integer literal")));

    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(cstring), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}
