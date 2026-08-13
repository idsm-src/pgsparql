#include <postgres.h>
#include "types/parser.h"
#include "types/boolean.h"


bool boolean_parse(char *data, int size)
{
    bool result;
    int pos = 0;

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos < size && !memcmp(data + pos, "0", 1))
    {
        pos += 1;
        result = false;
    }
    else if(pos < size && !memcmp(data + pos, "1", 1))
    {
        pos += 1;
        result = true;
    }
    else if(pos + 4 < size && !memcmp(data + pos, "false", 5))
    {
        pos += 5;
        result = false;
    }
    else if(pos + 3 < size && !memcmp(data + pos, "true", 4))
    {
        pos += 4;
        result = true;
    }
    else
    {
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:boolean literal")));
    }

    while(pos < size && xsd_isspace(data[pos]))
        pos++;

    if(pos != size)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("malformed xsd:boolean literal")));

    return result;
}


int boolean_print(bool value, char *buffer)
{
    if(value)
    {
        memcpy(buffer, "true", 4);
        return 4;
    }
    else
    {
        memcpy(buffer, "false", 5);
        return 5;
    }
}
