load ../psql_tests.bash



@test "fn: sparql.cast_as_negativeinteger_from_boolean('f'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_boolean('t'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_byte('-128'::int2)" {
  expect_output '-128'
}

@test "fn: sparql.cast_as_negativeinteger_from_byte('-1'::int2)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_byte('0'::int2)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_byte('127'::int2)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_unsignedbyte('0'::int2)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_unsignedbyte('255'::int2)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_short('-32768'::int2)" {
  expect_output '-32768'
}

@test "fn: sparql.cast_as_negativeinteger_from_short('-1'::int2)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_short('0'::int2)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_short('32767'::int2)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_unsignedshort('0'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_unsignedshort('65535'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_int('-2147483648'::int4)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_negativeinteger_from_int('-1'::int4)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_int('0'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_int('2147483647'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_unsignedint('0'::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_unsignedint('4294967295'::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_long('-9223372036854775808'::int8)" {
  expect_output '-9223372036854775808'
}

@test "fn: sparql.cast_as_negativeinteger_from_long('-1'::int8)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_long('0'::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_long('9223372036854775807'::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_unsignedlong('0'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_unsignedlong('18446744073709551615'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_nonpositiveinteger('-18446744073709551616'::decimal)" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.cast_as_negativeinteger_from_nonpositiveinteger('0'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_nonnegativeinteger('0'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_nonnegativeinteger('18446744073709551616'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_positiveinteger('1'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_positiveinteger('18446744073709551616'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_integer('-infinity'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_integer('-18446744073709551616'::decimal)" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.cast_as_negativeinteger_from_integer('-1'::decimal)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_integer('0'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_integer('1'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_integer('18446744073709551616'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_integer('infinity'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_integer('nan'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_decimal('-infinity'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_decimal('-1.9'::decimal)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_decimal('-0.9'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_decimal('0.9'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_decimal('1.9'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_decimal('18446744073709551616.9'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_decimal('infinity'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_decimal('nan'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('-inf'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('-1.5'::float4)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('-0.5'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('0'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('0.5'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('1.5'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('1e15'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('9007199254740992'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('18446744073709551616'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('inf'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_float('nan'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('-inf'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('-1.5'::float8)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('-0.5'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('0'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('0.5'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('1.5'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('1e15'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('9007199254740992'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('18446744073709551616'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('inf'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_double('nan'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' -infinity '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' -18446744073709551616 '::varchar)" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' -1 '::varchar)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' -0 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' 0 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' +1 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' 007 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' 18446744073709551616 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' 1e2 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' 10.0 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(' '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_string(''::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_byte('-128'::int2))" {
  expect_output '-128'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_byte('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_byte('0'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_byte('127'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_unsignedbyte('0'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_short('0'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_unsignedshort('0'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_int('0'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_unsignedint('0'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '-9223372036854775808'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_long('0'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_unsignedlong('0'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal))" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal))" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_negativeinteger('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_nonnegativeinteger('18446744073709551616'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_integer('-infinity'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_integer('-18446744073709551616'::decimal))" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_integer('0'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_integer('18446744073709551616'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_integer('infinity'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_integer('nan'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_decimal('-infinity'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_decimal('-1.9'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_decimal('-0.9'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_decimal('0.9'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_decimal('1.9'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_decimal('18446744073709551616.9'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_decimal('infinity'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_decimal('nan'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_string(' 1 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_string(' 1.0 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_negativeinteger_from_rdfbox(sparql.rdfbox_create_from_iri('http://123.org'::varchar))" {
  expect_output '(null)'
}
