load ../psql_tests.bash



####
# rdfbox_promote_to_short()
#

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output ''
}



####
# rdfbox_promote_to_int()
#

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output ''
}



####
# rdfbox_promote_to_long()
#

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output ''
}



####
# rdfbox_promote_to_integer()
#

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output ''
}



####
# rdfbox_promote_to_decimal()
#

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output ''
}



####
# rdfbox_promote_to_float()
#

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output ''
}



####
# rdfbox_promote_to_double()
#

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output '-1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '1'
}

@test "sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output ''
}
