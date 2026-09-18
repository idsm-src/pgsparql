#include <postgres.h>
#include <common/hashfn.h>
#include <utils/float.h>
#include <utils/fmgrprotos.h>
#include <math.h>
#include "rdfbox/rdfbox.h"


static inline uint64 hash_varchar(VarChar *value, uint64 seed)
{
    return hash_bytes_extended((const unsigned char *) VARDATA_ANY(value), VARSIZE_ANY_EXHDR(value), seed);
}


static uint64 hash_term(RdfBox *box, uint64 seed)
{
    uint64 result = hash_bytes_uint32_extended(box->type, seed);
    uint64 value = 0;

    switch(box->type)
    {
        case XSD_BOOLEAN:
            value = hash_bytes_uint32_extended(RdfBoxGetBool(box), seed);
            break;

        case XSD_BYTE:
        case XSD_UNSIGNEDBYTE:
        case XSD_SHORT:
            value = hash_bytes_uint32_extended((uint32) (int32) RdfBoxGetInt16(box), seed);
            break;

        case XSD_UNSIGNEDSHORT:
        case XSD_INT:
            value = hash_bytes_uint32_extended((uint32) RdfBoxGetInt32(box), seed);
            break;

        case XSD_UNSIGNEDINT:
            value = hash_bytes_uint32_extended(RdfBoxGetUInt32(box), seed);
            break;

        case XSD_LONG:
        case XSD_DAYTIMEDURATION:
        case IBLANKNODE:
        {
            int64 integer = RdfBoxGetInt64(box);
            value = hash_bytes_extended((const unsigned char *) &integer, sizeof(integer), seed);
            break;
        }

        case XSD_UNSIGNEDLONG:
        {
            uint64 integer = RdfBoxGetUInt64(box);
            value = hash_bytes_extended((const unsigned char *) &integer, sizeof(integer), seed);
            break;
        }

        case XSD_INTEGER:
        case XSD_NONPOSITIVEINTEGER:
        case XSD_NEGATIVEINTEGER:
        case XSD_NONNEGATIVEINTEGER:
        case XSD_POSITIVEINTEGER:
        case XSD_DECIMAL:
        {
            Numeric numeric = RdfBoxGetNumeric(box);
            value = DatumGetUInt64(DirectFunctionCall2(hash_numeric_extended, NumericGetDatum(numeric), UInt64GetDatum(seed)));
            break;
        }

        case XSD_FLOAT:
        {
            float4 number = RdfBoxGetFloat4(box);

            if(isnan(number))
                number = get_float4_nan();

            value = hash_bytes_extended((const unsigned char *) &number, sizeof(number), seed);
            break;
        }

        case XSD_DOUBLE:
        {
            float8 number = RdfBoxGetFloat8(box);

            if(isnan(number))
                number = get_float8_nan();

            value = hash_bytes_extended((const unsigned char *) &number, sizeof(number), seed);
            break;
        }

        case XSD_DATETIME:
        {
            Datum datetime = ZonedDateTimeGetDatum(RdfBoxGetZonedDateTime(box));
            value = DatumGetUInt64(DirectFunctionCall2(zoneddatetime_hash_extended, datetime, UInt64GetDatum(seed)));
            break;
        }

        case XSD_DATE:
        {
            Datum date = ZonedDateGetDatum(RdfBoxGetZonedDate(box));
            value = DatumGetUInt64(DirectFunctionCall2(zoneddate_hash_extended, date, UInt64GetDatum(seed)));
            break;
        }

        case XSD_STRING:
        case IRI:
        case SBLANKNODE:
            value = hash_varchar(RdfBoxGetVarChar(box), seed);
            break;

        case RDF_LANGSTRING:
        case TYPED_LITERAL:
            value = hash_combine64(hash_varchar(RdfBoxGetVarChar(box), seed), hash_varchar(RdfBoxGetAttachment(box), seed));
            break;

        case USER_LITERAL:
            value = hash_combine64(ubox_hash_value(NULL, RdfBoxGetUBox(box), seed), hash_varchar(RdfBoxGetAttachment(box), seed));
            break;

        default:
            elog(ERROR, "unexpected rdfbox type");
    }

    result = hash_combine64(result, value);

    if(box->lexical)
        result = hash_combine64(result, hash_varchar(RdfBoxGetLexical(box), seed));

    return result;
}


PG_FUNCTION_INFO_V1(rdfbox_hash);
Datum rdfbox_hash(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);

    uint32 result = (uint32) hash_term(box, 0);

    PG_FREE_IF_COPY(box, 0);

    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(rdfbox_hash_extended);
Datum rdfbox_hash_extended(PG_FUNCTION_ARGS)
{
    RdfBox *box = PG_GETARG_RDFBOX_P(0);
    uint64 seed = PG_GETARG_INT64(1);

    uint64 result = hash_term(box, seed);

    PG_FREE_IF_COPY(box, 0);

    PG_RETURN_UINT64(result);
}
