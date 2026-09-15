load ../psql_tests.bash

setup_file() {
  pg_session_start sparql.zoneddate
}



####
# in/out
#

@test "io: ' 0000-02-18Z '::sparql.zoneddate" {
  expect_output '0000-02-18Z'
}

@test "io: ' -0010-02-18Z '::sparql.zoneddate" {
  expect_output '-0010-02-18Z'
}

@test "io: ' -0010-03-17+00:00 '::sparql.zoneddate" {
  expect_output '-0010-03-17Z'
}

@test "io: ' -0001-04-16+10:55 '::sparql.zoneddate" {
  expect_output '-0001-04-16+10:55'
}

@test "io: ' -1990-05-15-14:00 '::sparql.zoneddate" {
  expect_output '-1990-05-15-14:00'
}

@test "io: ' -2010-05-15-14:00 '::sparql.zoneddate" {
  expect_output '-2010-05-15-14:00'
}

@test "io: ' 0010-02-18Z '::sparql.zoneddate" {
  expect_output '0010-02-18Z'
}

@test "io: ' 0010-03-17+00:00 '::sparql.zoneddate" {
  expect_output '0010-03-17Z'
}

@test "io: ' 0001-04-16+10:55 '::sparql.zoneddate" {
  expect_output '0001-04-16+10:55'
}

@test "io: ' 1990-05-15-14:00 '::sparql.zoneddate" {
  expect_output '1990-05-15-14:00'
}

@test "io: ' 2010-05-15-14:00 '::sparql.zoneddate" {
  expect_output '2010-05-15-14:00'
}

@test "io: ' 2010-05-15 '::sparql.zoneddate" {
  expect_output '2010-05-15'
}

@test "io: ' 10000-06-14+14:00 '::sparql.zoneddate" {
  expect_output '10000-06-14+14:00'
}

@test "io: ' 2020-02-30 '::sparql.zoneddate" {
  expect_error
}

@test "io: ' 999-04-15 '::sparql.zoneddate" {
  expect_error
}

@test "io: ' 1990-1-20 '::sparql.zoneddate" {
  expect_error
}

@test "io: ' 1990-01-20+14:01 '::sparql.zoneddate" {
  expect_error
}

@test "io: ' 1990-01-20-14:01 '::sparql.zoneddate" {
  expect_error
}

@test "io: ' '::sparql.zoneddate" {
  expect_error
}

@test "io: ''::sparql.zoneddate" {
  expect_error
}



####
# receive/send
#

@test "rs: ' 0000-02-18Z '::sparql.zoneddate" {
  expect_output '0000-02-18Z'
}

@test "rs: ' -0010-02-18Z '::sparql.zoneddate" {
  expect_output '-0010-02-18Z'
}

@test "rs: ' -0010-03-17+00:00 '::sparql.zoneddate" {
  expect_output '-0010-03-17Z'
}

@test "rs: ' -0001-04-16+10:55 '::sparql.zoneddate" {
  expect_output '-0001-04-16+10:55'
}

@test "rs: ' -1990-05-15-14:00 '::sparql.zoneddate" {
  expect_output '-1990-05-15-14:00'
}

@test "rs: ' -2010-05-15-14:00 '::sparql.zoneddate" {
  expect_output '-2010-05-15-14:00'
}

@test "rs: ' 0010-02-18Z '::sparql.zoneddate" {
  expect_output '0010-02-18Z'
}

@test "rs: ' 0010-03-17+00:00 '::sparql.zoneddate" {
  expect_output '0010-03-17Z'
}

@test "rs: ' 0001-04-16+10:55 '::sparql.zoneddate" {
  expect_output '0001-04-16+10:55'
}

@test "rs: ' 1990-05-15-14:00 '::sparql.zoneddate" {
  expect_output '1990-05-15-14:00'
}

@test "rs: ' 2010-05-15-14:00 '::sparql.zoneddate" {
  expect_output '2010-05-15-14:00'
}

@test "rs: ' 2010-05-15 '::sparql.zoneddate" {
  expect_output '2010-05-15'
}

@test "rs: ' 10000-06-14+14:00 '::sparql.zoneddate" {
  expect_output '10000-06-14+14:00'
}



####
# sparql.zoneddate_create
#

@test "fn: sparql.zoneddate_create('0001-02-18 BC'::date, 0::int4)" {
  expect_output '0000-02-18Z'
}

@test "fn: sparql.zoneddate_create('0011-02-18 BC'::date, 0::int4)" {
  expect_output '-0010-02-18Z'
}

@test "fn: sparql.zoneddate_create('0011-03-17 BC'::date, 0::int4)" {
  expect_output '-0010-03-17Z'
}

@test "fn: sparql.zoneddate_create('0002-04-16 BC'::date, ((10*60+55)*60)::int4)" {
  expect_output '-0001-04-16+10:55'
}

@test "fn: sparql.zoneddate_create('1991-05-15 BC'::date, (-14*60*60)::int4)" {
  expect_output '-1990-05-15-14:00'
}

@test "fn: sparql.zoneddate_create('2011-05-15 BC'::date, (-14*60*60)::int4)" {
  expect_output '-2010-05-15-14:00'
}

@test "fn: sparql.zoneddate_create('0010-02-18'::date, 0::int4)" {
  expect_output '0010-02-18Z'
}

@test "fn: sparql.zoneddate_create('0010-03-17'::date, 0::int4)" {
  expect_output '0010-03-17Z'
}

@test "fn: sparql.zoneddate_create('0001-04-16'::date, ((10*60+55)*60)::int4)" {
  expect_output '0001-04-16+10:55'
}

@test "fn: sparql.zoneddate_create('1990-05-15'::date, (-14*60*60)::int4)" {
  expect_output '1990-05-15-14:00'
}

@test "fn: sparql.zoneddate_create('2010-05-15'::date, (-14*60*60)::int4)" {
  expect_output '2010-05-15-14:00'
}

@test "fn: sparql.zoneddate_create('2010-05-15'::date, '-2147483648'::int4)" {
  expect_output '2010-05-15'
}

@test "fn: sparql.zoneddate_create('10000-06-14'::date, (14*60*60)::int4)" {
  expect_output '10000-06-14+14:00'
}



####
# sparql.zoneddate_get_value
#

@test "fn: sparql.zoneddate_get_value(sparql.zoneddate_create('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0001-02-18 BC'
}

@test "fn: sparql.zoneddate_get_value(sparql.zoneddate_create('1990-05-15'::date, (-14*60*60)::int4))" {
  expect_output '1990-05-15'
}

@test "fn: sparql.zoneddate_get_value(sparql.zoneddate_create('2011-07-25'::date, (10*60*60)::int4))" {
  expect_output '2011-07-25'
}

@test "fn: sparql.zoneddate_get_value(sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4))" {
  expect_output '2022-10-05'
}



####
# sparql.zoneddate_get_value_of_zone()
#

@test "fn: sparql.zoneddate_get_value_of_zone(sparql.zoneddate_create('0001-02-18 BC'::date, 0::int4), 0::int4)" {
  expect_output '0001-02-18 BC'
}

@test "fn: sparql.zoneddate_get_value_of_zone(sparql.zoneddate_create('1990-05-15'::date, (-14*60*60)::int4), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.zoneddate_get_value_of_zone(sparql.zoneddate_create('2011-07-25'::date, (10*60*60)::int4), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.zoneddate_get_value_of_zone(sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '2022-10-05'
}



####
# sparql.zoneddate_get_zone()
#

@test "fn: sparql.zoneddate_get_zone(sparql.zoneddate_create('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0'
}

@test "fn: sparql.zoneddate_get_zone(sparql.zoneddate_create('1990-05-15'::date, (-14*60*60)::int4))" {
  expect_output '-50400'
}

@test "fn: sparql.zoneddate_get_zone(sparql.zoneddate_create('2011-07-25'::date, (10*60*60)::int4))" {
  expect_output '36000'
}

@test "fn: sparql.zoneddate_get_zone(sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4))" {
  expect_output '-2147483648'
}



####
# operator === / sameTerm()
#

@test "op: sparql.zoneddate_create('2022-10-05'::date, 0::int4) operator(sparql.===) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.===) sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.===) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.===) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.===) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.===) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}



####
# operator =
#

@test "op: sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.=) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.=) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.=) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.=) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}



####
# operator !=
#

@test "op: sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.!=) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.!=) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.!=) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.!=) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}



####
# operator <
#

@test "op: sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.<) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.<) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.<) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.<) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}



####
# operator >
#

@test "op: sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.>) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.>) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.>) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.>) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}



####
# operator <=
#

@test "op: sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.<=) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.<=) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.<=) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.<=) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}



####
# operator >=
#

@test "op: sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.>=) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.>=) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.>=) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.>=) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}



####
# sparql.zoneddate_compare()
#

@test "fn: sparql.zoneddate_compare(sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4), sparql.zoneddate_create('2022-10-05'::date, 0::int4))" {
  expect_output '0'
}

@test "fn: sparql.zoneddate_compare(sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4), sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.zoneddate_compare(sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4), sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4))" {
  expect_output '1'
}

@test "fn: sparql.zoneddate_compare(sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4), sparql.zoneddate_create('0001-01-01'::date, 0::int4))" {
  expect_output '-1'
}
