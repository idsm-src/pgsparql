load ../psql_tests.bash



####
# operator === / sameTerm()
#

@test "op: sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.===) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.===) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('0'::int2) operator(sparql.===) sparql.rdfbox_create_from_short('0'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('0'::int2) operator(sparql.===) sparql.rdfbox_create_from_short('-1'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_int('0'::int4) operator(sparql.===) sparql.rdfbox_create_from_int('0'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_int('0'::int4) operator(sparql.===) sparql.rdfbox_create_from_int('-1'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_long('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_long('0'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_long('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_long('-1'::int8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_integer('0'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_integer('-1'::decimal)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_decimal('0.0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_decimal('0'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_decimal('0.0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_decimal('-1'::decimal)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('-0.0'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('+0.0'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('-0.0'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('-0.0'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_float('0.0'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('-1'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('-0.0'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('+0.0'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('-0.0'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('-0.0'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_double('0.0'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('-1'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('2'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('2'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.===) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00'::sparql.zoneddatetime) operator(sparql.===) sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00'::sparql.zoneddatetime)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00'::sparql.zoneddatetime) operator(sparql.===) sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00Z'::sparql.zoneddatetime)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('2000-01-01'::sparql.zoneddate) operator(sparql.===) sparql.rdfbox_create_from_date('2000-01-01'::sparql.zoneddate)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('2000-01-01'::sparql.zoneddate) operator(sparql.===) sparql.rdfbox_create_from_date('2000-01-01Z'::sparql.zoneddate)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_daytimeduration('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_daytimeduration('0'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_daytimeduration('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_daytimeduration('-1'::int8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.===) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.===) sparql.rdfbox_create_from_string('-1'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_langstring('0'::varchar, 'en'::varchar) operator(sparql.===) sparql.rdfbox_create_from_langstring('0'::varchar, 'en'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_langstring('0'::varchar, 'en'::varchar) operator(sparql.===) sparql.rdfbox_create_from_langstring('-1'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_typedliteral('-1'::varchar, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_iri('http://example.org/'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_iblanknode('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_iblanknode('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_iblanknode('1'::int8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_sblanknode('00000000'::varchar) operator(sparql.===) sparql.rdfbox_create_from_sblanknode('00000000'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_sblanknode('00000000'::varchar) operator(sparql.===) sparql.rdfbox_create_from_sblanknode('00000001'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_int('0'::int4) operator(sparql.===) sparql.rdfbox_create_from_long('0'::int8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_decimal('0'::decimal)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('0.0'::float4) operator(sparql.===) sparql.rdfbox_create_from_double('0.0'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00'::sparql.zoneddatetime) operator(sparql.===) sparql.rdfbox_create_from_date('2000-01-01'::sparql.zoneddate)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.===) sparql.rdfbox_create_from_langstring('-1'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_iblanknode('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_sblanknode('00000000'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('-NaN'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_int('1'::int4) operator(sparql.===) sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar) operator(sparql.===) sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar) operator(sparql.===) sparql.rdfbox_create_from_int_with_lexical('1'::int4, '001'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('1'::float8) operator(sparql.===) sparql.rdfbox_create_from_double_with_lexical('1'::float8, '1.0'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_decimal('1.0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_decimal('1.00'::decimal)" {
  expect_output 't'
}

@test "op: '\"1.00\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox operator(sparql.===) '\"1.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "op: '\"01\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox operator(sparql.===) '\"1\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "op: '\"01\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox operator(sparql.===) '\"01\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output 't'
}

@test "op: '\"true\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox operator(sparql.===) '\"1\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "op: '\"2022-10-05T10:00:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox operator(sparql.===) '\"2022-10-05T10:00:00+00:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "op: '\"2022-10-05T10:00:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox operator(sparql.===) '\"2022-10-05T12:00:00+02:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org/other'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral('0'::int8, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('1:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output 'f'
}


####
# operator =
#

@test "op: sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('2'::float4) operator(sparql.=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('2'::float8) operator(sparql.=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string(''::varchar) operator(sparql.=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org/other'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral('0'::int8, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('1:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.=) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output 'f'
}


####
# operator !=
#

@test "op: sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.!=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.!=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.!=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.!=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.!=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.!=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.!=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.!=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_float('2'::float4) operator(sparql.!=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_double('2'::float8) operator(sparql.!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.!=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.!=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.!=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.!=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string(''::varchar) operator(sparql.!=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.!=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.!=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org/other'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral('0'::int8, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('1:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output 't'
}


####
# operator <
#

@test "op: sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.<) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.<) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.<) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.<) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.<) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.<) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.<) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('2'::float4) operator(sparql.<) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('2'::float8) operator(sparql.<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.<) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.<) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.<) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.<) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.<) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.<) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string(''::varchar) operator(sparql.<) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.<) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.<) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.<) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org/other'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral('0'::int8, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('1:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output '(null)'
}


####
# operator >
#

@test "op: sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.>) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.>) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.>) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.>) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.>) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.>) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.>) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('2'::float4) operator(sparql.>) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('2'::float8) operator(sparql.>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.>) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.>) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.>) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.>) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.>) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.>) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string(''::varchar) operator(sparql.>) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.>) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.>) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.>) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org/other'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral('0'::int8, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('1:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output '(null)'
}


####
# operator <=
#

@test "op: sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.<=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.<=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.<=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.<=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('2'::float4) operator(sparql.<=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('2'::float8) operator(sparql.<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.<=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string(''::varchar) operator(sparql.<=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.<=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org/other'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral('0'::int8, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('1:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output '(null)'
}


####
# operator >=
#

@test "op: sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.>=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.>=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.>=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.>=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('2'::float4) operator(sparql.>=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_double('2'::float8) operator(sparql.>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.>=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string(''::varchar) operator(sparql.>=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_short('4'::int2) operator(sparql.>=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('1'::int4, 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org/other'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral('0'::int8, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral_with_lexical('0'::int4, 'http://example.org'::varchar, ' 0 '::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('0:integer'::sparql.ubox), 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral(sparql.ubox_create('1:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_userliteral('1.0'::decimal, 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_userliteral('1.00'::decimal, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_userliteral('0'::int4, 'http://example.org'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output '(null)'
}



####
# the integer types derived from xsd:integer
#

@test "op: sparql.rdfbox_create_from_byte('0'::int2) operator(sparql.===) sparql.rdfbox_create_from_byte('0'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_byte('0'::int2) operator(sparql.===) sparql.rdfbox_create_from_unsignedbyte('0'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.===) sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_positiveinteger('1'::decimal) operator(sparql.===) sparql.rdfbox_create_from_integer('1'::decimal)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_byte('2'::int2) operator(sparql.=) sparql.rdfbox_create_from_short('2'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_byte('-1'::int2) operator(sparql.=) sparql.rdfbox_create_from_unsignedbyte('255'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_short('-1'::int2) operator(sparql.=) sparql.rdfbox_create_from_unsignedshort('65535'::int4)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_int('-1'::int4) operator(sparql.=) sparql.rdfbox_create_from_unsignedint('4294967295'::int8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_unsignedint('4294967295'::int8) operator(sparql.=) sparql.rdfbox_create_from_long('4294967295'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_long('-1'::int8) operator(sparql.=) sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.=) sparql.rdfbox_create_from_integer('18446744073709551615'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('9223372036854775808'::decimal) operator(sparql.=) sparql.rdfbox_create_from_double('9223372036854775808'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.=) sparql.rdfbox_create_from_float('1.8446744e19'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_positiveinteger('5'::decimal) operator(sparql.=) sparql.rdfbox_create_from_unsignedbyte('5'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal) operator(sparql.=) sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_negativeinteger('-1'::decimal) operator(sparql.=) sparql.rdfbox_create_from_byte('-1'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('1'::decimal) operator(sparql.=) sparql.rdfbox_create_from_decimal('1.0'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_byte('1'::int2) operator(sparql.=) sparql.rdfbox_create_from_string('1'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_byte('-1'::int2) operator(sparql.!=) sparql.rdfbox_create_from_unsignedbyte('255'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_long('-1'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_positiveinteger('5'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_unsignedbyte('5'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_unsignedlong('0'::decimal)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_byte('1'::int2) operator(sparql.!=) sparql.rdfbox_create_from_string('1'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_byte('-1'::int2) operator(sparql.<) sparql.rdfbox_create_from_unsignedbyte('0'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedbyte('255'::int2) operator(sparql.<) sparql.rdfbox_create_from_short('256'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_short('-1'::int2) operator(sparql.<) sparql.rdfbox_create_from_unsignedshort('0'::int4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_int('-1'::int4) operator(sparql.<) sparql.rdfbox_create_from_unsignedint('0'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedint('4294967295'::int8) operator(sparql.<) sparql.rdfbox_create_from_long('4294967296'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_long('9223372036854775807'::int8) operator(sparql.<) sparql.rdfbox_create_from_unsignedlong('9223372036854775808'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.<) sparql.rdfbox_create_from_integer('18446744073709551616'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.<) sparql.rdfbox_create_from_double('2e19'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.<) sparql.rdfbox_create_from_double('1.8446744073709552e19'::float8)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_negativeinteger('-1'::decimal) operator(sparql.<) sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal) operator(sparql.<) sparql.rdfbox_create_from_positiveinteger('1'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_byte('1'::int2) operator(sparql.<) sparql.rdfbox_create_from_string('2'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_unsignedbyte('0'::int2) operator(sparql.>) sparql.rdfbox_create_from_byte('-1'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('9223372036854775808'::decimal) operator(sparql.>) sparql.rdfbox_create_from_long('9223372036854775807'::int8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_integer('18446744073709551616'::decimal) operator(sparql.>) sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_positiveinteger('1'::decimal) operator(sparql.>) sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('0'::decimal) operator(sparql.>) sparql.rdfbox_create_from_byte('0'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_unsignedshort('65535'::int4) operator(sparql.>) sparql.rdfbox_create_from_float('65534.5'::float4)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_integer('18446744073709551615'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_byte('-128'::int2) operator(sparql.<=) sparql.rdfbox_create_from_negativeinteger('-128'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedbyte('255'::int2) operator(sparql.<=) sparql.rdfbox_create_from_byte('127'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_unsignedint('4294967295'::int8) operator(sparql.<=) sparql.rdfbox_create_from_decimal('4294967295.0'::decimal)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_double('1.8446744073709552e19'::float8)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_unsignedshort('65535'::int4) operator(sparql.>=) sparql.rdfbox_create_from_short('32767'::int2)" {
  expect_output 't'
}

@test "op: sparql.rdfbox_create_from_byte('-1'::int2) operator(sparql.>=) sparql.rdfbox_create_from_unsignedbyte('0'::int2)" {
  expect_output 'f'
}

@test "op: sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal)" {
  expect_output 't'
}
