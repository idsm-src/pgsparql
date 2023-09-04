load ../psql_tests.bash



####
# year()
#

@test "sparql.year_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '-100'
}

@test "sparql.year_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.year_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.year_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '1990'
}

@test "sparql.year_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '2010'
}

@test "sparql.year_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '-100'
}

@test "sparql.year_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '0'
}

@test "sparql.year_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "sparql.year_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '1990'
}

@test "sparql.year_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '2010'
}

@test "sparql.year_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '-100'
}

@test "sparql.year_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '0'
}

@test "sparql.year_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '0'
}

@test "sparql.year_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '1990'
}

@test "sparql.year_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '2010'
}

@test "sparql.year_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '-100'
}

@test "sparql.year_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '0'
}

@test "sparql.year_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "sparql.year_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '1990'
}

@test "sparql.year_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '2010'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '-100'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '1990'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '2010'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '-100'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '0'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '1990'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '2010'
}

@test "sparql.year_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output ''
}



####
# month()
#

@test "sparql.month_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '2'
}

@test "sparql.month_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '3'
}

@test "sparql.month_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '4'
}

@test "sparql.month_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '10'
}

@test "sparql.month_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '11'
}

@test "sparql.month_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '2'
}

@test "sparql.month_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '3'
}

@test "sparql.month_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '4'
}

@test "sparql.month_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '10'
}

@test "sparql.month_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '11'
}

@test "sparql.month_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '2'
}

@test "sparql.month_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '3'
}

@test "sparql.month_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '4'
}

@test "sparql.month_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '10'
}

@test "sparql.month_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '11'
}

@test "sparql.month_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '2'
}

@test "sparql.month_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '3'
}

@test "sparql.month_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '4'
}

@test "sparql.month_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '10'
}

@test "sparql.month_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '11'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '2'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '3'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '4'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '10'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '11'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '2'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '3'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '4'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '10'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '11'
}

@test "sparql.month_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output ''
}



####
# day()
#

@test "sparql.day_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '18'
}

@test "sparql.day_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '16'
}

@test "sparql.day_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '18'
}

@test "sparql.day_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '10'
}

@test "sparql.day_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '18'
}

@test "sparql.day_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '18'
}

@test "sparql.day_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '16'
}

@test "sparql.day_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '18'
}

@test "sparql.day_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '10'
}

@test "sparql.day_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '18'
}

@test "sparql.day_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '18'
}

@test "sparql.day_date('0000-03-15'::sparql.zoneddate)" {
  expect_output '15'
}

@test "sparql.day_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '17'
}

@test "sparql.day_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '10'
}

@test "sparql.day_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '18'
}

@test "sparql.day_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '18'
}

@test "sparql.day_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output '15'
}

@test "sparql.day_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '17'
}

@test "sparql.day_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '10'
}

@test "sparql.day_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '18'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '18'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '16'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '18'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '10'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '18'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '18'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output '15'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '17'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '10'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '18'
}

@test "sparql.day_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output ''
}



####
# hours()
#

@test "sparql.hours_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '10'
}

@test "sparql.hours_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.hours_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.hours_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.hours_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.hours_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '10'
}

@test "sparql.hours_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '0'
}

@test "sparql.hours_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "sparql.hours_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '0'
}

@test "sparql.hours_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '0'
}

@test "sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '10'
}

@test "sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0'
}

@test "sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '0'
}

@test "sparql.hours_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '0'
}

@test "sparql.hours_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output ''
}

@test "sparql.hours_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output ''
}



####
# minutes()
#

@test "sparql.minutes_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '22'
}

@test "sparql.minutes_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.minutes_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.minutes_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '22'
}

@test "sparql.minutes_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '59'
}

@test "sparql.minutes_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '22'
}

@test "sparql.minutes_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '0'
}

@test "sparql.minutes_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "sparql.minutes_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '22'
}

@test "sparql.minutes_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '59'
}

@test "sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '22'
}

@test "sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0'
}

@test "sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '22'
}

@test "sparql.minutes_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '59'
}

@test "sparql.minutes_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output ''
}

@test "sparql.minutes_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output ''
}



####
# seconds()
#

@test "sparql.seconds_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '50'
}

@test "sparql.seconds_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.seconds_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.seconds_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '30'
}

@test "sparql.seconds_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '59.99'
}

@test "sparql.seconds_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '50'
}

@test "sparql.seconds_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output '0'
}

@test "sparql.seconds_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '0'
}

@test "sparql.seconds_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '30'
}

@test "sparql.seconds_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '59.99'
}

@test "sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '50'
}

@test "sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output '0'
}

@test "sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '0'
}

@test "sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '30'
}

@test "sparql.seconds_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '59.99'
}

@test "sparql.seconds_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output ''
}

@test "sparql.seconds_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output ''
}



####
# timezone()
#

@test "sparql.timezone_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output '0'
}

@test "sparql.timezone_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output ''
}

@test "sparql.timezone_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '37800000000'
}

@test "sparql.timezone_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '-50400000000'
}

@test "sparql.timezone_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '50400000000'
}

@test "sparql.timezone_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output '0'
}

@test "sparql.timezone_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.timezone_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '37800000000'
}

@test "sparql.timezone_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '-50400000000'
}

@test "sparql.timezone_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '50400000000'
}

@test "sparql.timezone_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output '0'
}

@test "sparql.timezone_date('0000-03-15'::sparql.zoneddate)" {
  expect_output ''
}

@test "sparql.timezone_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '37800000000'
}

@test "sparql.timezone_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '-50400000000'
}

@test "sparql.timezone_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '50400000000'
}

@test "sparql.timezone_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output '0'
}

@test "sparql.timezone_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.timezone_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '37800000000'
}

@test "sparql.timezone_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '-50400000000'
}

@test "sparql.timezone_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '50400000000'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output '0'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output ''
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '37800000000'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '-50400000000'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '50400000000'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output '0'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output ''
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '37800000000'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '-50400000000'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '50400000000'
}

@test "sparql.timezone_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output ''
}



####
# tz()
#

@test "sparql.tz_datetime('-0100-02-18T10:22:50+00:00'::sparql.zoneddatetime)" {
  expect_output 'Z'
}

@test "sparql.tz_datetime('0000-03-15T24:00:00'::sparql.zoneddatetime)" {
  expect_output ''
}

@test "sparql.tz_datetime('0000-04-17T24:00:00+10:30'::sparql.zoneddatetime)" {
  expect_output '+10:30'
}

@test "sparql.tz_datetime('1990-10-10T00:22:30-14:00'::sparql.zoneddatetime)" {
  expect_output '-14:00'
}

@test "sparql.tz_datetime('2010-11-18T00:59:59.99+14:00'::sparql.zoneddatetime)" {
  expect_output '+14:00'
}

@test "sparql.tz_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4)" {
  expect_output 'Z'
}

@test "sparql.tz_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.tz_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4)" {
  expect_output '+10:30'
}

@test "sparql.tz_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '-14:00'
}

@test "sparql.tz_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '+14:00'
}

@test "sparql.tz_date('-0100-02-18+00:00'::sparql.zoneddate)" {
  expect_output 'Z'
}

@test "sparql.tz_date('0000-03-15'::sparql.zoneddate)" {
  expect_output ''
}

@test "sparql.tz_date('0000-04-17+10:30'::sparql.zoneddate)" {
  expect_output '+10:30'
}

@test "sparql.tz_date('1990-10-10-14:00'::sparql.zoneddate)" {
  expect_output '-14:00'
}

@test "sparql.tz_date('2010-11-18+14:00'::sparql.zoneddate)" {
  expect_output '+14:00'
}

@test "sparql.tz_date('0101-02-18 BC'::date, '0'::int4)" {
  expect_output 'Z'
}

@test "sparql.tz_date('0001-03-15 BC'::date, '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.tz_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4)" {
  expect_output '+10:30'
}

@test "sparql.tz_date('1990-10-10'::date, (-14*60*60)::int4)" {
  expect_output '-14:00'
}

@test "sparql.tz_date('2010-11-18'::date, (14*60*60)::int4)" {
  expect_output '+14:00'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('0101-02-18T10:22:50+00:00 BC'::timestamptz, '0'::int4))" {
  expect_output 'Z'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('0001-03-15T24:00:00 BC'::timestamptz, '-2147483648'::int4))" {
  expect_output ''
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('0001-04-17T24:00:00+10:30 BC'::timestamptz, ((10*60+30)*60)::int4))" {
  expect_output '+10:30'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('1990-10-10T00:22:30-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '-14:00'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_datetime('2010-11-18T00:59:59.99+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '+14:00'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_date('0101-02-18 BC'::date, '0'::int4))" {
  expect_output 'Z'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_date('0001-03-15 BC'::date, '-2147483648'::int4))" {
  expect_output ''
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_date('0001-04-17 BC'::date, ((10*60+30)*60)::int4))" {
  expect_output '+10:30'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_date('1990-10-10'::date, (-14*60*60)::int4))" {
  expect_output '-14:00'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_date('2010-11-18'::date, (14*60*60)::int4))" {
  expect_output '+14:00'
}

@test "sparql.tz_rdfbox(sparql.rdfbox_create_from_string(''))" {
  expect_output ''
}
