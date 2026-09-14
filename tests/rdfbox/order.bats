load ../psql_tests.bash



####
# operator =
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.@=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.@=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.@=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.@=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.@=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.@=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.@=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.@=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.@=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.@=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.@=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.@=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.@=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.@=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.@=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.@=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.@=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@=) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@=) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.@=) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 'f'
}



####
# operator <>
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.@<>) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<>) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<>) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@<>) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@<>) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@<>) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.@<>) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.@<>) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.@<>) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.@<>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<>) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<>) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.@<>) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@<>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@<>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.@<>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.@<>) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@<>) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@<>) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@<>) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.@<>) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.@<>) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.@<>) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.@<>) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.@<>) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.@<>) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.@<>) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<>) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@<>) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@<>) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.@<>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.@<>) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@<>) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@<>) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.@<>) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}



####
# operator <
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.@<) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@<) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@<) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@<) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.@<) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.@<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.@<) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@<) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@<) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@<) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.@<) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.@<) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.@<) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.@<) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.@<) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@<) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@<) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 'f'
}



####
# operator >
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.@>) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@>) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@>) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@>) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@>) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@>) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@>) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@>) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.@>) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.@>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@>) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.@>) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@>) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@>) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@>) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.@>) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.@>) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.@>) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.@>) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.@>) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.@>) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.@>) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@>) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@>) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@>) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.@>) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.@>) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@>) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@>) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.@>) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}



####
# operator <=
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.@<=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@<=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@<=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@<=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.@<=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.@<=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.@<=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.@<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.@<=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.@<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@<=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.@<=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@<=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@<=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@<=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.@<=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.@<=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.@<=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.@<=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.@<=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.@<=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.@<=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@<=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@<=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@<=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.@<=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.@<=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@<=) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@<=) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.@<=) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 'f'
}



####
# operator >=
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.@>=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@>=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@>=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@>=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@>=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@>=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.@>=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.@>=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.@>=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.@>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@>=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@>=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.@>=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.@>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@>=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.@>=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@>=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@>=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@>=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.@>=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.@>=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.@>=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.@>=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.@>=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.@>=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.@>=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@>=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@>=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@>=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.@>=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.@>=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@>=) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@>=) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.@>=) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}



####
# operator rdfbox_order_compare
#

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_boolean('f'::bool), sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_boolean('t'::bool), sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_boolean('t'::bool), sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '0'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_short('2'::int2), sparql.rdfbox_create_from_short('4'::int2))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_short('4'::int2), sparql.rdfbox_create_from_int('2'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_short('2'::int2), sparql.rdfbox_create_from_long('2'::int8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_integer('12'::decimal), sparql.rdfbox_create_from_int('4'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_decimal('-14'::decimal), sparql.rdfbox_create_from_int('-14'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_integer('-4'::decimal), sparql.rdfbox_create_from_float('-4'::float4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_integer('-2'::decimal), sparql.rdfbox_create_from_double('4'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_float('NaN'::float4), sparql.rdfbox_create_from_float('NaN'::float4))" {
  expect_output '0'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_float('NaN'::float4), sparql.rdfbox_create_from_float('4'::float4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_float('2'::float4), sparql.rdfbox_create_from_float('NaN'::float4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_double('NaN'::float8), sparql.rdfbox_create_from_double('NaN'::float8))" {
  expect_output '0'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_double('NaN'::float8), sparql.rdfbox_create_from_double('4'::float8))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_double('2'::float8), sparql.rdfbox_create_from_double('NaN'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_float('NaN'::float4), sparql.rdfbox_create_from_double('NaN'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4), sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4), sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4), sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4), sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4), sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4), sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4), sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4), sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('ab'::varchar))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '0'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_string('a'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_boolean('t'::bool), sparql.rdfbox_create_from_short('4'::int2))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_short('4'::int2), sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4), sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_string('2'::varchar), sparql.rdfbox_create_from_double('4'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_string('b'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string('0'::varchar))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_string('0'::varchar), sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output '1'
}



####
# total order operators
#

@test "sparql.rdfbox_create_from_int('3'::int4) operator(sparql.@<) sparql.rdfbox_create_from_decimal('3.5'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('3.5'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_int('3'::int4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('16777216'::float4) operator(sparql.@<) sparql.rdfbox_create_from_double('16777216.5'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('16777216.5'::float8) operator(sparql.@<) sparql.rdfbox_create_from_integer('16777217'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('16777216'::float4) operator(sparql.@<) sparql.rdfbox_create_from_integer('16777217'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('16777217'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_float('16777216'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_long('9223372036854775807'::int8) operator(sparql.@<) sparql.rdfbox_create_from_double('9223372036854775807'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('9223372036854775807'::float8) operator(sparql.@>) sparql.rdfbox_create_from_long('9223372036854775807'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_long('-9223372036854775808'::int8) operator(sparql.@<) sparql.rdfbox_create_from_double('-9223372036854775808'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_long('9007199254740993'::int8) operator(sparql.@>) sparql.rdfbox_create_from_decimal('9007199254740992.9'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_long('1152921504606846977'::int8) operator(sparql.@>) sparql.rdfbox_create_from_double('1152921504606846976'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('0.1'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_double('0.1'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('0.3'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_double('0.3'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('0.1000000000000000055511151231257827021181583404541015625'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_double('0.1'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('0.1000000000000000055511151231257827021181583404541015626'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_double('0.1'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('0.5'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_double('0.5'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('0.5'::float8) operator(sparql.@>) sparql.rdfbox_create_from_decimal('0.5'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('1e400'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_double('Infinity'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('1e400'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_double('1.7976931348623157e308'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('-1e400'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_double('-Infinity'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('1e-310'::decimal) operator(sparql.@>) sparql.rdfbox_create_from_double('0'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('1e-310'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_double('1e-300'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('1e-330'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_double('5e-324'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@>) sparql.rdfbox_create_from_decimal('1e400'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@>) sparql.rdfbox_create_from_double('Infinity'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('1'::int2) operator(sparql.@<) sparql.rdfbox_create_from_int('1'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_int('1'::int4) operator(sparql.@<) sparql.rdfbox_create_from_long('1'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_long('1'::int8) operator(sparql.@<) sparql.rdfbox_create_from_integer('1'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('1'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_decimal('1'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('1'::decimal) operator(sparql.@<) sparql.rdfbox_create_from_float('1'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('1'::float4) operator(sparql.@<) sparql.rdfbox_create_from_double('1'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_integer('16777217'::decimal), sparql.rdfbox_create_from_float('16777216'::float4))" {
  expect_output '1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_float('16777216'::float4), sparql.rdfbox_create_from_double('16777216.5'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_double('16777216.5'::float8), sparql.rdfbox_create_from_integer('16777217'::decimal))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_decimal('0.5'::decimal), sparql.rdfbox_create_from_double('0.5'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_decimal('0.1000000000000000055511151231257827021181583404541015625'::decimal), sparql.rdfbox_create_from_double('0.1'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_decimal('0.1000000000000000055511151231257827021181583404541015624'::decimal), sparql.rdfbox_create_from_double('0.1'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_decimal('0.1000000000000000055511151231257827021181583404541015626'::decimal), sparql.rdfbox_create_from_double('0.1'::float8))" {
  expect_output '1'
}

@test "(select string_agg(x::text, ' ' order by x) from unnest(array[sparql.rdfbox_create_from_integer('16777217'::decimal), sparql.rdfbox_create_from_float('16777216'::float4), sparql.rdfbox_create_from_double('16777216.5'::float8)]) x)" {
  expect_output '"1.6777216E7"^^<http://www.w3.org/2001/XMLSchema#float> "1.67772165E7"^^<http://www.w3.org/2001/XMLSchema#double> "16777217"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "(select string_agg(x::text, ' ' order by x) from unnest(array[sparql.rdfbox_create_from_boolean('f'::bool), sparql.rdfbox_create_from_double('2.5'::float8), sparql.rdfbox_create_from_int('3'::int4), sparql.rdfbox_create_from_decimal('2.5'::decimal), sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4), sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4), sparql.rdfbox_create_from_daytimeduration('60000000'::int8), sparql.rdfbox_create_from_string('b'::varchar), sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar), sparql.rdfbox_create_from_typedliteral('x'::varchar, 'http://example.org/type'::varchar), sparql.rdfbox_create_from_iri('http://example.org/b'::varchar), sparql.rdfbox_create_from_iri('http://example.org/a'::varchar), sparql.rdfbox_create_from_iblanknode('7'::int8), sparql.rdfbox_create_from_sblanknode('x'::varchar), sparql.rdfbox_create_from_float('NaN'::float4), sparql.rdfbox_create_from_long('-1'::int8)]) x)" {
  expect_output '_:sx _:i0000000000000007 <http://example.org/a> <http://example.org/b> "x"^^<http://example.org/type> "a"@en "b"^^<http://www.w3.org/2001/XMLSchema#string> "PT1M"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration> "2022-10-05Z"^^<http://www.w3.org/2001/XMLSchema#date> "2022-10-05T10:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime> "-1"^^<http://www.w3.org/2001/XMLSchema#long> "2.5"^^<http://www.w3.org/2001/XMLSchema#decimal> "2.5E0"^^<http://www.w3.org/2001/XMLSchema#double> "3"^^<http://www.w3.org/2001/XMLSchema#int> "NaN"^^<http://www.w3.org/2001/XMLSchema#float> "false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}



####
# sign of zero and NaN
#

@test "sparql.rdfbox_create_from_float('-0.0'::float4) operator(sparql.@=) sparql.rdfbox_create_from_float('0.0'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('-0.0'::float4) operator(sparql.@<) sparql.rdfbox_create_from_float('0.0'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('0.0'::float4) operator(sparql.@>) sparql.rdfbox_create_from_float('-0.0'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('-0.0'::float8) operator(sparql.@<>) sparql.rdfbox_create_from_double('0.0'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_double('-0.0'::float8), sparql.rdfbox_create_from_double('0.0'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_create_from_float('-0.0'::float4) operator(sparql.@<) sparql.rdfbox_create_from_double('0.0'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('-0.0'::float8) operator(sparql.@>) sparql.rdfbox_create_from_float('0.0'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@=) sparql.rdfbox_create_from_double('-NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_double('NaN'::float8), sparql.rdfbox_create_from_double('-NaN'::float8))" {
  expect_output '0'
}



####
# lexical forms
#

@test "sparql.rdfbox_create_from_int('1'::int4) operator(sparql.@=) sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_int('1'::int4) operator(sparql.@<>) sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_int('1'::int4) operator(sparql.@<) sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_int_with_lexical('1'::int4, '001'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar) operator(sparql.@=) sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar) operator(sparql.@<) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_int_with_lexical('2'::int4, '02'::varchar) operator(sparql.@>) sparql.rdfbox_create_from_int('1'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_int('1'::int4), sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar))" {
  expect_output '-1'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_int_with_lexical('1'::int4, '01'::varchar), sparql.rdfbox_create_from_int_with_lexical('1'::int4, '001'::varchar))" {
  expect_output '1'
}

@test "sparql.rdfbox_create_from_double('1'::float8) operator(sparql.@=) sparql.rdfbox_create_from_double_with_lexical('1'::float8, '1.0'::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('1'::float8) operator(sparql.@<) sparql.rdfbox_create_from_double_with_lexical('1'::float8, '1.0'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('1.0'::decimal) operator(sparql.@=) sparql.rdfbox_create_from_decimal('1.00'::decimal)" {
  expect_output 't'
}

@test "sparql.rdfbox_order_compare(sparql.rdfbox_create_from_decimal('1.0'::decimal), sparql.rdfbox_create_from_decimal('1.00'::decimal))" {
  expect_output '0'
}

@test "'\"1.00\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox operator(sparql.@=) '\"1.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "'\"1.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox operator(sparql.@<) '\"1.00\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output 't'
}

@test "'\"01\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox operator(sparql.@=) '\"1\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "'\"1\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox operator(sparql.@<) '\"01\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output 't'
}

@test "'\"true\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox operator(sparql.@=) '\"1\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "'\"true\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox operator(sparql.@<) '\"1\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output 't'
}

@test "'\"2022-10-05T10:00:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox operator(sparql.@=) '\"2022-10-05T10:00:00+00:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output 'f'
}

@test "'\"2022-10-05T10:00:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox operator(sparql.@<) '\"2022-10-05T10:00:00+00:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output 't'
}
