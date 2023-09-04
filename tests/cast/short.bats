load ../psql_tests.bash



@test "sparql.cast_as_short_from_boolean('f'::bool)" {
  expect_output '0'
}

@test "sparql.cast_as_short_from_boolean('t'::bool)" {
  expect_output '1'
}

@test "sparql.cast_as_short_from_int('-32769'::int4)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_int('-32768'::int4)" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_int('32767'::int4)" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_int('32768'::int4)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_long('-32769'::int8)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_long('-32768'::int8)" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_long('32767'::int8)" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_long('32768'::int8)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_integer('-infinity'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_integer('-32769'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_integer('-32768'::decimal)" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_integer('32767'::decimal)" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_integer('32768'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_integer('infinity'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_integer('nan'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_decimal('-infinity'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_decimal('-32769.0'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_decimal('-32768.9'::decimal)" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_decimal('32767.9'::decimal)" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_decimal('32768.9'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_decimal('infinity'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_decimal('nan'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_float('-inf'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_float('-32769'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_float('-32768'::float4)" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_float('32767'::float4)" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_float('32768'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_float('inf'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_float('nan'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_double('-inf'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_double('-32769'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_double('-32768'::float8)" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_double('32767'::float8)" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_double('32768'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_double('inf'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_double('nan'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_string(' -infinity '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_string(' -32769 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_string(' -32768 '::varchar)" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_string(' 32767 '::varchar)" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_string(' 32768 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_string(' infinity '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_string(' nan '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_string(' 10.0 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_string(' '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_string(''::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output '0'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '1'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_int('-32769'::int4))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_int('-32768'::int4))" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_int('32767'::int4))" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_int('32768'::int4))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_long('-32769'::int8))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_long('-32768'::int8))" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_long('32767'::int8))" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_long('32768'::int8))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_integer('-infinity'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_integer('-32769'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_integer('-32768'::decimal))" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_integer('32767'::decimal))" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_integer('32768'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_integer('infinity'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_integer('nan'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_decimal('-infinity'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_decimal('-32769.0'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_decimal('-32768.9'::decimal))" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_decimal('32767.9'::decimal))" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_decimal('32768.9'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_decimal('infinity'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_decimal('nan'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_float('-32769'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_float('-32768'::float4))" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_float('32767'::float4))" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_float('32768'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_double('-32769'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_double('-32768'::float8))" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_double('32767'::float8))" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_double('32768'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' -infinity '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' -32769 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' -32768 '::varchar))" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' 32767 '::varchar))" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' 32768 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' infinity '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' nan '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' 10.0 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "sparql.cast_as_short_from_rdfbox(sparql.rdfbox_create_from_iri(' http://123.org '::varchar))" {
  expect_output ''
}
