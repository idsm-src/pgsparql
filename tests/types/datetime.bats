load ../psql_tests.bash



####
# in/out
#

@test "' 0000-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "' -0010-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "' -0010-03-17T24:00:00+00:00 '::sparql.zoneddatetime" {
  expect_output '-0010-03-18T00:00:00Z'
}

@test "' -0001-04-16T12:10:03.0+10:55 '::sparql.zoneddatetime" {
  expect_output '-0001-04-16T12:10:03+10:55'
}

@test "' -1990-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '-1990-05-15T14:00:00.5-14:00'
}

@test "' -2010-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '-2010-05-15T14:00:00.5-14:00'
}

@test "' 0010-02-18T00:00:00Z '::sparql.zoneddatetime" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "' 0010-03-17T24:00:00+00:00 '::sparql.zoneddatetime" {
  expect_output '0010-03-18T00:00:00Z'
}

@test "' 0001-04-16T12:10:03.0+10:55 '::sparql.zoneddatetime" {
  expect_output '0001-04-16T12:10:03+10:55'
}

@test "' 1990-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '1990-05-15T14:00:00.5-14:00'
}

@test "' 2010-05-15T14:00:00.50-14:00 '::sparql.zoneddatetime" {
  expect_output '2010-05-15T14:00:00.5-14:00'
}

@test "' 2010-05-15T14:00:00 '::sparql.zoneddatetime" {
  expect_output '2010-05-15T14:00:00'
}

@test "' 10000-06-14T00:00:00+14:00 '::sparql.zoneddatetime" {
  expect_output '10000-06-14T00:00:00+14:00'
}

@test "' 2020-02-30T00:00:00 '::sparql.zoneddatetime" {
  expect_error
}

@test "' 999-04-15T00:00:00 '::sparql.zoneddatetime" {
  expect_error
}

@test "' 1990-1-20T00:00:00 '::sparql.zoneddatetime" {
  expect_error
}

@test "' 2000-10-20T24:00:10 '::sparql.zoneddatetime" {
  expect_error
}

@test "' 2000-10-20T00:00:00. '::sparql.zoneddatetime" {
  expect_error
}

@test "' 2000-10-20T00:00:00+14:01 '::sparql.zoneddatetime" {
  expect_error
}

@test "' 2000-10-20T00:00:00-14:01 '::sparql.zoneddatetime" {
  expect_error
}

@test "' '::sparql.zoneddatetime" {
  expect_error
}

@test "''::sparql.zoneddatetime" {
  expect_error
}



####
# sparql.zoneddatetime_create()
#

@test "sparql.zoneddatetime_create('0001-02-18T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '0000-02-18T00:00:00Z'
}

@test "sparql.zoneddatetime_create('0011-02-18T00:00:00Z BC'::timestamptz, 0::int4)" {
  expect_output '-0010-02-18T00:00:00Z'
}

@test "sparql.zoneddatetime_create('0011-03-17T24:00:00+00:00 BC'::timestamptz, 0::int4)" {
  expect_output '-0010-03-18T00:00:00Z'
}

@test "sparql.zoneddatetime_create('0002-04-16T12:10:03.0+10:55 BC'::timestamptz, ((10*60+55)*60)::int4)" {
  expect_output '-0001-04-16T12:10:03+10:55'
}

@test "sparql.zoneddatetime_create('1991-05-15T14:00:00.50-14:00 BC'::timestamptz, (-14*60*60)::int4)" {
  expect_output '-1990-05-15T14:00:00.5-14:00'
}

@test "sparql.zoneddatetime_create('2011-05-15T14:00:00.50-14:00 BC'::timestamptz, (-14*60*60)::int4)" {
  expect_output '-2010-05-15T14:00:00.5-14:00'
}

@test "sparql.zoneddatetime_create('0010-02-18T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output '0010-02-18T00:00:00Z'
}

@test "sparql.zoneddatetime_create('0010-03-17T24:00:00+00:00'::timestamptz, 0::int4)" {
  expect_output '0010-03-18T00:00:00Z'
}

@test "sparql.zoneddatetime_create('0001-04-16T12:10:03.0+10:55'::timestamptz, ((10*60+55)*60)::int4)" {
  expect_output '0001-04-16T12:10:03+10:55'
}

@test "sparql.zoneddatetime_create('1990-05-15T14:00:00.50-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '1990-05-15T14:00:00.5-14:00'
}

@test "sparql.zoneddatetime_create('2010-05-15T14:00:00.50-14:00'::timestamptz, (-14*60*60)::int4)" {
  expect_output '2010-05-15T14:00:00.5-14:00'
}

@test "sparql.zoneddatetime_create('2010-05-15T14:00:00'::timestamptz, '-2147483648'::int4)" {
  expect_output '2010-05-15T14:00:00'
}

@test "sparql.zoneddatetime_create('10000-06-14T00:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output '10000-06-14T00:00:00+14:00'
}



####
# sparql.zoneddatetime_get_value
#

@test "sparql.zoneddatetime_get_value(sparql.zoneddatetime_create('0001-02-18T00:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0001-02-18 00:00:00+00 BC'
}

@test "sparql.zoneddatetime_get_value(sparql.zoneddatetime_create('1990-05-15T14:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '1990-05-16 04:00:00+00'
}

@test "sparql.zoneddatetime_get_value(sparql.zoneddatetime_create('2011-07-25T10:00:00+10:00'::timestamptz, (10*60*60)::int4))" {
  expect_output '2011-07-25 00:00:00+00'
}

@test "sparql.zoneddatetime_get_value(sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4))" {
  expect_output '2022-10-05 10:00:00+00'
}



####
# sparql.zoneddatetime_get_value_of_zone()
#

@test "sparql.zoneddatetime_get_value_of_zone(sparql.zoneddatetime_create('0001-02-18T00:00:00Z BC'::timestamptz, 0::int4), 0::int4)" {
  expect_output '0001-02-18 00:00:00+00 BC'
}

@test "sparql.zoneddatetime_get_value_of_zone(sparql.zoneddatetime_create('1990-05-15T14:00:00-14:00'::timestamptz, (-14*60*60)::int4), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.zoneddatetime_get_value_of_zone(sparql.zoneddatetime_create('2011-07-25T10:00:00+10:00'::timestamptz, (10*60*60)::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.zoneddatetime_get_value_of_zone(sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '2022-10-05 10:00:00+00'
}



####
# sparql.zoneddatetime_get_zone()
#

@test "sparql.zoneddatetime_get_zone(sparql.zoneddatetime_create('0001-02-18T00:00:00Z BC'::timestamptz, 0::int4))" {
  expect_output '0'
}

@test "sparql.zoneddatetime_get_zone(sparql.zoneddatetime_create('1990-05-15T14:00:00-14:00'::timestamptz, (-14*60*60)::int4))" {
  expect_output '-50400'
}

@test "sparql.zoneddatetime_get_zone(sparql.zoneddatetime_create('2011-07-25T10:00:00+10:00'::timestamptz, (10*60*60)::int4))" {
  expect_output '36000'
}

@test "sparql.zoneddatetime_get_zone(sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4))" {
  expect_output '-2147483648'
}



####
# operator === / sameTerm()
#

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4) operator(sparql.===) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.===) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.===) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.===) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.===) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.===) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}



####
# operator =
#

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.=) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.=) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.=) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.=) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}



####
# operator !=
#

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.!=) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.!=) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.!=) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.!=) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}



####
# operator <
#

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.<) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}



####
# operator >
#

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.>) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}



####
# operator <=
#

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.<=) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<=) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.<=) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.<=) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}



####
# operator >=
#

@test "sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4) operator(sparql.>=) sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>=) sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4) operator(sparql.>=) sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4) operator(sparql.>=) sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4)" {
  expect_output 'f'
}



####
# sparql.zoneddatetime_compare()
#

@test "sparql.zoneddatetime_compare(sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, '-2147483648'::int4), sparql.zoneddatetime_create('2022-10-05T10:00:00Z'::timestamptz, 0::int4))" {
  expect_output '0'
}

@test "sparql.zoneddatetime_compare(sparql.zoneddatetime_create('1990-05-14T16:00:00-14:00'::timestamptz, (-14*60*60)::int4), sparql.zoneddatetime_create('1990-05-15T20:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '0'
}

@test "sparql.zoneddatetime_compare(sparql.zoneddatetime_create('2050-02-12T16:00:00-14:00'::timestamptz, (-14*60*60)::int4), sparql.zoneddatetime_create('2050-02-12T16:00:00+14:00'::timestamptz, (14*60*60)::int4))" {
  expect_output '1'
}

@test "sparql.zoneddatetime_compare(sparql.zoneddatetime_create('0001-01-01T00:00:00Z BC'::timestamptz, 0::int4), sparql.zoneddatetime_create('0001-01-01T00:00:00Z'::timestamptz, 0::int4))" {
  expect_output '-1'
}
