load ../psql_tests.bash



####
# - x
#

@test "op: operator(sparql.-) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_integer('4'::decimal)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_decimal('4'::decimal)" {
  expect_output '"-4.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"-4.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"-4.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output '(null)'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_decimal('Infinity'::decimal)" {
  expect_output '(null)'
}

@test "op: operator(sparql.-) sparql.rdfbox_create_from_integer('NaN'::decimal)" {
  expect_output '(null)'
}



####
# x + y
#

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.+) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.+) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.+) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"6"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"6.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"6.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"6.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.+) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.+) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_integer('9e131071'::decimal) operator(sparql.+) sparql.rdfbox_create_from_integer('9e131071'::decimal)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_decimal('Infinity'::decimal) operator(sparql.+) sparql.rdfbox_create_from_int('1'::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_double('Infinity'::float8) operator(sparql.+) sparql.rdfbox_create_from_int('1'::int4)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# x - y
#

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.-) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.-) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.-) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"-2.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"-2.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"-2.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.-) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.-) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_decimal('-9e131071'::decimal) operator(sparql.-) sparql.rdfbox_create_from_decimal('9e131071'::decimal)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_int('1'::int4) operator(sparql.-) sparql.rdfbox_create_from_decimal('-Infinity'::decimal)" {
  expect_output '(null)'
}



####
# x * y
#

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.*) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.*) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql.*) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"8"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "op: sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"8.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"8.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"8.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql.*) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql.*) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_decimal('1e131071'::decimal) operator(sparql.*) sparql.rdfbox_create_from_decimal('1e131071'::decimal)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_decimal('NaN'::decimal) operator(sparql.*) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_double('1e308'::float8) operator(sparql.*) sparql.rdfbox_create_from_double('10'::float8)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# x / y
#

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_short('4'::int2)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_long('4'::int8)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('4'::int4)" {
  expect_output '"0.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_float('4'::float4)" {
  expect_output '"5.0E-1"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '"5.0E-1"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_string('4'::varchar)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql./) sparql.rdfbox_create_from_double('4'::float8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_decimal('1e131071'::decimal) operator(sparql./) sparql.rdfbox_create_from_decimal('1e-10'::decimal)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_decimal('Infinity'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('2'::int4)" {
  expect_output '(null)'
}



####
# x / 0
#

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_short('0'::int2)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_int('0'::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_short('2'::int2) operator(sparql./) sparql.rdfbox_create_from_long('0'::int8)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('0'::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_decimal('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_int('0'::int4)" {
  expect_output '(null)'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_float('0'::float4)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "op: sparql.rdfbox_create_from_integer('2'::decimal) operator(sparql./) sparql.rdfbox_create_from_double('0'::float8)" {
  expect_output '"INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "op: sparql.rdfbox_create_from_string('2'::varchar) operator(sparql./) sparql.rdfbox_create_from_double('0'::float8)" {
  expect_output '(null)'
}
