load ../psql_tests.bash



@test "sparql.cast_as_long_from_boolean('f'::bool)" {
  expect_output '0'
}

@test "sparql.cast_as_long_from_boolean('t'::bool)" {
  expect_output '1'
}

@test "sparql.cast_as_long_from_short('-32768'::int2)" {
  expect_output '-32768'
}

@test "sparql.cast_as_long_from_short('32767'::int2)" {
  expect_output '32767'
}

@test "sparql.cast_as_long_from_int('-2147483648'::int4)" {
  expect_output '-2147483648'
}

@test "sparql.cast_as_long_from_int('2147483647'::int4)" {
  expect_output '2147483647'
}

@test "sparql.cast_as_long_from_integer('-infinity'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_integer('-9223372036854775809'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_integer('-9223372036854775808'::decimal)" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_integer('9223372036854775807'::decimal)" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_long_from_integer('9223372036854775808'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_integer('infinity'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_integer('nan'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_decimal('-infinity'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_decimal('-9223372036854775809.0'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_decimal('-9223372036854775808.9'::decimal)" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_decimal('9223372036854775807.9'::decimal)" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_long_from_decimal('9223372036854775808.9'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_decimal('infinity'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_decimal('nan'::decimal)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_float('-inf'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_float('-9223372586610589697'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_float('-9223372586610589696'::float4)" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_float('-16777215'::float4)" {
  expect_output '-16777215'
}

@test "sparql.cast_as_long_from_float('16777215'::float4)" {
  expect_output '16777215'
}

@test "sparql.cast_as_long_from_float('9223371761976868863'::float4)" {
  expect_output '9223371487098961920'
}

@test "sparql.cast_as_long_from_float('9223371761976868864'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_float('inf'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_float('nan'::float4)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_double('-inf'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_double('-9223372036854776833'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_double('-9223372036854776832'::float8)" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_double('-9007199254740991'::float8)" {
  expect_output '-9007199254740991'
}

@test "sparql.cast_as_long_from_double('9007199254740991'::float8)" {
  expect_output '9007199254740991'
}

@test "sparql.cast_as_long_from_double('9223372036854775295'::float8)" {
  expect_output '9223372036854774784'
}

@test "sparql.cast_as_long_from_double('9223372036854775296'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_double('inf'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_double('nan'::float8)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_string(' -infinity '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_string(' -9223372036854775809 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_string(' -9223372036854775808 '::varchar)" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_string(' 9223372036854775807 '::varchar)" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_long_from_string(' 9223372036854775808 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_string(' infinity '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_string(' nan '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_string(' 10.0 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_string(' '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_string(''::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output '0'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '1'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_integer('-infinity'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_integer('-9223372036854775809'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_integer('-9223372036854775808'::decimal))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_integer('9223372036854775807'::decimal))" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_integer('infinity'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_integer('nan'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_decimal('-infinity'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_decimal('-9223372036854775809.0'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_decimal('-9223372036854775808.9'::decimal))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_decimal('9223372036854775807.9'::decimal))" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_decimal('9223372036854775808.9'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_decimal('infinity'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_decimal('nan'::decimal))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('-9223372586610589697'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('-9223372586610589696'::float4))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('-16777215'::float4))" {
  expect_output '-16777215'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('16777215'::float4))" {
  expect_output '16777215'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('9223371761976868863'::float4))" {
  expect_output '9223371487098961920'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('9223371761976868864'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('-9223372036854776833'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('-9223372036854776832'::float8))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('-9007199254740991'::float8))" {
  expect_output '-9007199254740991'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('9007199254740991'::float8))" {
  expect_output '9007199254740991'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('9223372036854775295'::float8))" {
  expect_output '9223372036854774784'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('9223372036854775296'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' -infinity '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' -9223372036854775809 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' -9223372036854775808 '::varchar))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' 9223372036854775807 '::varchar))" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' 9223372036854775808 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' infinity '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' nan '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' 10.0 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_long_from_rdfbox(sparql.rdfbox_create_from_iri(' http://123.org '::varchar))" {
  expect_output ''
}
