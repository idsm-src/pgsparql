load ../psql_tests.bash



####
# rdfbox_promote_to_short()
#

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_int()
#

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_long()
#

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_integer()
#

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_decimal()
#

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_float()
#

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_double()
#

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_short('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_int('-1'::int4))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_float('-1'::float4))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_float('1'::float4))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_double('-1'::float8))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# the integer types derived from xsd:integer
#

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_byte('-128'::int2))" {
  expect_output '-128'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_unsignedshort('1'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_unsignedlong('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_short(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_byte('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '65535'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_unsignedint('1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_int(sparql.rdfbox_create_from_nonnegativeinteger('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '65535'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '4294967295'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_unsignedlong('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_long(sparql.rdfbox_create_from_negativeinteger('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '4294967295'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '18446744073709551615'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal))" {
  expect_output '0'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_negativeinteger('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal))" {
  expect_output '0'
}

@test "fn: sparql.rdfbox_promote_to_integer(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal))" {
  expect_output '18446744073709551616'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '18446744073709551615'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_decimal(sparql.rdfbox_create_from_byte('-128'::int2))" {
  expect_output '-128'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '1.8446744e+19'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_byte('-128'::int2))" {
  expect_output '-128'
}

@test "fn: sparql.rdfbox_promote_to_float(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '1.8446744073709552e+19'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '4294967295'
}

@test "fn: sparql.rdfbox_promote_to_double(sparql.rdfbox_create_from_negativeinteger('-1'::decimal))" {
  expect_output '-1'
}



####
# rdfbox_promote_to_byte()
#

@test "fn: sparql.rdfbox_promote_to_byte(sparql.rdfbox_create_from_byte('-128'::int2))" {
  expect_output '-128'
}

@test "fn: sparql.rdfbox_promote_to_byte(sparql.rdfbox_create_from_byte('127'::int2))" {
  expect_output '127'
}

@test "fn: sparql.rdfbox_promote_to_byte(sparql.rdfbox_create_from_unsignedbyte('0'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_byte(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_byte(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_byte(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_unsignedbyte()
#

@test "fn: sparql.rdfbox_promote_to_unsignedbyte(sparql.rdfbox_create_from_unsignedbyte('0'::int2))" {
  expect_output '0'
}

@test "fn: sparql.rdfbox_promote_to_unsignedbyte(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.rdfbox_promote_to_unsignedbyte(sparql.rdfbox_create_from_byte('0'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedbyte(sparql.rdfbox_create_from_unsignedshort('1'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedbyte(sparql.rdfbox_create_from_nonnegativeinteger('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedbyte(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_unsignedshort()
#

@test "fn: sparql.rdfbox_promote_to_unsignedshort(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.rdfbox_promote_to_unsignedshort(sparql.rdfbox_create_from_unsignedshort('0'::int4))" {
  expect_output '0'
}

@test "fn: sparql.rdfbox_promote_to_unsignedshort(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '65535'
}

@test "fn: sparql.rdfbox_promote_to_unsignedshort(sparql.rdfbox_create_from_short('1'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedshort(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedshort(sparql.rdfbox_create_from_unsignedint('1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedshort(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_unsignedint()
#

@test "fn: sparql.rdfbox_promote_to_unsignedint(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.rdfbox_promote_to_unsignedint(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '65535'
}

@test "fn: sparql.rdfbox_promote_to_unsignedint(sparql.rdfbox_create_from_unsignedint('0'::int8))" {
  expect_output '0'
}

@test "fn: sparql.rdfbox_promote_to_unsignedint(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '4294967295'
}

@test "fn: sparql.rdfbox_promote_to_unsignedint(sparql.rdfbox_create_from_int('1'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedint(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedint(sparql.rdfbox_create_from_unsignedlong('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedint(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_unsignedlong()
#

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '65535'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '4294967295'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_unsignedlong('0'::decimal))" {
  expect_output '0'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '18446744073709551615'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_long('1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_nonnegativeinteger('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_unsignedlong(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_nonpositiveinteger()
#

@test "fn: sparql.rdfbox_promote_to_nonpositiveinteger(sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal))" {
  expect_output '0'
}

@test "fn: sparql.rdfbox_promote_to_nonpositiveinteger(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal))" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.rdfbox_promote_to_nonpositiveinteger(sparql.rdfbox_create_from_negativeinteger('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_nonpositiveinteger(sparql.rdfbox_create_from_byte('-1'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_nonpositiveinteger(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_nonpositiveinteger(sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_nonpositiveinteger(sparql.rdfbox_create_from_decimal('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_nonpositiveinteger(sparql.rdfbox_create_from_string('-1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_negativeinteger()
#

@test "fn: sparql.rdfbox_promote_to_negativeinteger(sparql.rdfbox_create_from_negativeinteger('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.rdfbox_promote_to_negativeinteger(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal))" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.rdfbox_promote_to_negativeinteger(sparql.rdfbox_create_from_nonpositiveinteger('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_negativeinteger(sparql.rdfbox_create_from_integer('-1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_negativeinteger(sparql.rdfbox_create_from_long('-1'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_negativeinteger(sparql.rdfbox_create_from_string('-1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_nonnegativeinteger()
#

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '65535'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '4294967295'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '18446744073709551615'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal))" {
  expect_output '0'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal))" {
  expect_output '18446744073709551616'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_byte('1'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_decimal('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_nonnegativeinteger(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}



####
# rdfbox_promote_to_positiveinteger()
#

@test "fn: sparql.rdfbox_promote_to_positiveinteger(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.rdfbox_promote_to_positiveinteger(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal))" {
  expect_output '18446744073709551616'
}

@test "fn: sparql.rdfbox_promote_to_positiveinteger(sparql.rdfbox_create_from_nonnegativeinteger('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_positiveinteger(sparql.rdfbox_create_from_unsignedlong('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_positiveinteger(sparql.rdfbox_create_from_integer('1'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_promote_to_positiveinteger(sparql.rdfbox_create_from_string('1'::varchar))" {
  expect_output '(null)'
}
