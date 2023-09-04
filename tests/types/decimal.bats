load ../psql_tests.bash



####
# - x
#

@test "operator(sparql.-) '4'::decimal" {
  expect_output '-4'
}



####
# x + y
#

@test "'2'::decimal operator(sparql.+) '4'::decimal" {
  expect_output '6'
}



####
# x - y
#

@test "'2'::decimal operator(sparql.-) '4'::decimal" {
  expect_output '-2'
}



####
# x * y
#

@test "'2'::decimal operator(sparql.*) '4'::decimal" {
  expect_output '8'
}



####
# x / y
#

@test "'2'::decimal operator(sparql./) '4'::decimal" {
  expect_output '0.50000000000000000000'
}



####
# x / 0
#

@test "'-1'::decimal operator(sparql./) '0'::decimal" {
  expect_output ''
}

@test "'0'::decimal operator(sparql./) '0'::decimal" {
  expect_output ''
}

@test "'1'::decimal operator(sparql./) '0'::decimal" {
  expect_output ''
}
