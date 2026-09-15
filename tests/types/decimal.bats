load ../psql_tests.bash



####
# - x
#

@test "op: operator(sparql.-) '4'::decimal" {
  expect_output '-4'
}



####
# x + y
#

@test "op: '2'::decimal operator(sparql.+) '4'::decimal" {
  expect_output '6'
}



####
# x - y
#

@test "op: '2'::decimal operator(sparql.-) '4'::decimal" {
  expect_output '-2'
}



####
# x * y
#

@test "op: '2'::decimal operator(sparql.*) '4'::decimal" {
  expect_output '8'
}



####
# x / y
#

@test "op: '2'::decimal operator(sparql./) '4'::decimal" {
  expect_output '0.50000000000000000000'
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
