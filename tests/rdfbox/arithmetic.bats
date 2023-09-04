load ../psql_tests.bash



####
# - x
#

@test "operator(sparql.-) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "operator(sparql.-) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "operator(sparql.-) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "operator(sparql.-) sparql.rdfbox_create_from_integer('4'::decimal)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "operator(sparql.-) sparql.rdfbox_create_from_decimal('4'::decimal)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "operator(sparql.-) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "operator(sparql.-) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "operator(sparql.-) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output ''
}



####
# x + y
#

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.+) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.+) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.+) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.+) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}



####
# x - y
#

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.-) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.-) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.-) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.-) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}



####
# x * y
#

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.*) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.*) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql.*) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.*) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}



####
# x / y
#

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql./) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output ''
}



####
# x / 0
#

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_short('0'::int2)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_int('0'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_long('0'::int8)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('0'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('0'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_float('0'::float4)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_double('0'::float8)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.rdfbox_create_from_string('2'::varchar) operator(sparql./) sparql.rdfbox_create_from_double('0'::float8)" {
  expect_output ''
}
