load ../psql_tests.bash



####
# operator === / sameTerm()
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.===) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.===) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('0'::int2) operator(sparql.===) sparql.rdfbox_create_from_short('0'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('0'::int2) operator(sparql.===) sparql.rdfbox_create_from_short('-1'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_int('0'::int4) operator(sparql.===) sparql.rdfbox_create_from_int('0'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_int('0'::int4) operator(sparql.===) sparql.rdfbox_create_from_int('-1'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_long('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_long('0'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_long('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_long('-1'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_integer('0'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_integer('-1'::decimal)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_decimal('0.0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_decimal('0'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('0.0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_decimal('-1'::decimal)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('-0.0'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('+0.0'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('0.0'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('-1'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('-0.0'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('+0.0'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('0.0'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('-1'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.===) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.===) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.===) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00'::sparql.zoneddatetime) operator(sparql.===) sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00'::sparql.zoneddatetime)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00'::sparql.zoneddatetime) operator(sparql.===) sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00Z'::sparql.zoneddatetime)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2000-01-01'::sparql.zoneddate) operator(sparql.===) sparql.rdfbox_create_from_date('2000-01-01'::sparql.zoneddate)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2000-01-01'::sparql.zoneddate) operator(sparql.===) sparql.rdfbox_create_from_date('2000-01-01Z'::sparql.zoneddate)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_daytimeduration('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_daytimeduration('0'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_daytimeduration('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_daytimeduration('-1'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.===) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.===) sparql.rdfbox_create_from_string('-1'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_langstring('0'::varchar, 'en'::varchar) operator(sparql.===) sparql.rdfbox_create_from_langstring('0'::varchar, 'en'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_langstring('0'::varchar, 'en'::varchar) operator(sparql.===) sparql.rdfbox_create_from_langstring('-1'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_typedliteral('0'::varchar, 'http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_typedliteral('-1'::varchar, 'http://example.org'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_iri('http://example.org/'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iblanknode('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iblanknode('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_iblanknode('1'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_sblanknode('00000000'::varchar) operator(sparql.===) sparql.rdfbox_create_from_sblanknode('00000000'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_sblanknode('00000000'::varchar) operator(sparql.===) sparql.rdfbox_create_from_sblanknode('00000001'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_int('0'::int4) operator(sparql.===) sparql.rdfbox_create_from_long('0'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('0'::decimal) operator(sparql.===) sparql.rdfbox_create_from_decimal('0'::decimal)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('0.0'::float4) operator(sparql.===) sparql.rdfbox_create_from_double('0.0'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2000-01-01T00:00:00'::sparql.zoneddatetime) operator(sparql.===) sparql.rdfbox_create_from_date('2000-01-01'::sparql.zoneddate)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.===) sparql.rdfbox_create_from_langstring('-1'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('http://example.org'::varchar) operator(sparql.===) sparql.rdfbox_create_from_iri('http://example.org'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iblanknode('0'::int8) operator(sparql.===) sparql.rdfbox_create_from_sblanknode('00000000'::varchar)" {
  expect_output 'f'
}



####
# operator =
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output ''
}



####
# operator !=
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.!=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.!=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.!=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.!=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.!=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.!=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.!=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.!=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.!=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.!=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.!=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.!=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.!=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.!=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.!=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.!=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.!=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.!=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output ''
}



####
# operator <
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.<) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.<) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.<) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.<) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.<) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.<) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.<) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.<) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.<) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.<) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.<) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.<) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.<) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.<) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.<) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.<) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.<) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.<) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output ''
}



####
# operator >
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.>) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.>) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.>) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.>) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.>) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.>) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.>) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.>) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.>) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.>) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.>) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.>) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.>) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.>) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.>) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.>) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.>) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.>) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output ''
}



####
# operator <=
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.<=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.<=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.<=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.<=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.<=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.<=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.<=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.<=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.<=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.<=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output ''
}



####
# operator >=
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.>=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.>=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.>=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.>=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.>=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.>=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.>=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.>=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.>=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.>=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output ''
}
