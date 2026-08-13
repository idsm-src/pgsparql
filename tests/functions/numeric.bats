load ../psql_tests.bash



####
# abs()
#

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '"32768"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '"32767"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '"2147483648"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '"2147483647"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '"9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_integer('-9223372036854775808'::decimal))" {
  expect_output '"9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_integer('9223372036854775807'::decimal))" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_decimal('-92233720.36854775808'::decimal))" {
  expect_output '"92233720.36854775808"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_decimal('92233720.36854775807'::decimal))" {
  expect_output '"92233720.36854775807"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '"3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '"1.1754944E-38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('-1234.75'::float4))" {
  expect_output '"1.23475E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('-1234.5'::float4))" {
  expect_output '"1.2345E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('-1234.25'::float4))" {
  expect_output '"1.23425E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('-0.0'::float4))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('0.0'::float4))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('1234.25'::float4))" {
  expect_output '"1.23425E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('1234.5'::float4))" {
  expect_output '"1.2345E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('1234.75'::float4))" {
  expect_output '"1.23475E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '"1.1754944E-38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '"3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8))" {
  expect_output '"1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8))" {
  expect_output '"2.2250738585072014E-308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('-1234.75'::float8))" {
  expect_output '"1.23475E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('-1234.5'::float8))" {
  expect_output '"1.2345E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('-1234.25'::float8))" {
  expect_output '"1.23425E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('-0.0'::float8))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('0.0'::float8))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('1234.25'::float8))" {
  expect_output '"1.23425E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('1234.5'::float8))" {
  expect_output '"1.2345E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('1234.75'::float8))" {
  expect_output '"1.23475E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8))" {
  expect_output '"2.2250738585072014E-308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '"1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.abs_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}



####
# round()
#

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '"-32768"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '"32767"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '"-2147483648"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '"2147483647"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_integer('-9223372036854775808'::decimal))" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_integer('9223372036854775807'::decimal))" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_decimal('-92233720.36854775808'::decimal))" {
  expect_output '"-92233720.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_decimal('92233720.36854775807'::decimal))" {
  expect_output '"92233720.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '"-3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('-1234.75'::float4))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('-1234.5'::float4))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('-1234.25'::float4))" {
  expect_output '"-1.234E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('-0.0'::float4))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('0.0'::float4))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('1234.25'::float4))" {
  expect_output '"1.234E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('1234.5'::float4))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('1234.75'::float4))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '"3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8))" {
  expect_output '"-1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('-1234.75'::float8))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('-1234.5'::float8))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('-1234.25'::float8))" {
  expect_output '"-1.234E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('-0.0'::float8))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('0.0'::float8))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('1234.25'::float8))" {
  expect_output '"1.234E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('1234.5'::float8))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('1234.75'::float8))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '"1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.round_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}



####
# ceil()
#

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '"-32768"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '"32767"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '"-2147483648"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '"2147483647"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_integer('-9223372036854775808'::decimal))" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_integer('9223372036854775807'::decimal))" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_decimal('-92233720.36854775808'::decimal))" {
  expect_output '"-92233720.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_decimal('92233720.36854775807'::decimal))" {
  expect_output '"92233721.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '"-3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('-1234.75'::float4))" {
  expect_output '"-1.234E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('-1234.5'::float4))" {
  expect_output '"-1.234E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('-1234.25'::float4))" {
  expect_output '"-1.234E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('-0.0'::float4))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('0.0'::float4))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('1234.25'::float4))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('1234.5'::float4))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('1234.75'::float4))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '"1.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '"3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8))" {
  expect_output '"-1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('-1234.75'::float8))" {
  expect_output '"-1.234E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('-1234.5'::float8))" {
  expect_output '"-1.234E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('-1234.25'::float8))" {
  expect_output '"-1.234E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('-0.0'::float8))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('0.0'::float8))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('1234.25'::float8))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('1234.5'::float8))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('1234.75'::float8))" {
  expect_output '"1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8))" {
  expect_output '"1.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '"1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.ceil_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}



####
# floor()
#

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '"-32768"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '"32767"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '"-2147483648"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '"2147483647"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_integer('-9223372036854775808'::decimal))" {
  expect_output '"-9223372036854775808"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_integer('9223372036854775807'::decimal))" {
  expect_output '"9223372036854775807"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_decimal('-92233720.36854775808'::decimal))" {
  expect_output '"-92233721.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_decimal('92233720.36854775807'::decimal))" {
  expect_output '"92233720.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '"-3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '"-1.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('-1234.75'::float4))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('-1234.5'::float4))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('-1234.25'::float4))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('-0.0'::float4))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('0.0'::float4))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('1234.25'::float4))" {
  expect_output '"1.234E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('1234.5'::float4))" {
  expect_output '"1.234E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('1234.75'::float4))" {
  expect_output '"1.234E3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '"3.4028235E38"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8))" {
  expect_output '"-1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8))" {
  expect_output '"-1.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('-1234.75'::float8))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('-1234.5'::float8))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('-1234.25'::float8))" {
  expect_output '"-1.235E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('-0.0'::float8))" {
  expect_output '"-0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('0.0'::float8))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('1234.25'::float8))" {
  expect_output '"1.234E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('1234.5'::float8))" {
  expect_output '"1.234E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('1234.75'::float8))" {
  expect_output '"1.234E3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8))" {
  expect_output '"0.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '"1.7976931348623157E308"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.floor_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}
