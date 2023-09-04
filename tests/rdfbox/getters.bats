load ../psql_tests.bash



####
# rdfbox_get_boolean()
#

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'f'
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output 't'
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_boolean(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_short()
#

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_short(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_int()
#

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_int(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_long()
#

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '-9223372036854775808'
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '9223372036854775807'
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_long(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_integer()
#

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_integer('-9223372036854775809'::decimal))" {
  expect_output '-9223372036854775809'
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output '9223372036854775808'
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_integer(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_decimal()
#

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_decimal('-9223372036854775809.876'::decimal))" {
  expect_output '-9223372036854775809.876'
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output '9223372036854775808.765'
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_decimal(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_float()
#

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '-Infinity'
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '-3.4028235e+38'
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '-1.1754944e-38'
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '1.1754944e-38'
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '3.4028235e+38'
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output 'Infinity'
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output 'NaN'
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_float(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_double()
#

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '-Infinity'
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8))" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8))" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8))" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output 'Infinity'
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output 'NaN'
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_double(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_datetime()
#

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime))" {
  expect_output '-0100-02-18T10:22:50Z'
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime))" {
  expect_output '0000-03-16T00:00:00'
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime))" {
  expect_output '1990-10-10T00:22:30-14:00'
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output '2010-11-18T00:59:59.99+14:00'
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_datetime_value()
#

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '0101-02-18 10:22:50+00 BC'
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0001-03-16 00:00:00+00 BC'
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '1990-10-10 14:22:30+00'
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '2010-11-17 10:59:59.99+00'
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}


@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}
@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_datetime_value_of_zone()
#

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '0001-03-16 00:00:00+00 BC'
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4), (14*60*60)::int4)" {
  expect_output '2010-11-17 10:59:59.99+00'
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_boolean('t'::bool), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_short('32767'::int2), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_int('2147483647'::int4), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_long('9223372036854775807'::int8), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_float('3.402823466e38'::float4), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_string('abc'::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_iri('http://example.org'::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_value_of_zone(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), (14*60*60)::int4)" {
  expect_output ''
}



####
# rdfbox_get_datetime_zone()
#

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '0'
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '-50400'
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '50400'
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_datetime_zone(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_date()
#

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_date('-0100-02-18+00:00'::sparql.zoneddate))" {
  expect_output '-0100-02-18Z'
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_date('0000-03-15'::sparql.zoneddate))" {
  expect_output '0000-03-15'
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_date('1990-10-10-14:00'::sparql.zoneddate))" {
  expect_output '1990-10-10-14:00'
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output '2010-11-18+14:00'
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_date_value()
#

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '0101-02-18 BC'
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '0001-03-15 BC'
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '1990-10-10'
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '2010-11-18'
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_date_value_of_zone()
#

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '0001-03-15 BC'
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4), (14*60*60)::int4)" {
  expect_output '2010-11-18'
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_boolean('t'::bool), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_short('32767'::int2), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_int('2147483647'::int4), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_long('9223372036854775807'::int8), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_float('3.402823466e38'::float4), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_string('abc'::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_iri('http://example.org'::varchar), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_value_of_zone(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), (14*60*60)::int4)" {
  expect_output ''
}



####
# rdfbox_get_date_zone()
#

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '0'
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '-50400'
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '50400'
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_date_zone(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_daytimeduration()
#

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_daytimeduration('-9223372036854775808'::int8))" {
  expect_output '-9223372036854775808'
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output '9223372036854775807'
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_daytimeduration(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_string()
#

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output 'abc'
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_langstring_value()
#

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_langstring('abc'::varchar, 'cy'::varchar))" {
  expect_output 'abc'
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_langstring_value_of_lang()
#

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_langstring('123'::varchar, 'en'::varchar), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_langstring('abc'::varchar, 'cy'::varchar), 'cy'::varchar)" {
  expect_output 'abc'
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_boolean('t'::bool), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_short('32767'::int2), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_int('2147483647'::int4), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_string('abc'::varchar), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'cy'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_value_of_lang(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'cy'::varchar)" {
  expect_output ''
}



####
# rdfbox_get_langstring_lang()
#

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 'en'
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_langstring('abc'::varchar, 'cy'::varchar))" {
  expect_output 'cy'
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_langstring_lang(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_typedliteral_value()
#

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar))" {
  expect_output 'abc'
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_typedliteral_value_of_type()
#

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_typedliteral('123'::varchar, 'http://example.org'::varchar), 'http://example.org/dir?query#tag'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar), 'http://example.org/dir?query#tag'::varchar)" {
  expect_output 'abc'
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_boolean('t'::bool), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_short('32767'::int2), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_int('2147483647'::int4), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_long('9223372036854775807'::int8), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_float('3.402823466e38'::float4), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_string('abc'::varchar), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), 'http://example.org'::varchar)" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_value_of_type(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), 'http://example.org'::varchar)" {
  expect_output ''
}



####
# rdfbox_get_typedliteral_type()
#

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar))" {
  expect_output 'http://example.org'
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org/dir?query#tag'::varchar))" {
  expect_output 'http://example.org/dir?query#tag'
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_typedliteral_type(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_iri()
#

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_iri('http://example.org/dir?query#tag'::varchar))" {
  expect_output 'http://example.org/dir?query#tag'
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iri(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_iblanknode()
#

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_iblanknode('-9223372034707292161'::int8))" {
  expect_output '-9223372034707292161'
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output '9223372034707292160'
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_iblanknode_value()
#

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_iblanknode('2147483647'::int4, '-2147483648'::int4))" {
  expect_output '2147483647'
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_iblanknode('-2147483648'::int4, '2147483647'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_iblanknode_value_of_segment()
#

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_iblanknode('2147483647'::int4, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '2147483647'
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_iblanknode('-2147483648'::int4, '2147483647'::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_boolean('t'::bool), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_short('32767'::int2), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_int('2147483647'::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_long('9223372036854775807'::int8), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_float('3.402823466e38'::float4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_string('abc'::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_iri('http://example.org'::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_value_of_segment(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar), '-2147483648'::int4)" {
  expect_output ''
}



####
# rdfbox_get_iblanknode_segment()
#

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_iblanknode('2147483647'::int4, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_iblanknode('-2147483648'::int4, '2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_iblanknode_segment(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}



####
# rdfbox_get_sblanknode()
#

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_sblanknode('80000000'::varchar))" {
  expect_output '80000000'
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output '7fffffffid'
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}



####
# rdfbox_get_sblanknode_value()
#

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_sblanknode(''::varchar, '-2147483648'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_sblanknode('id'::varchar, '2147483647'::int4))" {
  expect_output 'id'
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}



####
# rdfbox_get_sblanknode_value_of_segment()
#

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_sblanknode('abc'::varchar, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output 'abc'
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_sblanknode('id'::varchar, '2147483647'::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_boolean('t'::bool), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_short('32767'::int2), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_int('2147483647'::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_long('9223372036854775807'::int8), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_float('3.402823466e38'::float4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_string('abc'::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_iri('http://example.org'::varchar), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_value_of_segment(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8), '-2147483648'::int4)" {
  expect_output ''
}



####
# rdfbox_get_sblanknode_segment()
#

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_sblanknode(''::varchar, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_sblanknode('id'::varchar, '2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_sblanknode_segment(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}



####
# rdfbox_get_string_literal()
#

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_string('abc'::varchar))" {
  expect_output 'abc'
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_langstring('abc'::varchar, 'cy'::varchar))" {
  expect_output 'abc'
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_boolean('t'::bool))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_integer('9223372036854775808'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_decimal('9223372036854775808.765'::decimal))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_date('2010-11-18+14:00'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_typedliteral('abc'::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_iblanknode('9223372034707292160'::int8))" {
  expect_output ''
}

@test "sparql.rdfbox_get_string_literal(sparql.rdfbox_create_from_sblanknode('7fffffffid'::varchar))" {
  expect_output ''
}
