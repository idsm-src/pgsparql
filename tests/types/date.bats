load ../psql_tests.bash



####
# in/out
#

@test "' 0000-02-18Z '::sparql.zoneddate" {
  expect_output '0000-02-18Z'
}

@test "' -0010-02-18Z '::sparql.zoneddate" {
  expect_output '-0010-02-18Z'
}

@test "' -0010-03-17+00:00 '::sparql.zoneddate" {
  expect_output '-0010-03-17Z'
}

@test "' -0001-04-16+10:55 '::sparql.zoneddate" {
  expect_output '-0001-04-16+10:55'
}

@test "' -1990-05-15-14:00 '::sparql.zoneddate" {
  expect_output '-1990-05-15-14:00'
}

@test "' -2010-05-15-14:00 '::sparql.zoneddate" {
  expect_output '-2010-05-15-14:00'
}

@test "' 0010-02-18Z '::sparql.zoneddate" {
  expect_output '0010-02-18Z'
}

@test "' 0010-03-17+00:00 '::sparql.zoneddate" {
  expect_output '0010-03-17Z'
}

@test "' 0001-04-16+10:55 '::sparql.zoneddate" {
  expect_output '0001-04-16+10:55'
}

@test "' 1990-05-15-14:00 '::sparql.zoneddate" {
  expect_output '1990-05-15-14:00'
}

@test "' 2010-05-15-14:00 '::sparql.zoneddate" {
  expect_output '2010-05-15-14:00'
}

@test "' 2010-05-15 '::sparql.zoneddate" {
  expect_output '2010-05-15'
}

@test "' 10000-06-14+14:00 '::sparql.zoneddate" {
  expect_output '10000-06-14+14:00'
}

@test "' 2020-02-30 '::sparql.zoneddate" {
  expect_error
}

@test "' 999-04-15 '::sparql.zoneddate" {
  expect_error
}

@test "' 1990-1-20 '::sparql.zoneddate" {
  expect_error
}

@test "' 1990-01-20+14:01 '::sparql.zoneddate" {
  expect_error
}

@test "' 1990-01-20-14:01 '::sparql.zoneddate" {
  expect_error
}

@test "' '::sparql.zoneddate" {
  expect_error
}

@test "''::sparql.zoneddate" {
  expect_error
}



####
# sparql.zoneddate_create
#

@test sparql.zoneddate_create('0001-02-18 BC'::date, 0::int4)" {
  expect_output '0000-02-18Z'
}

@test sparql.zoneddate_create('0011-02-18 BC'::date, 0::int4)" {
  expect_output '-0010-02-18Z'
}

@test sparql.zoneddate_create('0011-03-17 BC'::date, 0::int4)" {
  expect_output '-0010-03-17Z'
}

@test sparql.zoneddate_create('0002-04-16 BC'::date, ((10*60+55)*60)::int4)" {
  expect_output '-0001-04-16+10:55'
}

@test sparql.zoneddate_create('1991-05-15 BC'::date, (-14*60*60)::int4)" {
  expect_output '-1990-05-15-14:00'
}

@test sparql.zoneddate_create('2011-05-15 BC'::date, (-14*60*60)::int4)" {
  expect_output '-2010-05-15-14:00'
}

@test sparql.zoneddate_create('0010-02-18'::date, 0::int4)" {
  expect_output '0010-02-18Z'
}

@test sparql.zoneddate_create('0010-03-17'::date, 0::int4)" {
  expect_output '0010-03-17Z'
}

@test sparql.zoneddate_create('0001-04-16'::date, ((10*60+55)*60)::int4)" {
  expect_output '0001-04-16+10:55'
}

@test sparql.zoneddate_create('1990-05-15'::date, (-14*60*60)::int4)" {
  expect_output '1990-05-15-14:00'
}

@test sparql.zoneddate_create('2010-05-15'::date, (-14*60*60)::int4)" {
  expect_output '2010-05-15-14:00'
}

@test sparql.zoneddate_create('2010-05-15'::date, '-2147483648'::int4)" {
  expect_output '2010-05-15'
}

@test sparql.zoneddate_create('10000-06-14'::date, (14*60*60)::int4)" {
  expect_output '10000-06-14+14:00'
}



####
# sparql.zoneddate_get_value
#

@test "sparql.zoneddate_get_value(sparql.zoneddate_create('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0001-02-18 BC'
}

@test "sparql.zoneddate_get_value(sparql.zoneddate_create('1990-05-15'::date, (-14*60*60)::int4))" {
  expect_output '1990-05-15'
}

@test "sparql.zoneddate_get_value(sparql.zoneddate_create('2011-07-25'::date, (10*60*60)::int4))" {
  expect_output '2011-07-25'
}

@test "sparql.zoneddate_get_value(sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4))" {
  expect_output '2022-10-05'
}



####
# sparql.zoneddate_get_value_of_zone()
#

@test "sparql.zoneddate_get_value_of_zone(sparql.zoneddate_create('0001-02-18 BC'::date, 0::int4), 0::int4)" {
  expect_output '0001-02-18 BC'
}

@test "sparql.zoneddate_get_value_of_zone(sparql.zoneddate_create('1990-05-15'::date, (-14*60*60)::int4), (14*60*60)::int4)" {
  expect_output ''
}

@test "sparql.zoneddate_get_value_of_zone(sparql.zoneddate_create('2011-07-25'::date, (10*60*60)::int4), '-2147483648'::int4)" {
  expect_output ''
}

@test "sparql.zoneddate_get_value_of_zone(sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '2022-10-05'
}



####
# sparql.zoneddate_get_zone()
#

@test "sparql.zoneddate_get_zone(sparql.zoneddate_create('0001-02-18 BC'::date, 0::int4))" {
  expect_output '0'
}

@test "sparql.zoneddate_get_zone(sparql.zoneddate_create('1990-05-15'::date, (-14*60*60)::int4))" {
  expect_output '-50400'
}

@test "sparql.zoneddate_get_zone(sparql.zoneddate_create('2011-07-25'::date, (10*60*60)::int4))" {
  expect_output '36000'
}

@test "sparql.zoneddate_get_zone(sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4))" {
  expect_output '-2147483648'
}



####
# operator === / sameTerm()
#

@test "sparql.zoneddate_create('2022-10-05'::date, 0::int4) operator(sparql.===) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.===) sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.===) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.===) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.===) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.===) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}



####
# operator =
#

@test "sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.=) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.=) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.=) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.=) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}



####
# operator !=
#

@test "sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.!=) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.!=) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.!=) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.!=) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}



####
# operator <
#

@test "sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.<) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.<) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.<) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.<) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}



####
# operator >
#

@test "sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.>) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.>) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.>) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.>) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}



####
# operator <=
#

@test "sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.<=) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.<=) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.<=) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 'f'
}

@test "sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.<=) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 't'
}



####
# operator >=
#

@test "sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4) operator(sparql.>=) sparql.zoneddate_create('2022-10-05'::date, 0::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4) operator(sparql.>=) sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4) operator(sparql.>=) sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4)" {
  expect_output 't'
}

@test "sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4) operator(sparql.>=) sparql.zoneddate_create('0001-01-01'::date, 0::int4)" {
  expect_output 'f'
}



####
# sparql.zoneddate_compare()
#

@test "sparql.zoneddate_compare(sparql.zoneddate_create('2022-10-05'::date, '-2147483648'::int4), sparql.zoneddate_create('2022-10-05'::date, 0::int4))" {
  expect_output '0'
}

@test "sparql.zoneddate_compare(sparql.zoneddate_create('1990-05-14', (-14*60*60)::int4), sparql.zoneddate_create('1990-05-15'::date, (10*60*60)::int4))" {
  expect_output '0'
}

@test "sparql.zoneddate_compare(sparql.zoneddate_create('2050-02-12'::date, (-14*60*60)::int4), sparql.zoneddate_create('2050-02-13'::date, (12*60*60)::int4))" {
  expect_output '1'
}

@test "sparql.zoneddate_compare(sparql.zoneddate_create('0001-01-01 BC'::date, 0::int4), sparql.zoneddate_create('0001-01-01'::date, 0::int4))" {
  expect_output '-1'
}
