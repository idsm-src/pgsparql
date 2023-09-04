load ../psql_tests.bash



@test "sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.rdfbox_create_from_short('-32768'::int2)" {
  expect_output '"-32768"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.rdfbox_create_from_short('32767'::int2)" {
  expect_output '"32767"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.rdfbox_create_from_int('-2147483648'::int4)" {
  expect_output '"-2147483648"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "sparql.rdfbox_create_from_int('2147483647'::int4)" {
  expect_output '"2147483647"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "sparql.rdfbox_create_from_long('-9223372036854775808'::int8)" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "sparql.rdfbox_create_from_long('9223372036854775807'::int8)" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "sparql.rdfbox_create_from_integer('-9223372036854775809'::decimal)" {
  expect_output '"-9223372036854775809"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_integer('9223372036854775808'::decimal)" {
  expect_output '"9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_decimal('-9223372036854775809.876'::decimal)" {
  expect_output '"-9223372036854775809.876"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal)" {
  expect_output '"9223372036854775808.765"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_float('-inf'::float4)" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_float('-3.402823466e38'::float4)" {
  expect_output '"-3.4028235e+38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_float('-1.175494351e-38'::float4)" {
  expect_output '"-1.1754944e-38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_float('1.175494351e-38'::float4)" {
  expect_output '"1.1754944e-38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_float('3.402823466e38'::float4)" {
  expect_output '"3.4028235e+38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_float('inf'::float4)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_float('nan'::float4)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_double('-inf'::float8)" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8)" {
  expect_output '"-1.7976931348623157e+308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8)" {
  expect_output '"-2.2250738585072014e-308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8)" {
  expect_output '"2.2250738585072014e-308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8)" {
  expect_output '"1.7976931348623157e+308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_double('inf'::float8)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_double('nan'::float8)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '"-0100-02-18T10:22:50Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.rdfbox_create_from_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '"0000-03-16T00:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '"1990-10-10T00:22:30-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '"2010-11-18T00:59:59.99+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '"-0100-02-18T10:22:50Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '"0000-03-16T00:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '"1990-10-10T00:22:30-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '"2010-11-18T00:59:59.99+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.rdfbox_create_from_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '"-0100-02-18Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.rdfbox_create_from_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '"0000-03-15"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.rdfbox_create_from_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '"1990-10-10-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '"2010-11-18+14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '"-0100-02-18Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '"0000-03-15"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '"1990-10-10-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '"2010-11-18+14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.rdfbox_create_from_daytimeduration('-9223372036854775808'::int8)" {
  expect_output '"-P106751991DT4H54.775808S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8)" {
  expect_output '"P106751991DT4H54.775807S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.rdfbox_create_from_string('abc'::varchar)" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.rdfbox_create_from_iri('http://example.org/dir?query#tag'::varchar)" {
  expect_output '<http://example.org/dir?query#tag>'
}

@test "sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)" {
  expect_output '""@en'
}

@test "sparql.rdfbox_create_from_langstring('abc'::varchar, 'cy'::varchar)" {
  expect_output '"abc"@cy'
}

@test "sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar)" {
  expect_output '""^^<http://example.org>'
}

@test "sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar)" {
  expect_output '"abc"^^<http://example.org/dir?query#tag>'
}

@test "sparql.rdfbox_create_from_iblanknode('-9223372034707292161'::int8)" {
  expect_output '_:i800000007fffffff'
}

@test "sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8)" {
  expect_output '_:i7fffffff80000000'
}

@test "sparql.rdfbox_create_from_iblanknode('2147483647'::int4, '-2147483648'::int4)" {
  expect_output '_:i800000007fffffff'
}

@test "sparql.rdfbox_create_from_iblanknode('-2147483648'::int4, '2147483647'::int4)" {
  expect_output '_:i7fffffff80000000'
}

@test "sparql.rdfbox_create_from_sblanknode('80000000'::varchar)" {
  expect_output '_:s80000000'
}

@test "sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar)" {
  expect_output '_:s7fffffffid'
}

@test "sparql.rdfbox_create_from_sblanknode(''::varchar, '-2147483648'::int4)" {
  expect_output '_:s80000000'
}

@test "sparql.rdfbox_create_from_sblanknode('id'::varchar, '2147483647'::int4)" {
  expect_output '_:s7fffffffid'
}
