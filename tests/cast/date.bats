load ../psql_tests.bash



@test "sparql.cast_as_date_from_datetime('0000-02-18T20:00:00Z'::sparql.zoneddatetime)" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_date_from_datetime('-0010-02-18T20:00:00Z'::sparql.zoneddatetime)" {
  expect_output '-0010-02-18Z'
}

@test "sparql.cast_as_date_from_datetime('0010-02-18T20:00:00+00:00'::sparql.zoneddatetime)" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_date_from_datetime('0010-02-18T20:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.cast_as_date_from_datetime('1990-02-18T20:00:00+14:00'::sparql.zoneddatetime)" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.cast_as_date_from_datetime('2010-02-18T20:00:00-14:00'::sparql.zoneddatetime)" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.cast_as_date_from_datetime('2010-02-18T20:00:00'::sparql.zoneddatetime)" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_date_from_datetime('0001-02-18T20:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_date_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '-0009-02-18Z'
}

@test "sparql.cast_as_date_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4)" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_date_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.cast_as_date_from_datetime('1990-02-18T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.cast_as_date_from_datetime('2010-02-18T20:00:00-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.cast_as_date_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4)" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_date_from_string(' 0000-02-18Z '::varchar)" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_date_from_string(' -0010-02-18Z '::varchar)" {
  expect_output '-0010-02-18Z'
}

@test "sparql.cast_as_date_from_string(' -0010-03-17+00:00 '::varchar)" {
  expect_output '-0010-03-17Z'
}

@test "sparql.cast_as_date_from_string(' -0001-04-16+10:55 '::varchar)" {
  expect_output '-0001-04-16+10:55'
}

@test "sparql.cast_as_date_from_string(' -1990-05-15-14:00 '::varchar)" {
  expect_output '-1990-05-15-14:00'
}

@test "sparql.cast_as_date_from_string(' -2010-05-15-14:00 '::varchar)" {
  expect_output '-2010-05-15-14:00'
}

@test "sparql.cast_as_date_from_string(' 0010-02-18Z '::varchar)" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_date_from_string(' 0010-03-17+00:00 '::varchar)" {
  expect_output '0010-03-17Z'
}

@test "sparql.cast_as_date_from_string(' 0001-04-16+10:55 '::varchar)" {
  expect_output '0001-04-16+10:55'
}

@test "sparql.cast_as_date_from_string(' 1990-05-15-14:00 '::varchar)" {
  expect_output '1990-05-15-14:00'
}

@test "sparql.cast_as_date_from_string(' 2010-05-15-14:00 '::varchar)" {
  expect_output '2010-05-15-14:00'
}

@test "sparql.cast_as_date_from_string(' 2010-05-15 '::varchar)" {
  expect_output '2010-05-15'
}

@test "sparql.cast_as_date_from_string(' 10000-06-14+14:00 '::varchar)" {
  expect_output '10000-06-14+14:00'
}

@test "sparql.cast_as_date_from_string(' 2020-02-30 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_date_from_string(' 999-04-15 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_date_from_string(' 1990-1-20 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_date_from_string(' 1990-01-20+14:01 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_date_from_string(' 1990-01-20-14:01 '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_date_from_string(' '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_date_from_string(''::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0000-02-18T20:00:00Z'::sparql.zoneddatetime))" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('-0010-02-18T20:00:00Z'::sparql.zoneddatetime))" {
  expect_output '-0010-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::sparql.zoneddatetime))" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::sparql.zoneddatetime))" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T20:00:00+14:00'::sparql.zoneddatetime))" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00-14:00'::sparql.zoneddatetime))" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00'::sparql.zoneddatetime))" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0001-02-18T20:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '-0009-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4))" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18+10:30'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T20:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '1990-02-18+14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '2010-02-18-14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4))" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 0000-02-18Z '::varchar))" {
  expect_output '0000-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' -0010-02-18Z '::varchar))" {
  expect_output '-0010-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' -0010-03-17+00:00 '::varchar))" {
  expect_output '-0010-03-17Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' -0001-04-16+10:55 '::varchar))" {
  expect_output '-0001-04-16+10:55'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' -1990-05-15-14:00 '::varchar))" {
  expect_output '-1990-05-15-14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' -2010-05-15-14:00 '::varchar))" {
  expect_output '-2010-05-15-14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 0010-02-18Z '::varchar))" {
  expect_output '0010-02-18Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 0010-03-17+00:00 '::varchar))" {
  expect_output '0010-03-17Z'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 0001-04-16+10:55 '::varchar))" {
  expect_output '0001-04-16+10:55'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 1990-05-15-14:00 '::varchar))" {
  expect_output '1990-05-15-14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 2010-05-15-14:00 '::varchar))" {
  expect_output '2010-05-15-14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 2010-05-15 '::varchar))" {
  expect_output '2010-05-15'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 10000-06-14+14:00 '::varchar))" {
  expect_output '10000-06-14+14:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 2020-02-30 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 999-04-15 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 1990-1-20 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 1990-01-20+14:01 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' 1990-01-20-14:01 '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_date('1990-05-15+10:00'::sparql.zoneddate))" {
  expect_output '1990-05-15+10:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_date('2000-05-15'::sparql.zoneddate))" {
  expect_output '2000-05-15'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_date('2010-05-15-10:00'::sparql.zoneddate))" {
  expect_output '2010-05-15-10:00'
}

@test "sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output ''
}



@test "sparql.cast_as_plain_date_from_datetime('0001-02-18T20:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '0001-02-18 BC'
}

@test "sparql.cast_as_plain_date_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '0010-02-18 BC'
}

@test "sparql.cast_as_plain_date_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4)" {
  expect_output '0010-02-18'
}

@test "sparql.cast_as_plain_date_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0010-02-18'
}

@test "sparql.cast_as_plain_date_from_datetime('1990-02-18T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '1990-02-18'
}

@test "sparql.cast_as_plain_date_from_datetime('2010-02-18T20:00:00-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_plain_date_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4)" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0001-02-18T20:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0001-02-18 BC'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0010-02-18 BC'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+00:00'::timestamptz, 0::int4))" {
  expect_output '0010-02-18'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_datetime('0010-02-18T20:00:00+10:30'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0010-02-18'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_datetime('1990-02-18T20:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '1990-02-18'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_datetime('2010-02-18T20:00:00+00:00'::timestamptz, '-2147483648'::int4))" {
  expect_output '2010-02-18'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_date('1990-05-15+10:00'::sparql.zoneddate))" {
  expect_output '1990-05-15'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_date('2000-05-15'::sparql.zoneddate))" {
  expect_output '2000-05-15'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_date('2010-05-15-10:00'::sparql.zoneddate))" {
  expect_output '2010-05-15'
}

@test "sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output ''
}
