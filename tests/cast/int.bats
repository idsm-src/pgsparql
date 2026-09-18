load ../psql_tests.bash



@test "fn: sparql.cast_as_int_from_boolean('f'::bool)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_boolean('t'::bool)" {
  expect_output '1'
}

@test "fn: sparql.cast_as_int_from_byte('-128'::int2)" {
  expect_output '-128'
}

@test "fn: sparql.cast_as_int_from_byte('127'::int2)" {
  expect_output '127'
}

@test "fn: sparql.cast_as_int_from_unsignedbyte('0'::int2)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_unsignedbyte('255'::int2)" {
  expect_output '255'
}

@test "fn: sparql.cast_as_int_from_short('-32768'::int2)" {
  expect_output '-32768'
}

@test "fn: sparql.cast_as_int_from_short('32767'::int2)" {
  expect_output '32767'
}

@test "fn: sparql.cast_as_int_from_unsignedshort('0'::int4)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_unsignedshort('65535'::int4)" {
  expect_output '65535'
}

@test "fn: sparql.cast_as_int_from_unsignedint('0'::int8)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_unsignedint('2147483647'::int8)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_unsignedint('2147483648'::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_unsignedint('4294967295'::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_long('-2147483649'::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_long('-2147483648'::int8)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_long('2147483647'::int8)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_long('2147483648'::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_unsignedlong('0'::decimal)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_unsignedlong('2147483647'::decimal)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_unsignedlong('2147483648'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_unsignedlong('18446744073709551615'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_integer('-infinity'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_integer('-2147483649'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_integer('-2147483648'::decimal)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_integer('2147483647'::decimal)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_integer('2147483648'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_integer('infinity'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_integer('nan'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_nonpositiveinteger('-18446744073709551616'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_nonpositiveinteger('-2147483649'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_nonpositiveinteger('-2147483648'::decimal)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_nonpositiveinteger('0'::decimal)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_negativeinteger('-18446744073709551616'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_negativeinteger('-2147483649'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_negativeinteger('-2147483648'::decimal)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_negativeinteger('-1'::decimal)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_int_from_nonnegativeinteger('0'::decimal)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_nonnegativeinteger('2147483647'::decimal)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_nonnegativeinteger('2147483648'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_nonnegativeinteger('18446744073709551616'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_positiveinteger('1'::decimal)" {
  expect_output '1'
}

@test "fn: sparql.cast_as_int_from_positiveinteger('2147483647'::decimal)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_positiveinteger('2147483648'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_positiveinteger('18446744073709551616'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_decimal('-infinity'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_decimal('-2147483649.0'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_decimal('-2147483648.9'::decimal)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_decimal('2147483647.9'::decimal)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_decimal('2147483648.9'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_decimal('infinity'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_decimal('nan'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_float('-inf'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_float('-2147483777'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_float('-2147483776'::float4)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_float('-16777215'::float4)" {
  expect_output '-16777215'
}

@test "fn: sparql.cast_as_int_from_float('16777215'::float4)" {
  expect_output '16777215'
}

@test "fn: sparql.cast_as_int_from_float('2147483583'::float4)" {
  expect_output '2147483520'
}

@test "fn: sparql.cast_as_int_from_float('2147483584'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_float('inf'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_float('nan'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double('-inf'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double('-2147483649'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double('-2147483648'::float8)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_double('2147483647'::float8)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_double('2147483648'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double('inf'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double('nan'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_string(' -infinity '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_string(' -2147483649 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_string(' -2147483648 '::varchar)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_string(' 2147483647 '::varchar)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_string(' 2147483648 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_string(' infinity '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_string(' nan '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_string(' 10.0 '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_string(' '::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_string(''::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '1'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_long('-2147483649'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_long('-2147483648'::int8))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_long('2147483647'::int8))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_long('2147483648'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_integer('-infinity'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_integer('-2147483649'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_integer('-2147483648'::decimal))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_integer('2147483647'::decimal))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_integer('2147483648'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_integer('infinity'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_integer('nan'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_decimal('-infinity'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_decimal('-2147483649.0'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_decimal('-2147483648.9'::decimal))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_decimal('2147483647.9'::decimal))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_decimal('2147483648.9'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_decimal('infinity'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_decimal('nan'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('-2147483777'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('-2147483776'::float4))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('-16777215'::float4))" {
  expect_output '-16777215'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('16777215'::float4))" {
  expect_output '16777215'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('2147483583'::float4))" {
  expect_output '2147483520'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('2147483584'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_double('-2147483649'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_double('-2147483648'::float8))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_double('2147483647'::float8))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_double('2147483648'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' -infinity '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' -2147483649 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' -2147483648 '::varchar))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' 2147483647 '::varchar))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' 2147483648 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' infinity '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' nan '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' 10.0 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_iri('http://123.org'::varchar))" {
  expect_output '(null)'
}



####
# the range has to be checked before the conversion, which is undefined for NaN
# and for anything the target type cannot hold
#

@test "fn: sparql.cast_as_int_from_double('NaN'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double('Infinity'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double('-Infinity'::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double(2147483648.0::float8)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_double(2147483647.0::float8)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_double(-2147483648.0::float8)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_float(2147483648.0::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_float('NaN'::float4)" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_byte('-1'::int2))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '65535'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_unsignedint('2147483647'::int8))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_unsignedint('2147483648'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_unsignedlong('2147483647'::decimal))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_unsignedlong('2147483648'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_nonpositiveinteger('-2147483648'::decimal))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_negativeinteger('-2147483649'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal))" {
  expect_output '0'
}

@test "fn: sparql.cast_as_int_from_rdfbox(sparql.rdfbox_create_from_positiveinteger('2147483648'::decimal))" {
  expect_output '(null)'
}
