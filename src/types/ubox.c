#include <postgres.h>
#include <fmgr.h>
#include <catalog/pg_type.h>
#include <common/hashfn.h>
#include <libpq/pqformat.h>
#include <parser/parse_coerce.h>
#include <utils/builtins.h>
#include <utils/datum.h>
#include <utils/lsyscache.h>
#include "pgsparql.h"
#include "types/ubox.h"


/*
 * Build a box holding "value" of type "typeoid".  Varlena values are
 * detoasted first (this also flattens expanded objects), so the box always
 * contains a plain inline copy with a 4-byte header.
 */
UBox *ubox_make(Oid typeoid, Datum value)
{
    // anonymous records carry a typmod that is only meaningful within the current backend; named composite types are fine
    if(typeoid == RECORDOID || typeoid == RECORDARRAYOID)
        ereport(ERROR, (errcode(ERRCODE_FEATURE_NOT_SUPPORTED), errmsg("cannot box a value of anonymous record type")));

    TypeCacheEntry *typentry = lookup_type_cache(typeoid, 0);

    if(typentry->typlen == -1)
        value = PointerGetDatum(PG_DETOAST_DATUM(value));

    Size size = datumGetSize(value, typentry->typbyval, typentry->typlen);
    UBox *box = (UBox *) palloc(UBOX_HDRSZ + size);

    SET_VARSIZE(box, UBOX_HDRSZ + size);
    box->typeoid = typeoid;

    if(typentry->typbyval)
        store_att_byval(box->value, value, typentry->typlen);
    else
        memcpy(box->value, DatumGetPointer(value), size);

    return box;
}


/*
 * Type cache entry for the boxed type, remembered in fn_extra across calls
 * (the same pattern array_eq()/array_cmp() use).  Type cache entries are
 * never freed, so the pointer stays valid; a column holding boxes of several
 * types just triggers a new lookup whenever the type changes.
 */
static TypeCacheEntry *ubox_cached_typentry(FmgrInfo *flinfo, Oid typeoid, int flags)
{
    TypeCacheEntry *typentry = (TypeCacheEntry *) flinfo->fn_extra;

    if(typentry == NULL || typentry->type_id != typeoid)
    {
        typentry = lookup_type_cache(typeoid, flags);
        flinfo->fn_extra = typentry;
    }

    return typentry;
}


/*
 * Equality of two boxes according to the boxed type's own "=" operator (the
 * equality member of its default B-tree or hash operator class).  Returns
 * false without setting *equal when the boxes hold values of different types
 * or the type has no equality operator.
 */
static bool ubox_value_eq(FmgrInfo *flinfo, UBox *a, UBox *b, bool *equal)
{
    if(a->typeoid != b->typeoid)
        return false;

    TypeCacheEntry *typentry = ubox_cached_typentry(flinfo, a->typeoid, TYPECACHE_EQ_OPR_FINFO);

    if(!OidIsValid(typentry->eq_opr_finfo.fn_oid))
        return false;

    // boxes carry no collation, so use the type's default one (like 'a' = 'b' does)
    *equal = DatumGetBool(FunctionCall2Coll(&typentry->eq_opr_finfo, typentry->typcollation, ubox_value(a, typentry), ubox_value(b, typentry)));
    return true;
}


/*
 * Three-way comparison of two boxes according to the boxed type's default
 * B-tree comparison function (the one behind its <, <=, =, >=, > operators).
 * Returns false without setting *cmp when the boxes hold values of different
 * types or the type has no B-tree operator class.
 */
static bool ubox_value_cmp(FmgrInfo *flinfo, UBox *a, UBox *b, int *cmp)
{
    if(a->typeoid != b->typeoid)
        return false;

    TypeCacheEntry *typentry = ubox_cached_typentry(flinfo, a->typeoid, TYPECACHE_CMP_PROC_FINFO);

    if(!OidIsValid(typentry->cmp_proc_finfo.fn_oid))
        return false;

    *cmp = DatumGetInt32(FunctionCall2Coll(&typentry->cmp_proc_finfo, typentry->typcollation, ubox_value(a, typentry), ubox_value(b, typentry)));
    return true;
}


/*
 * Text format:  value:typename
 *
 * The type name is always canonical: format_type_extended() with
 * FORMAT_TYPE_FORCE_QUALIFY prints it schema-qualified and quoted whenever
 * needed, independently of search_path (only the SQL-standard names such as
 * integer or character varying stay unqualified, as they cannot be
 * shadowed).  It is parsed by regtypein().  The value may contain anything,
 * while a type name cannot contain a colon outside of double quotes, so the
 * separator is the last colon that is not inside double quotes; everything
 * before it is handed verbatim to the input function of the boxed type.
 */
PG_FUNCTION_INFO_V1(ubox_input);
Datum ubox_input(PG_FUNCTION_ARGS)
{
    char *str = PG_GETARG_CSTRING(0);
    int sep = -1;
    bool in_quotes = false;

    for(int pos = strlen(str) - 1; pos >= 0 && sep < 0; pos--)
    {
        if(str[pos] == '"')
            in_quotes = !in_quotes;
        else if(str[pos] == ':' && !in_quotes)
            sep = pos;
    }

    if(sep < 0)
        ereport(ERROR, (errcode(ERRCODE_INVALID_TEXT_REPRESENTATION), errmsg("invalid input syntax for type %s: \"%s\"", "ubox", str), errhint("Expected format is \"value:typename\".")));

    char *typname = str + sep + 1;
    Oid typeoid = DatumGetObjectId(DirectFunctionCall1(regtypein, CStringGetDatum(typname)));

    Oid typinput;
    Oid typioparam;
    getTypeInputInfo(typeoid, &typinput, &typioparam);

    char *valstr = pnstrdup(str, sep);
    Datum value = OidInputFunctionCall(typinput, valstr, typioparam, -1);

    PG_RETURN_UBOX_P(ubox_make(typeoid, value));
}


PG_FUNCTION_INFO_V1(ubox_output);
Datum ubox_output(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);
    TypeCacheEntry *typentry = lookup_type_cache(box->typeoid, 0);

    Oid typoutput;
    bool typisvarlena;
    getTypeOutputInfo(box->typeoid, &typoutput, &typisvarlena);

    char *valstr = OidOutputFunctionCall(typoutput, ubox_value(box, typentry));
    char *typname = format_type_extended(box->typeoid, -1, FORMAT_TYPE_FORCE_QUALIFY);

    PG_RETURN_CSTRING(psprintf("%s:%s", valstr, typname));
}


/*
 * Binary format:  NUL-terminated canonical type name (as in the text format),
 * followed by the binary (send) representation of the boxed value.  The value
 * is the last field, so its receive function simply consumes the rest of the
 * message; the caller of ubox_recv verifies that the whole message was used up.
 */
PG_FUNCTION_INFO_V1(ubox_recv);
Datum ubox_recv(PG_FUNCTION_ARGS)
{
    StringInfo buf = (StringInfo) PG_GETARG_POINTER(0);
    const char *typname = pq_getmsgstring(buf);
    Oid typeoid = DatumGetObjectId(DirectFunctionCall1(regtypein, CStringGetDatum(typname)));

    Oid typreceive;
    Oid typioparam;
    getTypeBinaryInputInfo(typeoid, &typreceive, &typioparam);

    Datum value = OidReceiveFunctionCall(typreceive, buf, typioparam, -1);

    PG_RETURN_UBOX_P(ubox_make(typeoid, value));
}


PG_FUNCTION_INFO_V1(ubox_send);
Datum ubox_send(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);
    TypeCacheEntry *typentry = lookup_type_cache(box->typeoid, 0);

    Oid typsend;
    bool typisvarlena;
    getTypeBinaryOutputInfo(box->typeoid, &typsend, &typisvarlena);

    bytea *valbytes = OidSendFunctionCall(typsend, ubox_value(box, typentry));

    StringInfoData buf;
    pq_begintypsend(&buf);
    pq_sendstring(&buf, format_type_extended(box->typeoid, -1, FORMAT_TYPE_FORCE_QUALIFY));
    pq_sendbytes(&buf, VARDATA(valbytes), VARSIZE(valbytes) - VARHDRSZ);

    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}


PG_FUNCTION_INFO_V1(ubox_create);
Datum ubox_create(PG_FUNCTION_ARGS)
{
    Oid typeoid = get_fn_expr_argtype(fcinfo->flinfo, 0);

    if(!OidIsValid(typeoid))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("could not determine input data type")));

    PG_RETURN_UBOX_P(ubox_make(typeoid, PG_GETARG_DATUM(0)));
}


/*
 * The second argument only determines the result type and is normally passed
 * as NULL::type, therefore this function must NOT be declared STRICT.
 */
PG_FUNCTION_INFO_V1(ubox_get_value);
Datum ubox_get_value(PG_FUNCTION_ARGS)
{
    if(PG_ARGISNULL(0))
        PG_RETURN_NULL();

    UBox *box = PG_GETARG_UBOX_P(0);
    Oid rettype = get_fn_expr_rettype(fcinfo->flinfo);

    if(!OidIsValid(rettype))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("could not determine result data type")));

    if(box->typeoid != rettype)
        ereport(ERROR, (errcode(ERRCODE_DATATYPE_MISMATCH), errmsg("ubox contains a value of type %s, not %s", format_type_be(box->typeoid), format_type_be(rettype))));

    PG_RETURN_DATUM(ubox_value(box, lookup_type_cache(rettype, 0)));
}


/*
 * ubox_as_varchar() reproduces exactly what "value::varchar" does:
 * find_coercion_pathway() tells us how the parser would implement the cast
 * (binary-compatible relabel, a pg_cast function, or the I/O-conversion
 * fallback) and we do the same thing.  The resolved cast is cached in
 * fn_extra per boxed type.
 */
typedef struct
{
    Oid typeoid;                // boxed type this entry is valid for
    TypeCacheEntry *typentry;
    CoercionPathType pathtype;
    FmgrInfo castfunc;          // COERCION_PATH_FUNC
    int castnargs;
    FmgrInfo outfunc;           // COERCION_PATH_COERCEVIAIO
    FmgrInfo infunc;
    Oid typioparam;
}
UBoxCastCache;


PG_FUNCTION_INFO_V1(ubox_as_varchar);
Datum ubox_as_varchar(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);
    UBoxCastCache *cache = (UBoxCastCache *) fcinfo->flinfo->fn_extra;

    if(cache == NULL || cache->typeoid != box->typeoid)
    {
        MemoryContext mcxt = fcinfo->flinfo->fn_mcxt;

        if(cache == NULL)
        {
            cache = (UBoxCastCache *) MemoryContextAllocZero(mcxt, sizeof(UBoxCastCache));
            fcinfo->flinfo->fn_extra = cache;
        }

        // invalidate the entry until it is completely set up
        cache->typeoid = InvalidOid;
        cache->typentry = lookup_type_cache(box->typeoid, 0);

        Oid funcid;
        cache->pathtype = find_coercion_pathway(VARCHAROID, box->typeoid, COERCION_EXPLICIT, &funcid);

        switch(cache->pathtype)
        {
            case COERCION_PATH_RELABELTYPE:
                // binary compatible, e.g. text or a domain over varchar
                break;

            case COERCION_PATH_FUNC:
                // a function from pg_cast, e.g. rtrim1 for bpchar
                fmgr_info_cxt(funcid, &cache->castfunc, mcxt);
                cache->castnargs = get_func_nargs(funcid);
                break;

            case COERCION_PATH_COERCEVIAIO:
            {
                // output function of the source, input function of varchar
                Oid outfuncid;
                bool typisvarlena;
                getTypeOutputInfo(box->typeoid, &outfuncid, &typisvarlena);
                fmgr_info_cxt(outfuncid, &cache->outfunc, mcxt);

                Oid infuncid;
                getTypeInputInfo(VARCHAROID, &infuncid, &cache->typioparam);
                fmgr_info_cxt(infuncid, &cache->infunc, mcxt);
                break;
            }

            default:
                ereport(ERROR, (errcode(ERRCODE_CANNOT_COERCE), errmsg("cannot cast type %s to %s", format_type_be(box->typeoid), format_type_be(VARCHAROID))));
        }

        cache->typeoid = box->typeoid;
    }

    Datum value = ubox_value(box, cache->typentry);

    switch(cache->pathtype)
    {
        case COERCION_PATH_FUNC:
        {
            // cast functions take (value [, typmod [, is_explicit]])
            Oid collation = cache->typentry->typcollation;

            if(cache->castnargs == 1)
                PG_RETURN_DATUM(FunctionCall1Coll(&cache->castfunc, collation, value));

            if(cache->castnargs == 2)
                PG_RETURN_DATUM(FunctionCall2Coll(&cache->castfunc, collation, value, Int32GetDatum(-1)));

            PG_RETURN_DATUM(FunctionCall3Coll(&cache->castfunc, collation, value, Int32GetDatum(-1), BoolGetDatum(true)));
        }

        case COERCION_PATH_COERCEVIAIO:
        {
            char *str = OutputFunctionCall(&cache->outfunc, value);
            PG_RETURN_DATUM(InputFunctionCall(&cache->infunc, str, cache->typioparam, -1));
        }

        default: // COERCION_PATH_RELABELTYPE
            PG_RETURN_DATUM(value);
    }
}


/*
 * Value comparison (operators =, <>, <, >, <=, >=)
 *
 * SPARQL-like semantics: NULL when the boxes hold values of different types
 * or when the boxed type has no corresponding operator, otherwise the result
 * of that operator.  = and <> use the type's equality operator (from its
 * default B-tree or hash operator class), the inequalities its B-tree
 * comparison function.
 *
 * Because they yield NULL for non-null inputs they can be members of no
 * operator class: a B-tree requires exactly one of a < b, a = b, a > b to be
 * true.  = and <> do use the standard eqsel/neqsel estimators, which treat a
 * NULL operator result as "no match" (PostgreSQL 13+), so MCV-based
 * estimates come out right.  The inequalities have none: scalarltsel's
 * binary search over the histogram assumes the operator agrees with the
 * column's sort order, which < does not across types, and the resulting
 * estimates would be far off; the default 50 % is the safer guess.
 */
PG_FUNCTION_INFO_V1(ubox_is_equal_to);
Datum ubox_is_equal_to(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    bool equal = false;

    if(!ubox_value_eq(fcinfo->flinfo, a, b, &equal))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(equal);
}


PG_FUNCTION_INFO_V1(ubox_is_not_equal_to);
Datum ubox_is_not_equal_to(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    bool equal = false;

    if(!ubox_value_eq(fcinfo->flinfo, a, b, &equal))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(!equal);
}


PG_FUNCTION_INFO_V1(ubox_is_less_than);
Datum ubox_is_less_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    int cmp = 0;

    if(!ubox_value_cmp(fcinfo->flinfo, a, b, &cmp))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(cmp < 0);
}


PG_FUNCTION_INFO_V1(ubox_is_greater_than);
Datum ubox_is_greater_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    int cmp = 0;

    if(!ubox_value_cmp(fcinfo->flinfo, a, b, &cmp))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(cmp > 0);
}


PG_FUNCTION_INFO_V1(ubox_is_not_less_than);
Datum ubox_is_not_less_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    int cmp = 0;

    if(!ubox_value_cmp(fcinfo->flinfo, a, b, &cmp))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(cmp >= 0);
}


PG_FUNCTION_INFO_V1(ubox_is_not_greater_than);
Datum ubox_is_not_greater_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    int cmp = 0;

    if(!ubox_value_cmp(fcinfo->flinfo, a, b, &cmp))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(cmp <= 0);
}


/*
 * Total order (operators @<, @<=, @=, @>=, @>, @<>) and hashing
 *
 * These back the default B-tree and hash operator classes, so they are what
 * indexes, ORDER BY, GROUP BY, DISTINCT, UNION and merge/hash joins use (the
 * planner finds them in the operator class by strategy number, not by name).
 *
 * Boxes of different types are ordered by the type OID.  Boxes of the same
 * type are compared with the type's default B-tree comparison function -- the
 * one its own <, <=, =, >=, > operators are based on -- so that e.g. numeric
 * 1.0 = 1.00 or bpchar 'a' = 'a '.  If the type has no B-tree operator class,
 * the stored bytes are compared lexicographically instead.
 *
 * Hashing must agree with @=: the type's default hash function when the type
 * has one (it agrees with the type's equality, and identical bytes hash alike
 * anyway), a hash of the stored bytes when the type has neither an ordering
 * nor a hash function, and the type OID alone when the type is ordered by its
 * B-tree comparison but has no hash function (money, bit, tsvector, ...): all
 * values of such a type then share one hash bucket, which is slow but
 * correct, and it keeps hash joins and hash aggregates over ubox columns from
 * failing at run time.
 */

/*
 * The bytes that identify the boxed value: the payload without the varlena
 * header for varlena types, the stored bytes otherwise (fixed-length types;
 * cstring including its terminating NUL).
 */
static void ubox_raw_bytes(UBox *box, TypeCacheEntry *typentry, const unsigned char **ptr, int *len)
{
    if(typentry->typlen == -1)
    {
        *ptr = (const unsigned char *) VARDATA(box->value);
        *len = VARSIZE(box->value) - VARHDRSZ;
    }
    else
    {
        *ptr = (const unsigned char *) box->value;
        *len = (int) (VARSIZE(box) - UBOX_HDRSZ);
    }
}


static int ubox_order_cmp(FmgrInfo *flinfo, UBox *a, UBox *b)
{
    if(a->typeoid != b->typeoid)
        return a->typeoid < b->typeoid ? -1 : 1;

    int cmp = 0;

    if(ubox_value_cmp(flinfo, a, b, &cmp))
        return cmp;

    // no B-tree comparison for this type: compare the bytes
    TypeCacheEntry *typentry = ubox_cached_typentry(flinfo, a->typeoid, TYPECACHE_CMP_PROC_FINFO);

    const unsigned char *pa;
    const unsigned char *pb;
    int la;
    int lb;

    ubox_raw_bytes(a, typentry, &pa, &la);
    ubox_raw_bytes(b, typentry, &pb, &lb);

    int diff = memcmp(pa, pb, Min(la, lb));

    if(diff != 0)
        return diff < 0 ? -1 : 1;

    return la < lb ? -1 : la > lb ? 1 : 0;
}


PG_FUNCTION_INFO_V1(ubox_order_compare);
Datum ubox_order_compare(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_INT32(ubox_order_cmp(fcinfo->flinfo, a, b));
}


PG_FUNCTION_INFO_V1(ubox_order_is_equal_to);
Datum ubox_order_is_equal_to(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order_cmp(fcinfo->flinfo, a, b) == 0);
}


PG_FUNCTION_INFO_V1(ubox_order_is_not_equal_to);
Datum ubox_order_is_not_equal_to(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order_cmp(fcinfo->flinfo, a, b) != 0);
}


PG_FUNCTION_INFO_V1(ubox_order_is_less_than);
Datum ubox_order_is_less_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order_cmp(fcinfo->flinfo, a, b) < 0);
}


PG_FUNCTION_INFO_V1(ubox_order_is_greater_than);
Datum ubox_order_is_greater_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order_cmp(fcinfo->flinfo, a, b) > 0);
}


PG_FUNCTION_INFO_V1(ubox_order_is_not_less_than);
Datum ubox_order_is_not_less_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order_cmp(fcinfo->flinfo, a, b) >= 0);
}


PG_FUNCTION_INFO_V1(ubox_order_is_not_greater_than);
Datum ubox_order_is_not_greater_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order_cmp(fcinfo->flinfo, a, b) <= 0);
}


/*
 * The type OID is folded into the value's hash the way hash_array() folds in
 * successive elements; this keeps the low 32 bits of ubox_hash_extended(x, 0)
 * equal to ubox_hash(x), as the hash access method requires.  TYPECACHE_EQ_OPR
 * is requested so that the type cache verifies the hash function against the
 * type's equality operator.
 */
PG_FUNCTION_INFO_V1(ubox_hash);
Datum ubox_hash(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);
    TypeCacheEntry *typentry = ubox_cached_typentry(fcinfo->flinfo, box->typeoid, TYPECACHE_EQ_OPR | TYPECACHE_CMP_PROC | TYPECACHE_HASH_PROC_FINFO);
    uint32 valhash = 0;

    if(OidIsValid(typentry->hash_proc_finfo.fn_oid))
    {
        valhash = DatumGetUInt32(FunctionCall1Coll(&typentry->hash_proc_finfo, typentry->typcollation, ubox_value(box, typentry)));
    }
    else if(!OidIsValid(typentry->cmp_proc))
    {
        // neither ordering nor hashing: equality is bytewise, so hash the bytes
        const unsigned char *ptr;
        int len;

        ubox_raw_bytes(box, typentry, &ptr, &len);
        valhash = hash_bytes(ptr, len);
    }
    // else: ordered by its B-tree comparison but no hash function -- hash the type only

    uint32 result = hash_bytes_uint32(box->typeoid);
    result = (result << 5) - result + valhash;

    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(ubox_hash_extended);
Datum ubox_hash_extended(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);
    uint64 seed = PG_GETARG_INT64(1);
    TypeCacheEntry *typentry = ubox_cached_typentry(fcinfo->flinfo, box->typeoid, TYPECACHE_EQ_OPR | TYPECACHE_CMP_PROC | TYPECACHE_HASH_EXTENDED_PROC_FINFO);
    uint64 valhash = 0;

    if(OidIsValid(typentry->hash_extended_proc_finfo.fn_oid))
    {
        valhash = DatumGetUInt64(FunctionCall2Coll(&typentry->hash_extended_proc_finfo, typentry->typcollation, ubox_value(box, typentry), Int64GetDatum(seed)));
    }
    else if(!OidIsValid(typentry->cmp_proc))
    {
        const unsigned char *ptr;
        int len;

        ubox_raw_bytes(box, typentry, &ptr, &len);
        valhash = hash_bytes_extended(ptr, len, seed);
    }

    uint64 result = hash_bytes_uint32_extended(box->typeoid, seed);
    result = (result << 5) - result + valhash;

    PG_RETURN_UINT64(result);
}
