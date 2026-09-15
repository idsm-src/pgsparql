load ../psql_tests.bash



####
# year()
#

@test "fn: sparql.year_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '-100'
}

@test "fn: sparql.year_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.year_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.year_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '1990'
}

@test "fn: sparql.year_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '2010'
}

@test "fn: sparql.year_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '-100'
}

@test "fn: sparql.year_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '0'
}

@test "fn: sparql.year_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "fn: sparql.year_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '1990'
}

@test "fn: sparql.year_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '2010'
}

@test "fn: sparql.year_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '-100'
}

@test "fn: sparql.year_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '0'
}

@test "fn: sparql.year_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '0'
}

@test "fn: sparql.year_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '1990'
}

@test "fn: sparql.year_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '2010'
}

@test "fn: sparql.year_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '-100'
}

@test "fn: sparql.year_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '0'
}

@test "fn: sparql.year_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "fn: sparql.year_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '1990'
}

@test "fn: sparql.year_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '2010'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '-100'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '1990'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '2010'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '-100'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '0'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '1990'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '2010'
}

@test "fn: sparql.year_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output '(null)'
}



####
# month()
#

@test "fn: sparql.month_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '2'
}

@test "fn: sparql.month_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '3'
}

@test "fn: sparql.month_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '4'
}

@test "fn: sparql.month_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '10'
}

@test "fn: sparql.month_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '11'
}

@test "fn: sparql.month_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '2'
}

@test "fn: sparql.month_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '3'
}

@test "fn: sparql.month_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '4'
}

@test "fn: sparql.month_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '10'
}

@test "fn: sparql.month_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '11'
}

@test "fn: sparql.month_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '2'
}

@test "fn: sparql.month_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '3'
}

@test "fn: sparql.month_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '4'
}

@test "fn: sparql.month_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '10'
}

@test "fn: sparql.month_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '11'
}

@test "fn: sparql.month_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '2'
}

@test "fn: sparql.month_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '3'
}

@test "fn: sparql.month_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '4'
}

@test "fn: sparql.month_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '10'
}

@test "fn: sparql.month_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '11'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '2'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '3'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '4'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '10'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '11'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '2'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '3'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '4'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '10'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '11'
}

@test "fn: sparql.month_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output '(null)'
}



####
# day()
#

@test "fn: sparql.day_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '18'
}

@test "fn: sparql.day_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '16'
}

@test "fn: sparql.day_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '18'
}

@test "fn: sparql.day_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '10'
}

@test "fn: sparql.day_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '18'
}

@test "fn: sparql.day_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '18'
}

@test "fn: sparql.day_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '16'
}

@test "fn: sparql.day_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '18'
}

@test "fn: sparql.day_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '10'
}

@test "fn: sparql.day_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '18'
}

@test "fn: sparql.day_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '18'
}

@test "fn: sparql.day_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '15'
}

@test "fn: sparql.day_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '17'
}

@test "fn: sparql.day_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '10'
}

@test "fn: sparql.day_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '18'
}

@test "fn: sparql.day_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '18'
}

@test "fn: sparql.day_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '15'
}

@test "fn: sparql.day_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '17'
}

@test "fn: sparql.day_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '10'
}

@test "fn: sparql.day_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '18'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '18'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '16'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '18'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '10'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '18'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '18'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '15'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '17'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '10'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '18'
}

@test "fn: sparql.day_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output '(null)'
}



####
# hours()
#

@test "fn: sparql.hours_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '10'
}

@test "fn: sparql.hours_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.hours_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.hours_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.hours_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.hours_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '10'
}

@test "fn: sparql.hours_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '0'
}

@test "fn: sparql.hours_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "fn: sparql.hours_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '0'
}

@test "fn: sparql.hours_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '0'
}

@test "fn: sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '10'
}

@test "fn: sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0'
}

@test "fn: sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.hours_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.hours_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output '(null)'
}



####
# minutes()
#

@test "fn: sparql.minutes_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '22'
}

@test "fn: sparql.minutes_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.minutes_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.minutes_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '22'
}

@test "fn: sparql.minutes_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '59'
}

@test "fn: sparql.minutes_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '22'
}

@test "fn: sparql.minutes_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '0'
}

@test "fn: sparql.minutes_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "fn: sparql.minutes_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '22'
}

@test "fn: sparql.minutes_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '59'
}

@test "fn: sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '22'
}

@test "fn: sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0'
}

@test "fn: sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '22'
}

@test "fn: sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '59'
}

@test "fn: sparql.minutes_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.minutes_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output '(null)'
}



####
# seconds()
#

@test "fn: sparql.seconds_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '50'
}

@test "fn: sparql.seconds_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.seconds_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.seconds_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '30'
}

@test "fn: sparql.seconds_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '59.99'
}

@test "fn: sparql.seconds_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '50'
}

@test "fn: sparql.seconds_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '0'
}

@test "fn: sparql.seconds_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "fn: sparql.seconds_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '30'
}

@test "fn: sparql.seconds_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '59.99'
}

@test "fn: sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '50'
}

@test "fn: sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0'
}

@test "fn: sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '30'
}

@test "fn: sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '59.99'
}

@test "fn: sparql.seconds_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.seconds_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output '(null)'
}



####
# timezone()
#

@test "fn: sparql.timezone_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "fn: sparql.timezone_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '(null)'
}

@test "fn: sparql.timezone_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '37800000000'
}

@test "fn: sparql.timezone_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '-50400000000'
}

@test "fn: sparql.timezone_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '50400000000'
}

@test "fn: sparql.timezone_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '0'
}

@test "fn: sparql.timezone_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.timezone_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '37800000000'
}

@test "fn: sparql.timezone_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '-50400000000'
}

@test "fn: sparql.timezone_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '50400000000'
}

@test "fn: sparql.timezone_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '0'
}

@test "fn: sparql.timezone_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '(null)'
}

@test "fn: sparql.timezone_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '37800000000'
}

@test "fn: sparql.timezone_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '-50400000000'
}

@test "fn: sparql.timezone_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '50400000000'
}

@test "fn: sparql.timezone_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '0'
}

@test "fn: sparql.timezone_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.timezone_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '37800000000'
}

@test "fn: sparql.timezone_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '-50400000000'
}

@test "fn: sparql.timezone_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '50400000000'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '0'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '37800000000'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '-50400000000'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '50400000000'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '0'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '(null)'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '37800000000'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '-50400000000'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '50400000000'
}

@test "fn: sparql.timezone_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output '(null)'
}



####
# tz()
#

@test "fn: sparql.tz_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output 'Z'
}

@test "fn: sparql.tz_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output ''
}

@test "fn: sparql.tz_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '+10:30'
}

@test "fn: sparql.tz_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '-14:00'
}

@test "fn: sparql.tz_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '+14:00'
}

@test "fn: sparql.tz_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output 'Z'
}

@test "fn: sparql.tz_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output ''
}

@test "fn: sparql.tz_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '+10:30'
}

@test "fn: sparql.tz_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '-14:00'
}

@test "fn: sparql.tz_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '+14:00'
}

@test "fn: sparql.tz_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output 'Z'
}

@test "fn: sparql.tz_date('0000-03-15'::sparql.zoneddate)" {
  expect_output ''
}

@test "fn: sparql.tz_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '+10:30'
}

@test "fn: sparql.tz_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '-14:00'
}

@test "fn: sparql.tz_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '+14:00'
}

@test "fn: sparql.tz_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output 'Z'
}

@test "fn: sparql.tz_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output ''
}

@test "fn: sparql.tz_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '+10:30'
}

@test "fn: sparql.tz_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '-14:00'
}

@test "fn: sparql.tz_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '+14:00'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output 'Z'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output ''
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '+10:30'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '-14:00'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '+14:00'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output 'Z'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output ''
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '+10:30'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '-14:00'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '+14:00'
}

@test "fn: sparql.tz_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output '(null)'
}
