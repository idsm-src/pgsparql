load ../psql_tests.bash



####
# rdfbox_get_datetime_lexical_of_zone()
#

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4), '-2147483648'::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4), '-2147483648'::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4, ''::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4, ''::varchar), '-2147483648'::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4, ''::varchar), '-2147483648'::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4, ' -0100-02-18T10:22:50Z '::varchar), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4, ' -0100-02-18T10:22:50Z '::varchar), '-2147483648'::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4, ' -0100-02-18T10:22:50Z '::varchar), '-2147483648'::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4), '-2147483648'::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4), '-2147483648'::int4, 'false'::bool)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4, ''::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4, ''::varchar), '-2147483648'::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4, ''::varchar), '-2147483648'::int4, 'false'::bool)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4, ' 0000-03-16T00:00:00 '::varchar), '-2147483648'::int4)" {
  expect_output ' 0000-03-16T00:00:00 '
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4, ' 0000-03-16T00:00:00 '::varchar), '-2147483648'::int4, 'true'::bool)" {
  expect_output ' 0000-03-16T00:00:00 '
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4, ' 0000-03-16T00:00:00 '::varchar), '-2147483648'::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4, ' 1990-10-10T00:22:30-14:00 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4, ' 1990-10-10T00:22:30-14:00 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4, ' 1990-10-10T00:22:30-14:00 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4), (14*60*60)::int4)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4), (14*60*60)::int4, 'false'::bool)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4, ''::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output ''
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4, ' 2010-11-18T00:59:59.99+14:00 '::varchar), (14*60*60)::int4)" {
  expect_output ' 2010-11-18T00:59:59.99+14:00 '
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4, ' 2010-11-18T00:59:59.99+14:00 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output ' 2010-11-18T00:59:59.99+14:00 '
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_datetime_with_lexical('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4, ' 2010-11-18T00:59:59.99+14:00 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean('t'::bool), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean('t'::bool), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean('t'::bool), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_boolean_with_lexical('t'::bool, ' true '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short('32767'::int2), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short('32767'::int2), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short('32767'::int2), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_short_with_lexical('32767'::int2, ' 32767 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int('2147483647'::int4), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int('2147483647'::int4), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int('2147483647'::int4), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_int_with_lexical('2147483647'::int4, ' 2147483647 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long('9223372036854775807'::int8), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long('9223372036854775807'::int8), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long('9223372036854775807'::int8), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_long_with_lexical('9223372036854775807'::int8, ' 9223372036854775807 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_integer_with_lexical('9223372036854775808'::decimal, ' 9223372036854775808 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_decimal_with_lexical('9223372036854775808.765'::decimal, ' 9223372036854775808.765 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float('3.402823466e38'::float4), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float('3.402823466e38'::float4), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float('3.402823466e38'::float4), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_float_with_lexical('3.402823466e38'::float4, ' 3.4028235E38 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_double_with_lexical('1.7976931348623158e308'::float8, ' 1.7976931348623157E308 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_date_with_lexical('2010-11-18+14:00'::sparql.zoneddate, ' 2010-11-18+14:00 '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_daytimeduration_with_lexical('9223372036854775807'::int8, ' P106751991DT4H54.775807S '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_string('abc'::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_string('abc'::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_string('abc'::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral('abc'::varchar, 'http://example.org'::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ''::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_userliteral_with_lexical('abc'::varchar, 'http://example.org'::varchar, ' abc '::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_iri('http://example.org'::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_iri('http://example.org'::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_iri('http://example.org'::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), (14*60*60)::int4, 'true'::bool)" {
  expect_output '(null)'
}

@test "fn: sparql.rdfbox_get_datetime_lexical_of_zone(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), (14*60*60)::int4, 'false'::bool)" {
  expect_output '(null)'
}
