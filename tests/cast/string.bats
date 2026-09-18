load ../psql_tests.bash



@test "fn: sparql.cast_as_string_from_boolean('f'::bool)" {
  expect_output 'false'
}

@test "fn: sparql.cast_as_string_from_boolean('true'::bool)" {
  expect_output 'true'
}

@test "fn: sparql.cast_as_string_from_byte('-128'::int2)" {
  expect_output '-128'
}

@test "fn: sparql.cast_as_string_from_byte('127'::int2)" {
  expect_output '127'
}

@test "fn: sparql.cast_as_string_from_unsignedbyte('0'::int2)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_string_from_unsignedbyte('255'::int2)" {
  expect_output '255'
}

@test "fn: sparql.cast_as_string_from_short('-32768'::int2)" {
  expect_output '-32768'
}

@test "fn: sparql.cast_as_string_from_short('32767'::int2)" {
  expect_output '32767'
}

@test "fn: sparql.cast_as_string_from_unsignedshort('0'::int4)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_string_from_unsignedshort('65535'::int4)" {
  expect_output '65535'
}

@test "fn: sparql.cast_as_string_from_int('-2147483648'::int4)" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_string_from_int('2147483647'::int4)" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_string_from_unsignedint('0'::int8)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_string_from_unsignedint('4294967295'::int8)" {
  expect_output '4294967295'
}

@test "fn: sparql.cast_as_string_from_long('-9223372036854775808'::int8)" {
  expect_output '-9223372036854775808'
}

@test "fn: sparql.cast_as_string_from_long('9223372036854775807'::int8)" {
  expect_output '9223372036854775807'
}

@test "fn: sparql.cast_as_string_from_unsignedlong('0'::decimal)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_string_from_unsignedlong('18446744073709551615'::decimal)" {
  expect_output '18446744073709551615'
}

@test "fn: sparql.cast_as_string_from_integer('-92233720368547758080'::decimal)" {
  expect_output '-92233720368547758080'
}

@test "fn: sparql.cast_as_string_from_integer('92233720368547758080'::decimal)" {
  expect_output '92233720368547758080'
}

@test "fn: sparql.cast_as_string_from_nonpositiveinteger('-18446744073709551616'::decimal)" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.cast_as_string_from_nonpositiveinteger('0'::decimal)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_string_from_negativeinteger('-18446744073709551616'::decimal)" {
  expect_output '-18446744073709551616'
}

@test "fn: sparql.cast_as_string_from_negativeinteger('-1'::decimal)" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_string_from_nonnegativeinteger('0'::decimal)" {
  expect_output '0'
}

@test "fn: sparql.cast_as_string_from_nonnegativeinteger('18446744073709551616'::decimal)" {
  expect_output '18446744073709551616'
}

@test "fn: sparql.cast_as_string_from_positiveinteger('1'::decimal)" {
  expect_output '1'
}

@test "fn: sparql.cast_as_string_from_positiveinteger('18446744073709551616'::decimal)" {
  expect_output '18446744073709551616'
}

@test "fn: sparql.cast_as_string_from_float('-inf'::float4)" {
  expect_output '-INF'
}

@test "fn: sparql.cast_as_string_from_float('-3.402823466e38'::float4)" {
  expect_output '-3.4028235E38'
}

@test "fn: sparql.cast_as_string_from_float('-1.175494351e-38'::float4)" {
  expect_output '-1.1754944E-38'
}

@test "fn: sparql.cast_as_string_from_float('1.175494351e-38'::float4)" {
  expect_output '1.1754944E-38'
}

@test "fn: sparql.cast_as_string_from_float('3.402823466e38'::float4)" {
  expect_output '3.4028235E38'
}

@test "fn: sparql.cast_as_string_from_float('inf'::float4)" {
  expect_output 'INF'
}

@test "fn: sparql.cast_as_string_from_float('nan'::float4)" {
  expect_output 'NaN'
}

@test "fn: sparql.cast_as_string_from_double('-inf'::float8)" {
  expect_output '-INF'
}

@test "fn: sparql.cast_as_string_from_double('-1.7976931348623158e308'::float8)" {
  expect_output '-1.7976931348623157E308'
}

@test "fn: sparql.cast_as_string_from_double('-2.2250738585072014e-308'::float8)" {
  expect_output '-2.2250738585072014E-308'
}

@test "fn: sparql.cast_as_string_from_double('2.2250738585072014e-308'::float8)" {
  expect_output '2.2250738585072014E-308'
}

@test "fn: sparql.cast_as_string_from_double('1.7976931348623158e308'::float8)" {
  expect_output '1.7976931348623157E308'
}

@test "fn: sparql.cast_as_string_from_double('inf'::float8)" {
  expect_output 'INF'
}

@test "fn: sparql.cast_as_string_from_double('nan'::float8)" {
  expect_output 'NaN'
}

@test "fn: sparql.cast_as_string_from_datetime('0000-02-18T10:00:00Z'::sparql.zoneddatetime)" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "fn: sparql.cast_as_string_from_datetime('-0010-02-18T20:00:00Z'::sparql.zoneddatetime)" {
  expect_output '-0010-02-18T20:00:00Z'
}

@test "fn: sparql.cast_as_string_from_datetime('0010-02-18T20:00:00+00:00'::sparql.zoneddatetime)" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "fn: sparql.cast_as_string_from_datetime('0010-02-18T20:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "fn: sparql.cast_as_string_from_datetime('1990-02-18T00:00:00+14:00'::sparql.zoneddatetime)" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "fn: sparql.cast_as_string_from_datetime('2010-02-18T00:00:00-14:00'::sparql.zoneddatetime)" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "fn: sparql.cast_as_string_from_datetime('2010-02-18T20:00:00'::sparql.zoneddatetime)" {
  expect_output '2010-02-18T20:00:00'
}

@test "fn: sparql.cast_as_string_from_datetime('0001-02-18T10:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "fn: sparql.cast_as_string_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '-0009-02-18T20:00:00Z'
}

@test "fn: sparql.cast_as_string_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4)" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "fn: sparql.cast_as_string_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "fn: sparql.cast_as_string_from_datetime('1990-02-18T00:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "fn: sparql.cast_as_string_from_datetime('2010-02-18T00:00:00-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "fn: sparql.cast_as_string_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4)" {
  expect_output '2010-02-18T20:00:00'
}

@test "fn: sparql.cast_as_string_from_date('0000-02-18Z'::sparql.zoneddate)" {
  expect_output '0000-02-18Z'
}

@test "fn: sparql.cast_as_string_from_date('-0010-02-18Z'::sparql.zoneddate)" {
  expect_output '-0010-02-18Z'
}

@test "fn: sparql.cast_as_string_from_date('0010-02-18+00:00'::sparql.zoneddate)" {
  expect_output '0010-02-18Z'
}

@test "fn: sparql.cast_as_string_from_date('0010-02-18+10:30'::sparql.zoneddate)" {
  expect_output '0010-02-18+10:30'
}

@test "fn: sparql.cast_as_string_from_date('1990-02-18+14:00'::sparql.zoneddate)" {
  expect_output '1990-02-18+14:00'
}

@test "fn: sparql.cast_as_string_from_date('2010-02-18-14:00'::sparql.zoneddate)" {
  expect_output '2010-02-18-14:00'
}

@test "fn: sparql.cast_as_string_from_date('2010-02-18'::sparql.zoneddate)" {
  expect_output '2010-02-18'
}

@test "fn: sparql.cast_as_string_from_date('0001-02-18 BC'::date, 0::int4)" {
  expect_output '0000-02-18Z'
}

@test "fn: sparql.cast_as_string_from_date('0010-02-18 BC'::date, 0::int4)" {
  expect_output '-0009-02-18Z'
}

@test "fn: sparql.cast_as_string_from_date('0010-02-18'::date, 0::int4)" {
  expect_output '0010-02-18Z'
}

@test "fn: sparql.cast_as_string_from_date('0010-02-18'::date, ((10*60+30)*60)::int4)" {
  expect_output '0010-02-18+10:30'
}

@test "fn: sparql.cast_as_string_from_date('1990-02-18'::date, (14*60*60)::int4)" {
  expect_output '1990-02-18+14:00'
}

@test "fn: sparql.cast_as_string_from_date('2010-02-18'::date, (-14*60*60)::int4)" {
  expect_output '2010-02-18-14:00'
}

@test "fn: sparql.cast_as_string_from_date('2010-02-18'::date, '-2147483648'::int4)" {
  expect_output '2010-02-18'
}

@test "fn: sparql.cast_as_string_from_daytimeduration('-9223372036854775808'::int8)" {
  expect_output '-P106751991DT4H54.775808S'
}

@test "fn: sparql.cast_as_string_from_daytimeduration('-9223372036854775807'::int8)" {
  expect_output '-P106751991DT4H54.775807S'
}

@test "fn: sparql.cast_as_string_from_daytimeduration('9223372036854775807'::int8)" {
  expect_output 'P106751991DT4H54.775807S'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'false'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_boolean('true'::bool))" {
  expect_output 'true'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '2147483647'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '-9223372036854775808'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '9223372036854775807'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_integer('-92233720368547758080'::decimal))" {
  expect_output '-92233720368547758080'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_integer('92233720368547758080'::decimal))" {
  expect_output '92233720368547758080'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '-INF'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '-3.4028235E38'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '-1.1754944E-38'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '1.1754944E-38'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '3.4028235E38'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output 'INF'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output 'NaN'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '-INF'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8))" {
  expect_output '-1.7976931348623157E308'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8))" {
  expect_output '-2.2250738585072014E-308'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8))" {
  expect_output '2.2250738585072014E-308'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '1.7976931348623157E308'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output 'INF'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output 'NaN'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0000-02-18T10:00:00Z'::sparql.zoneddatetime))" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('-0010-02-18T20:00:00Z'::sparql.zoneddatetime))" {
  expect_output '-0010-02-18T20:00:00Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::sparql.zoneddatetime))" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::sparql.zoneddatetime))" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T00:00:00+14:00'::sparql.zoneddatetime))" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T00:00:00-14:00'::sparql.zoneddatetime))" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00'::sparql.zoneddatetime))" {
  expect_output '2010-02-18T20:00:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0001-02-18T10:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '-0009-02-18T20:00:00Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4))" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T00:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T00:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4))" {
  expect_output '2010-02-18T20:00:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0000-02-18Z'::sparql.zoneddate))" {
  expect_output '0000-02-18Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('-0010-02-18Z'::sparql.zoneddate))" {
  expect_output '-0010-02-18Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18+00:00'::sparql.zoneddate))" {
  expect_output '0010-02-18Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18+10:30'::sparql.zoneddate))" {
  expect_output '0010-02-18+10:30'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('1990-02-18+14:00'::sparql.zoneddate))" {
  expect_output '1990-02-18+14:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18-14:00'::sparql.zoneddate))" {
  expect_output '2010-02-18-14:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::sparql.zoneddate))" {
  expect_output '2010-02-18'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0000-02-18Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18 BC'::date, 0::int4))" {
  expect_output '-0009-02-18Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, 0::int4))" {
  expect_output '0010-02-18Z'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18+10:30'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('1990-02-18'::date, (14*60*60)::int4))" {
  expect_output '1990-02-18+14:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, (-14*60*60)::int4))" {
  expect_output '2010-02-18-14:00'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, '-2147483648'::int4))" {
  expect_output '2010-02-18'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_daytimeduration('-9223372036854775808'::int8))" {
  expect_output '-P106751991DT4H54.775808S'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_daytimeduration('-9223372036854775807'::int8))" {
  expect_output '-P106751991DT4H54.775807S'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output 'P106751991DT4H54.775807S'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_string(' hello '::varchar))" {
  expect_output ' hello '
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output 'http://false.org'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_byte('-128'::int2))" {
  expect_output '-128'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_unsignedbyte('255'::int2))" {
  expect_output '255'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_unsignedshort('65535'::int4))" {
  expect_output '65535'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_unsignedint('4294967295'::int8))" {
  expect_output '4294967295'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_unsignedlong('18446744073709551615'::decimal))" {
  expect_output '18446744073709551615'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_nonpositiveinteger('0'::decimal))" {
  expect_output '0'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_negativeinteger('-1'::decimal))" {
  expect_output '-1'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_nonnegativeinteger('0'::decimal))" {
  expect_output '0'
}

@test "fn: sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_positiveinteger('1'::decimal))" {
  expect_output '1'
}

@test "fn: sparql.cast_as_string_from_rdfbox('\"+5\"^^<http://www.w3.org/2001/XMLSchema#byte>'::sparql.rdfbox)" {
  expect_output '5'
}

@test "fn: sparql.cast_as_string_from_rdfbox('\"007\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox)" {
  expect_output '7'
}
