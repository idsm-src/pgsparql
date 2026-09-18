load ../psql_tests.bash

setup_file() {
  # hashing is the only remaining strategy, so DISTINCT, GROUP BY and joins on @= exercise the hash operator class  
  pg_session_start
  pg_send 'set enable_sort = off; set enable_nestloop = off; set enable_mergejoin = off;'
}



####
# consistency with operator @=
#

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_string('abc'::varchar)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_decimal('1.0'::decimal)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_decimal('1.00'::decimal))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_integer('0'::decimal)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_integer('-0'::decimal))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_double('NaN'::float8)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_double('-NaN'::float8))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_float('NaN'::float4)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_float('NaN'::float4))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash('\"1.00\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox) = sparql.rdfbox_hash(sparql.rdfbox_create_from_decimal_with_lexical('1.00'::decimal, '1.00'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_datetime('2022-10-05T12:00:00+02:00'::timestamptz, 0::int4))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_int('1'::int4)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_int('2'::int4))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_int('1'::int4)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_int('1'::int4)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_float('-0.0'::float4)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_float('0.0'::float4))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_decimal('1.0'::decimal)) <> sparql.rdfbox_hash('\"1.00\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox)" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_string('a'::varchar)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_langstring('a'::varchar, 'cs'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_iri('http://example.org'::varchar)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_string('http://example.org'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash('\"2022-10-05T10:00:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox) <> sparql.rdfbox_hash('\"2022-10-05T10:00:00+00:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox)" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org/other'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int8, 'http://example.org'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output 't'
}


@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_byte('1'::int2)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_byte('1'::int2))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)) = sparql.rdfbox_hash('\"18446744073709551615\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox)" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_positiveinteger('1'::decimal)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal)) = sparql.rdfbox_hash(sparql.rdfbox_create_from_nonnegativeinteger('-0'::decimal))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_byte('1'::int2)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_unsignedbyte('1'::int2))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_byte('1'::int2)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_unsignedlong('1'::decimal)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_positiveinteger('1'::decimal)) <> sparql.rdfbox_hash(sparql.rdfbox_create_from_nonnegativeinteger('1'::decimal))" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)) <> sparql.rdfbox_hash('\"018446744073709551615\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox)" {
  expect_output 't'
}


####
# extended hash
#

@test "fn: (sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_string('abc'::varchar), 0::int8) & 4294967295) = (sparql.rdfbox_hash(sparql.rdfbox_create_from_string('abc'::varchar))::int8 & 4294967295)" {
  expect_output 't'
}

@test "fn: (sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_decimal('1.5'::decimal), 0::int8) & 4294967295) = (sparql.rdfbox_hash(sparql.rdfbox_create_from_decimal('1.5'::decimal))::int8 & 4294967295)" {
  expect_output 't'
}

@test "fn: (sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_double('NaN'::float8), 0::int8) & 4294967295) = (sparql.rdfbox_hash(sparql.rdfbox_create_from_double('NaN'::float8))::int8 & 4294967295)" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_string('abc'::varchar), 0::int8) <> sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_string('abc'::varchar), 1::int8)" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_decimal('1.0'::decimal), 7::int8) = sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_decimal('1.00'::decimal), 7::int8)" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_double('NaN'::float8), 7::int8) = sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_double('-NaN'::float8), 7::int8)" {
  expect_output 't'
}

@test "fn: (sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar), 0::int8) & 4294967295) = (sparql.rdfbox_hash(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar))::int8 & 4294967295)" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar), 7::int8) = sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar), 7::int8)" {
  expect_output 't'
}

@test "fn: sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar), 0::int8) <> sparql.rdfbox_hash_extended(sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar), 1::int8)" {
  expect_output 't'
}


####
# hash operator class
#

@test "oc: (select count(*) from (select distinct x from unnest(array[sparql.rdfbox_create_from_decimal('1.0'::decimal), sparql.rdfbox_create_from_decimal('1.00'::decimal), '\"1.00\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox, sparql.rdfbox_create_from_double('NaN'::float8), sparql.rdfbox_create_from_double('-NaN'::float8), sparql.rdfbox_create_from_float('-0.0'::float4), sparql.rdfbox_create_from_float('0.0'::float4), sparql.rdfbox_create_from_int('1'::int4), sparql.rdfbox_create_from_long('1'::int8), sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)]) x) t)" {
  expect_output '8'
}

@test "oc: (select count(*) from (select x from unnest(array[sparql.rdfbox_create_from_string('a'::varchar), sparql.rdfbox_create_from_string('a'::varchar), sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org/a'::varchar), sparql.rdfbox_create_from_sblanknode('00000000a'::varchar)]) x group by x) t)" {
  expect_output '4'
}

@test "oc: (select count(*) from unnest(array[sparql.rdfbox_create_from_int('1'::int4), sparql.rdfbox_create_from_int('2'::int4), sparql.rdfbox_create_from_decimal('1.0'::decimal)]) a join unnest(array[sparql.rdfbox_create_from_int('1'::int4), sparql.rdfbox_create_from_decimal('1.00'::decimal), sparql.rdfbox_create_from_long('1'::int8)]) b on a operator(sparql.@=) b)" {
  expect_output '2'
}

@test "oc: (select count(*) from (select distinct x from unnest(array[sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar), sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar), sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org/other'::varchar), sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar), sparql.rdfbox_create_from_userliteral_with_lexical('1'::int4, 'http://example.org'::varchar, ' 1 '::varchar)]) x) t)" {
  expect_output '4'
}
