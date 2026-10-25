load ../psql_tests.bash

setup_file() {
  # the casts between xsd:date and xsd:dateTime take the midnight that begins a date in the zone
  # of the date and the date of the local time of a date-time, so their results must not depend
  # on the TimeZone of the session; the other files run in UTC, this one in a zone with daylight
  # saving time (the timestamptz results are printed in it)
  pg_session_start
  pg_send "set timezone = 'Europe/Prague';"
}



@test "fn: sparql.cast_as_datetime_from_date('2020-01-01Z'::sparql.zoneddate)" {
  expect_output '2020-01-01T00:00:00Z'
}

@test "fn: sparql.cast_as_datetime_from_date('2020-07-01Z'::sparql.zoneddate)" {
  expect_output '2020-07-01T00:00:00Z'
}

@test "fn: sparql.cast_as_datetime_from_date('2020-01-01+10:30'::sparql.zoneddate)" {
  expect_output '2020-01-01T00:00:00+10:30'
}

@test "fn: sparql.cast_as_datetime_from_date('2020-07-01-14:00'::sparql.zoneddate)" {
  expect_output '2020-07-01T00:00:00-14:00'
}

@test "fn: sparql.cast_as_datetime_from_date('2020-01-01'::sparql.zoneddate)" {
  expect_output '2020-01-01T00:00:00'
}

@test "fn: sparql.cast_as_datetime_from_date('2020-07-01'::date, 0::int4)" {
  expect_output '2020-07-01T00:00:00Z'
}

@test "fn: sparql.cast_as_datetime_from_date('2020-01-01'::date, '-2147483648'::int4)" {
  expect_output '2020-01-01T00:00:00'
}

@test "fn: sparql.cast_as_datetime_from_rdfbox(sparql.rdfbox_create_from_date('2020-07-01+01:00'::sparql.zoneddate))" {
  expect_output '2020-07-01T00:00:00+01:00'
}

@test "fn: sparql.cast_as_plain_datetime_from_date('2020-01-01'::date, 0::int4)" {
  expect_output '2020-01-01 01:00:00+01'
}

@test "fn: sparql.cast_as_plain_datetime_from_date('2020-07-01'::date, 0::int4)" {
  expect_output '2020-07-01 02:00:00+02'
}

@test "fn: sparql.cast_as_plain_datetime_from_date('2020-07-01'::date, ((10*60+30)*60)::int4)" {
  expect_output '2020-06-30 15:30:00+02'
}

@test "fn: sparql.cast_as_plain_datetime_from_date('2020-01-01'::date, '-2147483648'::int4)" {
  expect_output '2020-01-01 01:00:00+01'
}

@test "fn: sparql.cast_as_plain_datetime_from_rdfbox(sparql.rdfbox_create_from_date('2020-01-01'::date, (-14*60*60)::int4))" {
  expect_output '2020-01-01 15:00:00+01'
}

@test "fn: sparql.cast_as_date_from_datetime('2020-01-01T23:30:00-01:00'::sparql.zoneddatetime)" {
  expect_output '2020-01-01-01:00'
}

@test "fn: sparql.cast_as_date_from_datetime('2020-07-01T00:30:00+01:00'::sparql.zoneddatetime)" {
  expect_output '2020-07-01+01:00'
}

@test "fn: sparql.cast_as_date_from_datetime('2020-01-01T23:30:00'::sparql.zoneddatetime)" {
  expect_output '2020-01-01'
}

@test "fn: sparql.cast_as_date_from_datetime('2020-07-01T23:30:00+00:00'::timestamptz, 0::int4)" {
  expect_output '2020-07-01Z'
}

@test "fn: sparql.cast_as_date_from_datetime('2020-01-01T23:30:00+00:00'::timestamptz, '-2147483648'::int4)" {
  expect_output '2020-01-01'
}

@test "fn: sparql.cast_as_date_from_rdfbox(sparql.rdfbox_create_from_datetime('2020-07-01T00:30:00+01:00'::sparql.zoneddatetime))" {
  expect_output '2020-07-01+01:00'
}

@test "fn: sparql.cast_as_plain_date_from_datetime('2020-01-01T23:30:00-01:00'::timestamptz, (-60*60)::int4)" {
  expect_output '2020-01-01'
}

@test "fn: sparql.cast_as_plain_date_from_datetime('2020-07-01T23:30:00+00:00'::timestamptz, 0::int4)" {
  expect_output '2020-07-01'
}

@test "fn: sparql.cast_as_plain_date_from_rdfbox(sparql.rdfbox_create_from_datetime('2020-07-01T00:30:00+01:00'::sparql.zoneddatetime))" {
  expect_output '2020-07-01'
}
