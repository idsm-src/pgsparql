load ../psql_tests.bash



@test "sparql.cast_as_datetime_from_date('0000-02-18Z'::sparql.zoneddate)" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_date('-0010-02-18Z'::sparql.zoneddate)" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_date('0010-02-18+00:00'::sparql.zoneddate)" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_date('0010-02-18+10:30'::sparql.zoneddate)" {
  expect_output '0010-02-18T00:00:00+10:30'
}

@test "sparql.cast_as_datetime_from_date('1990-02-18+14:00'::sparql.zoneddate)" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.cast_as_datetime_from_date('2010-02-18-14:00'::sparql.zoneddate)" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.cast_as_datetime_from_date('2010-02-18'::sparql.zoneddate)" {
  expect_output '2010-02-18T00:00:00'
}

@test "sparql.cast_as_datetime_from_date('0001-02-18 BC'::date, 0::int4)" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_date('0010-02-18 BC'::date, 0::int4)" {
  expect_output '-0009-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_date('0010-02-18'::date, 0::int4)" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_date('0010-02-18'::date, ((10*60+30)*60)::int4)" {
  expect_output '0010-02-18T00:00:00+10:30'
}

@test "sparql.cast_as_datetime_from_date('1990-02-18'::date, (14*60*60)::int4)" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.cast_as_datetime_from_date('2010-02-18'::date, (-14*60*60)::int4)" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.cast_as_datetime_from_date('2010-02-18'::date, '-2147483648'::int4)" {
  expect_output '2010-02-18T00:00:00'
}

@test "sparql.cast_as_datetime_from_string(' 0000-02-18T00:00:00Z '::varchar)" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_string(' -0010-02-18T00:00:00Z '::varchar)" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_string(' -0010-03-17T24:00:00+00:00 '::varchar)" {
  expect_output '-0010-03-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_string(' -0001-04-16T12:10:03.0+10:55 '::varchar)" {
  expect_output '-0001-04-16T12:10:03+10:55'
}

@test "sparql.cast_as_datetime_from_string(' -1990-05-15T14:00:00.50-14:00 '::varchar)" {
  expect_output '-1990-05-15T14:00:00.5-14:00'
}

@test "sparql.cast_as_datetime_from_string(' -2010-05-15T14:00:00.50-14:00 '::varchar)" {
  expect_output '-2010-05-15T14:00:00.5-14:00'
}

@test "sparql.cast_as_datetime_from_string(' 0010-02-18T00:00:00Z '::varchar)" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_string(' 0010-03-17T24:00:00+00:00 '::varchar)" {
  expect_output '0010-03-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_string(' 0001-04-16T12:10:03.0+10:55 '::varchar)" {
  expect_output '0001-04-16T12:10:03+10:55'
}

@test "sparql.cast_as_datetime_from_string(' 1990-05-15T14:00:00.50-14:00 '::varchar)" {
  expect_output '1990-05-15T14:00:00.5-14:00'
}

@test "sparql.cast_as_datetime_from_string(' 2010-05-15T14:00:00.50-14:00 '::varchar)" {
  expect_output '2010-05-15T14:00:00.5-14:00'
}

@test "sparql.cast_as_datetime_from_string(' 2010-05-15T14:00:00 '::varchar)" {
  expect_output '2010-05-15T14:00:00'
}

@test "sparql.cast_as_datetime_from_string(' 10000-06-14T00:00:00+14:00 '::varchar)" {
  expect_output '10000-06-14T00:00:00+14:00'
}

@test "sparql.cast_as_datetime_from_string(' 2020-02-30T00:00:00 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_string(' 999-04-15T00:00:00 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_string(' 1990-1-20T00:00:00 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_string(' 2000-10-20T24:00:10 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_string(' 2000-10-20T00:00:00. '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_string(' 2000-10-20T00:00:00+14:01 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_string(' 2000-10-20T00:00:00-14:01 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_string(' '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_string(''::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0000-02-18Z'::sparql.zoneddate))" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('-0010-02-18Z'::sparql.zoneddate))" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18+00:00'::sparql.zoneddate))" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18+10:30'::sparql.zoneddate))" {
  expect_output '0010-02-18T00:00:00+10:30'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('1990-02-18+14:00'::sparql.zoneddate))" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18-14:00'::sparql.zoneddate))" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::sparql.zoneddate))" {
  expect_output '2010-02-18T00:00:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18 BC'::date, 0::int4))" {
  expect_output '-0009-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, 0::int4))" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18T00:00:00+10:30'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('1990-02-18'::date, (14*60*60)::int4))" {
  expect_output '1990-02-18T00:00:00+14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, (-14*60*60)::int4))" {
  expect_output '2010-02-18T00:00:00-14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, '-2147483648'::int4))" {
  expect_output '2010-02-18T00:00:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 0000-02-18T00:00:00Z '::varchar))" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' -0010-02-18T00:00:00Z '::varchar))" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' -0010-03-17T24:00:00+00:00 '::varchar))" {
  expect_output '-0010-03-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' -0001-04-16T12:10:03.0+10:55 '::varchar))" {
  expect_output '-0001-04-16T12:10:03+10:55'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' -1990-05-15T14:00:00.50-14:00 '::varchar))" {
  expect_output '-1990-05-15T14:00:00.5-14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' -2010-05-15T14:00:00.50-14:00 '::varchar))" {
  expect_output '-2010-05-15T14:00:00.5-14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 0010-02-18T00:00:00Z '::varchar))" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 0010-03-17T24:00:00+00:00 '::varchar))" {
  expect_output '0010-03-18T00:00:00Z'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 0001-04-16T12:10:03.0+10:55 '::varchar))" {
  expect_output '0001-04-16T12:10:03+10:55'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 1990-05-15T14:00:00.50-14:00 '::varchar))" {
  expect_output '1990-05-15T14:00:00.5-14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 2010-05-15T14:00:00.50-14:00 '::varchar))" {
  expect_output '2010-05-15T14:00:00.5-14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 2010-05-15T14:00:00 '::varchar))" {
  expect_output '2010-05-15T14:00:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 10000-06-14T00:00:00+14:00 '::varchar))" {
  expect_output '10000-06-14T00:00:00+14:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 2020-02-30T00:00:00 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 999-04-15T00:00:00 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 1990-1-20T00:00:00 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 2000-10-20T24:00:10 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 2000-10-20T00:00:00. '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 2000-10-20T00:00:00+14:01 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' 2000-10-20T00:00:00-14:01 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-05-15T10:00:00+10:00'::sparql.zoneddatetime))" {
  expect_output '1990-05-15T10:00:00+10:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_datetime('2000-05-15T20:00:00'::sparql.zoneddatetime))" {
  expect_output '2000-05-15T20:00:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-05-15T00:00:00-10:00'::sparql.zoneddatetime))" {
  expect_output '2010-05-15T00:00:00-10:00'
}

@test "sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output ''
}



@test "sparql.cast_as_plain_datetime_from_date('0001-02-18 BC'::date, 0::int4)" {
  expect_output '0001-02-18 00:00:00+00 BC'
}

@test "sparql.cast_as_plain_datetime_from_date('0010-02-18 BC'::date, 0::int4)" {
  expect_output '0010-02-18 00:00:00+00 BC'
}

@test "sparql.cast_as_plain_datetime_from_date('0010-02-18'::date, 0::int4)" {
  expect_output '0010-02-18 00:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_date('0010-02-18'::date, ((10*60+30)*60)::int4)" {
  expect_output '0010-02-17 13:30:00+00'
}

@test "sparql.cast_as_plain_datetime_from_date('1990-02-18'::date, (14*60*60)::int4)" {
  expect_output '1990-02-17 10:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_date('2010-02-18'::date, (-14*60*60)::int4)" {
  expect_output '2010-02-18 14:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_date('2010-02-18'::date, '-2147483648'::int4)" {
  expect_output '2010-02-18 00:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0001-02-18 00:00:00+00 BC'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18 BC'::date, 0::int4))" {
  expect_output '0010-02-18 00:00:00+00 BC'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, 0::int4))" {
  expect_output '0010-02-18 00:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_date('0010-02-18'::date, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-17 13:30:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_date('1990-02-18'::date, (14*60*60)::int4))" {
  expect_output '1990-02-17 10:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, (-14*60*60)::int4))" {
  expect_output '2010-02-18 14:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_date('2010-02-18'::date, '-2147483648'::int4))" {
  expect_output '2010-02-18 00:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-05-15T10:00:00+10:00'::sparql.zoneddatetime))" {
  expect_output '1990-05-15 00:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_datetime('2000-05-15T20:00:00'::sparql.zoneddatetime))" {
  expect_output '2000-05-15 20:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-05-15T00:00:00-10:00'::sparql.zoneddatetime))" {
  expect_output '2010-05-15 10:00:00+00'
}

@test "sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output ''
}
