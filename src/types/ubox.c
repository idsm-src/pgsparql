/**
 * @file
 * The type ubox: building a box, its text and binary forms, the extraction and the cast of the boxed value, the
 * comparison of the boxed values by the operators of their type, and the total order and the hashing that the
 * operator classes of ubox are built on.
 */
#include <postgres.h>
#include <fmgr.h>
#include <catalog/pg_type.h>
#include <common/hashfn.h>
#include <libpq/pqformat.h>
#include <parser/parse_coerce.h>
#include <utils/builtins.h>
#include <utils/datum.h>
#include <utils/guc.h>
#include <utils/lsyscache.h>
#include "pgsparql.h"
#include "types/ubox.h"


/**
 * Build a box holding "value" of type "typeoid".  Varlena values are
 * detoasted first (this also flattens expanded objects), so the box always
 * contains a plain inline copy with a 4-byte header.
 *
 * @param typeoid the type of the value
 * @param value the value
 * @return the palloc'd box; a value of an anonymous record type raises an error
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


/**
 * Type cache entry for the boxed type, remembered in fn_extra across calls
 * (the same pattern array_eq()/array_cmp() use).  Type cache entries are
 * never freed, so the pointer stays valid; a column holding boxes of several
 * types just triggers a new lookup whenever the type changes.  A caller that
 * has no FunctionCallInfo of its own passes NULL and pays for a lookup on
 * every call.
 *
 * The flags are remembered together with the entry: lookup_type_cache() only
 * fills in the fields that were asked for, so an entry cached for one set of
 * flags says nothing about the fields another caller needs.  Every function
 * here happens to pass the same flags on every call, but nothing enforces it
 * and the failure would be a silently empty FmgrInfo rather than an error.
 */
typedef struct
{
    Oid typeoid;                /**< the type the entry was looked up for */
    int flags;                  /**< the fields of the entry that are filled in, as TYPECACHE_* flags */
    TypeCacheEntry *typentry;   /**< the type cache entry, NULL before the first lookup */
}
UBoxTypeCache;


/**
 * Returns the type cache entry of a type with the given fields filled in, remembered in a ::UBoxTypeCache in the
 * fn_extra of a function.
 *
 * @param flinfo the FmgrInfo of the calling function, whose fn_extra holds nothing else, or NULL to look the entry up
 *               on every call
 * @param typeoid the type
 * @param flags the TYPECACHE_* flags of the fields that have to be filled in
 * @return the type cache entry, which is never freed
 */
static TypeCacheEntry *ubox_cached_typentry(FmgrInfo *flinfo, Oid typeoid, int flags)
{
    if(flinfo == NULL)
        return lookup_type_cache(typeoid, flags);

    UBoxTypeCache *cache = (UBoxTypeCache *) flinfo->fn_extra;

    if(cache == NULL)
    {
        cache = (UBoxTypeCache *) MemoryContextAllocZero(flinfo->fn_mcxt, sizeof(UBoxTypeCache));
        flinfo->fn_extra = cache;
    }

    if(cache->typentry == NULL || cache->typeoid != typeoid)
    {
        cache->typentry = lookup_type_cache(typeoid, flags);
        cache->typeoid = typeoid;
        cache->flags = flags;
    }
    else if((cache->flags & flags) != flags)
    {
        cache->typentry = lookup_type_cache(typeoid, flags);
        cache->flags |= flags;
    }

    return cache->typentry;
}


/**
 * Equality of two boxes according to the boxed type's own "=" operator (the
 * equality member of its default B-tree or hash operator class).  Returns
 * false without setting *equal when the boxes hold values of different types
 * or the type has no equality operator.
 *
 * As the boxes carry no collation, the default collation of the type is used.
 *
 * @param flinfo the FmgrInfo whose fn_extra caches the type cache entry, or NULL
 * @param a the left box
 * @param b the right box
 * @param equal receives the result of the equality operator
 * @return true if the operator was applied, false if the boxes cannot be compared
 */
bool ubox_equals(FmgrInfo *flinfo, UBox *a, UBox *b, bool *equal)
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


/**
 * Three-way comparison of two boxes according to the boxed type's default
 * B-tree comparison function (the one behind its `<`, `<=`, `=`, `>=`, `>` operators).
 * Returns false without setting *cmp when the boxes hold values of different
 * types or the type has no B-tree operator class.
 *
 * @param flinfo the FmgrInfo whose fn_extra caches the type cache entry, or NULL
 * @param a the left box
 * @param b the right box
 * @param cmp receives a negative number, zero or a positive number if @a a is less than, equal to or greater than @a b
 * @return true if the values were compared, false if the boxes cannot be compared
 */
bool ubox_compare(FmgrInfo *flinfo, UBox *a, UBox *b, int *cmp)
{
    if(a->typeoid != b->typeoid)
        return false;

    TypeCacheEntry *typentry = ubox_cached_typentry(flinfo, a->typeoid, TYPECACHE_CMP_PROC_FINFO);

    if(!OidIsValid(typentry->cmp_proc_finfo.fn_oid))
        return false;

    *cmp = DatumGetInt32(FunctionCall2Coll(&typentry->cmp_proc_finfo, typentry->typcollation, ubox_value(a, typentry), ubox_value(b, typentry)));
    return true;
}


/**
 * Resolve a type name the way regtypein() does, but with the search path
 * pinned to pg_catalog, so that the result does not depend on the session:
 * what ubox_type_as_cstring() prints is either an SQL-standard name, which
 * the grammar resolves on its own, or a schema-qualified one, and both mean
 * the same type everywhere.  An unqualified name of a type outside of
 * pg_catalog therefore does not resolve at all.  GUC_ACTION_SAVE remembers
 * the previous value and AtEOXact_GUC() puts it back, as it also does when
 * the transaction aborts.
 *
 * @param typname the type name, as ubox_type_as_cstring() prints it
 * @return the OID of the type; a name that does not resolve raises an error
 */
static Oid ubox_type_from_cstring(const char *typname)
{
    int nestlevel = NewGUCNestLevel();

    (void) set_config_option("search_path", "pg_catalog", PGC_USERSET, PGC_S_SESSION, GUC_ACTION_SAVE, true, 0, false);

    Oid typeoid = DatumGetObjectId(DirectFunctionCall1(regtypein, CStringGetDatum(typname)));

    AtEOXact_GUC(false, nestlevel);

    return typeoid;
}


/**
 * Parses the text form of a box, `value:typename`.
 *
 * The type name is always canonical: format_type_extended() with
 * FORMAT_TYPE_FORCE_QUALIFY prints it schema-qualified and quoted whenever
 * needed, independently of search_path (only the SQL-standard names such as
 * integer or character varying stay unqualified, as they cannot be
 * shadowed).  The value may contain anything, while a type name cannot
 * contain a colon outside of double quotes, so the separator is the last
 * colon that is not inside double quotes; everything before it is handed
 * verbatim to the input function of the boxed type.
 *
 * @param str the text form, terminated by a zero byte
 * @param value if not NULL, receives the palloc'd value part of the text, so that the caller can tell a canonical
 *              lexical form from one that has to be stored
 * @return the palloc'd box; a text without the separator, an unknown type or a value that the input function of the
 *         type rejects raises an error
 */
UBox *ubox_parse(const char *str, char **value)
{
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

    const char *typname = str + sep + 1;
    Oid typeoid = ubox_type_from_cstring(typname);

    Oid typinput;
    Oid typioparam;
    getTypeInputInfo(typeoid, &typinput, &typioparam);

    char *valstr = pnstrdup(str, sep);
    Datum datum = OidInputFunctionCall(typinput, valstr, typioparam, -1);

    if(value != NULL)
        *value = valstr;

    return ubox_make(typeoid, datum);
}


/**
 * Prints the boxed value by the output function of its type, the value part of the text form.
 *
 * @param box the box
 * @return the palloc'd string
 */
char *ubox_value_as_cstring(UBox *box)
{
    TypeCacheEntry *typentry = lookup_type_cache(box->typeoid, 0);

    Oid typoutput;
    bool typisvarlena;
    getTypeOutputInfo(box->typeoid, &typoutput, &typisvarlena);

    return OidOutputFunctionCall(typoutput, ubox_value(box, typentry));
}


/**
 * Prints the canonical name of the boxed type, the type part of the text form: schema-qualified and quoted where
 * needed, independently of the search path, unless it is an SQL-standard name.
 *
 * @param box the box
 * @return the palloc'd string
 */
char *ubox_type_as_cstring(UBox *box)
{
    return format_type_extended(box->typeoid, -1, FORMAT_TYPE_FORCE_QUALIFY);
}


/**
 * Reads the binary form of a box from a message.
 *
 * Binary format:  NUL-terminated canonical type name (as in the text format),
 * followed by the binary (send) representation of the boxed value.  The value
 * is the last field, so its receive function simply consumes the rest of the
 * message; the caller of ubox_recv verifies that the whole message was used up.
 *
 * @param buf the message, read up to its end
 * @return the palloc'd box; an unknown type or a value that the receive function of the type rejects raises an error
 */
UBox *ubox_receive(StringInfo buf)
{
    const char *typname = pq_getmsgstring(buf);
    Oid typeoid = ubox_type_from_cstring(typname);

    Oid typreceive;
    Oid typioparam;
    getTypeBinaryInputInfo(typeoid, &typreceive, &typioparam);

    Datum value = OidReceiveFunctionCall(typreceive, buf, typioparam, -1);

    return ubox_make(typeoid, value);
}


/**
 * Appends the binary form of a box, as ubox_receive() reads it, to a message.
 *
 * @param buf the message
 * @param box the box
 */
void ubox_append_binary(StringInfo buf, UBox *box)
{
    TypeCacheEntry *typentry = lookup_type_cache(box->typeoid, 0);

    Oid typsend;
    bool typisvarlena;
    getTypeBinaryOutputInfo(box->typeoid, &typsend, &typisvarlena);

    bytea *valbytes = OidSendFunctionCall(typsend, ubox_value(box, typentry));

    pq_sendstring(buf, ubox_type_as_cstring(box));
    pq_sendbytes(buf, VARDATA(valbytes), VARSIZE(valbytes) - VARHDRSZ);
}


/**
 * Returns the boxed value, checking that it is of the expected type.
 *
 * @param box the box
 * @param typeoid the expected type
 * @return the boxed value, which points into the box for a by-reference type; an invalid @a typeoid or a box of
 *         another type raises an error
 */
Datum ubox_value_of_type(UBox *box, Oid typeoid)
{
    if(!OidIsValid(typeoid))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("could not determine result data type")));

    if(box->typeoid != typeoid)
        ereport(ERROR, (errcode(ERRCODE_DATATYPE_MISMATCH), errmsg("ubox contains a value of type %s, not %s", format_type_be(box->typeoid), format_type_be(typeoid))));

    return ubox_value(box, lookup_type_cache(typeoid, 0));
}


/**
 * The cast from a boxed type to varchar as ubox_value_as_varchar() resolves it.
 *
 * ubox_as_varchar() reproduces exactly what `value::varchar` does:
 * find_coercion_pathway() tells us how the parser would implement the cast
 * (binary-compatible relabel, a pg_cast function, or the I/O-conversion
 * fallback) and we do the same thing.  The resolved cast is cached in
 * fn_extra per boxed type.
 */
typedef struct
{
    Oid typeoid;                /**< boxed type this entry is valid for, InvalidOid while it is set up */
    TypeCacheEntry *typentry;   /**< the type cache entry of the boxed type */
    CoercionPathType pathtype;  /**< how the cast is done */
    FmgrInfo castfunc;          /**< the cast function from pg_cast, for COERCION_PATH_FUNC */
    int castnargs;              /**< the number of arguments of the cast function */
    FmgrInfo outfunc;           /**< the output function of the boxed type, for COERCION_PATH_COERCEVIAIO */
    FmgrInfo infunc;            /**< the input function of varchar, for COERCION_PATH_COERCEVIAIO */
    Oid typioparam;             /**< the I/O parameter of the input function of varchar */
}
UBoxCastCache;


/**
 * Casts the boxed value to varchar exactly as `value::varchar` does, see ::UBoxCastCache.
 *
 * @param flinfo the FmgrInfo of the calling function, whose fn_extra caches the resolved cast and holds nothing else,
 *               or NULL to resolve the cast on every call
 * @param box the box
 * @return the varchar, which points into the box for a type binary-compatible with varchar; a type that cannot be
 *         cast to varchar raises an error
 */
VarChar *ubox_value_as_varchar(FmgrInfo *flinfo, UBox *box)
{
    UBoxCastCache entry;
    UBoxCastCache *cache = flinfo != NULL ? (UBoxCastCache *) flinfo->fn_extra : NULL;

    if(cache == NULL || cache->typeoid != box->typeoid)
    {
        MemoryContext mcxt = flinfo != NULL ? flinfo->fn_mcxt : CurrentMemoryContext;

        if(cache == NULL && flinfo != NULL)
        {
            cache = (UBoxCastCache *) MemoryContextAllocZero(mcxt, sizeof(UBoxCastCache));
            flinfo->fn_extra = cache;
        }
        else if(cache == NULL)
        {
            // no place to remember the resolved cast, so it is resolved again on every call
            cache = memset(&entry, 0, sizeof(UBoxCastCache));
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
                return (VarChar *) DatumGetPointer(FunctionCall1Coll(&cache->castfunc, collation, value));

            if(cache->castnargs == 2)
                return (VarChar *) DatumGetPointer(FunctionCall2Coll(&cache->castfunc, collation, value, Int32GetDatum(-1)));

            return (VarChar *) DatumGetPointer(FunctionCall3Coll(&cache->castfunc, collation, value, Int32GetDatum(-1), BoolGetDatum(true)));
        }

        case COERCION_PATH_COERCEVIAIO:
        {
            char *str = OutputFunctionCall(&cache->outfunc, value);
            return (VarChar *) DatumGetPointer(InputFunctionCall(&cache->infunc, str, cache->typioparam, -1));
        }

        default: // COERCION_PATH_RELABELTYPE
            return (VarChar *) DatumGetPointer(value);
    }
}


/**
 * The bytes that identify the boxed value: the payload without the varlena
 * header for varlena types, the stored bytes otherwise (fixed-length types;
 * cstring including its terminating NUL).
 *
 * @param box the box
 * @param typentry the type cache entry of the boxed type
 * @param ptr receives the beginning of the bytes, which point into the box
 * @param len receives the number of the bytes
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


/**
 * Compares two boxes in the total order that the operator classes of ubox are built on.
 *
 * Boxes of different types are ordered by the type OID, boxes of the same type by the default B-tree comparison
 * function of the type, or by their stored bytes if the type has none.
 *
 * @param flinfo the FmgrInfo whose fn_extra caches the type cache entry, or NULL
 * @param a the left box
 * @param b the right box
 * @return a negative number, zero or a positive number if @a a is less than, equal to or greater than @a b
 */
int ubox_order(FmgrInfo *flinfo, UBox *a, UBox *b)
{
    if(a->typeoid != b->typeoid)
        return a->typeoid < b->typeoid ? -1 : 1;

    int cmp = 0;

    if(ubox_compare(flinfo, a, b, &cmp))
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


/**
 * Hashes a box consistently with ubox_order(): boxes that the order takes as equal have the same hash.
 *
 * The type OID is folded into the value's hash the way hash_array() folds in
 * successive elements.  This is the only place the hash is computed, and
 * ubox_hash() just truncates it at seed 0, so the low 32 bits of
 * ubox_hash_extended(x, 0) are equal to ubox_hash(x) by construction, as the
 * hash access method requires.  TYPECACHE_EQ_OPR is requested so that the type
 * cache verifies the hash function against the type's equality operator.
 *
 * Support function 2 of a hash operator class is optional, so a type may have a
 * plain hash function and no extended one; falling straight through to the
 * type-only hash in that case would make the two entry points disagree.  The
 * plain function ignores the seed, which costs seed diversity for such a type
 * but keeps the two consistent.
 *
 * @param flinfo the FmgrInfo whose fn_extra caches the type cache entry, or NULL
 * @param box the box
 * @param seed the seed, 0 for the plain 32-bit hash
 * @return the 64-bit hash
 */
uint64 ubox_hash_value(FmgrInfo *flinfo, UBox *box, uint64 seed)
{
    TypeCacheEntry *typentry = ubox_cached_typentry(flinfo, box->typeoid,
            TYPECACHE_EQ_OPR | TYPECACHE_CMP_PROC | TYPECACHE_HASH_PROC_FINFO | TYPECACHE_HASH_EXTENDED_PROC_FINFO);
    uint64 valhash = 0;

    if(OidIsValid(typentry->hash_extended_proc_finfo.fn_oid))
    {
        valhash = DatumGetUInt64(FunctionCall2Coll(&typentry->hash_extended_proc_finfo, typentry->typcollation, ubox_value(box, typentry), Int64GetDatum(seed)));
    }
    else if(OidIsValid(typentry->hash_proc_finfo.fn_oid))
    {
        valhash = DatumGetUInt32(FunctionCall1Coll(&typentry->hash_proc_finfo, typentry->typcollation, ubox_value(box, typentry)));
    }
    else if(!OidIsValid(typentry->cmp_proc))
    {
        // neither ordering nor hashing: equality is bytewise, so hash the bytes
        const unsigned char *ptr;
        int len;

        ubox_raw_bytes(box, typentry, &ptr, &len);
        valhash = hash_bytes_extended(ptr, len, seed);
    }
    // else: ordered by its B-tree comparison but no hash function -- hash the type only

    uint64 result = hash_bytes_uint32_extended(box->typeoid, seed);

    return (result << 5) - result + valhash;
}


/**
 * The input function of the type ubox, which reads the text form `value:typename` (see ubox_parse()).
 *
 * @param fcinfo the cstring
 * @return the ubox; a malformed text raises an error
 */
PG_FUNCTION_INFO_V1(ubox_input);
Datum ubox_input(PG_FUNCTION_ARGS)
{
    char *str = PG_GETARG_CSTRING(0);

    PG_RETURN_UBOX_P(ubox_parse(str, NULL));
}


/**
 * The output function of the type ubox, which prints the text form `value:typename` with the canonical type name.
 *
 * @param fcinfo the ubox
 * @return the cstring
 */
PG_FUNCTION_INFO_V1(ubox_output);
Datum ubox_output(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);

    PG_RETURN_CSTRING(psprintf("%s:%s", ubox_value_as_cstring(box), ubox_type_as_cstring(box)));
}


/**
 * The receive function of the type ubox, which reads the binary form (see ubox_receive()).
 *
 * @param fcinfo the internal StringInfo holding the message
 * @return the ubox; an unknown type or an invalid value raises an error
 */
PG_FUNCTION_INFO_V1(ubox_recv);
Datum ubox_recv(PG_FUNCTION_ARGS)
{
    StringInfo buf = (StringInfo) PG_GETARG_POINTER(0);

    PG_RETURN_UBOX_P(ubox_receive(buf));
}


/**
 * The send function of the type ubox, which writes the binary form (see ubox_append_binary()).
 *
 * @param fcinfo the ubox
 * @return the bytea
 */
PG_FUNCTION_INFO_V1(ubox_send);
Datum ubox_send(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);

    StringInfoData buf;
    pq_begintypsend(&buf);
    ubox_append_binary(&buf, box);

    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}


/**
 * Boxes a value of any type, `ubox_create(anyelement)`.
 *
 * @param fcinfo the value, whose type is taken from the call expression
 * @return the ubox; a value of an undeterminable or an anonymous record type raises an error
 */
PG_FUNCTION_INFO_V1(ubox_create);
Datum ubox_create(PG_FUNCTION_ARGS)
{
    Oid typeoid = get_fn_expr_argtype(fcinfo->flinfo, 0);

    if(!OidIsValid(typeoid))
        ereport(ERROR, (errcode(ERRCODE_INVALID_PARAMETER_VALUE), errmsg("could not determine input data type")));

    PG_RETURN_UBOX_P(ubox_make(typeoid, PG_GETARG_DATUM(0)));
}


/**
 * Takes the value out of a box, `ubox_get_value(ubox, anyelement) RETURNS anyelement`.
 *
 * The second argument only determines the result type and is normally passed
 * as `NULL::type`, therefore this function must NOT be declared STRICT.
 *
 * @param fcinfo the ubox, which may be NULL, and a value of the expected type, normally NULL
 * @return the boxed value, NULL if the ubox is NULL; a box holding a value of another type raises an error
 */
PG_FUNCTION_INFO_V1(ubox_get_value);
Datum ubox_get_value(PG_FUNCTION_ARGS)
{
    if(PG_ARGISNULL(0))
        PG_RETURN_NULL();

    UBox *box = PG_GETARG_UBOX_P(0);

    PG_RETURN_DATUM(ubox_value_of_type(box, get_fn_expr_rettype(fcinfo->flinfo)));
}


/**
 * Casts the boxed value to varchar exactly as `value::varchar` does (see ubox_value_as_varchar()).
 *
 * @param fcinfo the ubox
 * @return the varchar; a type that cannot be cast to varchar raises an error
 */
PG_FUNCTION_INFO_V1(ubox_as_varchar);
Datum ubox_as_varchar(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);

    PG_RETURN_VARCHAR_P(ubox_value_as_varchar(fcinfo->flinfo, box));
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

/**
 * The operator `=` on ubox: the equality operator of the boxed type.
 *
 * @param fcinfo the two ubox values
 * @return the bool result of the operator, NULL if the boxes hold values of different types or the type has no
 *         equality operator
 */
PG_FUNCTION_INFO_V1(ubox_is_equal_to);
Datum ubox_is_equal_to(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    bool equal = false;

    if(!ubox_equals(fcinfo->flinfo, a, b, &equal))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(equal);
}


/**
 * The operator `<>` on ubox: the negated equality operator of the boxed type.
 *
 * @param fcinfo the two ubox values
 * @return the bool result, NULL if the boxes hold values of different types or the type has no equality operator
 */
PG_FUNCTION_INFO_V1(ubox_is_not_equal_to);
Datum ubox_is_not_equal_to(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    bool equal = false;

    if(!ubox_equals(fcinfo->flinfo, a, b, &equal))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(!equal);
}


/**
 * The operator `<` on ubox: the comparison by the default B-tree comparison function of the boxed type.
 *
 * @param fcinfo the two ubox values
 * @return the bool result, NULL if the boxes hold values of different types or the type has no B-tree operator class
 */
PG_FUNCTION_INFO_V1(ubox_is_less_than);
Datum ubox_is_less_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    int cmp = 0;

    if(!ubox_compare(fcinfo->flinfo, a, b, &cmp))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(cmp < 0);
}


/**
 * The operator `>` on ubox: the comparison by the default B-tree comparison function of the boxed type.
 *
 * @param fcinfo the two ubox values
 * @return the bool result, NULL if the boxes hold values of different types or the type has no B-tree operator class
 */
PG_FUNCTION_INFO_V1(ubox_is_greater_than);
Datum ubox_is_greater_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    int cmp = 0;

    if(!ubox_compare(fcinfo->flinfo, a, b, &cmp))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(cmp > 0);
}


/**
 * The operator `>=` on ubox: the comparison by the default B-tree comparison function of the boxed type.
 *
 * @param fcinfo the two ubox values
 * @return the bool result, NULL if the boxes hold values of different types or the type has no B-tree operator class
 */
PG_FUNCTION_INFO_V1(ubox_is_not_less_than);
Datum ubox_is_not_less_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    int cmp = 0;

    if(!ubox_compare(fcinfo->flinfo, a, b, &cmp))
        PG_RETURN_NULL();

    PG_RETURN_BOOL(cmp >= 0);
}


/**
 * The operator `<=` on ubox: the comparison by the default B-tree comparison function of the boxed type.
 *
 * @param fcinfo the two ubox values
 * @return the bool result, NULL if the boxes hold values of different types or the type has no B-tree operator class
 */
PG_FUNCTION_INFO_V1(ubox_is_not_greater_than);
Datum ubox_is_not_greater_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);
    int cmp = 0;

    if(!ubox_compare(fcinfo->flinfo, a, b, &cmp))
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

/**
 * Compares two boxes in the total order (see ubox_order()), the support function 1 of the default B-tree operator
 * class of ubox.
 *
 * @param fcinfo the two ubox values
 * @return a negative int4, zero or a positive int4 if the first box is less than, equal to or greater than the second
 *         one
 */
PG_FUNCTION_INFO_V1(ubox_order_compare);
Datum ubox_order_compare(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_INT32(ubox_order(fcinfo->flinfo, a, b));
}


/**
 * The operator `@=` on ubox: whether the first box is equal to the second one in the total order, the equality of
 * the default B-tree and hash operator classes.
 *
 * @param fcinfo the two ubox values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(ubox_order_is_equal_to);
Datum ubox_order_is_equal_to(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order(fcinfo->flinfo, a, b) == 0);
}


/**
 * The operator `@<>` on ubox: whether the first box is not equal to the second one in the total order.
 *
 * @param fcinfo the two ubox values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(ubox_order_is_not_equal_to);
Datum ubox_order_is_not_equal_to(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order(fcinfo->flinfo, a, b) != 0);
}


/**
 * The operator `@<` on ubox: whether the first box is less than the second one in the total order.
 *
 * @param fcinfo the two ubox values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(ubox_order_is_less_than);
Datum ubox_order_is_less_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order(fcinfo->flinfo, a, b) < 0);
}


/**
 * The operator `@>` on ubox: whether the first box is greater than the second one in the total order.
 *
 * @param fcinfo the two ubox values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(ubox_order_is_greater_than);
Datum ubox_order_is_greater_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order(fcinfo->flinfo, a, b) > 0);
}


/**
 * The operator `@>=` on ubox: whether the first box is not less than the second one in the total order.
 *
 * @param fcinfo the two ubox values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(ubox_order_is_not_less_than);
Datum ubox_order_is_not_less_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order(fcinfo->flinfo, a, b) >= 0);
}


/**
 * The operator `@<=` on ubox: whether the first box is not greater than the second one in the total order.
 *
 * @param fcinfo the two ubox values
 * @return the bool result
 */
PG_FUNCTION_INFO_V1(ubox_order_is_not_greater_than);
Datum ubox_order_is_not_greater_than(PG_FUNCTION_ARGS)
{
    UBox *a = PG_GETARG_UBOX_P(0);
    UBox *b = PG_GETARG_UBOX_P(1);

    PG_RETURN_BOOL(ubox_order(fcinfo->flinfo, a, b) <= 0);
}


/**
 * Hashes a box, the support function 1 of the default hash operator class of ubox.
 *
 * @param fcinfo the ubox
 * @return the int4 hash, the low 32 bits of ubox_hash_extended() at seed 0
 */
PG_FUNCTION_INFO_V1(ubox_hash);
Datum ubox_hash(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);

    // the 32-bit hash is the low half of the 64-bit one at seed 0, by definition
    PG_RETURN_UINT32((uint32) ubox_hash_value(fcinfo->flinfo, box, 0));
}


/**
 * Hashes a box with a seed, the support function 2 of the default hash operator class of ubox.
 *
 * @param fcinfo the ubox and the int8 seed
 * @return the int8 hash
 */
PG_FUNCTION_INFO_V1(ubox_hash_extended);
Datum ubox_hash_extended(PG_FUNCTION_ARGS)
{
    UBox *box = PG_GETARG_UBOX_P(0);
    uint64 seed = PG_GETARG_INT64(1);

    PG_RETURN_UINT64(ubox_hash_value(fcinfo->flinfo, box, seed));
}
