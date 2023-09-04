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
# operator !=
#

@test "sparql.rdfbox_create_from_boolean('f'::bool) operator(sparql.@!=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@!=) sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@!=) sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@!=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@!=) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.@!=) sparql.rdfbox_create_from_long('2'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('12'::decimal) operator(sparql.@!=) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_decimal('-14'::decimal) operator(sparql.@!=) sparql.rdfbox_create_from_int('-14'::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-4'::decimal) operator(sparql.@!=) sparql.rdfbox_create_from_float('-4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_integer('-2'::decimal) operator(sparql.@!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@!=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@!=) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('2'::float4) operator(sparql.@!=) sparql.rdfbox_create_from_float('NaN'::float4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_double('NaN'::float8) operator(sparql.@!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_double('2'::float8) operator(sparql.@!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_float('NaN'::float4) operator(sparql.@!=) sparql.rdfbox_create_from_double('NaN'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.@!=) sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@!=) sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.@!=) sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@!=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4) operator(sparql.@!=) sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4) operator(sparql.@!=) sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.@!=) sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4) operator(sparql.@!=) sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar) operator(sparql.@!=) sparql.rdfbox_create_from_string('ab'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string(''::varchar) operator(sparql.@!=) sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output 'f'
}

@test "sparql.rdfbox_create_from_string('a'::varchar) operator(sparql.@!=) sparql.rdfbox_create_from_string('b'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool) operator(sparql.@!=) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_short('4'::int2) operator(sparql.@!=) sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.@!=) sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.@!=) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('b'::varchar) operator(sparql.@!=) sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@!=) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_iri('http://example.org'::varchar) operator(sparql.@!=) sparql.rdfbox_create_from_string('0'::varchar)" {
  expect_output 't'
}

@test "sparql.rdfbox_create_from_string('0'::varchar) operator(sparql.@!=) sparql.rdfbox_create_from_iblanknode('0'::int8)" {
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
