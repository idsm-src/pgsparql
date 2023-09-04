load ../psql_tests.bash



####
# Effective Boolean Value
#

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_short('0'::int2))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_int('0'::int4))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_long('0'::int8))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_integer('0'::decimal))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_decimal('0'::decimal))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_float('0'::float4))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_float('NaN'::float4))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_double('0'::float8))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_double('NaN'::float8))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output 't'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_typedliteral('true'::varchar, 'http://www.w3.org/2001/XMLSchema#int'::varchar))" {
  expect_output 'f'
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_typedliteral('true'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.ebv_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}
