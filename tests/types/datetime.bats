load ../psql_tests.bash

setup_file() {
  pg_session_start sparql.zoneddatetime
}



####
# in/out
#

@test "io: ' 0000-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "io: ' -0010-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "io: ' -0010-03-17T24:00:00+00:00 '::sparql.zoneddatetime" {
  expect_output '-0010-03-18T00:00:00Z'
}

@test "io: ' -0001-04-16T12:10:03.0+10:55 '::sparql.zoneddatetime" {
  expect_output '-0001-04-16T12:10:03+10:55'
}

@test "io: ' -1990-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '-1990-05-15T14:00:00.5-14:00'
}

@test "io: ' -2010-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '-2010-05-15T14:00:00.5-14:00'
}

@test "io: ' 0010-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "io: ' 0010-03-17T24:00:00+00:00 '::sparql.zoneddatetime" {
  expect_output '0010-03-18T00:00:00Z'
}

@test "io: ' 0001-04-16T12:10:03.0+10:55 '::sparql.zoneddatetime" {
  expect_output '0001-04-16T12:10:03+10:55'
}

@test "io: ' 1990-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '1990-05-15T14:00:00.5-14:00'
}

@test "io: ' 2010-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '2010-05-15T14:00:00.5-14:00'
}

@test "io: ' 2010-05-15T14:00:00 '::sparql.zoneddatetime" {
  expect_output '2010-05-15T14:00:00'
}

@test "io: ' 10000-06-14T00:00:00+14:00 '::sparql.zoneddatetime" {
  expect_output '10000-06-14T00:00:00+14:00'
}

@test "io: ' 2020-02-30T00:00:00 '::sparql.zoneddatetime" {
  expect_error
}

@test "io: ' 999-04-15T00:00:00 '::sparql.zoneddatetime" {
  expect_error
}

@test "io: ' 1990-1-20T00:00:00 '::sparql.zoneddatetime" {
  expect_error
}

@test "io: ' 2000-10-20T24:00:10 '::sparql.zoneddatetime" {
  expect_error
}

@test "io: ' 2000-10-20T00:00:00. '::sparql.zoneddatetime" {
  expect_error
}

@test "io: ' 2000-10-20T00:00:00+14:01 '::sparql.zoneddatetime" {
  expect_error
}

@test "io: ' 2000-10-20T00:00:00-14:01 '::sparql.zoneddatetime" {
  expect_error
}

@test "io: ' '::sparql.zoneddatetime" {
  expect_error
}

@test "io: ''::sparql.zoneddatetime" {
  expect_error
}



####
# receive/send
#

@test "rs: ' 0000-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "rs: ' -0010-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "rs: ' -0010-03-17T24:00:00+00:00 '::sparql.zoneddatetime" {
  expect_output '-0010-03-18T00:00:00Z'
}

@test "rs: ' -0001-04-16T12:10:03.0+10:55 '::sparql.zoneddatetime" {
  expect_output '-0001-04-16T12:10:03+10:55'
}

@test "rs: ' -1990-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '-1990-05-15T14:00:00.5-14:00'
}

@test "rs: ' -2010-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '-2010-05-15T14:00:00.5-14:00'
}

@test "rs: ' 0010-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "rs: ' 0010-03-17T24:00:00+00:00 '::sparql.zoneddatetime" {
  expect_output '0010-03-18T00:00:00Z'
}

@test "rs: ' 0001-04-16T12:10:03.0+10:55 '::sparql.zoneddatetime" {
  expect_output '0001-04-16T12:10:03+10:55'
}

@test "rs: ' 1990-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '1990-05-15T14:00:00.5-14:00'
}

@test "rs: ' 2010-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '2010-05-15T14:00:00.5-14:00'
}

@test "rs: ' 2010-05-15T14:00:00 '::sparql.zoneddatetime" {
  expect_output '2010-05-15T14:00:00'
}

@test "rs: ' 10000-06-14T00:00:00+14:00 '::sparql.zoneddatetime" {
  expect_output '10000-06-14T00:00:00+14:00'
}



####
# sparql.zoneddatetime_create()
#

@test "fn: sparql.zoneddatetime_create('0001-02-18T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "fn: sparql.zoneddatetime_create('0011-02-18T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "fn: sparql.zoneddatetime_create('0011-03-17T24:00:00+00:00 BC'::timestamptz, 0::int4)" {
  expect_output '-0010-03-18T00:00:00Z'
}

@test "fn: sparql.zoneddatetime_create('0002-04-16T12:10:03.0+10:55 BC'::timestamptz, ((10*60+55)*60)::int4)" {
  expect_output '-0001-04-16T12:10:03+10:55'
}

@test "fn: sparql.zoneddatetime_create('1991-05-15T14:00:00.50-14:00 BC'::timestamptz, (-14*60*60)::int4)" {
  expect_output '-1990-05-15T14:00:00.5-14:00'
}

@test "fn: sparql.zoneddatetime_create('2011-05-15T14:00:00.50-14:00 BC'::timestamptz, (-14*60*60)::int4)" {
  expect_output '-2010-05-15T14:00:00.5-14:00'
}

@test "fn: sparql.zoneddatetime_create('0010-02-18T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "fn: sparql.zoneddatetime_create('0010-03-17T24:00:00+00:00'::timestamptz, 0::int4)" {
  expect_output '0010-03-18T00:00:00Z'
}

@test "fn: sparql.zoneddatetime_create('0001-04-16T12:10:03.0+10:55'::timestamptz, ((10*60+55)*60)::int4)" {
  expect_output '0001-04-16T12:10:03+10:55'
}

@test "fn: sparql.zoneddatetime_create('1990-05-15T14:00:00.50-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '1990-05-15T14:00:00.5-14:00'
}

@test "fn: sparql.zoneddatetime_create('2010-05-15T14:00:00.50-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '2010-05-15T14:00:00.5-14:00'
}

@test "fn: sparql.zoneddatetime_create('2010-05-15T14:00:00'::timestamptz, '-2147483648'::int4)" {
  expect_output '2010-05-15T14:00:00'
}

@test "fn: sparql.zoneddatetime_create('10000-06-14T00:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '10000-06-14T00:00:00+14:00'
}



####
# sparql.zoneddatetime_get_value
#

@test "fn: sparql.zoneddatetime_get_value(sparql.zoneddatetime_create('0001-02-18T00:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0001-02-18 00:00:00+00 BC'
}

@test "fn: sparql.zoneddatetime_get_value(sparql.zoneddatetime_create('1990-05-15T14:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '1990-05-16 04:00:00+00'
}

@test "fn: sparql.zoneddatetime_get_value(sparql.zoneddatetime_create('2011-07-25T10:00:00+10:00'::timestamptz, (10*60*60)::int4))" {
  expect_output '2011-07-25 00:00:00+00'
}

@test "fn: sparql.zoneddatetime_get_value(sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4))" {
  expect_output '2022-10-05 10:00:00+00'
}



####
# sparql.zoneddatetime_get_value_of_zone()
#

@test "fn: sparql.zoneddatetime_get_value_of_zone(sparql.zoneddatetime_create('0001-02-18T00:00:00Z BC'::timestamptz, 0::int4), 0::int4)" {
  expect_output '0001-02-18 00:00:00+00 BC'
}

@test "fn: sparql.zoneddatetime_get_value_of_zone(sparql.zoneddatetime_create('1990-05-15T14:00:00-14:00'::timestamptz, (-14*60*60)::int4), (14*60*60)::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.zoneddatetime_get_value_of_zone(sparql.zoneddatetime_create('2011-07-25T10:00:00+10:00'::timestamptz, (10*60*60)::int4), '-2147483648'::int4)" {
  expect_output '(null)'
}

@test "fn: sparql.zoneddatetime_get_value_of_zone(sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '2022-10-05 10:00:00+00'
}



####
# sparql.zoneddatetime_get_zone()
#

@test "fn: sparql.zoneddatetime_get_zone(sparql.zoneddatetime_create('0001-02-18T00:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0'
}

@test "fn: sparql.zoneddatetime_get_zone(sparql.zoneddatetime_create('1990-05-15T14:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '-50400'
}

@test "fn: sparql.zoneddatetime_get_zone(sparql.zoneddatetime_create('2011-07-25T10:00:00+10:00'::timestamptz, (10*60*60)::int4))" {
  expect_output '36000'
}

@test "fn: sparql.zoneddatetime_get_zone(sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4))" {
  expect_output '-2147483648'
}



####
# operator === / sameTerm()
#

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4) operator(sparql.===) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.===) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.===) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.===) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.===) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.===) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}



####
# operator =
#

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.=) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.=) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.=) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.=) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}



####
# operator !=
#

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.!=) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.!=) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.!=) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.!=) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}



####
# operator <
#

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.<) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}



####
# operator >
#

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.>) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}



####
# operator <=
#

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.<=) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<=) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<=) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "op: sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<=) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}



####
# operator >=
#

@test "op: sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.>=) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>=) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>=) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "op: sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>=) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}



####
# sparql.zoneddatetime_compare()
#

@test "fn: sparql.zoneddatetime_compare(sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4), sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4))" {
  expect_output '0'
}

@test "fn: sparql.zoneddatetime_compare(sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4), sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '0'
}

@test "fn: sparql.zoneddatetime_compare(sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4), sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '1'
}

@test "fn: sparql.zoneddatetime_compare(sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4), sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4))" {
  expect_output '-1'
}
