load ../psql_tests.bash



####
# operator =
#

@test "op: '2'::float8 operator(sparql.=) '2'::float8" {
  expect_output 't'
}

@test "op: '2'::float8 operator(sparql.=) '4'::float8" {
  expect_output 'f'
}

@test "op: '4'::float8 operator(sparql.=) '2'::float8" {
  expect_output 'f'
}

@test "op: 'NaN'::float8 operator(sparql.=) 'NaN'::float8" {
  expect_output 'f'
}

@test "op: 'NaN'::float8 operator(sparql.=) '4'::float8" {
  expect_output 'f'
}

@test "op: '2'::float8 operator(sparql.=) 'NaN'::float8" {
  expect_output 'f'
}



####
# operator !=
#

@test "op: '2'::float8 operator(sparql.!=) '2'::float8" {
  expect_output 'f'
}

@test "op: '2'::float8 operator(sparql.!=) '4'::float8" {
  expect_output 't'
}

@test "op: '4'::float8 operator(sparql.!=) '2'::float8" {
  expect_output 't'
}

@test "op: 'NaN'::float8 operator(sparql.!=) 'NaN'::float8" {
  expect_output 't'
}

@test "op: 'NaN'::float8 operator(sparql.!=) '4'::float8" {
  expect_output 't'
}

@test "op: '2'::float8 operator(sparql.!=) 'NaN'::float8" {
  expect_output 't'
}



####
# operator <
#

@test "op: '2'::float8 operator(sparql.<) '2'::float8" {
  expect_output 'f'
}

@test "op: '2'::float8 operator(sparql.<) '4'::float8" {
  expect_output 't'
}

@test "op: '4'::float8 operator(sparql.<) '2'::float8" {
  expect_output 'f'
}

@test "op: 'NaN'::float8 operator(sparql.<) 'NaN'::float8" {
  expect_output 'f'
}

@test "op: 'NaN'::float8 operator(sparql.<) '4'::float8" {
  expect_output 'f'
}

@test "op: '2'::float8 operator(sparql.<) 'NaN'::float8" {
  expect_output 'f'
}



####
# operator >
#

@test "op: '2'::float8 operator(sparql.>) '2'::float8" {
  expect_output 'f'
}

@test "op: '2'::float8 operator(sparql.>) '4'::float8" {
  expect_output 'f'
}

@test "op: '4'::float8 operator(sparql.>) '2'::float8" {
  expect_output 't'
}

@test "op: 'NaN'::float8 operator(sparql.>) 'NaN'::float8" {
  expect_output 'f'
}

@test "op: 'NaN'::float8 operator(sparql.>) '4'::float8" {
  expect_output 'f'
}

@test "op: '2'::float8 operator(sparql.>) 'NaN'::float8" {
  expect_output 'f'
}



####
# operator <=
#

@test "op: '2'::float8 operator(sparql.<=) '2'::float8" {
  expect_output 't'
}

@test "op: '2'::float8 operator(sparql.<=) '4'::float8" {
  expect_output 't'
}

@test "op: '4'::float8 operator(sparql.<=) '2'::float8" {
  expect_output 'f'
}

@test "op: 'NaN'::float8 operator(sparql.<=) 'NaN'::float8" {
  expect_output 'f'
}

@test "op: 'NaN'::float8 operator(sparql.<=) '4'::float8" {
  expect_output 'f'
}

@test "op: '2'::float8 operator(sparql.<=) 'NaN'::float8" {
  expect_output 'f'
}



####
# operator >=
#

@test "op: '2'::float8 operator(sparql.>=) '2'::float8" {
  expect_output 't'
}

@test "op: '2'::float8 operator(sparql.>=) '4'::float8" {
  expect_output 'f'
}

@test "op: '4'::float8 operator(sparql.>=) '2'::float8" {
  expect_output 't'
}

@test "op: 'NaN'::float8 operator(sparql.>=) 'NaN'::float8" {
  expect_output 'f'
}

@test "op: 'NaN'::float8 operator(sparql.>=) '4'::float8" {
  expect_output 'f'
}

@test "op: '2'::float8 operator(sparql.>=) 'NaN'::float8" {
  expect_output 'f'
}



####
# - x
#

@test "op: operator(sparql.-) '4'::float8" {
  expect_output '-4'
}

@test "op: operator(sparql.-) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "op: operator(sparql.-) '-Infinity'::float8" {
  expect_output 'Infinity'
}

@test "op: operator(sparql.-) 'Infinity'::float8" {
  expect_output '-Infinity'
}



####
# x + y
#

@test "op: '2'::float8 operator(sparql.+) '4'::float8" {
  expect_output '6'
}

@test "op: '2'::float8 operator(sparql.+) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "op: 'NaN'::float8 operator(sparql.+) '4'::float8" {
  expect_output 'NaN'
}

@test "op: '-Infinity'::float8 operator(sparql.+) '-Infinity'::float8" {
  expect_output '-Infinity'
}

@test "op: 'Infinity'::float8 operator(sparql.+) '-Infinity'::float8" {
  expect_output 'NaN'
}

@test "op: 'Infinity'::float8 operator(sparql.+) 'Infinity'::float8" {
  expect_output 'Infinity'
}



####
# x - y
#

@test "op: '2'::float8 operator(sparql.-) '4'::float8" {
  expect_output '-2'
}

@test "op: '2'::float8 operator(sparql.-) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "op: 'NaN'::float8 operator(sparql.-) '4'::float8" {
  expect_output 'NaN'
}

@test "op: '-Infinity'::float8 operator(sparql.-) '-Infinity'::float8" {
  expect_output 'NaN'
}

@test "op: 'Infinity'::float8 operator(sparql.-) '-Infinity'::float8" {
  expect_output 'Infinity'
}

@test "op: 'Infinity'::float8 operator(sparql.-) 'Infinity'::float8" {
  expect_output 'NaN'
}



####
# x * y
#

@test "op: '2'::float8 operator(sparql.*) '4'::float8" {
  expect_output '8'
}

@test "op: '2'::float8 operator(sparql.*) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "op: 'NaN'::float8 operator(sparql.*) '4'::float8" {
  expect_output 'NaN'
}

@test "op: '-Infinity'::float8 operator(sparql.*) '-Infinity'::float8" {
  expect_output 'Infinity'
}

@test "op: 'Infinity'::float8 operator(sparql.*) '-Infinity'::float8" {
  expect_output '-Infinity'
}

@test "op: 'Infinity'::float8 operator(sparql.*) 'Infinity'::float8" {
  expect_output 'Infinity'
}



####
# x / y
#

@test "op: '2'::float8 operator(sparql./) '4'::float8" {
  expect_output '0.5'
}

@test "op: '2'::float8 operator(sparql./) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "op: 'NaN'::float8 operator(sparql./) '4'::float8" {
  expect_output 'NaN'
}

@test "op: '-Infinity'::float8 operator(sparql./) '-Infinity'::float8" {
  expect_output 'NaN'
}

@test "op: 'Infinity'::float8 operator(sparql./) '-Infinity'::float8" {
  expect_output 'NaN'
}

@test "op: 'Infinity'::float8 operator(sparql./) 'Infinity'::float8" {
  expect_output 'NaN'
}



####
# x / 0
#

@test "op: '-1'::float8 operator(sparql./) '0'::float8" {
  expect_output '-Infinity'
}

@test "op: '0'::float8 operator(sparql./) '0'::float8" {
  expect_output 'NaN'
}

@test "op: '1'::float8 operator(sparql./) '0'::float8" {
  expect_output 'Infinity'
}

@test "op: 'NaN'::float8 operator(sparql./) '0'::float8" {
  expect_output 'NaN'
}

@test "op: '-Infinity'::float8 operator(sparql./) '0'::float8" {
  expect_output '-Infinity'
}

@test "op: 'Infinity'::float8 operator(sparql./) '0'::float8" {
  expect_output 'Infinity'
}
