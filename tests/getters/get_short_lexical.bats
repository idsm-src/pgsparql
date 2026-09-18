load ../psql_tests.bash



####
# rdfbox_get_short_lexical()
#

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short('-32768'::int2), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short('-32768'::int2), 'false'::bool)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('-32768'::int2, ''::varchar))" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('-32768'::int2, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('-32768'::int2, ''::varchar), 'false'::bool)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('-32768'::int2, ' -32768 '::varchar))" {
  expect_output ' -32768 '
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('-32768'::int2, ' -32768 '::varchar), 'true'::bool)" {
  expect_output ' -32768 '
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('-32768'::int2, ' -32768 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short('32767'::int2), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short('32767'::int2), 'false'::bool)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar))" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), 'false'::bool)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar))" {
  expect_output ' 32767 '
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), 'true'::bool)" {
  expect_output ' 32767 '
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean('t'::bool), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean('t'::bool), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte('127'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte('127'::int2), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte('127'::int2), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ' 127 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ' 127 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ' 127 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte('255'::int2), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte('255'::int2), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ' 255 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ' 255 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ' 255 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort('65535'::int4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort('65535'::int4), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ' 65535 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ' 65535 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ' 65535 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int('2147483647'::int4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int('2147483647'::int4), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint('4294967295'::int8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint('4294967295'::int8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ' 4294967295 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ' 4294967295 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ' 4294967295 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ' 18446744073709551615 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ' 18446744073709551615 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ' 18446744073709551615 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger('18446744073709551616'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger('18446744073709551616'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger('18446744073709551616'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_string('abc'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_string('abc'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_short_lexical(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'false'::bool)" {
  expect_output '(null)'
}
