load ../psql_tests.bash



####
# sum_integer()
#

@test "fn: sparql.sum_integer(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '0'
}

@test "fn: sparql.sum_integer(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_integer(x) from (values ('2'::decimal), (NULL::decimal), ('3'::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_integer(x) from (values ('2'::decimal), ('3'::decimal)) as tab(x)" {
  expect_output '5'
}

@test "fn: sparql.sum_integer(x) from (values ('1'::decimal), ('2'::decimal), ('3'::decimal), ('4'::decimal)) as tab(x)" {
  expect_output '10'
}

@test "fn: sparql.sum_integer(x) from (values (repeat('9', 131072)::decimal), (repeat('9', 131072)::decimal)) as tab(x)" {
  expect_output '(null)'
}



####
# sum_decimal()
#

@test "fn: sparql.sum_decimal(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_decimal(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_decimal(x) from (values ('2'::decimal), (NULL::decimal), ('3'::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_decimal(x) from (values ('2'::decimal), ('3'::decimal)) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_decimal(x) from (values ('1'::decimal), ('2'::decimal), ('3'::decimal), ('4'::decimal)) as tab(x)" {
  expect_output '"10.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_decimal(x) from (values (repeat('9', 131072)::decimal), (repeat('9', 131072)::decimal)) as tab(x)" {
  expect_output '(null)'
}



####
# sum_float()
#

@test "fn: sparql.sum_float(x) from (values (NULL::float4)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_float(x) from (values (NULL::float4), (NULL::float4), (NULL::float4), (NULL::float4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_float(x) from (values ('2'::float4), (NULL::float4), ('3'::float4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_float(x) from (values ('2'::float4), ('3'::float4)) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_float(x) from (values ('1'::float4), ('2'::float4), ('3'::float4), ('4'::float4)) as tab(x)" {
  expect_output '"1.0E1"^^<http://www.w3.org/2001/XMLSchema#float>'
}



####
# sum_double()
#

@test "fn: sparql.sum_double(x) from (values (NULL::float8)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_double(x) from (values (NULL::float8), (NULL::float8), (NULL::float8), (NULL::float8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_double(x) from (values ('2'::float8), (NULL::float8), ('3'::float8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_double(x) from (values ('2'::float8), ('3'::float8)) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_double(x) from (values ('1'::float8), ('2'::float8), ('3'::float8), ('4'::float8)) as tab(x)" {
  expect_output '"1.0E1"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# sum_rdfbox()
#

@test "fn: sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"5"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer(repeat('9', 131072)::decimal)), (sparql.rdfbox_create_from_integer(repeat('9', 131072)::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_integer(repeat('9', 131072)::decimal)), (sparql.rdfbox_create_from_integer(repeat('9', 131072)::decimal)), (sparql.rdfbox_create_from_double('1'::float8))) as tab(x)" {
  expect_output '(null)'
}



####
# avg_integer()
#

@test "fn: sparql.avg_integer(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.avg_integer(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_integer(x) from (values ('2'::decimal), (NULL::decimal), ('3'::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_integer(x) from (values ('2'::decimal), ('3'::decimal)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_integer(x) from (values ('1'::decimal), ('2'::decimal), ('3'::decimal), ('4'::decimal)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_integer(x) from (values (repeat('9', 131072)::decimal), (repeat('9', 131072)::decimal)) as tab(x)" {
  expect_output '(null)'
}



####
# avg_decimal()
#

@test "fn: sparql.avg_decimal(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.avg_decimal(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_decimal(x) from (values ('2'::decimal), (NULL::decimal), ('3'::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_decimal(x) from (values ('2'::decimal), ('3'::decimal)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_decimal(x) from (values ('1'::decimal), ('2'::decimal), ('3'::decimal), ('4'::decimal)) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_decimal(x) from (values (repeat('9', 131072)::decimal), (repeat('9', 131072)::decimal)) as tab(x)" {
  expect_output '(null)'
}



####
# avg_float()
#

@test "fn: sparql.avg_float(x) from (values (NULL::float4)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.avg_float(x) from (values (NULL::float4), (NULL::float4), (NULL::float4), (NULL::float4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_float(x) from (values ('2'::float4), (NULL::float4), ('3'::float4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_float(x) from (values ('2'::float4), ('3'::float4)) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_float(x) from (values ('1'::float4), ('2'::float4), ('3'::float4), ('4'::float4)) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}



####
# avg_double()
#

@test "fn: sparql.avg_double(x) from (values (NULL::float8)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.avg_double(x) from (values (NULL::float8), (NULL::float8), (NULL::float8), (NULL::float8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_double(x) from (values ('2'::float8), (NULL::float8), ('3'::float8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_double(x) from (values ('2'::float8), ('3'::float8)) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_double(x) from (values ('1'::float8), ('2'::float8), ('3'::float8), ('4'::float8)) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# avg_rdfbox()
#

@test "fn: sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('2'::decimal)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('2'::decimal)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_long('2'::int8)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_int('2'::int4)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_double('3'::float8))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"2.5E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_integer('3'::decimal))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_long('3'::int8))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_int('3'::int4))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_short('3'::int2))) as tab(x)" {
  expect_output '"2.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_integer(repeat('9', 131072)::decimal)), (sparql.rdfbox_create_from_integer(repeat('9', 131072)::decimal))) as tab(x)" {
  expect_output '(null)'
}



####
# min()
#

@test "fn: sparql.min(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_boolean('f'::bool)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('t'::bool))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_boolean('f'::bool)), (sparql.rdfbox_create_from_boolean('t'::bool))) as tab(x)" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_boolean('f'::bool))) as tab(x)" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_boolean('t'::bool))) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_short('4'::int2))) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_short('4'::int2)), (sparql.rdfbox_create_from_int('2'::int4))) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_long('2'::int8))) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_integer('12'::decimal)), (sparql.rdfbox_create_from_int('4'::int4))) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_decimal('-14'::decimal)), (sparql.rdfbox_create_from_int('-14'::int4))) as tab(x)" {
  expect_output '"-14"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_integer('-4'::decimal)), (sparql.rdfbox_create_from_float('-4'::float4))) as tab(x)" {
  expect_output '"-4"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_integer('-2'::decimal)), (sparql.rdfbox_create_from_double('4'::float8))) as tab(x)" {
  expect_output '"-2"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_float('NaN'::float4))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_float('4'::float4))) as tab(x)" {
  expect_output '"4.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_float('NaN'::float4))) as tab(x)" {
  expect_output '"2.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_double('NaN'::float8)), (sparql.rdfbox_create_from_double('NaN'::float8))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_double('NaN'::float8)), (sparql.rdfbox_create_from_double('4'::float8))) as tab(x)" {
  expect_output '"4.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_double('NaN'::float8))) as tab(x)" {
  expect_output '"2.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_double('NaN'::float8))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4)), (sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '"2022-10-05T10:00:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4)), (sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4))) as tab(x)" {
  expect_output '"1990-05-14T16:00:00-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4)), (sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4))) as tab(x)" {
  expect_output '"2050-02-12T16:00:00+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '"0000-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4)), (sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4))) as tab(x)" {
  expect_output '"2022-10-05"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4)), (sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4))) as tab(x)" {
  expect_output '"1990-05-14-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4)), (sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4))) as tab(x)" {
  expect_output '"2050-02-13+12:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)), (sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4))) as tab(x)" {
  expect_output '"0000-01-01Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_string('abc'::varchar)), (sparql.rdfbox_create_from_string('ab'::varchar))) as tab(x)" {
  expect_output '"ab"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar))) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '"a"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_short('4'::int2))) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_short('4'::int2)), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '"0000-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4))) as tab(x)" {
  expect_output '"0000-01-01Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_double('4'::float8))) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"b"@en'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_iri('http://example.org'::varchar)), (sparql.rdfbox_create_from_iblanknode('0'::int8))) as tab(x)" {
  expect_output '_:i0000000000000000'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_iri('http://example.org'::varchar)), (sparql.rdfbox_create_from_string('0'::varchar))) as tab(x)" {
  expect_output '<http://example.org>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_string('0'::varchar)), (sparql.rdfbox_create_from_iblanknode('0'::int8))) as tab(x)" {
  expect_output '_:i0000000000000000'
}

@test "fn: sparql.min(x) from (values (NULL::bool)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::bool), (NULL::bool), (NULL::bool), (NULL::bool)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('t'::bool), ('f'::bool)) as tab(x)" {
  expect_output 'f'
}

@test "fn: sparql.min(x) from (values ('f'::bool), ('t'::bool)) as tab(x)" {
  expect_output 'f'
}

@test "fn: sparql.min(x) from (values ('t'::bool), (NULL::bool), ('f'::bool)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('f'::bool), (NULL::bool)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::bool), ('t'::bool)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int2)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int2), (NULL::int2), (NULL::int2), (NULL::int2)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('4'::int2), ('2'::int2)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('2'::int2), ('4'::int2)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('4'::int2), (NULL::int2), ('2'::int2)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2'::int2), (NULL::int2)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int2), ('4'::int2)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int4)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int4), (NULL::int4), (NULL::int4), (NULL::int4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('4'::int4), ('2'::int4)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('2'::int4), ('4'::int4)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('4'::int4), (NULL::int4), ('2'::int4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2'::int4), (NULL::int4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int4), ('4'::int4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int8)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int8), (NULL::int8), (NULL::int8), (NULL::int8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('4'::int8), ('2'::int8)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('2'::int8), ('4'::int8)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('4'::int8), (NULL::int8), ('2'::int8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2'::int8), (NULL::int8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::int8), ('4'::int8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::decimal)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::decimal), (NULL::decimal), (NULL::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('4.5'::decimal), ('2.25'::decimal)) as tab(x)" {
  expect_output '2.25'
}

@test "fn: sparql.min(x) from (values ('2.25'::decimal), ('4.5'::decimal)) as tab(x)" {
  expect_output '2.25'
}

@test "fn: sparql.min(x) from (values ('4.5'::decimal), (NULL::decimal), ('2.25'::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2.25'::decimal), (NULL::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::decimal), ('4.5'::decimal)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::float4)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::float4), (NULL::float4), (NULL::float4), (NULL::float4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('4'::float4), ('2'::float4)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('2'::float4), ('4'::float4)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('4'::float4), (NULL::float4), ('2'::float4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2'::float4), (NULL::float4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::float4), ('4'::float4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::float8)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::float8), (NULL::float8), (NULL::float8), (NULL::float8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('4'::float8), ('2'::float8)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('2'::float8), ('4'::float8)) as tab(x)" {
  expect_output '2'
}

@test "fn: sparql.min(x) from (values ('4'::float8), (NULL::float8), ('2'::float8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2'::float8), (NULL::float8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::float8), ('4'::float8)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('b'::varchar), ('a'::varchar)) as tab(x)" {
  expect_output 'a'
}

@test "fn: sparql.min(x) from (values ('a'::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a'
}

@test "fn: sparql.min(x) from (values ('b'::varchar), (NULL::varchar), ('a'::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('a'::varchar), (NULL::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::varchar), ('b'::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::text)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::text), (NULL::text), (NULL::text), (NULL::text)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('b'::text), ('a'::text)) as tab(x)" {
  expect_output 'a'
}

@test "fn: sparql.min(x) from (values ('a'::text), ('b'::text)) as tab(x)" {
  expect_output 'a'
}

@test "fn: sparql.min(x) from (values ('b'::text), (NULL::text), ('a'::text)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('a'::text), (NULL::text)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::text), ('b'::text)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::date)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::date), (NULL::date), (NULL::date), (NULL::date)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2020-01-02'::date), ('2019-05-06'::date)) as tab(x)" {
  expect_output '2019-05-06'
}

@test "fn: sparql.min(x) from (values ('2019-05-06'::date), ('2020-01-02'::date)) as tab(x)" {
  expect_output '2019-05-06'
}

@test "fn: sparql.min(x) from (values ('2020-01-02'::date), (NULL::date), ('2019-05-06'::date)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2019-05-06'::date), (NULL::date)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::date), ('2020-01-02'::date)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::timestamptz)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::timestamptz), (NULL::timestamptz), (NULL::timestamptz), (NULL::timestamptz)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2020-01-02 10:00Z'::timestamptz), ('2019-05-06 10:00Z'::timestamptz)) as tab(x)" {
  expect_output '2019-05-06 10:00:00+00'
}

@test "fn: sparql.min(x) from (values ('2019-05-06 10:00Z'::timestamptz), ('2020-01-02 10:00Z'::timestamptz)) as tab(x)" {
  expect_output '2019-05-06 10:00:00+00'
}

@test "fn: sparql.min(x) from (values ('2020-01-02 10:00Z'::timestamptz), (NULL::timestamptz), ('2019-05-06 10:00Z'::timestamptz)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('2019-05-06 10:00Z'::timestamptz), (NULL::timestamptz)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::timestamptz), ('2020-01-02 10:00Z'::timestamptz)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::interval)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::interval), (NULL::interval), (NULL::interval), (NULL::interval)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('P2D'::interval), ('P1D'::interval)) as tab(x)" {
  expect_output '1 day'
}

@test "fn: sparql.min(x) from (values ('P1D'::interval), ('P2D'::interval)) as tab(x)" {
  expect_output '1 day'
}

@test "fn: sparql.min(x) from (values ('P2D'::interval), (NULL::interval), ('P1D'::interval)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values ('P1D'::interval), (NULL::interval)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::interval), ('P2D'::interval)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.zoneddate)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.zoneddate), (NULL::sparql.zoneddate), (NULL::sparql.zoneddate), (NULL::sparql.zoneddate)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (sparql.zoneddate_create('2020-01-02'::date, 0::int4)), (sparql.zoneddate_create('2019-05-06'::date, 0::int4))) as tab(x)" {
  expect_output '2019-05-06Z'
}

@test "fn: sparql.min(x) from (values (sparql.zoneddate_create('2019-05-06'::date, 0::int4)), (sparql.zoneddate_create('2020-01-02'::date, 0::int4))) as tab(x)" {
  expect_output '2019-05-06Z'
}

@test "fn: sparql.min(x) from (values (sparql.zoneddate_create('2020-01-02'::date, 0::int4)), (NULL::sparql.zoneddate), (sparql.zoneddate_create('2019-05-06'::date, 0::int4))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (sparql.zoneddate_create('2019-05-06'::date, 0::int4)), (NULL::sparql.zoneddate)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.zoneddate), (sparql.zoneddate_create('2020-01-02'::date, 0::int4))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.zoneddatetime)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.zoneddatetime), (NULL::sparql.zoneddatetime), (NULL::sparql.zoneddatetime), (NULL::sparql.zoneddatetime)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (sparql.zoneddatetime_create('2020-01-02 10:00Z'::timestamptz, 0::int4)), (sparql.zoneddatetime_create('2019-05-06 10:00Z'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '2019-05-06T10:00:00Z'
}

@test "fn: sparql.min(x) from (values (sparql.zoneddatetime_create('2019-05-06 10:00Z'::timestamptz, 0::int4)), (sparql.zoneddatetime_create('2020-01-02 10:00Z'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '2019-05-06T10:00:00Z'
}

@test "fn: sparql.min(x) from (values (sparql.zoneddatetime_create('2020-01-02 10:00Z'::timestamptz, 0::int4)), (NULL::sparql.zoneddatetime), (sparql.zoneddatetime_create('2019-05-06 10:00Z'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (sparql.zoneddatetime_create('2019-05-06 10:00Z'::timestamptz, 0::int4)), (NULL::sparql.zoneddatetime)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.zoneddatetime), (sparql.zoneddatetime_create('2020-01-02 10:00Z'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.ubox)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.ubox), (NULL::sparql.ubox), (NULL::sparql.ubox), (NULL::sparql.ubox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (sparql.ubox_create('b'::text)), (sparql.ubox_create('a'::text))) as tab(x)" {
  expect_output 'a:pg_catalog.text'
}

@test "fn: sparql.min(x) from (values (sparql.ubox_create('a'::text)), (sparql.ubox_create('b'::text))) as tab(x)" {
  expect_output 'a:pg_catalog.text'
}

@test "fn: sparql.min(x) from (values (sparql.ubox_create('b'::text)), (NULL::sparql.ubox), (sparql.ubox_create('a'::text))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (sparql.ubox_create('a'::text)), (NULL::sparql.ubox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.min(x) from (values (NULL::sparql.ubox), (sparql.ubox_create('b'::text))) as tab(x)" {
  expect_output '(null)'
}



####
# max_rdfbox()
#

@test "fn: sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.max_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_boolean('f'::bool)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_boolean('t'::bool))) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_boolean('f'::bool)), (sparql.rdfbox_create_from_boolean('t'::bool))) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_boolean('f'::bool))) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_boolean('t'::bool))) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_short('4'::int2))) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_short('4'::int2)), (sparql.rdfbox_create_from_int('2'::int4))) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_short('2'::int2)), (sparql.rdfbox_create_from_long('2'::int8))) as tab(x)" {
  expect_output '"2"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('12'::decimal)), (sparql.rdfbox_create_from_int('4'::int4))) as tab(x)" {
  expect_output '"12"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_decimal('-14'::decimal)), (sparql.rdfbox_create_from_int('-14'::int4))) as tab(x)" {
  expect_output '"-14.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('-4'::decimal)), (sparql.rdfbox_create_from_float('-4'::float4))) as tab(x)" {
  expect_output '"-4.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('-2'::decimal)), (sparql.rdfbox_create_from_double('4'::float8))) as tab(x)" {
  expect_output '"4.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_float('NaN'::float4))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_float('4'::float4))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_float('2'::float4)), (sparql.rdfbox_create_from_float('NaN'::float4))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_double('NaN'::float8)), (sparql.rdfbox_create_from_double('NaN'::float8))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_double('NaN'::float8)), (sparql.rdfbox_create_from_double('4'::float8))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_double('2'::float8)), (sparql.rdfbox_create_from_double('NaN'::float8))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_float('NaN'::float4)), (sparql.rdfbox_create_from_double('NaN'::float8))) as tab(x)" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4)), (sparql.rdfbox_create_from_datetime('2022-10-05T10:00:00Z'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '"2022-10-05T10:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_datetime('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4)), (sparql.rdfbox_create_from_datetime('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4))) as tab(x)" {
  expect_output '"1990-05-15T20:00:00+14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4)), (sparql.rdfbox_create_from_datetime('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4))) as tab(x)" {
  expect_output '"2050-02-12T16:00:00-14:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '"0001-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_date('2022-10-05'::date, '-2147483648'::int4)), (sparql.rdfbox_create_from_date('2022-10-05'::date, 0::int4))) as tab(x)" {
  expect_output '"2022-10-05Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_date('1990-05-14', (-14*60*60)::int4)), (sparql.rdfbox_create_from_date('1990-05-15'::date, (10*60*60)::int4))) as tab(x)" {
  expect_output '"1990-05-15+10:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_date('2050-02-12'::date, (-14*60*60)::int4)), (sparql.rdfbox_create_from_date('2050-02-13'::date, (12*60*60)::int4))) as tab(x)" {
  expect_output '"2050-02-12-14:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4)), (sparql.rdfbox_create_from_date('0001-01-01'::date, 0::int4))) as tab(x)" {
  expect_output '"0001-01-01Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_string('abc'::varchar)), (sparql.rdfbox_create_from_string('ab'::varchar))) as tab(x)" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar))) as tab(x)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '"b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_boolean('t'::bool)), (sparql.rdfbox_create_from_short('4'::int2))) as tab(x)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_short('4'::int2)), (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4))) as tab(x)" {
  expect_output '"4"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4)), (sparql.rdfbox_create_from_date('0001-01-01 BC'::date, 0::int4))) as tab(x)" {
  expect_output '"0000-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_string('2'::varchar)), (sparql.rdfbox_create_from_double('4'::float8))) as tab(x)" {
  expect_output '"4.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output '"b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_iri('http://example.org'::varchar)), (sparql.rdfbox_create_from_iblanknode('0'::int8))) as tab(x)" {
  expect_output '<http://example.org>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_iri('http://example.org'::varchar)), (sparql.rdfbox_create_from_string('0'::varchar))) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_string('0'::varchar)), (sparql.rdfbox_create_from_iblanknode('0'::int8))) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#string>'
}



####
# group_concat_string()
#

@test "fn: sparql.group_concat_string(x) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_string(x) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x) from (values ('a'::varchar), (NULL::varchar), ('b'::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x) from (values ('a'::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_string(x) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a   b'
}

@test "fn: sparql.group_concat_string(x) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'a b c d'
}

@test "fn: sparql.group_concat_string(x, NULL) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_string(x, NULL) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x, NULL) from (values ('a'::varchar), (NULL::varchar), ('b'::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x, NULL) from (values ('a'::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_string(x, NULL) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a   b'
}

@test "fn: sparql.group_concat_string(x, NULL) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'a b c d'
}

@test "fn: sparql.group_concat_string(x, ''::varchar) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_string(x, ''::varchar) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x, ''::varchar) from (values ('a'::varchar), (NULL::varchar), ('b'::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x, ''::varchar) from (values ('a'::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_string(x, ''::varchar) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_string(x, ''::varchar) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'abcd'
}

@test "fn: sparql.group_concat_string(x, '-'::varchar) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_string(x, '-'::varchar) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x, '-'::varchar) from (values ('a'::varchar), (NULL::varchar), ('b'::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x, '-'::varchar) from (values ('a'::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a-b'
}

@test "fn: sparql.group_concat_string(x, '-'::varchar) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a---b'
}

@test "fn: sparql.group_concat_string(x, '-'::varchar) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'a-b-c-d'
}

@test "fn: sparql.group_concat_string(x, ' | '::varchar) from (values (NULL::varchar)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_string(x, ' | '::varchar) from (values (NULL::varchar), (NULL::varchar), (NULL::varchar), (NULL::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x, ' | '::varchar) from (values ('a'::varchar), (NULL::varchar), ('b'::varchar)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_string(x, ' | '::varchar) from (values ('a'::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a | b'
}

@test "fn: sparql.group_concat_string(x, ' | '::varchar) from (values ('a'::varchar), (''::varchar), (''::varchar), ('b'::varchar)) as tab(x)" {
  expect_output 'a |  |  | b'
}

@test "fn: sparql.group_concat_string(x, ' | '::varchar) from (values ('a'::varchar), ('b'::varchar), ('c'::varchar), ('d'::varchar)) as tab(x)" {
  expect_output 'a | b | c | d'
}



####
# group_concat_rdfbox()
#

@test "fn: sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a   b'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output 'a b c d'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a   b'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a b c d'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a   b'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output 'a b c d'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a   b'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a b c d'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar))) as tab(x)" {
  expect_output 'a b'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, NULL) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output 'abcd'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'abcd'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar))) as tab(x)" {
  expect_output 'ab'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, ''::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a-b'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a---b'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output 'a-b-c-d'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a-b'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a---b'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a-b-c-d'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a-b'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a-b'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar))) as tab(x)" {
  expect_output 'a-b'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, '-'::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox)) as tab(x) where false" {
  expect_output ''
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a | b'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string(''::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a |  |  | b'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar)), (sparql.rdfbox_create_from_string('c'::varchar)), (sparql.rdfbox_create_from_string('d'::varchar))) as tab(x)" {
  expect_output 'a | b | c | d'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a | b'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a |  |  | b'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('c'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('d'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a | b | c | d'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output 'a | b'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))) as tab(x)" {
  expect_output 'a | b'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_langstring('a'::varchar, 'en'::varchar)), (sparql.rdfbox_create_from_langstring('b'::varchar, 'us'::varchar))) as tab(x)" {
  expect_output 'a | b'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_integer('0'::decimal)), (sparql.rdfbox_create_from_string('b'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.group_concat_rdfbox(x, ' | '::varchar) from (values (sparql.rdfbox_create_from_string('a'::varchar)), (sparql.rdfbox_create_from_integer('0'::decimal))) as tab(x)" {
  expect_output '(null)'
}



####
# sample()
#

@test "fn: sparql.sample(x) from (values (NULL::int4)) as tab(x) where false" {
  expect_output '(null)'
}

@test "fn: sparql.sample(x) from (values (NULL::int4), (NULL::int4), (NULL::int4)) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.sample(x) from (values (NULL::int4), ('1'::int4), (NULL::int4)) as tab(x)" {
  expect_output '1'
}

@test "fn: sparql.sample(x) from (values (NULL::varchar), ('abc'::varchar), (NULL::varchar)) as tab(x)" {
  expect_output 'abc'
}

@test "fn: sparql.sample(x) from (values (NULL::sparql.rdfbox), (sparql.rdfbox_create_from_string('a'::varchar)), (NULL::sparql.rdfbox)) as tab(x)" {
  expect_output '"a"^^<http://www.w3.org/2001/XMLSchema#string>'
}



####
# the integer types derived from xsd:integer
#

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_byte('2'::int2)), (sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))) as tab(x)" {
  expect_output '"18446744073709551617"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_unsignedbyte('2'::int2)), (sparql.rdfbox_create_from_unsignedshort('3'::int4)), (sparql.rdfbox_create_from_unsignedint('4'::int8)), (sparql.rdfbox_create_from_nonpositiveinteger('-5'::decimal)), (sparql.rdfbox_create_from_negativeinteger('-6'::decimal)), (sparql.rdfbox_create_from_nonnegativeinteger('7'::decimal)), (sparql.rdfbox_create_from_positiveinteger('8'::decimal))) as tab(x)" {
  expect_output '"13"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_positiveinteger('2'::decimal)), (sparql.rdfbox_create_from_decimal('3'::decimal))) as tab(x)" {
  expect_output '"5.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_unsignedbyte('2'::int2)), (sparql.rdfbox_create_from_float('3'::float4))) as tab(x)" {
  expect_output '"5.0E0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)), (sparql.rdfbox_create_from_double('1'::float8))) as tab(x)" {
  expect_output '"1.8446744073709552E19"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.sum_rdfbox(x) from (values (sparql.rdfbox_create_from_byte('2'::int2)), (sparql.rdfbox_create_from_string('3'::varchar))) as tab(x)" {
  expect_output '(null)'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_unsignedbyte('2'::int2)), (sparql.rdfbox_create_from_unsignedshort('4'::int4))) as tab(x)" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)), (sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))) as tab(x)" {
  expect_output '"18446744073709551615.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "fn: sparql.avg_rdfbox(x) from (values (sparql.rdfbox_create_from_negativeinteger('-1'::decimal)), (sparql.rdfbox_create_from_double('2'::float8))) as tab(x)" {
  expect_output '"5.0E-1"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)), (sparql.rdfbox_create_from_long('1'::int8))) as tab(x)" {
  expect_output '"18446744073709551615"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_byte('1'::int2)), (sparql.rdfbox_create_from_unsignedbyte('1'::int2))) as tab(x)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "fn: sparql.max_rdfbox(x) from (values (sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal)), (sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal))) as tab(x)" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal)), (sparql.rdfbox_create_from_long('1'::int8))) as tab(x)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "fn: sparql.min(x) from (values (sparql.rdfbox_create_from_byte('-1'::int2)), (sparql.rdfbox_create_from_unsignedbyte('0'::int2))) as tab(x)" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#byte>'
}
