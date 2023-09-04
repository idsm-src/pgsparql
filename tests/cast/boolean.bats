load ../psql_tests.bash



@test "sparql.cast_as_boolean_from_short(0::int2)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_short(1::int2)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_int(0::int4)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_int(1::int4)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_long(0::int8)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_long(1::int8)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_integer(0::decimal)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_integer(1::decimal)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_decimal(0::decimal)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_decimal(1::decimal)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_float('nan'::float4)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_float(0::float4)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_float(1::float4)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_double('nan'::float8)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_double(0::float8)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_double(1::float8)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_string(' 1 '::varchar)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_string(' true '::varchar)" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_string(' TRUE '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_boolean_from_string(' 0 '::varchar)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_string(' false '::varchar)" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_string(' FALSE '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_boolean_from_string(' '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_boolean_from_string(''::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_short(0::int2))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_short(1::int2))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_int(0::int4))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_int(1::int4))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_long(0::int8))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_long(1::int8))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_integer(0::decimal))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_integer(1::decimal))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_decimal(0::decimal))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_decimal(1::decimal))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_float(0::float4))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_float(1::float4))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_double(0::float8))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_double(1::float8))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' 1 '::varchar))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' true '::varchar))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' TRUE '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' 0 '::varchar))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' false '::varchar))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' FALSE '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'f'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output 't'
}

@test "sparql.cast_as_boolean_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output ''
}
