load ../psql_tests.bash



####
# rdfbox_get_userliteral_typedvalue_of_type()
#

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean('f'::bool), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean('f'::bool), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean('f'::bool), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('f'::bool, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('f'::bool, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('f'::bool, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('f'::bool, ' false '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('f'::bool, ' false '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('f'::bool, ' false '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean('t'::bool), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean('t'::bool), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean('t'::bool), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte('127'::int2), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte('127'::int2), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte('127'::int2), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ' 127 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ' 127 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ' 127 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte('255'::int2), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte('255'::int2), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte('255'::int2), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ' 255 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ' 255 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ' 255 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short('32767'::int2), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short('32767'::int2), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short('32767'::int2), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort('65535'::int4), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort('65535'::int4), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort('65535'::int4), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ' 65535 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ' 65535 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ' 65535 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int('2147483647'::int4), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int('2147483647'::int4), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int('2147483647'::int4), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint('4294967295'::int8), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint('4294967295'::int8), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint('4294967295'::int8), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ' 4294967295 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ' 4294967295 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ' 4294967295 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ' 18446744073709551615 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ' 18446744073709551615 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ' 18446744073709551615 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger('18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger('18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger('18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_string('abc'::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_string('abc'::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_string('abc'::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output 'abc'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output 'abc'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output 'abc'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output 'abc'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output 'abc'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output 'abc'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123'::int4, 'http://example.org'::varchar), 'http://example.org'::varchar, null::int4)" {
  expect_output '123'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123'::int4, 'http://example.org'::varchar), 'http://example.org'::varchar, null::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123'::int4, 'http://example.org'::varchar), 'http://example.org'::varchar, null::int4, 'false'::bool)" {
  expect_output '123'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('123'::int4, 'http://example.org'::varchar, ' 123 '::varchar), 'http://example.org'::varchar, null::int4)" {
  expect_output '123'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('123'::int4, 'http://example.org'::varchar, ' 123 '::varchar), 'http://example.org'::varchar, null::int4, 'true'::bool)" {
  expect_output '123'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical('123'::int4, 'http://example.org'::varchar, ' 123 '::varchar), 'http://example.org'::varchar, null::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123:integer'::sparql.ubox, 'http://example.org'::varchar), 'http://example.org'::varchar, null::int4)" {
  expect_output '123'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123:integer'::sparql.ubox, 'http://example.org'::varchar), 'http://example.org'::varchar, null::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123:integer'::sparql.ubox, 'http://example.org'::varchar), 'http://example.org'::varchar, null::int4, 'false'::bool)" {
  expect_output '123'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar), 'http://example.org'::varchar, null::sparql.ubox)" {
  expect_output '123:integer'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar), 'http://example.org'::varchar, null::sparql.ubox, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar), 'http://example.org'::varchar, null::sparql.ubox, 'false'::bool)" {
  expect_output '123:integer'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar, ' 123 '::varchar), 'http://example.org'::varchar, null::sparql.ubox)" {
  expect_output '123:integer'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar, ' 123 '::varchar), 'http://example.org'::varchar, null::sparql.ubox, 'true'::bool)" {
  expect_output '123:integer'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral_with_lexical(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar, ' 123 '::varchar), 'http://example.org'::varchar, null::sparql.ubox, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'http://example.org'::varchar, null::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'http://example.org'::varchar, null::varchar, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'http://example.org'::varchar, null::varchar, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123'::int4, 'http://example.org'::varchar), 'http://example.org'::varchar, null::int8)" {
  expect_error
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral(sparql.ubox_create('123:integer'::sparql.ubox), 'http://example.org'::varchar), 'http://example.org'::varchar, null::int4)" {
  expect_error
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123'::int4, 'http://example.org'::varchar), 'http://example.org/other'::varchar, null::int8)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(null::sparql.rdfbox, 'http://example.org'::varchar, null::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123'::int4, 'http://example.org'::varchar), null::varchar, null::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_userliteral_typedvalue_of_type(sparql.rdfbox_create_from_userliteral('123'::int4, 'http://example.org'::varchar), 'http://example.org'::varchar, null::int4, null::bool)" {
  expect_output '(null)'
}
