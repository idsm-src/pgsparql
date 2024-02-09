load ../psql_tests.bash



@test "sparql.cast_as_double_from_boolean('f'::bool)" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_boolean('t'::bool)" {
  expect_output '1'
}

@test "sparql.cast_as_double_from_short('-32768'::int2)" {
  expect_output '-32768'
}

@test "sparql.cast_as_double_from_short('32767'::int2)" {
  expect_output '32767'
}

@test "sparql.cast_as_double_from_int('-2147483648'::int4)" {
  expect_output '-2147483648'
}

@test "sparql.cast_as_double_from_int('2147483647'::int4)" {
  expect_output '2147483647'
}

@test "sparql.cast_as_double_from_long('-9223372036854775808'::int8)" {
  expect_output '-9.223372036854776e+18'
}

@test "sparql.cast_as_double_from_long('9223372036854775807'::int8)" {
  expect_output '9.223372036854776e+18'
}

@test "sparql.cast_as_double_from_integer('-1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_integer('-179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal)" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_integer('179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal)" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_integer('1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_decimal('-1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_decimal('-179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal)" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_decimal('-0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014'::decimal)" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_decimal('-0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001'::decimal)" {
  expect_output '-0'
}

@test "sparql.cast_as_double_from_decimal('0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001'::decimal)" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_decimal('0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014'::decimal)" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_decimal('179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal)" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_decimal('1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_float('-inf'::float4)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_float('-3.402823466e38'::float4)" {
  expect_output '-3.4028234663852886e+38'
}

@test "sparql.cast_as_double_from_float('-1.175494351e-38'::float4)" {
  expect_output '-1.1754943508222875e-38'
}

@test "sparql.cast_as_double_from_float('1.175494351e-38'::float4)" {
  expect_output '1.1754943508222875e-38'
}

@test "sparql.cast_as_double_from_float('3.402823466e38'::float4)" {
  expect_output '3.4028234663852886e+38'
}

@test "sparql.cast_as_double_from_float('inf'::float4)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_string(' -INF '::varchar)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_string(' -1e309 '::varchar)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_string(' -1.7976931348623158e308 '::varchar)" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_string(' -2.2250738585072014e-308 '::varchar)" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_string(' -1e-324 '::varchar)" {
  expect_output '-0'
}

@test "sparql.cast_as_double_from_string(' 1e-324 '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_string(' 2.2250738585072014e-308 '::varchar)" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_string(' 1.7976931348623158e308 '::varchar)" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_string(' 1e309 '::varchar)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_string(' INF '::varchar)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_string(' .0 '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_string(' .0e-0 '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_string(' e1 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_double_from_string(' inf '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_double_from_string(' -1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 '::varchar)" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_string(' -179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 '::varchar)" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_string(' -0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014 '::varchar)" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_string(' -0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001 '::varchar)" {
  expect_output '-0'
}

@test "sparql.cast_as_double_from_string(' 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001 '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_string(' 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014 '::varchar)" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_string(' 179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 '::varchar)" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_string(' 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 '::varchar)" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_string(' '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_double_from_string(''::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '1'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '-9.223372036854776e+18'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '9.223372036854776e+18'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_integer('-1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_integer('-179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal))" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_integer('179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal))" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_integer('1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_decimal('-1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_decimal('-179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal))" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_decimal('-0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014'::decimal))" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_decimal('-0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001'::decimal))" {
  expect_output '-0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_decimal('0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001'::decimal))" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_decimal('0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014'::decimal))" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_decimal('179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal))" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_decimal('1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'::decimal))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '-3.4028234663852886e+38'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '-1.1754943508222875e-38'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '1.1754943508222875e-38'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '3.4028234663852886e+38'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -INF '::varchar))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -1e309 '::varchar))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -1.7976931348623158e308 '::varchar))" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -2.2250738585072014e-308 '::varchar))" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -1e-324 '::varchar))" {
  expect_output '-0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' 1e-324 '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' 2.2250738585072014e-308 '::varchar))" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' 1.7976931348623158e308 '::varchar))" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' 1e309 '::varchar))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' INF '::varchar))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' .0 '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' .0e-0 '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' e1 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' inf '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 '::varchar))" {
  expect_output '-Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 '::varchar))" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014 '::varchar))" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' -0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001 '::varchar))" {
  expect_output '-0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001 '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' 0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000022250738585072014 '::varchar))" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' 179769313486231580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 '::varchar))" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 '::varchar))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_double('1.402823466e38'::float8))" {
  expect_output '1.402823466e+38'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output 'Infinity'
}

@test "sparql.cast_as_double_from_rdfbox(sparql.rdfbox_create_from_iri(' http://123.org '::varchar))" {
  expect_output ''
}