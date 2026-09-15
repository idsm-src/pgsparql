load ../psql_tests.bash



####
# rdfbox_get_float()
#

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '-Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-inf'::float4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-inf'::float4), 'false'::bool)" {
  expect_output '-Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-inf'::float4, ''::varchar))" {
  expect_output '-Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-inf'::float4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-inf'::float4, ''::varchar), 'false'::bool)" {
  expect_output '-Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-inf'::float4, ' -INF '::varchar))" {
  expect_output '-Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-inf'::float4, ' -INF '::varchar), 'true'::bool)" {
  expect_output '-Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-inf'::float4, ' -INF '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '-3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-3.402823466e38'::float4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-3.402823466e38'::float4), 'false'::bool)" {
  expect_output '-3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-3.402823466e38'::float4, ''::varchar))" {
  expect_output '-3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-3.402823466e38'::float4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-3.402823466e38'::float4, ''::varchar), 'false'::bool)" {
  expect_output '-3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-3.402823466e38'::float4, ' -3.4028235E38 '::varchar))" {
  expect_output '-3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-3.402823466e38'::float4, ' -3.4028235E38 '::varchar), 'true'::bool)" {
  expect_output '-3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-3.402823466e38'::float4, ' -3.4028235E38 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '-1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4), 'false'::bool)" {
  expect_output '-1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-1.175494351e-38'::float4, ''::varchar))" {
  expect_output '-1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-1.175494351e-38'::float4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-1.175494351e-38'::float4, ''::varchar), 'false'::bool)" {
  expect_output '-1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-1.175494351e-38'::float4, ' -1.1754944E-38 '::varchar))" {
  expect_output '-1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-1.175494351e-38'::float4, ' -1.1754944E-38 '::varchar), 'true'::bool)" {
  expect_output '-1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('-1.175494351e-38'::float4, ' -1.1754944E-38 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('1.175494351e-38'::float4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('1.175494351e-38'::float4), 'false'::bool)" {
  expect_output '1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('1.175494351e-38'::float4, ''::varchar))" {
  expect_output '1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('1.175494351e-38'::float4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('1.175494351e-38'::float4, ''::varchar), 'false'::bool)" {
  expect_output '1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('1.175494351e-38'::float4, ' 1.1754944E-38 '::varchar))" {
  expect_output '1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('1.175494351e-38'::float4, ' 1.1754944E-38 '::varchar), 'true'::bool)" {
  expect_output '1.1754944e-38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('1.175494351e-38'::float4, ' 1.1754944E-38 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'false'::bool)" {
  expect_output '3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar))" {
  expect_output '3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), 'false'::bool)" {
  expect_output '3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar))" {
  expect_output '3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), 'true'::bool)" {
  expect_output '3.4028235e+38'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output 'Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('inf'::float4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('inf'::float4), 'false'::bool)" {
  expect_output 'Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('inf'::float4, ''::varchar))" {
  expect_output 'Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('inf'::float4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('inf'::float4, ''::varchar), 'false'::bool)" {
  expect_output 'Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('inf'::float4, ' INF '::varchar))" {
  expect_output 'Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('inf'::float4, ' INF '::varchar), 'true'::bool)" {
  expect_output 'Infinity'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('inf'::float4, ' INF '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output 'NaN'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('nan'::float4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('nan'::float4), 'false'::bool)" {
  expect_output 'NaN'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('nan'::float4, ''::varchar))" {
  expect_output 'NaN'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('nan'::float4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('nan'::float4, ''::varchar), 'false'::bool)" {
  expect_output 'NaN'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('nan'::float4, ' NaN '::varchar))" {
  expect_output 'NaN'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('nan'::float4, ' NaN '::varchar), 'true'::bool)" {
  expect_output 'NaN'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_float_with_lexical('nan'::float4, ' NaN '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean('t'::bool), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean('t'::bool), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short('32767'::int2), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short('32767'::int2), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int('2147483647'::int4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int('2147483647'::int4), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_string('abc'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_string('abc'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_float(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'false'::bool)" {
  expect_output '(null)'
}
