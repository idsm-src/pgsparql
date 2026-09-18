load ../psql_tests.bash



####
# rdfbox_get_iblanknode_value_of_segment()
#

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_iblanknode('2147483647'::int4, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '2147483647'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_iblanknode('-2147483648'::int4, '2147483647'::int4), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_boolean('t'::bool), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_byte('127'::int2), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_byte_with_lexical('127'::int2, ' 127 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedbyte('255'::int2), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedbyte_with_lexical('255'::int2, ' 255 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_short('32767'::int2), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedshort('65535'::int4), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedshort_with_lexical('65535'::int4, ' 65535 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_int('2147483647'::int4), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedint('4294967295'::int8), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedint_with_lexical('4294967295'::int8, ' 4294967295 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_long('9223372036854775807'::int8), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_unsignedlong_with_lexical('18446744073709551615'::decimal, ' 18446744073709551615 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_nonpositiveinteger('-18446744073709551616'::decimal), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_nonpositiveinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_negativeinteger('-18446744073709551616'::decimal), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_negativeinteger_with_lexical('-18446744073709551616'::decimal, ' -18446744073709551616 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_nonnegativeinteger('18446744073709551616'::decimal), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_nonnegativeinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_positiveinteger('18446744073709551616'::decimal), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_positiveinteger_with_lexical('18446744073709551616'::decimal, ' 18446744073709551616 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_float('3.402823466e38'::float4), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_string('abc'::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_iri('http://example.org'::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}
