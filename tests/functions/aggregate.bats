load ../psql_tests.bash



####
# sum_integer()
#

@test "sparql.sum_integer(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '0'
}

@test "sparql.sum_integer(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '0'
}

@test "sparql.sum_integer(x) from (values (NULL::decimal), ('2'::decimal), ('3'::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '5'
}

@test "sparql.sum_integer(x) from (values ('1'::decimal), ('2'::decimal), ('3'::decimal), ('4'::decimal)) as tab(x)" {
  expect_output '10'
}



####
# sum_decimal()
#

@test "sparql.sum_decimal(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_decimal(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_decimal(x) from (values (NULL::decimal), ('2'::decimal), ('3'::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_decimal(x) from (values ('1'::decimal), ('2'::decimal), ('3'::decimal), ('4'::decimal)) as tab(x)" {
  expect_output '"10"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}



####
# sum_float()
#

@test "sparql.sum_float(x) from (values (NULL::float4)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_float(x) from (values (NULL::float4), (NULL::float4), (NULL::float4), (NULL::float4)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_float(x) from (values (NULL::float4), ('2'::float4), ('3'::float4), (NULL::float4)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_float(x) from (values ('1'::float4), ('2'::float4), ('3'::float4), ('4'::float4)) as tab(x)" {
  expect_output '"10"^^<http://www.w3.org/2001/XMLSchema#float>'
}



####
# sum_double()
#

@test "sparql.sum_double(x) from (values (NULL::float8)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_double(x) from (values (NULL::float8), (NULL::float8), (NULL::float8), (NULL::float8)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_double(x) from (values (NULL::float8), ('2'::float8), ('3'::float8), (NULL::float8)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_double(x) from (values ('1'::float8), ('2'::float8), ('3'::float8), ('4'::float8)) as tab(x)" {
  expect_output '"10"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# sum_rdfbox()
#

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}



####
# avg_integer()
#

@test "sparql.avg_integer(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_integer(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_integer(x) from (values (NULL::decimal), ('2'::decimal), ('3'::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_integer(x) from (values ('1'::decimal), ('2'::decimal), ('3'::decimal), ('4'::decimal)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}



####
# avg_decimal()
#

@test "sparql.avg_decimal(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_decimal(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_decimal(x) from (values (NULL::decimal), ('2'::decimal), ('3'::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_decimal(x) from (values ('1'::decimal), ('2'::decimal), ('3'::decimal), ('4'::decimal)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}



####
# avg_float()
#

@test "sparql.avg_float(x) from (values (NULL::float4)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_float(x) from (values (NULL::float4), (NULL::float4), (NULL::float4), (NULL::float4)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_float(x) from (values (NULL::float4), ('2'::float4), ('3'::float4), (NULL::float4)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_float(x) from (values ('1'::float4), ('2'::float4), ('3'::float4), ('4'::float4)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}



####
# avg_double()
#

@test "sparql.avg_double(x) from (values (NULL::float8)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_double(x) from (values (NULL::float8), (NULL::float8), (NULL::float8), (NULL::float8)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_double(x) from (values (NULL::float8), ('2'::float8), ('3'::float8), (NULL::float8)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_double(x) from (values ('1'::float8), ('2'::float8), ('3'::float8), ('4'::float8)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# avg_rdfbox()
#

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_string('3'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_double('3'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_float('3'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_decimal('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_integer('3'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_long('3'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_int('3'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_short('3'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}



####
# min_rdfbox()
#

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output ''
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('f'::bool)), (sparql.rdfbox_create_from_boolean('t'::bool)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_boolean('f'::bool)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_boolean('t'::bool)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_short('4'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('4'::int2)), (sparql.rdfbox_create_from_int('2'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_long('2'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('12'::decimal)), (sparql.rdfbox_create_from_int('4'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('-14'::decimal)), (sparql.rdfbox_create_from_int('-14'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"-14"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('-4'::decimal)), (sparql.rdfbox_create_from_float('-4'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('-2'::decimal)), (sparql.rdfbox_create_from_double('4'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_float('NaN'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_float('4'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_float('NaN'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('NaN'::float8)), (sparql.rdfbox_create_from_double('NaN'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('NaN'::float8)), (sparql.rdfbox_create_from_double('4'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_double('NaN'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_double('NaN'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4)), (sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2022-10-05T10:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4)), (sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"1990-05-14T16:00:00-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4)), (sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2050-02-12T16:00:00+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0000-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4)), (sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2022-10-05"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4)), (sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"1990-05-14-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4)), (sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2050-02-13+12:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)), (sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0000-01-01Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('abc'::varchar)), (sparql.rdfbox_create_from_string('ab'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"ab"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_short('4'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('4'::int2)), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0000-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0000-01-01Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_double('4'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"b"@en'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_iri('http://example.org'::varchar)), (sparql.rdfbox_create_from_iblanknode('0'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '_:i0000000000000000'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_iri('http://example.org'::varchar)), (sparql.rdfbox_create_from_string('0'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '<http://example.org>'
}

@test "sparql.min_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('0'::varchar)), (sparql.rdfbox_create_from_iblanknode('0'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '_:i0000000000000000'
}



####
# max_rdfbox()
#

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output ''
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('f'::bool)), (sparql.rdfbox_create_from_boolean('t'::bool)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_boolean('f'::bool)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_boolean('t'::bool)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_short('4'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('4'::int2)), (sparql.rdfbox_create_from_int('2'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_long('2'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('12'::decimal)), (sparql.rdfbox_create_from_int('4'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"12"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_decimal('-14'::decimal)), (sparql.rdfbox_create_from_int('-14'::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"-14"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('-4'::decimal)), (sparql.rdfbox_create_from_float('-4'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('-2'::decimal)), (sparql.rdfbox_create_from_double('4'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_float('NaN'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_float('4'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_float('NaN'::float4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('NaN'::float8)), (sparql.rdfbox_create_from_double('NaN'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('NaN'::float8)), (sparql.rdfbox_create_from_double('4'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_double('NaN'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_double('NaN'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4)), (sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2022-10-05T10:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4)), (sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"1990-05-15T20:00:00+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4)), (sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2050-02-12T16:00:00-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0001-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4)), (sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2022-10-05Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4)), (sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"1990-05-15+10:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4)), (sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"2050-02-12-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)), (sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0001-01-01Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('abc'::varchar)), (sparql.rdfbox_create_from_string('ab'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_short('4'::int2)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_short('4'::int2)), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0000-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_double('4'::float8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_iri('http://example.org'::varchar)), (sparql.rdfbox_create_from_iblanknode('0'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '<http://example.org>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_iri('http://example.org'::varchar)), (sparql.rdfbox_create_from_string('0'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('0'::varchar)), (sparql.rdfbox_create_from_iblanknode('0'::int8)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#string>'
}



####
# group_concat_string()
#

@test "sparql.group_concat_string(x) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "sparql.group_concat_string(x) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_string(x) from (values (NULL::varchar), ('a'::varchar), ('b'::varchar), (NULL::varchar)) as tab(x)" {
  expect_output 'a b'
}

@test "sparql.group_concat_string(x) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a   b'
}

@test "sparql.group_concat_string(x) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'a b c d'
}

@test "sparql.group_concat_string(x, NULL) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "sparql.group_concat_string(x, NULL) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_string(x, NULL) from (values (NULL::varchar), ('a'::varchar), ('b'::varchar), (NULL::varchar)) as tab(x)" {
  expect_output 'a b'
}

@test "sparql.group_concat_string(x, NULL) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a   b'
}

@test "sparql.group_concat_string(x, NULL) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'a b c d'
}

@test "sparql.group_concat_string(x, ''::varchar) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "sparql.group_concat_string(x, ''::varchar) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_string(x, ''::varchar) from (values (NULL::varchar), ('a'::varchar), ('b'::varchar), (NULL::varchar)) as tab(x)" {
  expect_output 'ab'
}

@test "sparql.group_concat_string(x, ''::varchar) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'ab'
}

@test "sparql.group_concat_string(x, ''::varchar) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'abcd'
}

@test "sparql.group_concat_string(x, '-'::varchar) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "sparql.group_concat_string(x, '-'::varchar) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_string(x, '-'::varchar) from (values (NULL::varchar), ('a'::varchar), ('b'::varchar), (NULL::varchar)) as tab(x)" {
  expect_output 'a-b'
}

@test "sparql.group_concat_string(x, '-'::varchar) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a---b'
}

@test "sparql.group_concat_string(x, '-'::varchar) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'a-b-c-d'
}

@test "sparql.group_concat_string(x, ' | '::varchar) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "sparql.group_concat_string(x, ' | '::varchar) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_string(x, ' | '::varchar) from (values (NULL::varchar), ('a'::varchar), ('b'::varchar), (NULL::varchar)) as tab(x)" {
  expect_output 'a | b'
}

@test "sparql.group_concat_string(x, ' | '::varchar) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a |  |  | b'
}

@test "sparql.group_concat_string(x, ' | '::varchar) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'a | b | c | d'
}



####
# group_concat_rdfbox()
#

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '"a   b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output '"a b c d"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"@en'
}

@test "sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"a   b"@en'
}

@test "sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"a b c d"@en'
}

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '"a   b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output '"a b c d"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"@en'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"a   b"@en'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"a b c d"@en'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"ab"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '"ab"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output '"abcd"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"ab"@en'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"ab"@en'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"abcd"@en'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"ab"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"ab"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"ab"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a-b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '"a---b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output '"a-b-c-d"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a-b"@en'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"a---b"@en'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"a-b-c-d"@en'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a-b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a-b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a-b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a | b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '"a |  |  | b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output '"a | b | c | d"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a | b"@en'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"a |  |  | b"@en'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"a | b | c | d"@en'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a | b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a | b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a | b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}

@test "sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output ''
}



####
# sample()
#

@test "sparql.sample(x) from (values (NULL::int4)) as tab(x) where false" {
  expect_output ''
}

@test "sparql.sample(x) from (values (NULL::int4), (NULL::int4), (NULL::int4)) as tab(x)" {
  expect_output ''
}

@test "sparql.sample(x) from (values (NULL::int4), ('1'::int4), (NULL::int4)) as tab(x)" {
  expect_output '1'
}

@test "sparql.sample(x) from (values (NULL::varchar), ('abc'::varchar), (NULL::varchar)) as tab(x)" {
  expect_output 'abc'
}

@test "sparql.sample(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a"^^<http://www.w3.org/2001/XMLSchema#string>'
}
