#include <postgres.h>
#include <utils/numeric.h>
#include "call.h"
#include "try-catch.h"
#include "types/parser.h"
#include "types/decimal.h"


Numeric decimal_parse(char *data, int size)
{
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    int begin = pos;

    if(pos < size && (data[pos] == '-' || data[pos] == '+'))
        pos++;

    int num_pos = pos;

    while(pos < size && xsd_isdigit(data[pos]))
        pos++;

    if(pos < size && data[pos] == '.')
        pos++;

    while(pos < size && xsd_isdigit(data[pos]))
        pos++;

    if(pos - num_pos == (data[num_pos] == '.'))
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:decimal literal")));

    char *cstring = palloc(pos - begin + 1);
    memcpy(cstring, data + begin, pos - begin);
    cstring[pos - begin] = '\0';

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:decimal literal")));

    return DatumGetNumeric(DirectFunctionCall3(numeric_in, CStringGetDatum(cstring), ObjectIdGetDatum(InvalidOid), Int32GetDatum(-1)));
}


PG_FUNCTION_INFO_V1(numeric_div_checked);
Datum numeric_div_checked(PG_FUNCTION_ARGS)
{
    NullableDatum result = { .isnull = false };

    PG_TRY_EX();
    {
        result = NullableFunctionCall2(numeric_div, PG_GETARG_DATUM(0), PG_GETARG_DATUM(1));
    }
    PG_CATCH_EX();
    {
        if(sqlerrcode != ERRCODE_DIVISION_BY_ZERO)
            PG_RE_THROW_EX();

        result.isnull = true;
    }
    PG_END_TRY_EX();

    PG_RETURN(result);
}
