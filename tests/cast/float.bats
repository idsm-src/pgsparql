load ../psql_tests.bash



@test "sparql.cast_as_float_from_boolean('f'::bool)" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_boolean('t'::bool)" {
  expect_output '1'
}

@test "sparql.cast_as_float_from_short('-32768'::int2)" {
  expect_output '-32768'
}

@test "sparql.cast_as_float_from_short('32767'::int2)" {
  expect_output '32767'
}

@test "sparql.cast_as_float_from_int('-2147483648'::int4)" {
  expect_output '-2.1474836e+09'
}

@test "sparql.cast_as_float_from_int('2147483647'::int4)" {
  expect_output '2.1474836e+09'
}

@test "sparql.cast_as_float_from_long('-9223372036854775808'::int8)" {
  expect_output '-9.223372e+18'
}

@test "sparql.cast_as_float_from_long('9223372036854775807'::int8)" {
  expect_output '9.223372e+18'
}

@test "sparql.cast_as_float_from_integer('-1000000000000000000000000000000000000000'::decimal)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_integer('-340282346600000000000000000000000000000'::decimal)" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_integer('340282346600000000000000000000000000000'::decimal)" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_integer('1000000000000000000000000000000000000000'::decimal)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_decimal('-1000000000000000000000000000000000000000'::decimal)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_decimal('-340282346600000000000000000000000000000'::decimal)" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_decimal('-0.00000000000000000000000000000000000001175494351'::decimal)" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_float_from_decimal('-0.0000000000000000000000000000000000000000000001'::decimal)" {
  expect_output '-0'
}

@test "sparql.cast_as_float_from_decimal('0.0000000000000000000000000000000000000000000001'::decimal)" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_decimal('0.00000000000000000000000000000000000001175494351'::decimal)" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_float_from_decimal('340282346600000000000000000000000000000'::decimal)" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_decimal('1000000000000000000000000000000000000000'::decimal)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_double('-inf'::float8)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_double('-1e39'::float8)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_double('-3.402823466e38'::float8)" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_double('-1.175494351e-38'::float8)" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_float_from_double('-1e-46'::float8)" {
  expect_output '-0'
}

@test "sparql.cast_as_float_from_double('1e-46'::float8)" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_double('1.175494351e-38'::float8)" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_float_from_double('3.402823466e38'::float8)" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_double('1e39'::float8)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_double('inf'::float8)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_string(' -INF '::varchar)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_string(' -1e39 '::varchar)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_string(' -3.402823466e38 '::varchar)" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_string(' -1.175494351e-38 '::varchar)" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_float_from_string(' -1e-46 '::varchar)" {
  expect_output '-0'
}

@test "sparql.cast_as_float_from_string(' 1e-46 '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_string(' 1.175494351e-38 '::varchar)" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_float_from_string(' 3.402823466e38 '::varchar)" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_string(' 1e39 '::varchar)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_string(' INF '::varchar)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_string(' .0 '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_string(' .0e-0 '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_string(' e1 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_float_from_string(' inf '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_float_from_string(' -1000000000000000000000000000000000000000 '::varchar)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_string(' -340282346600000000000000000000000000000 '::varchar)" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_string(' -0.00000000000000000000000000000000000001175494351 '::varchar)" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_float_from_string(' -0.0000000000000000000000000000000000000000000001 '::varchar)" {
  expect_output '-0'
}

@test "sparql.cast_as_float_from_string(' 0.0000000000000000000000000000000000000000000001 '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_string(' 0.00000000000000000000000000000000000001175494351 '::varchar)" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_float_from_string(' 340282346600000000000000000000000000000 '::varchar)" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_string(' 1000000000000000000000000000000000000000 '::varchar)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_string(' '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_float_from_string(''::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '1'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2.1474836e+09'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '2.1474836e+09'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '-9.223372e+18'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '9.223372e+18'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_integer('-1000000000000000000000000000000000000000'::decimal))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_integer('-340282346600000000000000000000000000000'::decimal))" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_integer('340282346600000000000000000000000000000'::decimal))" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_integer('1000000000000000000000000000000000000000'::decimal))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_decimal('-1000000000000000000000000000000000000000'::decimal))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_decimal('-340282346600000000000000000000000000000'::decimal))" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_decimal('-0.00000000000000000000000000000000000001175494351'::decimal))" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_decimal('-0.0000000000000000000000000000000000000000000001'::decimal))" {
  expect_output '-0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_decimal('0.0000000000000000000000000000000000000000000001'::decimal))" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_decimal('0.00000000000000000000000000000000000001175494351'::decimal))" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_decimal('340282346600000000000000000000000000000'::decimal))" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_decimal('1000000000000000000000000000000000000000'::decimal))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('-1e39'::float8))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('-3.402823466e38'::float8))" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('-1.175494351e-38'::float8))" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('-1e-46'::float8))" {
  expect_output '-0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('1e-46'::float8))" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('1.175494351e-38'::float8))" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('3.402823466e38'::float8))" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('1e39'::float8))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -INF '::varchar))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -1e39 '::varchar))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -3.402823466e38 '::varchar))" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -1.175494351e-38 '::varchar))" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -1e-46 '::varchar))" {
  expect_output '-0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' 1e-46 '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' 1.175494351e-38 '::varchar))" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' 3.402823466e38 '::varchar))" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' 1e39 '::varchar))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' INF '::varchar))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' .0 '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' .0e-0 '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' e1 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' inf '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -1000000000000000000000000000000000000000 '::varchar))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -340282346600000000000000000000000000000 '::varchar))" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -0.00000000000000000000000000000000000001175494351 '::varchar))" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' -0.0000000000000000000000000000000000000000000001 '::varchar))" {
  expect_output '-0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' 0.0000000000000000000000000000000000000000000001 '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' 0.00000000000000000000000000000000000001175494351 '::varchar))" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' 340282346600000000000000000000000000000 '::varchar))" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' 1000000000000000000000000000000000000000 '::varchar))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_float('1.402823466e38'::float4))" {
  expect_output '1.4028234e+38'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_float_from_rdfbox(sparql.rdfbox_create_from_iri(' http://123.org '::varchar))" {
  expect_output ''
}
