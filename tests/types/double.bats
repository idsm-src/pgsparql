load ../psql_tests.bash



####
# operator =
#

@test "'2'::float8 operator(sparql.=) '2'::float8" {
  expect_output 't'
}

@test "'2'::float8 operator(sparql.=) '4'::float8" {
  expect_output 'f'
}

@test "'4'::float8 operator(sparql.=) '2'::float8" {
  expect_output 'f'
}

@test "'NaN'::float8 operator(sparql.=) 'NaN'::float8" {
  expect_output 'f'
}

@test "'NaN'::float8 operator(sparql.=) '4'::float8" {
  expect_output 'f'
}

@test "'2'::float8 operator(sparql.=) 'NaN'::float8" {
  expect_output 'f'
}



####
# operator !=
#

@test "'2'::float8 operator(sparql.!=) '2'::float8" {
  expect_output 'f'
}

@test "'2'::float8 operator(sparql.!=) '4'::float8" {
  expect_output 't'
}

@test "'4'::float8 operator(sparql.!=) '2'::float8" {
  expect_output 't'
}

@test "'NaN'::float8 operator(sparql.!=) 'NaN'::float8" {
  expect_output 't'
}

@test "'NaN'::float8 operator(sparql.!=) '4'::float8" {
  expect_output 't'
}

@test "'2'::float8 operator(sparql.!=) 'NaN'::float8" {
  expect_output 't'
}



####
# operator <
#

@test "'2'::float8 operator(sparql.<) '2'::float8" {
  expect_output 'f'
}

@test "'2'::float8 operator(sparql.<) '4'::float8" {
  expect_output 't'
}

@test "'4'::float8 operator(sparql.<) '2'::float8" {
  expect_output 'f'
}

@test "'NaN'::float8 operator(sparql.<) 'NaN'::float8" {
  expect_output 'f'
}

@test "'NaN'::float8 operator(sparql.<) '4'::float8" {
  expect_output 'f'
}

@test "'2'::float8 operator(sparql.<) 'NaN'::float8" {
  expect_output 'f'
}



####
# operator >
#

@test "'2'::float8 operator(sparql.>) '2'::float8" {
  expect_output 'f'
}

@test "'2'::float8 operator(sparql.>) '4'::float8" {
  expect_output 'f'
}

@test "'4'::float8 operator(sparql.>) '2'::float8" {
  expect_output 't'
}

@test "'NaN'::float8 operator(sparql.>) 'NaN'::float8" {
  expect_output 'f'
}

@test "'NaN'::float8 operator(sparql.>) '4'::float8" {
  expect_output 'f'
}

@test "'2'::float8 operator(sparql.>) 'NaN'::float8" {
  expect_output 'f'
}



####
# operator <=
#

@test "'2'::float8 operator(sparql.<=) '2'::float8" {
  expect_output 't'
}

@test "'2'::float8 operator(sparql.<=) '4'::float8" {
  expect_output 't'
}

@test "'4'::float8 operator(sparql.<=) '2'::float8" {
  expect_output 'f'
}

@test "'NaN'::float8 operator(sparql.<=) 'NaN'::float8" {
  expect_output 'f'
}

@test "'NaN'::float8 operator(sparql.<=) '4'::float8" {
  expect_output 'f'
}

@test "'2'::float8 operator(sparql.<=) 'NaN'::float8" {
  expect_output 'f'
}



####
# operator >=
#

@test "'2'::float8 operator(sparql.>=) '2'::float8" {
  expect_output 't'
}

@test "'2'::float8 operator(sparql.>=) '4'::float8" {
  expect_output 'f'
}

@test "'4'::float8 operator(sparql.>=) '2'::float8" {
  expect_output 't'
}

@test "'NaN'::float8 operator(sparql.>=) 'NaN'::float8" {
  expect_output 'f'
}

@test "'NaN'::float8 operator(sparql.>=) '4'::float8" {
  expect_output 'f'
}

@test "'2'::float8 operator(sparql.>=) 'NaN'::float8" {
  expect_output 'f'
}



####
# - x
#

@test "operator(sparql.-) '4'::float8" {
  expect_output '-4'
}

@test "operator(sparql.-) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "operator(sparql.-) '-Infinity'::float8" {
  expect_output 'Infinity'
}

@test "operator(sparql.-) 'Infinity'::float8" {
  expect_output '-Infinity'
}



####
# x + y
#

@test "'2'::float8 operator(sparql.+) '4'::float8" {
  expect_output '6'
}

@test "'2'::float8 operator(sparql.+) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "'NaN'::float8 operator(sparql.+) '4'::float8" {
  expect_output 'NaN'
}

@test "'-Infinity'::float8 operator(sparql.+) '-Infinity'::float8" {
  expect_output '-Infinity'
}

@test "'Infinity'::float8 operator(sparql.+) '-Infinity'::float8" {
  expect_output 'NaN'
}

@test "'Infinity'::float8 operator(sparql.+) 'Infinity'::float8" {
  expect_output 'Infinity'
}



####
# x - y
#

@test "'2'::float8 operator(sparql.-) '4'::float8" {
  expect_output '-2'
}

@test "'2'::float8 operator(sparql.-) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "'NaN'::float8 operator(sparql.-) '4'::float8" {
  expect_output 'NaN'
}

@test "'-Infinity'::float8 operator(sparql.-) '-Infinity'::float8" {
  expect_output 'NaN'
}

@test "'Infinity'::float8 operator(sparql.-) '-Infinity'::float8" {
  expect_output 'Infinity'
}

@test "'Infinity'::float8 operator(sparql.-) 'Infinity'::float8" {
  expect_output 'NaN'
}



####
# x * y
#

@test "'2'::float8 operator(sparql.*) '4'::float8" {
  expect_output '8'
}

@test "'2'::float8 operator(sparql.*) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "'NaN'::float8 operator(sparql.*) '4'::float8" {
  expect_output 'NaN'
}

@test "'-Infinity'::float8 operator(sparql.*) '-Infinity'::float8" {
  expect_output 'Infinity'
}

@test "'Infinity'::float8 operator(sparql.*) '-Infinity'::float8" {
  expect_output '-Infinity'
}

@test "'Infinity'::float8 operator(sparql.*) 'Infinity'::float8" {
  expect_output 'Infinity'
}



####
# x / y
#

@test "'2'::float8 operator(sparql./) '4'::float8" {
  expect_output '0.5'
}

@test "'2'::float8 operator(sparql./) 'NaN'::float8" {
  expect_output 'NaN'
}

@test "'NaN'::float8 operator(sparql./) '4'::float8" {
  expect_output 'NaN'
}

@test "'-Infinity'::float8 operator(sparql./) '-Infinity'::float8" {
  expect_output 'NaN'
}

@test "'Infinity'::float8 operator(sparql./) '-Infinity'::float8" {
  expect_output 'NaN'
}

@test "'Infinity'::float8 operator(sparql./) 'Infinity'::float8" {
  expect_output 'NaN'
}



####
# x / 0
#

@test "'-1'::float8 operator(sparql./) '0'::float8" {
  expect_output '-Infinity'
}

@test "'0'::float8 operator(sparql./) '0'::float8" {
  expect_output 'NaN'
}

@test "'1'::float8 operator(sparql./) '0'::float8" {
  expect_output 'Infinity'
}

@test "'NaN'::float8 operator(sparql./) '0'::float8" {
  expect_output 'NaN'
}

@test "'-Infinity'::float8 operator(sparql./) '0'::float8" {
  expect_output '-Infinity'
}

@test "'Infinity'::float8 operator(sparql./) '0'::float8" {
  expect_output 'Infinity'
}
