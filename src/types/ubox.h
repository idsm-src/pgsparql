#ifndef TYPES_UBOX_H_
#define TYPES_UBOX_H_

#include <postgres.h>
#if PG_VERSION_NUM >= 160000
#include <varatt.h>
#endif
#include <fmgr.h>
#include <lib/stringinfo.h>
#include <access/tupmacs.h>
#include <utils/typcache.h>


/*
 * A value of an arbitrary type together with the OID of that type.
 *
 * Memory layout:  [varlena header][typeoid][value bytes ...]
 *
 * The boxed value is stored exactly in its own Datum representation:
 * pass-by-value types and fixed-length by-reference types occupy typlen
 * bytes, varlena types are stored as a detoasted copy with a 4-byte header,
 * cstring is stored NUL-terminated.
 *
 * Because ubox is declared with "alignment = double" and the value starts at
 * offset 8, the boxed value is correctly aligned for any type as long as the
 * box itself is properly aligned.  PG_DETOAST_DATUM guarantees this: a box
 * that is stored with a short (1-byte) header, compressed or toasted is
 * always copied into freshly palloc'd (MAXALIGNed) memory, and a box with a
 * full 4-byte header is aligned according to typalign in tuples.
 */
typedef struct
{
    char vl_len_[4];
    Oid typeoid;
    char value[FLEXIBLE_ARRAY_MEMBER] pg_attribute_aligned(4);
}
UBox;


#define UBOX_HDRSZ offsetof(UBox, value)

#define DatumGetUBoxP(X) ((UBox *) PG_DETOAST_DATUM(X))
#define UBoxPGetDatum(X) PointerGetDatum(X)
#define PG_GETARG_UBOX_P(X) DatumGetUBoxP(PG_GETARG_DATUM(X))
#define PG_RETURN_UBOX_P(X) return UBoxPGetDatum(X)


UBox *ubox_make(Oid typeoid, Datum value);


/*
 * The pieces of the text and the binary representation, shared with the
 * user literal variant of rdfbox, which embeds a whole box in itself.
 * ubox_parse() hands back the value part of the text it consumed when
 * "value" is not NULL, so that the caller can tell a canonical lexical
 * form from one that has to be stored.
 */
UBox *ubox_parse(const char *str, char **value);
char *ubox_value_as_cstring(UBox *box);
char *ubox_type_as_cstring(UBox *box);
UBox *ubox_receive(StringInfo buf);
void ubox_append_binary(StringInfo buf, UBox *box);


/*
 * The operations behind the SQL-visible functions, callable without a
 * FunctionCallInfo.  "flinfo" is only used to cache the resolved type
 * information between calls and may be NULL.
 */
Datum ubox_value_of_type(UBox *box, Oid typeoid);
VarChar *ubox_value_as_varchar(FmgrInfo *flinfo, UBox *box);
bool ubox_equals(FmgrInfo *flinfo, UBox *a, UBox *b, bool *equal);
bool ubox_compare(FmgrInfo *flinfo, UBox *a, UBox *b, int *cmp);
int ubox_order(FmgrInfo *flinfo, UBox *a, UBox *b);
uint64 ubox_hash_value(FmgrInfo *flinfo, UBox *box, uint64 seed);


/*
 * Extract the boxed value as a Datum.  For by-reference types the result
 * points into the box, so it lives exactly as long as the box does.
 */
static inline Datum ubox_value(UBox *box, TypeCacheEntry *typentry)
{
    return fetch_att(box->value, typentry->typbyval, typentry->typlen);
}


Datum ubox_input(PG_FUNCTION_ARGS);
Datum ubox_output(PG_FUNCTION_ARGS);
Datum ubox_recv(PG_FUNCTION_ARGS);
Datum ubox_send(PG_FUNCTION_ARGS);

Datum ubox_create(PG_FUNCTION_ARGS);
Datum ubox_get_value(PG_FUNCTION_ARGS);
Datum ubox_as_varchar(PG_FUNCTION_ARGS);

Datum ubox_is_equal_to(PG_FUNCTION_ARGS);
Datum ubox_is_not_equal_to(PG_FUNCTION_ARGS);
Datum ubox_is_less_than(PG_FUNCTION_ARGS);
Datum ubox_is_greater_than(PG_FUNCTION_ARGS);
Datum ubox_is_not_less_than(PG_FUNCTION_ARGS);
Datum ubox_is_not_greater_than(PG_FUNCTION_ARGS);

Datum ubox_order_compare(PG_FUNCTION_ARGS);
Datum ubox_order_is_equal_to(PG_FUNCTION_ARGS);
Datum ubox_order_is_not_equal_to(PG_FUNCTION_ARGS);
Datum ubox_order_is_less_than(PG_FUNCTION_ARGS);
Datum ubox_order_is_greater_than(PG_FUNCTION_ARGS);
Datum ubox_order_is_not_less_than(PG_FUNCTION_ARGS);
Datum ubox_order_is_not_greater_than(PG_FUNCTION_ARGS);
Datum ubox_hash(PG_FUNCTION_ARGS);
Datum ubox_hash_extended(PG_FUNCTION_ARGS);

#endif /* TYPES_UBOX_H_ */
