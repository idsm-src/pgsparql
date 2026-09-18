load ../psql_tests.bash



@test "fn: sparql.cast_as_boolean_from_byte('-128'::int2)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_byte('0'::int2)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_byte('127'::int2)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_unsignedbyte('0'::int2)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_unsignedbyte('255'::int2)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_short(0::int2)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_short(1::int2)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_unsignedshort('0'::int4)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_unsignedshort('65535'::int4)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_int(0::int4)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_int(1::int4)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_unsignedint('0'::int8)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_unsignedint('4294967295'::int8)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_long(0::int8)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_long(1::int8)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_unsignedlong('0'::decimal)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_unsignedlong('18446744073709551615'::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_integer(0::decimal)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_integer(1::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_nonpositiveinteger('-18446744073709551616'::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_nonpositiveinteger('0'::decimal)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_negativeinteger('-18446744073709551616'::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_negativeinteger('-1'::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_nonnegativeinteger('0'::decimal)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_nonnegativeinteger('18446744073709551616'::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_positiveinteger('1'::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_positiveinteger('18446744073709551616'::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_decimal(0::decimal)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_decimal(1::decimal)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_float('nan'::float4)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_float(0::float4)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_float(1::float4)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_double('nan'::float8)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_double(0::float8)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_double(1::float8)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_string(' 1 '::varchar)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_string(' true '::varchar)" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_string(' TRUE '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_string(' 0 '::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_string(' false '::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_string(' FALSE '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_string(' '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_string(''::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_short(0::int2))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_short(1::int2))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_int(0::int4))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_int(1::int4))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_long(0::int8))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_long(1::int8))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_integer(0::decimal))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_integer(1::decimal))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_decimal(0::decimal))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_decimal(1::decimal))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_float(0::float4))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_float(1::float4))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_double(0::float8))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_double(1::float8))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' 1 '::varchar))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' true '::varchar))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' TRUE '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' 0 '::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' false '::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' FALSE '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_byte('0'::int2))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_byte('-1'::int2))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_unsignedbyte('1'::int2))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_unsignedbyte('0'::int2))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_unsignedint('0'::int8))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_unsignedlong('0'::decimal))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_negativeinteger('-1'::decimal))" {
  expect_output 't'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal))" {
  expect_output 'f'
}

@test "fn: sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output 't'
}
