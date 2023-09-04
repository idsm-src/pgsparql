load ../psql_tests.bash



####
# isIRI()
#

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_short('0'::int2))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_int('0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_long('0'::int8))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_integer('0'::decimal))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_decimal('0'::decimal))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_float('0'::float4))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_double('0'::float8))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::sparql.zoneddatetime))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::sparql.zoneddate))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::date, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_daytimeduration('0'::int8))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output 't'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int4, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_sblanknode('00000000'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_iri_rdfbox(sparql.rdfbox_create_from_sblanknode(''::varchar, '0'::int4))" {
  expect_output 'f'
}



####
# isBlank()
#

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_short('0'::int2))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_int('0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_long('0'::int8))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_integer('0'::decimal))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_decimal('0'::decimal))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_float('0'::float4))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_double('0'::float8))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::sparql.zoneddatetime))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::sparql.zoneddate))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::date, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_daytimeduration('0'::int8))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output 't'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int4, '0'::int4))" {
  expect_output 't'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_sblanknode('00000000'::varchar))" {
  expect_output 't'
}

@test "sparql.is_blank_rdfbox(sparql.rdfbox_create_from_sblanknode(''::varchar, '0'::int4))" {
  expect_output 't'
}



####
# isLiteral()
#

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_short('0'::int2))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_int('0'::int4))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_long('0'::int8))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_integer('0'::decimal))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_decimal('0'::decimal))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_float('0'::float4))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_double('0'::float8))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::sparql.zoneddatetime))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, '0'::int4))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::sparql.zoneddate))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::date, '0'::int4))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_daytimeduration('0'::int8))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar))" {
  expect_output 't'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output 'f'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int4, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_sblanknode('00000000'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_literal_rdfbox(sparql.rdfbox_create_from_sblanknode(''::varchar, '0'::int4))" {
  expect_output 'f'
}



####
# isNumeric()
#

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_short('0'::int2))" {
  expect_output 't'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_int('0'::int4))" {
  expect_output 't'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_long('0'::int8))" {
  expect_output 't'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_integer('0'::decimal))" {
  expect_output 't'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_decimal('0'::decimal))" {
  expect_output 't'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_float('0'::float4))" {
  expect_output 't'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_double('0'::float8))" {
  expect_output 't'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::sparql.zoneddatetime))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::sparql.zoneddate))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::date, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_daytimeduration('0'::int8))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int4, '0'::int4))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_sblanknode('00000000'::varchar))" {
  expect_output 'f'
}

@test "sparql.is_numeric_rdfbox(sparql.rdfbox_create_from_sblanknode(''::varchar, '0'::int4))" {
  expect_output 'f'
}



####
# str()
#

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'false'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_boolean('true'::bool))" {
  expect_output 'true'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_short('-32768'::int2))" {
  expect_output '-32768'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_short('32767'::int2))" {
  expect_output '32767'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_int('-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_int('2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_long('-9223372036854775808'::int8))" {
  expect_output '-9223372036854775808'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_long('9223372036854775807'::int8))" {
  expect_output '9223372036854775807'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_integer('-92233720368547758080'::decimal))" {
  expect_output '-92233720368547758080'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_integer('92233720368547758080'::decimal))" {
  expect_output '92233720368547758080'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('-inf'::float4))" {
  expect_output '-INF'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('-3.402823466e38'::float4))" {
  expect_output '-3.4028235e+38'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('-1.175494351e-38'::float4))" {
  expect_output '-1.1754944e-38'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.175494351e-38'::float4))" {
  expect_output '1.1754944e-38'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('3.402823466e38'::float4))" {
  expect_output '3.4028235e+38'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('inf'::float4))" {
  expect_output 'INF'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('nan'::float4))" {
  expect_output 'NaN'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('-inf'::float8))" {
  expect_output '-INF'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('-1.7976931348623158e308'::float8))" {
  expect_output '-1.7976931348623157e+308'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('-2.2250738585072014e-308'::float8))" {
  expect_output '-2.2250738585072014e-308'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('2.2250738585072014e-308'::float8))" {
  expect_output '2.2250738585072014e-308'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.7976931348623158e308'::float8))" {
  expect_output '1.7976931348623157e+308'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('inf'::float8))" {
  expect_output 'INF'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('nan'::float8))" {
  expect_output 'NaN'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('0000-02-18T10:00:00Z'::sparql.zoneddatetime))" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('-0010-02-18T20:00:00Z'::sparql.zoneddatetime))" {
  expect_output '-0010-02-18T20:00:00Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::sparql.zoneddatetime))" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::sparql.zoneddatetime))" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T00:00:00+14:00'::sparql.zoneddatetime))" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T00:00:00-14:00'::sparql.zoneddatetime))" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00'::sparql.zoneddatetime))" {
  expect_output '2010-02-18T20:00:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('0001-02-18T10:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0000-02-18T10:00:00Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '-0009-02-18T20:00:00Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4))" {
  expect_output '0010-02-18T20:00:00Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18T20:00:00+10:30'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T00:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T00:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4))" {
  expect_output '2010-02-18T20:00:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('0000-02-18Z'::sparql.zoneddate))" {
  expect_output '0000-02-18Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('-0010-02-18Z'::sparql.zoneddate))" {
  expect_output '-0010-02-18Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('0010-02-18+00:00'::sparql.zoneddate))" {
  expect_output '0010-02-18Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('0010-02-18+10:30'::sparql.zoneddate))" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('1990-02-18+14:00'::sparql.zoneddate))" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('2010-02-18-14:00'::sparql.zoneddate))" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::sparql.zoneddate))" {
  expect_output '2010-02-18'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0000-02-18Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('0010-02-18 BC'::date, 0::int4))" {
  expect_output '-0009-02-18Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, 0::int4))" {
  expect_output '0010-02-18Z'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('1990-02-18'::date, (14*60*60)::int4))" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, (-14*60*60)::int4))" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, '-2147483648'::int4))" {
  expect_output '2010-02-18'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_daytimeduration('-9223372036854775808'::int8))" {
  expect_output '-P106751991DT4H54.775808S'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_daytimeduration('-9223372036854775807'::int8))" {
  expect_output '-P106751991DT4H54.775807S'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output 'P106751991DT4H54.775807S'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_string('hello'::varchar))" {
  expect_output 'hello'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_langstring('hello'::varchar, 'en'::varchar))" {
  expect_output 'hello'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_typedliteral('value'::varchar, 'http://example.org'::varchar))" {
  expect_output 'value'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output 'http://false.org'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output ''
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int4, '0'::int4))" {
  expect_output ''
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_sblanknode('00000000'::varchar))" {
  expect_output ''
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_sblanknode(''::varchar, '0'::int4))" {
  expect_output ''
}



####
# lang()
#

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_short('0'::int2))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_int('0'::int4))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_long('0'::int8))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_integer('0'::decimal))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_decimal('0'::decimal))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_float('0'::float4))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_double('0'::float8))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::sparql.zoneddatetime))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, '0'::int4))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::sparql.zoneddate))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::date, '0'::int4))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_daytimeduration('0'::int8))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 'en'
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int4, '0'::int4))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_sblanknode('00000000'::varchar))" {
  expect_output ''
}

@test "sparql.lang_rdfbox(sparql.rdfbox_create_from_sblanknode(''::varchar, '0'::int4))" {
  expect_output ''
}



####
# datatype()
#

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_boolean('f'::bool))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#boolean'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_short('0'::int2))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#short'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_int('0'::int4))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#int'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_long('0'::int8))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#long'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_integer('0'::decimal))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#integer'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_decimal('0'::decimal))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#decimal'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_float('0'::float4))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#float'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_double('0'::float8))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#double'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::sparql.zoneddatetime))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#dateTime'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_datetime('0001-01-01T00:00:00Z'::timestamptz, '0'::int4))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#dateTime'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::sparql.zoneddate))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#date'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_date('0001-01-01Z'::date, '0'::int4))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#date'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_daytimeduration('0'::int8))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#dayTimeDuration'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 'http://www.w3.org/2001/XMLSchema#string'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 'http://www.w3.org/1999/02/22-rdf-syntax-ns#langString'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_typedliteral(''::varchar, 'http://example.org'::varchar))" {
  expect_output 'http://example.org'
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int8))" {
  expect_output ''
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_iblanknode('0'::int4, '0'::int4))" {
  expect_output ''
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_sblanknode('00000000'::varchar))" {
  expect_output ''
}

@test "sparql.datatype_rdfbox(sparql.rdfbox_create_from_sblanknode(''::varchar, '0'::int4))" {
  expect_output ''
}



####
# iri()
#

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, 'http://example.org/./dir'::varchar)" {
  expect_output 'http://example.org/dir'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, 'http://example.org/../dir'::varchar)" {
  expect_output 'http://example.org/dir'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, 'http://example.org/./'::varchar)" {
  expect_output 'http://example.org/'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, 'http://example.org/.'::varchar)" {
  expect_output 'http://example.org/'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, 'http://example.org/../'::varchar)" {
  expect_output 'http://example.org/'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, 'http://example.org/..'::varchar)" {
  expect_output 'http://example.org/'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, 'http://example.org/a/./b'::varchar)" {
  expect_output 'http://example.org/a/b'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, 'http://example.org/a/../b'::varchar)" {
  expect_output 'http://example.org/b'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, '//example.org/dir?query#tag'::varchar)" {
  expect_output 'https://example.org/dir?query#tag'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, '/dir/a/b?query#tag'::varchar)" {
  expect_output 'https://base.org/dir/a/b?query#tag'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, '/dir/a/b'::varchar)" {
  expect_output 'https://base.org/dir/a/b'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, './dir/a/b'::varchar)" {
  expect_output 'https://base.org/dir/a/b'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, '../dir/a/b'::varchar)" {
  expect_output 'https://base.org/dir/a/b'
}

@test "sparql.iri_string('https://base.org/basedir/sub?basequery#basetag'::varchar, './dir/a/b'::varchar)" {
  expect_output 'https://base.org/basedir/dir/a/b'
}

@test "sparql.iri_string('https://base.org/basedir/sub?basequery#basetag'::varchar, '../dir/a/b'::varchar)" {
  expect_output 'https://base.org/dir/a/b'
}

@test "sparql.iri_string('https://base.org/basedir/sub/?basequery#basetag'::varchar, './dir/a/b'::varchar)" {
  expect_output 'https://base.org/basedir/sub/dir/a/b'
}

@test "sparql.iri_string('https://base.org/basedir/sub/?basequery#basetag'::varchar, '../dir/a/b'::varchar)" {
  expect_output 'https://base.org/basedir/dir/a/b'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, '?query#tag'::varchar)" {
  expect_output 'https://base.org/basedir?query#tag'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, '?query'::varchar)" {
  expect_output 'https://base.org/basedir?query'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, '#tag'::varchar)" {
  expect_output 'https://base.org/basedir?basequery#tag'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, ''::varchar)" {
  expect_output 'https://base.org/basedir?basequery'
}

@test "sparql.iri_string('https://base.org/basedir?basequery#basetag'::varchar, '##'::varchar)" {
  expect_output ''
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('http://example.org/./dir'::varchar))" {
  expect_output 'http://example.org/dir'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('http://example.org/../dir'::varchar))" {
  expect_output 'http://example.org/dir'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('http://example.org/./'::varchar))" {
  expect_output 'http://example.org/'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('http://example.org/.'::varchar))" {
  expect_output 'http://example.org/'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('http://example.org/../'::varchar))" {
  expect_output 'http://example.org/'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('http://example.org/..'::varchar))" {
  expect_output 'http://example.org/'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('http://example.org/a/./b'::varchar))" {
  expect_output 'http://example.org/a/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('http://example.org/a/../b'::varchar))" {
  expect_output 'http://example.org/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('//example.org/dir?query#tag'::varchar))" {
  expect_output 'https://example.org/dir?query#tag'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('/dir/a/b?query#tag'::varchar))" {
  expect_output 'https://base.org/dir/a/b?query#tag'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('/dir/a/b'::varchar))" {
  expect_output 'https://base.org/dir/a/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('./dir/a/b'::varchar))" {
  expect_output 'https://base.org/dir/a/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('../dir/a/b'::varchar))" {
  expect_output 'https://base.org/dir/a/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir/sub?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('./dir/a/b'::varchar))" {
  expect_output 'https://base.org/basedir/dir/a/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir/sub?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('../dir/a/b'::varchar))" {
  expect_output 'https://base.org/dir/a/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir/sub/?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('./dir/a/b'::varchar))" {
  expect_output 'https://base.org/basedir/sub/dir/a/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir/sub/?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('../dir/a/b'::varchar))" {
  expect_output 'https://base.org/basedir/dir/a/b'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('?query#tag'::varchar))" {
  expect_output 'https://base.org/basedir?query#tag'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('?query'::varchar))" {
  expect_output 'https://base.org/basedir?query'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('#tag'::varchar))" {
  expect_output 'https://base.org/basedir?basequery#tag'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 'https://base.org/basedir?basequery'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_string('##'::varchar))" {
  expect_output ''
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_iri('http://example.org/dir?query#tag'::varchar))" {
  expect_output 'http://example.org/dir?query#tag'
}

@test "sparql.iri_rdfbox('https://base.org/basedir?basequery#basetag'::varchar, sparql.rdfbox_create_from_langstring('http://example.org/dir?query#tag'::varchar, 'en'))" {
  expect_output ''
}



####
# bnode()
#

@test "sparql.bnode()" {
  expect_output '0'
}



####
# strdt()
#

@test "sparql.strdt_string('true'::varchar, 'http://www.w3.org/2001/XMLSchema#boolean'::varchar)" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#short'::varchar)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#int'::varchar)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#long'::varchar)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#integer'::varchar)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#decimal'::varchar)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#float'::varchar)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#double'::varchar)" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "sparql.strdt_string(' 0001-01-01T00:00:00Z '::varchar, 'http://www.w3.org/2001/XMLSchema#dateTime'::varchar)" {
  expect_output '"0001-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "sparql.strdt_string(' 0001-01-01Z '::varchar, 'http://www.w3.org/2001/XMLSchema#date'::varchar)" {
  expect_output '"0001-01-01Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "sparql.strdt_string(' PT0S '::varchar, 'http://www.w3.org/2001/XMLSchema#dayTimeDuration'::varchar)" {
  expect_output '"PT0S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#string'::varchar)" {
  expect_output '" 1 "^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'http://www.w3.org/2001/XMLSchema#introman'::varchar)" {
  expect_output '" 1 "^^<http://www.w3.org/2001/XMLSchema#introman>'
}

@test "sparql.strdt_string(' 1 '::varchar, 'www.w3.org/2001/XMLSchema#int'::varchar)" {
  expect_output ''
}



####
# strlang()
#

@test "sparql.strlang_string('value'::varchar, 'en-US'::varchar)" {
  expect_output '"value"@en-us'
}

@test "sparql.strlang_string('value'::varchar, 'en'::varchar)" {
  expect_output '"value"@en'
}

@test "sparql.strlang_string('value'::varchar, 'e'::varchar)" {
  expect_output ''
}

@test "sparql.strlang_string('value'::varchar, ''::varchar)" {
  expect_output ''
}
