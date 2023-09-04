#include <postgres.h>
#include <fmgr.h>


static inline uint32 htoi(char value)
{
    if(value >= '0' && value <= '9')
        return value - '0';
    else if(value >= 'a' && value <= 'f')
        return value - 'a' + 10;
    else
        elog(ERROR, "could not decode sblanknode");
}


static inline char itoh(uint32 value)
{
    if(value < 10)
        return value + '0';
    else
        return value + 'a' - 10;
}


static inline uint32 read_segment(char *buffer)
{
    uint32 value = 0;

    for(int i = 0; i < 8; i++)
    {
        value <<= 4;
        value |= htoi(buffer[i]);
    }

    return value;
}


void write_sblanknode_segment(char *buffer, uint32 value)
{
    for(int i = 7; i >= 0; i--)
    {
        buffer[i] = itoh(value % 16);
        value >>= 4;
    }
}


PG_FUNCTION_INFO_V1(sblanknode_create);
Datum sblanknode_create(PG_FUNCTION_ARGS)
{
    VarChar *label = PG_GETARG_VARCHAR_PP(0);
    int32 segment = PG_GETARG_INT32(1);

    VarChar *result = (VarChar *) palloc0(VARHDRSZ + VARSIZE_ANY_EXHDR(label) + 8);
    SET_VARSIZE(result, VARHDRSZ + VARSIZE_ANY_EXHDR(label) + 8);

    write_sblanknode_segment(VARDATA(result), segment);
    memcpy(VARDATA(result) + 8, VARDATA_ANY(label), VARSIZE_ANY_EXHDR(label));

    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(sblanknode_get_value);
Datum sblanknode_get_value(PG_FUNCTION_ARGS)
{
    VarChar *blanknode = PG_GETARG_VARCHAR_PP(0);

    if(VARSIZE_ANY_EXHDR(blanknode) < 8)
        elog(ERROR, "could not decode sblanknode");

    VarChar *result = (VarChar *) palloc0(VARHDRSZ + VARSIZE_ANY_EXHDR(blanknode) - 8);
    SET_VARSIZE(result, VARHDRSZ + VARSIZE_ANY_EXHDR(blanknode) - 8);
    memcpy(VARDATA(result), VARDATA_ANY(blanknode) + 8, VARSIZE_ANY_EXHDR(blanknode) - 8);

    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(sblanknode_get_value_of_segment);
Datum sblanknode_get_value_of_segment(PG_FUNCTION_ARGS)
{
    VarChar *blanknode = PG_GETARG_VARCHAR_PP(0);
    int32 segment = PG_GETARG_INT32(1);

    if(VARSIZE_ANY_EXHDR(blanknode) < 8)
        elog(ERROR, "could not decode sblanknode");

    if(read_segment(VARDATA_ANY(blanknode)) != segment)
        PG_RETURN_NULL();

    VarChar *result = (VarChar *) palloc0(VARHDRSZ + VARSIZE_ANY_EXHDR(blanknode) - 8);
    SET_VARSIZE(result, VARHDRSZ + VARSIZE_ANY_EXHDR(blanknode) - 8);
    memcpy(VARDATA(result), VARDATA_ANY(blanknode) + 8, VARSIZE_ANY_EXHDR(blanknode) - 8);

    PG_RETURN_VARCHAR_P(result);
}


PG_FUNCTION_INFO_V1(sblanknode_get_segment);
Datum sblanknode_get_segment(PG_FUNCTION_ARGS)
{
    VarChar *blanknode = PG_GETARG_VARCHAR_PP(0);

    if(VARSIZE_ANY_EXHDR(blanknode) < 8)
        elog(ERROR, "could not decode sblanknode");

    int32 segment = read_segment(VARDATA_ANY(blanknode));
    PG_RETURN_INT32(segment);
}
