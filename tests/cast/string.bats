load ../psql_tests.bash



@test "sparql.cast_as_string_from_boolean('f'::bool)" {
  expect_output 'false'
}

@test "sparql.cast_as_string_from_boolean('true'::bool)" {
  expect_output 'true'
}

@test "sparql.cast_as_string_from_short('-32768'::int2)" {
  expect_output '-32768'
}

@test "sparql.cast_as_string_from_short('32767'::int2)" {
  expect_output '32767'
}

@test "sparql.cast_as_string_from_int('-2147483648'::int4)" {
  expect_output '-2147483648'
}

@test "sparql.cast_as_string_from_int('2147483647'::int4)" {
  expect_output '2147483647'
}

@test "sparql.cast_as_string_from_long('-9223372036854775808'::int8)" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_string_from_long('9223372036854775807'::int8)" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_string_from_integer('-92233720368547758080'::decimal)" {
  expect_output '-92233720368547758080'
}

@test "sparql.cast_as_string_from_integer('92233720368547758080'::decimal)" {
  expect_output '92233720368547758080'
}

@test "sparql.cast_as_string_from_float('-inf'::float4)" {
  expect_output '-INF'
}

@test "sparql.cast_as_string_from_float('-3.402823466e38'::float4)" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_string_from_float('-1.175494351e-38'::float4)" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_string_from_float('1.175494351e-38'::float4)" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_string_from_float('3.402823466e38'::float4)" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_string_from_float('inf'::float4)" {
  expect_output 'INF'
}

@test "sparql.cast_as_string_from_float('nan'::float4)" {
  expect_output 'NaN'
}

@test "sparql.cast_as_string_from_double('-inf'::float8)" {
  expect_output '-INF'
}

@test "sparql.cast_as_string_from_double('-1.7976931348623158e308'::float8)" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_string_from_double('-2.2250738585072014e-308'::float8)" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.cast_as_string_from_double('2.2250738585072014e-308'::float8)" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.cast_as_string_from_double('1.7976931348623158e308'::float8)" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_string_from_double('inf'::float8)" {
  expect_output 'INF'
}

@test "sparql.cast_as_string_from_double('nan'::float8)" {
  expect_output 'NaN'
}

@test "sparql.cast_as_string_from_datetime('0000-02-18T10:00:00Z'::sparql.zoneddatetime)" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "sparql.cast_as_string_from_datetime('-0010-02-18T20:00:00Z'::sparql.zoneddatetime)" {
  expect_output '-0010-02-18T20:00:00Z'
}

@test "sparql.cast_as_string_from_datetime('0010-02-18T20:00:00+00:00'::sparql.zoneddatetime)" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "sparql.cast_as_string_from_datetime('0010-02-18T20:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "sparql.cast_as_string_from_datetime('1990-02-18T00:00:00+14:00'::sparql.zoneddatetime)" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.cast_as_string_from_datetime('2010-02-18T00:00:00-14:00'::sparql.zoneddatetime)" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.cast_as_string_from_datetime('2010-02-18T20:00:00'::sparql.zoneddatetime)" {
  expect_output '2010-02-18T20:00:00'
}

@test "sparql.cast_as_string_from_datetime('0001-02-18T10:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "sparql.cast_as_string_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '-0009-02-18T20:00:00Z'
}

@test "sparql.cast_as_string_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4)" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "sparql.cast_as_string_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "sparql.cast_as_string_from_datetime('1990-02-18T00:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.cast_as_string_from_datetime('2010-02-18T00:00:00-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.cast_as_string_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4)" {
  expect_output '2010-02-18T20:00:00'
}

@test "sparql.cast_as_string_from_date('0000-02-18Z'::sparql.zoneddate)" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_string_from_date('-0010-02-18Z'::sparql.zoneddate)" {
  expect_output '-0010-02-18Z'
}

@test "sparql.cast_as_string_from_date('0010-02-18+00:00'::sparql.zoneddate)" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_string_from_date('0010-02-18+10:30'::sparql.zoneddate)" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.cast_as_string_from_date('1990-02-18+14:00'::sparql.zoneddate)" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.cast_as_string_from_date('2010-02-18-14:00'::sparql.zoneddate)" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.cast_as_string_from_date('2010-02-18'::sparql.zoneddate)" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_string_from_date('0001-02-18 BC'::date, 0::int4)" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_string_from_date('0010-02-18 BC'::date, 0::int4)" {
  expect_output '-0009-02-18Z'
}

@test "sparql.cast_as_string_from_date('0010-02-18'::date, 0::int4)" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_string_from_date('0010-02-18'::date, ((10*60+30)*60)::int4)" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.cast_as_string_from_date('1990-02-18'::date, (14*60*60)::int4)" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.cast_as_string_from_date('2010-02-18'::date, (-14*60*60)::int4)" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.cast_as_string_from_date('2010-02-18'::date, '-2147483648'::int4)" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_string_from_daytimeduration('-9223372036854775808'::int8)" {
  expect_output '-P106751991DT4H54.775808S'
}

@test "sparql.cast_as_string_from_daytimeduration('-9223372036854775807'::int8)" {
  expect_output '-P106751991DT4H54.775807S'
}

@test "sparql.cast_as_string_from_daytimeduration('9223372036854775807'::int8)" {
  expect_output 'P106751991DT4H54.775807S'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'false'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_boolean('true'::bool))" {
  expect_output 'true'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_integer('-92233720368547758080'::decimal))" {
  expect_output '-92233720368547758080'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_integer('92233720368547758080'::decimal))" {
  expect_output '92233720368547758080'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '-INF'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '-3.4028235e+38'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '-1.1754944e-38'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '1.1754944e-38'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '3.4028235e+38'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output 'INF'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output 'NaN'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '-INF'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8))" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8))" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8))" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output 'INF'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output 'NaN'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0000-02-18T10:00:00Z'::sparql.zoneddatetime))" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('-0010-02-18T20:00:00Z'::sparql.zoneddatetime))" {
  expect_output '-0010-02-18T20:00:00Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::sparql.zoneddatetime))" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::sparql.zoneddatetime))" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T00:00:00+14:00'::sparql.zoneddatetime))" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T00:00:00-14:00'::sparql.zoneddatetime))" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00'::sparql.zoneddatetime))" {
  expect_output '2010-02-18T20:00:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0001-02-18T10:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '-0009-02-18T20:00:00Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4))" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T00:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T00:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4))" {
  expect_output '2010-02-18T20:00:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0000-02-18Z'::sparql.zoneddate))" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('-0010-02-18Z'::sparql.zoneddate))" {
  expect_output '-0010-02-18Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18+00:00'::sparql.zoneddate))" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18+10:30'::sparql.zoneddate))" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('1990-02-18+14:00'::sparql.zoneddate))" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18-14:00'::sparql.zoneddate))" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::sparql.zoneddate))" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18 BC'::date, 0::int4))" {
  expect_output '-0009-02-18Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, 0::int4))" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('1990-02-18'::date, (14*60*60)::int4))" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, (-14*60*60)::int4))" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, '-2147483648'::int4))" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_daytimeduration('-9223372036854775808'::int8))" {
  expect_output '-P106751991DT4H54.775808S'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_daytimeduration('-9223372036854775807'::int8))" {
  expect_output '-P106751991DT4H54.775807S'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output 'P106751991DT4H54.775807S'
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_string(' hello '::varchar))" {
  expect_output ' hello '
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_string_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output 'http://false.org'
}
