load ../psql_tests.bash

setup_file() {
  # hashing is the only remaining strategy, so DISTINCT, GROUP BY, the set operations
  # and joins on @= exercise the hash operator class; ORDER BY has no alternative to
  # a sort and exercises the B-tree one
  pg_session_start sparql.ubox
  pg_send 'set enable_sort = off; set enable_nestloop = off; set enable_mergejoin = off;'

  # sparql on the search path would resolve the bare name ubox; the input function
  # pins the search path to pg_catalog, so it must not
  pg_send 'set search_path = sparql, public;'
}



####
# in/out
#

@test "io: '1:int4'::sparql.ubox" {
  expect_output '1:integer'
}

@test "io: '1:integer'::sparql.ubox" {
  expect_output '1:integer'
}

@test "io: '1:pg_catalog.int4'::sparql.ubox" {
  expect_output '1:integer'
}

@test "io: '1:  integer  '::sparql.ubox" {
  expect_output '1:integer'
}

@test "io: '  1  :integer'::sparql.ubox" {
  expect_output '1:integer'
}

@test "io: '1:bigint'::sparql.ubox" {
  expect_output '1:bigint'
}

@test "io: '1:smallint'::sparql.ubox" {
  expect_output '1:smallint'
}

@test "io: '1.50:numeric'::sparql.ubox" {
  expect_output '1.50:numeric'
}

@test "io: '1.5:float8'::sparql.ubox" {
  expect_output '1.5:double precision'
}

@test "io: 't:boolean'::sparql.ubox" {
  expect_output 't:boolean'
}

@test "io: 'abc:text'::sparql.ubox" {
  expect_output 'abc:pg_catalog.text'
}

@test "io: 'abc:pg_catalog.text'::sparql.ubox" {
  expect_output 'abc:pg_catalog.text'
}

@test "io: 'abc:\"pg_catalog\".\"text\"'::sparql.ubox" {
  expect_output 'abc:pg_catalog.text'
}

@test "io: 'abc:varchar'::sparql.ubox" {
  expect_output 'abc:character varying'
}

@test "io: 'abc:character varying'::sparql.ubox" {
  expect_output 'abc:character varying'
}

@test "io: 'abc:character(5)'::sparql.ubox" {
  expect_output 'abc:character'
}

@test "io: 'a:\"char\"'::sparql.ubox" {
  expect_output 'a:pg_catalog."char"'
}

@test "io: 'abc:name'::sparql.ubox" {
  expect_output 'abc:pg_catalog.name'
}

@test "io: '2020-01-02:date'::sparql.ubox" {
  expect_output '2020-01-02:pg_catalog.date'
}

@test "io: '1 day:interval'::sparql.ubox" {
  expect_output '1 day:interval'
}

@test "io: '{1,2}:int4[]'::sparql.ubox" {
  expect_output '{1,2}:integer[]'
}

@test "io: '(1,2):point'::sparql.ubox" {
  expect_output '(1,2):pg_catalog.point'
}

@test "io: '{\"a\":1}:jsonb'::sparql.ubox" {
  expect_output '{"a": 1}:pg_catalog.jsonb'
}

@test "io: '\\x78797a:bytea'::sparql.ubox" {
  expect_output '\x78797a:pg_catalog.bytea'
}

@test "io: 'abc:cstring'::sparql.ubox" {
  expect_output 'abc:pg_catalog.cstring'
}

@test "io: 'a:b:text'::sparql.ubox" {
  expect_output 'a:b:pg_catalog.text'
}

@test "io: 'a\"b:\"::text'::sparql.ubox" {
  expect_output 'a"b:"::pg_catalog.text'
}

@test "io: '1:integer:sparql.ubox'::sparql.ubox" {
  expect_output '1:integer:sparql.ubox'
}

@test "io: '1:integer:ubox'::sparql.ubox" {
  expect_error
}

@test "io: '{\"1:integer\",\"a:b:text\"}'::sparql.ubox[]" {
  expect_output '{1:integer,a:b:pg_catalog.text}'
}

@test "io: '1'::sparql.ubox" {
  expect_error
}

@test "io: ''::sparql.ubox" {
  expect_error
}

@test "io: ':int4'::sparql.ubox" {
  expect_error
}

@test "io: 'abc:int4'::sparql.ubox" {
  expect_error
}

@test "io: '1:int4:int4'::sparql.ubox" {
  expect_error
}

@test "io: '1:int4[]'::sparql.ubox" {
  expect_error
}

@test "io: '1:nonexistent'::sparql.ubox" {
  expect_error
}

@test "io: '1:\"public\".\"nonexistent\"'::sparql.ubox" {
  expect_error
}

@test "io: 'a:\"weird:type\"'::sparql.ubox" {
  expect_error
}

@test "io: '1:sparql.ubox'::sparql.ubox" {
  expect_error
}



####
# receive/send
#

@test "rs: '1:int4'::sparql.ubox" {
  expect_output '1:integer'
}

@test "rs: '1:integer'::sparql.ubox" {
  expect_output '1:integer'
}

@test "rs: '1:pg_catalog.int4'::sparql.ubox" {
  expect_output '1:integer'
}

@test "rs: '1:  integer  '::sparql.ubox" {
  expect_output '1:integer'
}

@test "rs: '  1  :integer'::sparql.ubox" {
  expect_output '1:integer'
}

@test "rs: '1:bigint'::sparql.ubox" {
  expect_output '1:bigint'
}

@test "rs: '1:smallint'::sparql.ubox" {
  expect_output '1:smallint'
}

@test "rs: '1.50:numeric'::sparql.ubox" {
  expect_output '1.50:numeric'
}

@test "rs: '1.5:float8'::sparql.ubox" {
  expect_output '1.5:double precision'
}

@test "rs: 't:boolean'::sparql.ubox" {
  expect_output 't:boolean'
}

@test "rs: 'abc:text'::sparql.ubox" {
  expect_output 'abc:pg_catalog.text'
}

@test "rs: 'abc:pg_catalog.text'::sparql.ubox" {
  expect_output 'abc:pg_catalog.text'
}

@test "rs: 'abc:\"pg_catalog\".\"text\"'::sparql.ubox" {
  expect_output 'abc:pg_catalog.text'
}

@test "rs: 'abc:varchar'::sparql.ubox" {
  expect_output 'abc:character varying'
}

@test "rs: 'abc:character varying'::sparql.ubox" {
  expect_output 'abc:character varying'
}

@test "rs: 'abc:character(5)'::sparql.ubox" {
  expect_output 'abc:character'
}

@test "rs: 'a:\"char\"'::sparql.ubox" {
  expect_output 'a:pg_catalog."char"'
}

@test "rs: 'abc:name'::sparql.ubox" {
  expect_output 'abc:pg_catalog.name'
}

@test "rs: '2020-01-02:date'::sparql.ubox" {
  expect_output '2020-01-02:pg_catalog.date'
}

@test "rs: '1 day:interval'::sparql.ubox" {
  expect_output '1 day:interval'
}

@test "rs: '{1,2}:int4[]'::sparql.ubox" {
  expect_output '{1,2}:integer[]'
}

@test "rs: '(1,2):point'::sparql.ubox" {
  expect_output '(1,2):pg_catalog.point'
}

@test "rs: '{\"a\":1}:jsonb'::sparql.ubox" {
  expect_output '{"a": 1}:pg_catalog.jsonb'
}

@test "rs: '\\x78797a:bytea'::sparql.ubox" {
  expect_output '\x78797a:pg_catalog.bytea'
}

@test "rs: 'abc:cstring'::sparql.ubox" {
  expect_output 'abc:pg_catalog.cstring'
}

@test "rs: 'a:b:text'::sparql.ubox" {
  expect_output 'a:b:pg_catalog.text'
}

@test "rs: 'a\"b:\"::text'::sparql.ubox" {
  expect_output 'a"b:"::pg_catalog.text'
}

@test "rs: '1:integer:sparql.ubox'::sparql.ubox" {
  expect_output '1:integer:sparql.ubox'
}



####
# sparql.ubox_create()
#

@test "fn: sparql.ubox_create(1::int4)" {
  expect_output '1:integer'
}

@test "fn: sparql.ubox_create(1::int8)" {
  expect_output '1:bigint'
}

@test "fn: sparql.ubox_create(1::int2)" {
  expect_output '1:smallint'
}

@test "fn: sparql.ubox_create(1.50::numeric)" {
  expect_output '1.50:numeric'
}

@test "fn: sparql.ubox_create('NaN'::float8)" {
  expect_output 'NaN:double precision'
}

@test "fn: sparql.ubox_create(true)" {
  expect_output 't:boolean'
}

@test "fn: sparql.ubox_create('abc'::text)" {
  expect_output 'abc:pg_catalog.text'
}

@test "fn: sparql.ubox_create('abc'::varchar)" {
  expect_output 'abc:character varying'
}

@test "fn: sparql.ubox_create('x'::char(3))" {
  expect_output 'x  :character'
}

@test "fn: sparql.ubox_create('abc'::name)" {
  expect_output 'abc:pg_catalog.name'
}

@test "fn: sparql.ubox_create(1::oid)" {
  expect_output '1:pg_catalog.oid'
}

@test "fn: sparql.ubox_create('1'::xid)" {
  expect_output '1:pg_catalog.xid'
}

@test "fn: sparql.ubox_create('int4'::regtype)" {
  expect_output 'integer:pg_catalog.regtype'
}

@test "fn: sparql.ubox_create('2020-01-02'::date)" {
  expect_output '2020-01-02:pg_catalog.date'
}

@test "fn: sparql.ubox_create('a:b'::text)" {
  expect_output 'a:b:pg_catalog.text'
}

@test "fn: sparql.ubox_create('{1,2}'::int4[])" {
  expect_output '{1,2}:integer[]'
}

@test "fn: sparql.ubox_create('(1,2)'::point)" {
  expect_output '(1,2):pg_catalog.point'
}

@test "fn: sparql.ubox_create('\$1.00'::money)" {
  expect_output '$1.00:pg_catalog.money'
}

@test "fn: sparql.ubox_create('101'::bit(3))" {
  expect_output '101:bit'
}

@test "fn: sparql.ubox_create('{\"a\":1}'::jsonb)" {
  expect_output '{"a": 1}:pg_catalog.jsonb'
}

@test "fn: sparql.ubox_create('xyz'::bytea)" {
  expect_output '\x78797a:pg_catalog.bytea'
}

@test "fn: sparql.ubox_create('abc'::cstring)" {
  expect_output 'abc:pg_catalog.cstring'
}

@test "fn: sparql.ubox_create('a b'::tsvector)" {
  expect_output "'a' 'b':pg_catalog.tsvector"
}

@test "fn: sparql.ubox_create(sparql.ubox_create(1::int4))" {
  expect_output '1:integer:sparql.ubox'
}

@test "fn: sparql.ubox_create(null::int4)" {
  expect_output '(null)'
}

@test "fn: array[sparql.ubox_create(1::int4), sparql.ubox_create('a:b'::text)]" {
  expect_output '{1:integer,a:b:pg_catalog.text}'
}

@test "fn: length(sparql.ubox_create(repeat('a', 100000)::text)::text)" {
  expect_output '100016'
}

@test "fn: sparql.ubox_create(null)" {
  expect_error
}

@test "fn: sparql.ubox_create('abc')" {
  expect_error
}

@test "fn: sparql.ubox_create(row(1, 2))" {
  expect_error
}

@test "fn: sparql.ubox_create(array[row(1, 2)])" {
  expect_error
}



####
# sparql.ubox_get_value()
#

@test "fn: sparql.ubox_get_value(sparql.ubox_create(1::int4), null::int4)" {
  expect_output '1'
}

@test "fn: pg_typeof(sparql.ubox_get_value(sparql.ubox_create(1::int4), null::int4))" {
  expect_output 'integer'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create(1::int4), 5::int4)" {
  expect_output '1'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create('abc'::text), null::text)" {
  expect_output 'abc'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create('abc'::varchar), null::varchar)" {
  expect_output 'abc'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create('x'::char(3)), null::bpchar)" {
  expect_output 'x  '
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create('x'::\"char\"), null::\"char\")" {
  expect_output 'x'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create(1.50::numeric), null::numeric)" {
  expect_output '1.50'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create('NaN'::float8), null::float8)" {
  expect_output 'NaN'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create(true), null::bool)" {
  expect_output 't'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create('{1,2}'::int4[]), null::int4[])" {
  expect_output '{1,2}'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create('xyz'::bytea), null::bytea)" {
  expect_output '\x78797a'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create(sparql.ubox_create(1::int4)), null::sparql.ubox)" {
  expect_output '1:integer'
}

@test "fn: length(sparql.ubox_get_value(sparql.ubox_create(repeat('a', 100000)::text), null::text))" {
  expect_output '100000'
}

@test "fn: sparql.ubox_get_value(null::sparql.ubox, null::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create(1::int4), null::int8)" {
  expect_error
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create('abc'::varchar), null::text)" {
  expect_error
}

@test "fn: sparql.ubox_get_value(sparql.ubox_create(1::int4), null)" {
  expect_error
}



####
# sparql.ubox_as_varchar()
#

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('abc'::varchar))" {
  expect_output 'abc'
}

@test "fn: pg_typeof(sparql.ubox_as_varchar(sparql.ubox_create(1::int4)))" {
  expect_output 'character varying'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('abc'::text))" {
  expect_output 'abc'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('abc'::name))" {
  expect_output 'abc'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('abc  '::char(5)))" {
  expect_output 'abc'
}

@test "fn: length(sparql.ubox_as_varchar(sparql.ubox_create('abc  '::char(5))))" {
  expect_output '3'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('x'::\"char\"))" {
  expect_output 'x'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('x'::cstring))" {
  expect_output 'x'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create(1::int4))" {
  expect_output '1'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create(1.50::numeric))" {
  expect_output '1.50'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('1.5'::float8))" {
  expect_output '1.5'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create(true))" {
  expect_output 'true'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('2020-01-02'::date))" {
  expect_output '2020-01-02'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('1 day'::interval))" {
  expect_output '1 day'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('{1,2}'::int4[]))" {
  expect_output '{1,2}'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('(1,2)'::point))" {
  expect_output '(1,2)'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('101'::bit(3)))" {
  expect_output '101'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('{\"a\":1}'::jsonb))" {
  expect_output '{"a": 1}'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('xyz'::bytea))" {
  expect_output '\x78797a'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create('int4'::regtype))" {
  expect_output 'integer'
}

@test "fn: sparql.ubox_as_varchar(sparql.ubox_create(sparql.ubox_create(1::int4)))" {
  expect_output '1:integer'
}

@test "fn: sparql.ubox_as_varchar(null::sparql.ubox)" {
  expect_output '(null)'
}

@test "fn: (select string_agg(sparql.ubox_as_varchar(x), ',') from unnest(array[sparql.ubox_create(1::int4), sparql.ubox_create('a  '::char(3)), sparql.ubox_create('b'::text), sparql.ubox_create(2::int4)]) x)" {
  expect_output '1,a,b,2'
}



####
# operator =
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.=) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.=) sparql.ubox_create(2::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.=) sparql.ubox_create(1::int8)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create(1.0::numeric) operator(sparql.=) sparql.ubox_create(1.00::numeric)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('a'::bpchar) operator(sparql.=) sparql.ubox_create('a '::bpchar)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('a'::text) operator(sparql.=) sparql.ubox_create('a '::text)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('NaN'::float8) operator(sparql.=) sparql.ubox_create('NaN'::float8)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('\$1.00'::money) operator(sparql.=) sparql.ubox_create('\$1.00'::money)" {
  expect_output 't'
}

# a type with a hash but no B-tree operator class has its equality taken from the hash one
@test "op: sparql.ubox_create('1'::xid) operator(sparql.=) sparql.ubox_create('1'::xid)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('1'::xid) operator(sparql.=) sparql.ubox_create('2'::xid)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('a b'::tsvector) operator(sparql.=) sparql.ubox_create('a b'::tsvector)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('xyz'::cstring) operator(sparql.=) sparql.ubox_create('xyz'::cstring)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create('(1,2)'::point) operator(sparql.=) sparql.ubox_create('(1,2)'::point)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create('{\"a\":1}'::json) operator(sparql.=) sparql.ubox_create('{\"a\":1}'::json)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create('{\"a\":1}'::jsonb) operator(sparql.=) sparql.ubox_create('{\"a\": 1}'::jsonb)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(sparql.ubox_create(1::int4)) operator(sparql.=) sparql.ubox_create(sparql.ubox_create(1::int4))" {
  expect_output 't'
}

@test "op: sparql.ubox_create(sparql.ubox_create(1::int4)) operator(sparql.=) sparql.ubox_create(sparql.ubox_create(1::int8))" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.=) null::sparql.ubox" {
  expect_output '(null)'
}



####
# operator <>
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.<>) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.<>) sparql.ubox_create(2::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.<>) sparql.ubox_create(1::int8)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create(1.0::numeric) operator(sparql.<>) sparql.ubox_create(1.00::numeric)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('a'::text) operator(sparql.<>) sparql.ubox_create('a '::text)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('(1,2)'::point) operator(sparql.<>) sparql.ubox_create('(1,3)'::point)" {
  expect_output '(null)'
}



####
# operator <
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.<) sparql.ubox_create(2::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(2::int4) operator(sparql.<) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.<) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.<) sparql.ubox_create(2::int8)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create('abc'::text) operator(sparql.<) sparql.ubox_create('abd'::text)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('2020-01-01'::date) operator(sparql.<) sparql.ubox_create('2020-01-02'::date)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('\$1.00'::money) operator(sparql.<) sparql.ubox_create('\$2.00'::money)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('101'::bit(3)) operator(sparql.<) sparql.ubox_create('110'::bit(3))" {
  expect_output 't'
}

@test "op: sparql.ubox_create('{\"a\":1}'::jsonb) operator(sparql.<) sparql.ubox_create('{\"a\":2}'::jsonb)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('(1,2)'::point) operator(sparql.<) sparql.ubox_create('(1,3)'::point)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create('xyz'::cstring) operator(sparql.<) sparql.ubox_create('xyz'::cstring)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create('1'::xid) operator(sparql.<) sparql.ubox_create('2'::xid)" {
  expect_output '(null)'
}



####
# operator >
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.>) sparql.ubox_create(2::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(2::int4) operator(sparql.>) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.>) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(2::int4) operator(sparql.>) sparql.ubox_create(1::int8)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create('NaN'::float8) operator(sparql.>) sparql.ubox_create('Infinity'::float8)" {
  expect_output 't'
}



####
# operator <=
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.<=) sparql.ubox_create(2::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.<=) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(2::int4) operator(sparql.<=) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.<=) sparql.ubox_create(1::int8)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create(1.0::numeric) operator(sparql.<=) sparql.ubox_create(1.00::numeric)" {
  expect_output 't'
}



####
# operator >=
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.>=) sparql.ubox_create(2::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.>=) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(2::int4) operator(sparql.>=) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(2::int4) operator(sparql.>=) sparql.ubox_create(1::int8)" {
  expect_output '(null)'
}

@test "op: sparql.ubox_create('a'::bpchar) operator(sparql.>=) sparql.ubox_create('a '::bpchar)" {
  expect_output 't'
}



####
# operator @=
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.@=) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@=) sparql.ubox_create(2::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@=) sparql.ubox_create(1::int8)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1.0::numeric) operator(sparql.@=) sparql.ubox_create(1.00::numeric)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('a'::bpchar) operator(sparql.@=) sparql.ubox_create('a '::bpchar)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('a'::text) operator(sparql.@=) sparql.ubox_create('a '::text)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('NaN'::float8) operator(sparql.@=) sparql.ubox_create('NaN'::float8)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('{\"a\":1}'::jsonb) operator(sparql.@=) sparql.ubox_create('{\"a\": 1}'::jsonb)" {
  expect_output 't'
}

# types without a B-tree operator class are compared bytewise
@test "op: sparql.ubox_create('(1,2)'::point) operator(sparql.@=) sparql.ubox_create('(1,2)'::point)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('(1,2)'::point) operator(sparql.@=) sparql.ubox_create('(1,3)'::point)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('{\"a\":1}'::json) operator(sparql.@=) sparql.ubox_create('{\"a\":1}'::json)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('{\"a\":1}'::json) operator(sparql.@=) sparql.ubox_create('{\"a\": 1}'::json)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('abc'::cstring) operator(sparql.@=) sparql.ubox_create('abc'::cstring)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('1'::xid) operator(sparql.@=) sparql.ubox_create('1'::xid)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('abc'::cstring) operator(sparql.@=) sparql.ubox_create('abcd'::cstring)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(sparql.ubox_create(1::int4)) operator(sparql.@=) sparql.ubox_create(sparql.ubox_create(1::int4))" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@=) null::sparql.ubox" {
  expect_output '(null)'
}



####
# operator @<>
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<>) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<>) sparql.ubox_create(2::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<>) sparql.ubox_create(1::int8)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1.0::numeric) operator(sparql.@<>) sparql.ubox_create(1.00::numeric)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('(1,2)'::point) operator(sparql.@<>) sparql.ubox_create('(1,3)'::point)" {
  expect_output 't'
}



####
# operator @<
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<) sparql.ubox_create(2::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(2::int4) operator(sparql.@<) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('abc'::text) operator(sparql.@<) sparql.ubox_create('abd'::text)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('NaN'::float8) operator(sparql.@<) sparql.ubox_create('Infinity'::float8)" {
  expect_output 'f'
}

# boxes of different types are ordered by the OID of the boxed type
@test "op: sparql.ubox_create(true) operator(sparql.@<) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<) sparql.ubox_create('a'::text)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('a'::text) operator(sparql.@<) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int8) operator(sparql.@<) sparql.ubox_create(0::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(0::int4) operator(sparql.@<) sparql.ubox_create(1::int8)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('ab'::cstring) operator(sparql.@<) sparql.ubox_create('abc'::cstring)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('abc'::cstring) operator(sparql.@<) sparql.ubox_create('ab'::cstring)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('xy'::bytea) operator(sparql.@<) sparql.ubox_create('xyz'::bytea)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('(1,2)'::point) operator(sparql.@<) sparql.ubox_create('(1,3)'::point)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('(1,3)'::point) operator(sparql.@<) sparql.ubox_create('(1,2)'::point)" {
  expect_output 'f'
}



####
# operator @>
#

@test "op: sparql.ubox_create(2::int4) operator(sparql.@>) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@>) sparql.ubox_create(2::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@>) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('NaN'::float8) operator(sparql.@>) sparql.ubox_create('Infinity'::float8)" {
  expect_output 't'
}

@test "op: sparql.ubox_create('a'::text) operator(sparql.@>) sparql.ubox_create(1::int4)" {
  expect_output 't'
}



####
# operator @<=
#

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<=) sparql.ubox_create(2::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<=) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(2::int4) operator(sparql.@<=) sparql.ubox_create(1::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create(1.0::numeric) operator(sparql.@<=) sparql.ubox_create(1.00::numeric)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@<=) sparql.ubox_create(1::int8)" {
  expect_output 'f'
}



####
# operator @>=
#

@test "op: sparql.ubox_create(2::int4) operator(sparql.@>=) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@>=) sparql.ubox_create(1::int4)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@>=) sparql.ubox_create(2::int4)" {
  expect_output 'f'
}

@test "op: sparql.ubox_create('a'::bpchar) operator(sparql.@>=) sparql.ubox_create('a '::bpchar)" {
  expect_output 't'
}

@test "op: sparql.ubox_create(1::int4) operator(sparql.@>=) sparql.ubox_create(1::int8)" {
  expect_output 't'
}



####
# sparql.ubox_order_compare()
#

@test "fn: sparql.ubox_order_compare(sparql.ubox_create(1::int4), sparql.ubox_create(2::int4))" {
  expect_output '-1'
}

@test "fn: sparql.ubox_order_compare(sparql.ubox_create(2::int4), sparql.ubox_create(1::int4))" {
  expect_output '1'
}

@test "fn: sparql.ubox_order_compare(sparql.ubox_create(1::int4), sparql.ubox_create(1::int4))" {
  expect_output '0'
}

@test "fn: sparql.ubox_order_compare(sparql.ubox_create(1.0::numeric), sparql.ubox_create(1.00::numeric))" {
  expect_output '0'
}

@test "fn: sparql.ubox_order_compare(sparql.ubox_create(1::int8), sparql.ubox_create(1::int4))" {
  expect_output '-1'
}

@test "fn: sparql.ubox_order_compare(sparql.ubox_create(1::int4), sparql.ubox_create(1::int8))" {
  expect_output '1'
}

@test "fn: sparql.ubox_order_compare(sparql.ubox_create('(1,2)'::point), sparql.ubox_create('(1,3)'::point))" {
  expect_output '-1'
}

@test "fn: sparql.ubox_order_compare(sparql.ubox_create('ab'::cstring), sparql.ubox_create('abc'::cstring))" {
  expect_output '-1'
}

@test "fn: sparql.ubox_order_compare(sparql.ubox_create(1::int4), null::sparql.ubox)" {
  expect_output '(null)'
}



####
# sparql.ubox_hash() consistency with operator @=
#

@test "fn: sparql.ubox_hash(sparql.ubox_create(1::int4)) = sparql.ubox_hash(sparql.ubox_create(1::int4))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create(1.0::numeric)) = sparql.ubox_hash(sparql.ubox_create(1.00::numeric))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('a'::bpchar)) = sparql.ubox_hash(sparql.ubox_create('a '::bpchar))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('NaN'::float8)) = sparql.ubox_hash(sparql.ubox_create('-NaN'::float8))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('{\"a\":1}'::jsonb)) = sparql.ubox_hash(sparql.ubox_create('{\"a\": 1}'::jsonb))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create(1.50::numeric)) = sparql.ubox_hash('1.50:numeric'::sparql.ubox)" {
  expect_output 't'
}

# types with neither a hash nor a B-tree operator class are hashed bytewise
@test "fn: sparql.ubox_hash(sparql.ubox_create('(1,2)'::point)) = sparql.ubox_hash(sparql.ubox_create('(1,2)'::point))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('abc'::cstring)) = sparql.ubox_hash(sparql.ubox_create('abc'::cstring))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('{\"a\":1}'::json)) = sparql.ubox_hash(sparql.ubox_create('{\"a\":1}'::json))" {
  expect_output 't'
}

# types that are ordered but not hashable share a single hash value
@test "fn: sparql.ubox_hash(sparql.ubox_create('\$1.00'::money)) = sparql.ubox_hash(sparql.ubox_create('\$2.00'::money))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('101'::bit(3))) = sparql.ubox_hash(sparql.ubox_create('110'::bit(3)))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('a b'::tsvector)) = sparql.ubox_hash(sparql.ubox_create('c'::tsvector))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create(1::int4)) <> sparql.ubox_hash(sparql.ubox_create(2::int4))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create(1::int4)) <> sparql.ubox_hash(sparql.ubox_create(1::int8))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('a'::text)) <> sparql.ubox_hash(sparql.ubox_create('a'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('a'::text)) <> sparql.ubox_hash(sparql.ubox_create('a '::text))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('(1,2)'::point)) <> sparql.ubox_hash(sparql.ubox_create('(1,3)'::point))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('{\"a\":1}'::json)) <> sparql.ubox_hash(sparql.ubox_create('{\"a\": 1}'::json))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('ab'::cstring)) <> sparql.ubox_hash(sparql.ubox_create('abc'::cstring))" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash(sparql.ubox_create('1'::xid)) <> sparql.ubox_hash(sparql.ubox_create('2'::xid))" {
  expect_output 't'
}

# the value hash is folded together with the type, so it is not the hash of the value alone
@test "fn: sparql.ubox_hash(sparql.ubox_create('abc'::text)) <> hashtext('abc')" {
  expect_output 't'
}



####
# sparql.ubox_hash_extended()
#

@test "fn: (sparql.ubox_hash_extended(sparql.ubox_create(1::int4), 0::int8) & 4294967295) = (sparql.ubox_hash(sparql.ubox_create(1::int4))::int8 & 4294967295)" {
  expect_output 't'
}

@test "fn: (sparql.ubox_hash_extended(sparql.ubox_create('abc'::text), 0::int8) & 4294967295) = (sparql.ubox_hash(sparql.ubox_create('abc'::text))::int8 & 4294967295)" {
  expect_output 't'
}

@test "fn: (sparql.ubox_hash_extended(sparql.ubox_create('(1,2)'::point), 0::int8) & 4294967295) = (sparql.ubox_hash(sparql.ubox_create('(1,2)'::point))::int8 & 4294967295)" {
  expect_output 't'
}

@test "fn: (sparql.ubox_hash_extended(sparql.ubox_create('\$1.00'::money), 0::int8) & 4294967295) = (sparql.ubox_hash(sparql.ubox_create('\$1.00'::money))::int8 & 4294967295)" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash_extended(sparql.ubox_create(1.0::numeric), 7::int8) = sparql.ubox_hash_extended(sparql.ubox_create(1.00::numeric), 7::int8)" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash_extended(sparql.ubox_create('\$1.00'::money), 7::int8) = sparql.ubox_hash_extended(sparql.ubox_create('\$2.00'::money), 7::int8)" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash_extended(sparql.ubox_create('(1,2)'::point), 7::int8) = sparql.ubox_hash_extended(sparql.ubox_create('(1,2)'::point), 7::int8)" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash_extended(sparql.ubox_create(1::int4), 0::int8) <> sparql.ubox_hash_extended(sparql.ubox_create(1::int4), 1::int8)" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash_extended(sparql.ubox_create(1::int4), 7::int8) <> sparql.ubox_hash_extended(sparql.ubox_create(1::int8), 7::int8)" {
  expect_output 't'
}

@test "fn: sparql.ubox_hash_extended(sparql.ubox_create('(1,2)'::point), 7::int8) <> sparql.ubox_hash_extended(sparql.ubox_create('(1,3)'::point), 7::int8)" {
  expect_output 't'
}



####
# operator classes
#

@test "oc: (select count(*) from (select distinct x from unnest(array[sparql.ubox_create(1.0::numeric), sparql.ubox_create(1.00::numeric), sparql.ubox_create(1::int4), sparql.ubox_create(1::int8), sparql.ubox_create('a'::bpchar), sparql.ubox_create('a '::bpchar), sparql.ubox_create('a'::text)]) x) t)" {
  expect_output '5'
}

# types without a B-tree operator class are grouped by their bytes
@test "oc: (select count(*) from (select distinct x from unnest(array[sparql.ubox_create('(1,2)'::point), sparql.ubox_create('(1,2)'::point), sparql.ubox_create('(1,3)'::point)]) x) t)" {
  expect_output '2'
}

# all values of a type that is ordered but not hashable share one hash bucket
@test "oc: (select count(*) from (select distinct x from unnest(array[sparql.ubox_create('\$1.00'::money), sparql.ubox_create('\$2.00'::money), sparql.ubox_create('\$1.00'::money)]) x) t)" {
  expect_output '2'
}

@test "oc: (select count(*) from (select distinct x from unnest(array[sparql.ubox_create(repeat('a', 100000)::text), sparql.ubox_create(repeat('a', 100000)::text), sparql.ubox_create('a'::text)]) x) t)" {
  expect_output '2'
}

@test "oc: (select count(*) from (select x from unnest(array[sparql.ubox_create(1::int4), sparql.ubox_create(1::int4), sparql.ubox_create('a'::text), null]) x group by x) t)" {
  expect_output '3'
}

@test "oc: (select count(*) from unnest(array[sparql.ubox_create(1::int4), sparql.ubox_create(2::int4), sparql.ubox_create(1.0::numeric)]) a join unnest(array[sparql.ubox_create(1::int4), sparql.ubox_create(1.00::numeric), sparql.ubox_create(1::int8)]) b on a operator(sparql.@=) b)" {
  expect_output '2'
}

@test "oc: (select count(*) from (select x from unnest(array[sparql.ubox_create(1::int4), sparql.ubox_create(1.0::numeric)]) x union select x from unnest(array[sparql.ubox_create(1::int8), sparql.ubox_create(1.00::numeric)]) x) t)" {
  expect_output '3'
}

@test "oc: (select count(*) from (select x from unnest(array[sparql.ubox_create(1.0::numeric), sparql.ubox_create(1::int4)]) x intersect select sparql.ubox_create(1.00::numeric)) t)" {
  expect_output '1'
}

@test "oc: (select count(*) from (select x from unnest(array[sparql.ubox_create(1.0::numeric), sparql.ubox_create(1::int4)]) x except select sparql.ubox_create(1.00::numeric)) t)" {
  expect_output '1'
}

# boxes of different types are ordered by the OID of the boxed type
@test "oc: (select string_agg(x::text, ',' order by x) from unnest(array[sparql.ubox_create('a'::text), sparql.ubox_create(1::int4), sparql.ubox_create(1::int8), sparql.ubox_create(true), sparql.ubox_create(1.0::numeric), sparql.ubox_create('(1,2)'::point)]) x)" {
  expect_output 't:boolean,1:bigint,1:integer,a:pg_catalog.text,(1,2):pg_catalog.point,1.0:numeric'
}

@test "oc: (select string_agg(x::text, ',' order by x desc) from unnest(array[sparql.ubox_create('a'::text), sparql.ubox_create(1::int4), sparql.ubox_create(1::int8), sparql.ubox_create(true), sparql.ubox_create(1.0::numeric), sparql.ubox_create('(1,2)'::point)]) x)" {
  expect_output '1.0:numeric,(1,2):pg_catalog.point,a:pg_catalog.text,1:integer,1:bigint,t:boolean'
}

@test "oc: (select t.x::text from (select x from unnest(array[sparql.ubox_create('a'::text), sparql.ubox_create(1::int4), sparql.ubox_create(true), null]) x order by x nulls last limit 1) t)" {
  expect_output 't:boolean'
}

@test "oc: (select t.x::text from (select x from unnest(array[sparql.ubox_create('a'::text), sparql.ubox_create(1::int4), sparql.ubox_create(true), null]) x order by x desc nulls last limit 1) t)" {
  expect_output 'a:pg_catalog.text'
}

@test "oc: (select length(t.x::text) from (select x from unnest(array[sparql.ubox_create(repeat('a', 100000)::text), sparql.ubox_create('a'::text)]) x order by x desc limit 1) t)" {
  expect_output '100016'
}



####
# the 32-bit hash must be the low half of the 64-bit one at seed 0; support
# function 2 of a hash operator class is optional, so a boxed type may have a
# plain hash function and no extended one
#

@test "fn: (select sparql.ubox_hash(b)::bigint & 4294967295 = sparql.ubox_hash_extended(b, 0) & 4294967295 from (select sparql.ubox_create('a'::text) b) t)" {
  expect_output 't'
}

@test "fn: (select sparql.ubox_hash(b)::bigint & 4294967295 = sparql.ubox_hash_extended(b, 0) & 4294967295 from (select sparql.ubox_create(1::money) b) t)" {
  expect_output 't'
}

@test "fn: (select sparql.ubox_hash(b)::bigint & 4294967295 = sparql.ubox_hash_extended(b, 0) & 4294967295 from (select sparql.ubox_create('123'::xid) b) t)" {
  expect_output 't'
}

@test "fn: (select sparql.ubox_hash(b)::bigint & 4294967295 = sparql.ubox_hash_extended(b, 0) & 4294967295 from (select sparql.ubox_create('(1,2)'::point) b) t)" {
  expect_output 't'
}
