load ../psql_tests.bash



####
# rdfbox_get_langstring_value_of_lang()
#

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_langstring('123'::varchar, 'en'::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_langstring('abc'::varchar, 'cy'::varchar), 'cy'::varchar)" {
  expect_output 'abc'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_boolean('t'::bool), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_short('32767'::int2), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_int('2147483647'::int4), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime, ' 2010-11-18T00:59:59.99+14:00 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_string('abc'::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'cy'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'cy'::varchar)" {
  expect_output '(null)'
}
