load ../psql_tests.bash



####
# - x
#

@test "op: operator(sparql.-) '4'::decimal" {
  expect_output '-4'
}

@test "op: operator(sparql.-) 'Infinity'::decimal" {
  expect_output '(null)'
}

@test "op: operator(sparql.-) 'NaN'::decimal" {
  expect_output '(null)'
}



####
# x + y
#

@test "op: '2'::decimal operator(sparql.+) '4'::decimal" {
  expect_output '6'
}

@test "op: '9e131071'::decimal operator(sparql.+) '9e131071'::decimal" {
  expect_output '(null)'
}

@test "op: 'Infinity'::decimal operator(sparql.+) '1'::decimal" {
  expect_output '(null)'
}

@test "op: 'NaN'::decimal operator(sparql.+) '1'::decimal" {
  expect_output '(null)'
}



####
# x - y
#

@test "op: '2'::decimal operator(sparql.-) '4'::decimal" {
  expect_output '-2'
}

@test "op: '-9e131071'::decimal operator(sparql.-) '9e131071'::decimal" {
  expect_output '(null)'
}

@test "op: '1'::decimal operator(sparql.-) 'Infinity'::decimal" {
  expect_output '(null)'
}

@test "op: '1'::decimal operator(sparql.-) 'NaN'::decimal" {
  expect_output '(null)'
}



####
# x * y
#

@test "op: '2'::decimal operator(sparql.*) '4'::decimal" {
  expect_output '8'
}

@test "op: '1e131071'::decimal operator(sparql.*) '1e131071'::decimal" {
  expect_output '(null)'
}

@test "op: '-Infinity'::decimal operator(sparql.*) '2'::decimal" {
  expect_output '(null)'
}

@test "op: '1'::decimal operator(sparql.*) 'NaN'::decimal" {
  expect_output '(null)'
}



####
# x / y
#

@test "op: '2'::decimal operator(sparql./) '4'::decimal" {
  expect_output '0.50000000000000000000'
}

@test "op: '1e131071'::decimal operator(sparql./) '1e-10'::decimal" {
  expect_output '(null)'
}

@test "op: 'Infinity'::decimal operator(sparql./) '2'::decimal" {
  expect_output '(null)'
}

@test "op: 'NaN'::decimal operator(sparql./) '2'::decimal" {
  expect_output '(null)'
}



####
# x / 0
#

@test "op: '-1'::decimal operator(sparql./) '0'::decimal" {
  expect_output '(null)'
}

@test "op: '0'::decimal operator(sparql./) '0'::decimal" {
  expect_output '(null)'
}

@test "op: '1'::decimal operator(sparql./) '0'::decimal" {
  expect_output '(null)'
}
