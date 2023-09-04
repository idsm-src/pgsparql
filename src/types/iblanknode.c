#include <postgres.h>
#include <fmgr.h>


PG_FUNCTION_INFO_V1(iblanknode_create);
Datum iblanknode_create(PG_FUNCTION_ARGS)
{
    int32 label = PG_GETARG_INT32(0);
    int32 segment = PG_GETARG_INT32(1);
    int64 blanknode = ((uint64) segment) << 32 | ((uint64) label & 0xFFFFFFFF);
    PG_RETURN_INT64(blanknode);
}


PG_FUNCTION_INFO_V1(iblanknode_get_value);
Datum iblanknode_get_value(PG_FUNCTION_ARGS)
{
    int64 blanknode = PG_GETARG_INT64(0);
    int32 label = (int32) blanknode;
    PG_RETURN_INT32(label);
}


PG_FUNCTION_INFO_V1(iblanknode_get_value_of_segment);
Datum iblanknode_get_value_of_segment(PG_FUNCTION_ARGS)
{
    int64 blanknode = PG_GETARG_INT64(0);
    int32 segment = PG_GETARG_INT32(1);

    if((int32) (blanknode >> 32) != segment)
        PG_RETURN_NULL();

    int32 label = (int32) blanknode;
    PG_RETURN_INT32(label);
}


PG_FUNCTION_INFO_V1(iblanknode_get_segment);
Datum iblanknode_get_segment(PG_FUNCTION_ARGS)
{
    int64 blanknode = PG_GETARG_INT64(0);
    int32 segment = (int32) (blanknode >> 32);
    PG_RETURN_INT32(segment);
}
