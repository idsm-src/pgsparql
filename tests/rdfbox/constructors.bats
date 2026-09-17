load ../psql_tests.bash



@test "fn: sparql.rdfbox_create_from_boolean('f'::bool)" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.rdfbox_create_from_boolean_with_lexical('f'::bool, ''::varchar)" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.rdfbox_create_from_boolean_with_lexical('f'::bool, ' false '::varchar)" {
  expect_output '" false "^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.rdfbox_create_from_boolean('t'::bool)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar)" {
  expect_output '" true "^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.rdfbox_create_from_short('-32768'::int2)" {
  expect_output '"-32768"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.rdfbox_create_from_short_with_lexical('-32768'::int2, ''::varchar)" {
  expect_output '"-32768"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.rdfbox_create_from_short_with_lexical('-32768'::int2, ' -32768 '::varchar)" {
  expect_output '" -32768 "^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.rdfbox_create_from_short('32767'::int2)" {
  expect_output '"32767"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar)" {
  expect_output '"32767"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar)" {
  expect_output '" 32767 "^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.rdfbox_create_from_int('-2147483648'::int4)" {
  expect_output '"-2147483648"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.rdfbox_create_from_int_with_lexical('-2147483648'::int4, ''::varchar)" {
  expect_output '"-2147483648"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.rdfbox_create_from_int_with_lexical('-2147483648'::int4, ' -2147483648 '::varchar)" {
  expect_output '" -2147483648 "^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.rdfbox_create_from_int('2147483647'::int4)" {
  expect_output '"2147483647"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar)" {
  expect_output '"2147483647"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar)" {
  expect_output '" 2147483647 "^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.rdfbox_create_from_long('-9223372036854775808'::int8)" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "fn: sparql.rdfbox_create_from_long_with_lexical('-9223372036854775808'::int8, ''::varchar)" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "fn: sparql.rdfbox_create_from_long_with_lexical('-9223372036854775808'::int8, ' -9223372036854775808 '::varchar)" {
  expect_output '" -9223372036854775808 "^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "fn: sparql.rdfbox_create_from_long('9223372036854775807'::int8)" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "fn: sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar)" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "fn: sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar)" {
  expect_output '" 9223372036854775807 "^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "fn: sparql.rdfbox_create_from_integer('-9223372036854775809'::decimal)" {
  expect_output '"-9223372036854775809"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.rdfbox_create_from_integer_with_lexical('-9223372036854775809'::decimal, ''::varchar)" {
  expect_output '"-9223372036854775809"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.rdfbox_create_from_integer_with_lexical('-9223372036854775809'::decimal, ' -9223372036854775809 '::varchar)" {
  expect_output '" -9223372036854775809 "^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.rdfbox_create_from_integer('9223372036854775808'::decimal)" {
  expect_output '"9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar)" {
  expect_output '"9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar)" {
  expect_output '" 9223372036854775808 "^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.rdfbox_create_from_decimal('-9223372036854775809.876'::decimal)" {
  expect_output '"-9223372036854775809.876"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.rdfbox_create_from_decimal_with_lexical('-9223372036854775809.876'::decimal, ''::varchar)" {
  expect_output '"-9223372036854775809.876"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.rdfbox_create_from_decimal_with_lexical('-9223372036854775809.876'::decimal, ' -9223372036854775809.876 '::varchar)" {
  expect_output '" -9223372036854775809.876 "^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal)" {
  expect_output '"9223372036854775808.765"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar)" {
  expect_output '"9223372036854775808.765"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar)" {
  expect_output '" 9223372036854775808.765 "^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.rdfbox_create_from_float('-inf'::float4)" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('-inf'::float4, ''::varchar)" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('-inf'::float4, ' -INF '::varchar)" {
  expect_output '" -INF "^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float('-3.402823466e38'::float4)" {
  expect_output '"-3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('-3.402823466e38'::float4, ''::varchar)" {
  expect_output '"-3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('-3.402823466e38'::float4, ' -3.4028235E38 '::varchar)" {
  expect_output '" -3.4028235E38 "^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float('-1.175494351e-38'::float4)" {
  expect_output '"-1.1754944E-38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('-1.175494351e-38'::float4, ''::varchar)" {
  expect_output '"-1.1754944E-38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('-1.175494351e-38'::float4, ' -1.1754944E-38 '::varchar)" {
  expect_output '" -1.1754944E-38 "^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float('1.175494351e-38'::float4)" {
  expect_output '"1.1754944E-38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('1.175494351e-38'::float4, ''::varchar)" {
  expect_output '"1.1754944E-38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('1.175494351e-38'::float4, ' 1.1754944E-38 '::varchar)" {
  expect_output '" 1.1754944E-38 "^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float('3.402823466e38'::float4)" {
  expect_output '"3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar)" {
  expect_output '"3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar)" {
  expect_output '" 3.4028235E38 "^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float('inf'::float4)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('inf'::float4, ''::varchar)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('inf'::float4, ' INF '::varchar)" {
  expect_output '" INF "^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float('nan'::float4)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('nan'::float4, ''::varchar)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_float_with_lexical('nan'::float4, ' NaN '::varchar)" {
  expect_output '" NaN "^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.rdfbox_create_from_double('-inf'::float8)" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('-inf'::float8, ''::varchar)" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('-inf'::float8, ' -INF '::varchar)" {
  expect_output '" -INF "^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8)" {
  expect_output '"-1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('-1.7976931348623158e308'::float8, ''::varchar)" {
  expect_output '"-1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('-1.7976931348623158e308'::float8, ' -1.7976931348623157E308 '::varchar)" {
  expect_output '" -1.7976931348623157E308 "^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8)" {
  expect_output '"-2.2250738585072014E-308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('-2.2250738585072014e-308'::float8, ''::varchar)" {
  expect_output '"-2.2250738585072014E-308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('-2.2250738585072014e-308'::float8, ' -2.2250738585072014E-308 '::varchar)" {
  expect_output '" -2.2250738585072014E-308 "^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8)" {
  expect_output '"2.2250738585072014E-308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('2.2250738585072014e-308'::float8, ''::varchar)" {
  expect_output '"2.2250738585072014E-308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('2.2250738585072014e-308'::float8, ' 2.2250738585072014E-308 '::varchar)" {
  expect_output '" 2.2250738585072014E-308 "^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8)" {
  expect_output '"1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar)" {
  expect_output '"1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar)" {
  expect_output '" 1.7976931348623157E308 "^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double('inf'::float8)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('inf'::float8, ''::varchar)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('inf'::float8, ' INF '::varchar)" {
  expect_output '" INF "^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double('nan'::float8)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('nan'::float8, ''::varchar)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_double_with_lexical('nan'::float8, ' NaN '::varchar)" {
  expect_output '" NaN "^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.rdfbox_create_from_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '"-0100-02-18T10:22:50Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime, ''::varchar)" {
  expect_output '"-0100-02-18T10:22:50Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime, ' -0100-02-18T10:22:50Z '::varchar)" {
  expect_output '" -0100-02-18T10:22:50Z "^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '"0000-03-16T00:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('0000-03-15T24:00:00'::sparql.zoneddatetime, ''::varchar)" {
  expect_output '"0000-03-16T00:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('0000-03-15T24:00:00'::sparql.zoneddatetime, ' 0000-03-16T00:00:00 '::varchar)" {
  expect_output '" 0000-03-16T00:00:00 "^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '"1990-10-10T00:22:30-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime, ''::varchar)" {
  expect_output '"1990-10-10T00:22:30-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime, ' 1990-10-10T00:22:30-14:00 '::varchar)" {
  expect_output '" 1990-10-10T00:22:30-14:00 "^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '"2010-11-18T00:59:59.99+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar)" {
  expect_output '"2010-11-18T00:59:59.99+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar)" {
  expect_output '" 2010-11-18T00:59:59.99+14:00 "^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '"-0100-02-18T10:22:50Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4, ''::varchar)" {
  expect_output '"-0100-02-18T10:22:50Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4, ' -0100-02-18T10:22:50Z '::varchar)" {
  expect_output '" -0100-02-18T10:22:50Z "^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '"0000-03-16T00:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4, ''::varchar)" {
  expect_output '"0000-03-16T00:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4, ' 0000-03-16T00:00:00 '::varchar)" {
  expect_output '" 0000-03-16T00:00:00 "^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '"1990-10-10T00:22:30-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4, ''::varchar)" {
  expect_output '"1990-10-10T00:22:30-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4, ' 1990-10-10T00:22:30-14:00 '::varchar)" {
  expect_output '" 1990-10-10T00:22:30-14:00 "^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '"2010-11-18T00:59:59.99+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4, ''::varchar)" {
  expect_output '"2010-11-18T00:59:59.99+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4, ' 2010-11-18T00:59:59.99+14:00 '::varchar)" {
  expect_output '" 2010-11-18T00:59:59.99+14:00 "^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.rdfbox_create_from_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '"-0100-02-18Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('-0100-02-18+00:00'::sparql.zoneddate, ''::varchar)" {
  expect_output '"-0100-02-18Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('-0100-02-18+00:00'::sparql.zoneddate, ' -0100-02-18Z '::varchar)" {
  expect_output '" -0100-02-18Z "^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '"0000-03-15"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('0000-03-15'::sparql.zoneddate, ''::varchar)" {
  expect_output '"0000-03-15"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('0000-03-15'::sparql.zoneddate, ' 0000-03-15 '::varchar)" {
  expect_output '" 0000-03-15 "^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '"1990-10-10-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('1990-10-10-14:00'::sparql.zoneddate, ''::varchar)" {
  expect_output '"1990-10-10-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('1990-10-10-14:00'::sparql.zoneddate, ' 1990-10-10-14:00 '::varchar)" {
  expect_output '" 1990-10-10-14:00 "^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '"2010-11-18+14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar)" {
  expect_output '"2010-11-18+14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar)" {
  expect_output '" 2010-11-18+14:00 "^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '"-0100-02-18Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('0101-02-18 BC'::date, '0'::int4, ''::varchar)" {
  expect_output '"-0100-02-18Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('0101-02-18 BC'::date, '0'::int4, ' -0100-02-18Z '::varchar)" {
  expect_output '" -0100-02-18Z "^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '"0000-03-15"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('0001-03-15 BC'::date, '-2147483648'::int4, ''::varchar)" {
  expect_output '"0000-03-15"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('0001-03-15 BC'::date, '-2147483648'::int4, ' 0000-03-15 '::varchar)" {
  expect_output '" 0000-03-15 "^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '"1990-10-10-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('1990-10-10'::date, (-14*60*60)::int4, ''::varchar)" {
  expect_output '"1990-10-10-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('1990-10-10'::date, (-14*60*60)::int4, ' 1990-10-10-14:00 '::varchar)" {
  expect_output '" 1990-10-10-14:00 "^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '"2010-11-18+14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('2010-11-18'::date, (14*60*60)::int4, ''::varchar)" {
  expect_output '"2010-11-18+14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_date_with_lexical('2010-11-18'::date, (14*60*60)::int4, ' 2010-11-18+14:00 '::varchar)" {
  expect_output '" 2010-11-18+14:00 "^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.rdfbox_create_from_daytimeduration('-9223372036854775808'::int8)" {
  expect_output '"-P106751991DT4H54.775808S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "fn: sparql.rdfbox_create_from_daytimeduration_with_lexical('-9223372036854775808'::int8, ''::varchar)" {
  expect_output '"-P106751991DT4H54.775808S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "fn: sparql.rdfbox_create_from_daytimeduration_with_lexical('-9223372036854775808'::int8, ' -P106751991DT4H54.775808S '::varchar)" {
  expect_output '" -P106751991DT4H54.775808S "^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "fn: sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8)" {
  expect_output '"P106751991DT4H54.775807S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "fn: sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar)" {
  expect_output '"P106751991DT4H54.775807S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "fn: sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar)" {
  expect_output '" P106751991DT4H54.775807S "^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "fn: sparql.rdfbox_create_from_string(''::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.rdfbox_create_from_string('abc'::varchar)" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.rdfbox_create_from_iri('http://example.org/dir?query#tag'::varchar)" {
  expect_output '<http://example.org/dir?query#tag>'
}

@test "fn: sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)" {
  expect_output '""@en'
}

@test "fn: sparql.rdfbox_create_from_langstring('abc'::varchar, 'cy'::varchar)" {
  expect_output '"abc"@cy'
}

@test "fn: sparql.rdfbox_create_from_userliteral(''::varchar, 'http://example.org'::varchar)" {
  expect_output "':character varying'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar)" {
  expect_output "'abc:character varying'^^<http://example.org/dir?query#tag>"
}

@test "fn: sparql.rdfbox_create_from_userliteral('123'::int4, 'http://example.org'::varchar)" {
  expect_output "'123:integer'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral('123'::int8, 'http://example.org'::varchar)" {
  expect_output "'123:bigint'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral('1.50'::decimal, 'http://example.org'::varchar)" {
  expect_output "'1.50:numeric'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral('t'::bool, 'http://example.org'::varchar)" {
  expect_output "'t:boolean'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral('2010-11-18'::date, 'http://example.org'::varchar)" {
  expect_output "'2010-11-18:pg_catalog.date'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral('a''b'::varchar, 'http://example.org'::varchar)" {
  expect_output "'a\\'b:character varying'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral('123:integer'::sparql.ubox, 'http://example.org'::varchar)" {
  expect_output "'123:integer'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar)" {
  expect_output "'123:integer:sparql.ubox'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral_with_lexical('123'::int4, 'http://example.org'::varchar, ''::varchar)" {
  expect_output "'123:integer'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral_with_lexical('123'::int4, 'http://example.org'::varchar, ' 123 '::varchar)" {
  expect_output "' 123 :integer'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral_with_lexical('123:integer'::sparql.ubox, 'http://example.org'::varchar, ''::varchar)" {
  expect_output "'123:integer'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral_with_lexical('123:integer'::sparql.ubox, 'http://example.org'::varchar, ' 123 '::varchar)" {
  expect_output "' 123 :integer'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_userliteral_with_lexical(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar, ' 123 '::varchar)" {
  expect_output "' 123 :sparql.ubox'^^<http://example.org>"
}

@test "fn: sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar)" {
  expect_output '""^^<http://example.org>'
}

@test "fn: sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar)" {
  expect_output '"abc"^^<http://example.org/dir?query#tag>'
}

@test "fn: sparql.rdfbox_create_from_iblanknode('-9223372034707292161'::int8)" {
  expect_output '_:i800000007fffffff'
}

@test "fn: sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8)" {
  expect_output '_:i7fffffff80000000'
}

@test "fn: sparql.rdfbox_create_from_iblanknode('2147483647'::int4, '-2147483648'::int4)" {
  expect_output '_:i800000007fffffff'
}

@test "fn: sparql.rdfbox_create_from_iblanknode('-2147483648'::int4, '2147483647'::int4)" {
  expect_output '_:i7fffffff80000000'
}

@test "fn: sparql.rdfbox_create_from_sblanknode('80000000'::varchar)" {
  expect_output '_:s80000000'
}

@test "fn: sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar)" {
  expect_output '_:s7fffffffid'
}

@test "fn: sparql.rdfbox_create_from_sblanknode(''::varchar, '-2147483648'::int4)" {
  expect_output '_:s80000000'
}

@test "fn: sparql.rdfbox_create_from_sblanknode('id'::varchar, '2147483647'::int4)" {
  expect_output '_:s7fffffffid'
}



####
# the one-argument form takes the whole stored value, segment and label together
#

@test "fn: sparql.rdfbox_create_from_sblanknode('00000001'::varchar)" {
  expect_output '_:s00000001'
}

@test "fn: sparql.rdfbox_create_from_sblanknode('00000001label'::varchar)" {
  expect_output '_:s00000001label'
}
