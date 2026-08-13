# Test values were derived from code taken from github.com/ulfjack/ryu under the
# terms of the Boost license (not the Apache license). The original copyright
# notice follows:
#
# Copyright 2018 Ulf Adams
#
# The contents of this file may be used under the terms of the Apache License,
# Version 2.0.
#
#    (See accompanying file LICENSE-Apache or copy at
#     http://www.apache.org/licenses/LICENSE-2.0)
#
# Alternatively, the contents of this file may be used under the terms of
# the Boost Software License, Version 1.0.
#    (See accompanying file LICENSE-Boost or copy at
#     https://www.boost.org/LICENSE_1_0.txt)
#
# Unless required by applicable law or agreed to in writing, this software
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.

load ../psql_tests.bash



@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('0.0'::float8))" {
  expect_output '0.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('-0.0'::float8))" {
  expect_output '-0.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0'::float8))" {
  expect_output '1.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('-1.0'::float8))" {
  expect_output '-1.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('NAN'::float8))" {
  expect_output 'NaN'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('INFINITY'::float8))" {
  expect_output 'INF'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('-INFINITY'::float8))" {
  expect_output '-INF'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('2.2250738585072014E-308'::float8))" {
  expect_output '2.2250738585072014E-308'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('2.98023223876953125E-8'::float8))" {
  expect_output '2.9802322387695312E-8'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('-2.109808898695963E16'::float8))" {
  expect_output '-2.109808898695963E16'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('4.940656E-318'::float8))" {
  expect_output '4.940656E-318'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.18575755E-316'::float8))" {
  expect_output '1.18575755E-316'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('2.989102097996E-312'::float8))" {
  expect_output '2.989102097996E-312'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('9.0608011534336E15'::float8))" {
  expect_output '9.0608011534336E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('4.708356024711512E18'::float8))" {
  expect_output '4.708356024711512E18'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('9.409340012568248E18'::float8))" {
  expect_output '9.409340012568248E18'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345678'::float8))" {
  expect_output '1.2345678E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1'::float8))" {
  expect_output '1.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2'::float8))" {
  expect_output '1.2E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23'::float8))" {
  expect_output '1.23E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234'::float8))" {
  expect_output '1.234E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345'::float8))" {
  expect_output '1.2345E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456'::float8))" {
  expect_output '1.23456E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234567'::float8))" {
  expect_output '1.234567E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456789'::float8))" {
  expect_output '1.23456789E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234567895'::float8))" {
  expect_output '1.234567895E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345678901'::float8))" {
  expect_output '1.2345678901E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456789012'::float8))" {
  expect_output '1.23456789012E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234567890123'::float8))" {
  expect_output '1.234567890123E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345678901234'::float8))" {
  expect_output '1.2345678901234E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456789012345'::float8))" {
  expect_output '1.23456789012345E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234567890123456'::float8))" {
  expect_output '1.234567890123456E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345678901234567'::float8))" {
  expect_output '1.2345678901234567E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('4.294967294'::float8))" {
  expect_output '4.294967294E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('4.294967295'::float8))" {
  expect_output '4.294967295E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('4.294967296'::float8))" {
  expect_output '4.294967296E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('4.294967297'::float8))" {
  expect_output '4.294967297E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('4.294967298'::float8))" {
  expect_output '4.294967298E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('9007199254740991.0'::float8))" {
  expect_output '9.007199254740991E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('9007199254740992.0'::float8))" {
  expect_output '9.007199254740992E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+0'::float8))" {
  expect_output '1.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2e+1'::float8))" {
  expect_output '1.2E1'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23e+2'::float8))" {
  expect_output '1.23E2'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234e+3'::float8))" {
  expect_output '1.234E3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345e+4'::float8))" {
  expect_output '1.2345E4'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456e+5'::float8))" {
  expect_output '1.23456E5'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234567e+6'::float8))" {
  expect_output '1.234567E6'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345678e+7'::float8))" {
  expect_output '1.2345678E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456789e+8'::float8))" {
  expect_output '1.23456789E8'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456789e+9'::float8))" {
  expect_output '1.23456789E9'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234567895e+9'::float8))" {
  expect_output '1.234567895E9'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345678901e+10'::float8))" {
  expect_output '1.2345678901E10'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456789012e+11'::float8))" {
  expect_output '1.23456789012E11'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234567890123e+12'::float8))" {
  expect_output '1.234567890123E12'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.2345678901234e+13'::float8))" {
  expect_output '1.2345678901234E13'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.23456789012345e+14'::float8))" {
  expect_output '1.23456789012345E14'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.234567890123456e+15'::float8))" {
  expect_output '1.234567890123456E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+1'::float8))" {
  expect_output '1.0E1'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+2'::float8))" {
  expect_output '1.0E2'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+3'::float8))" {
  expect_output '1.0E3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+4'::float8))" {
  expect_output '1.0E4'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+5'::float8))" {
  expect_output '1.0E5'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+6'::float8))" {
  expect_output '1.0E6'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+7'::float8))" {
  expect_output '1.0E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+8'::float8))" {
  expect_output '1.0E8'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+9'::float8))" {
  expect_output '1.0E9'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+10'::float8))" {
  expect_output '1.0E10'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+11'::float8))" {
  expect_output '1.0E11'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+12'::float8))" {
  expect_output '1.0E12'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+13'::float8))" {
  expect_output '1.0E13'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+14'::float8))" {
  expect_output '1.0E14'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8))" {
  expect_output '1.0E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+0'::float8))" {
  expect_output '1.000000000000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+1'::float8))" {
  expect_output '1.00000000000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+2'::float8))" {
  expect_output '1.0000000000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+3'::float8))" {
  expect_output '1.000000000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+4'::float8))" {
  expect_output '1.00000000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+5'::float8))" {
  expect_output '1.0000000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+6'::float8))" {
  expect_output '1.000000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+7'::float8))" {
  expect_output '1.00000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+8'::float8))" {
  expect_output '1.0000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+9'::float8))" {
  expect_output '1.000001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+10'::float8))" {
  expect_output '1.00001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+11'::float8))" {
  expect_output '1.0001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+12'::float8))" {
  expect_output '1.001E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+13'::float8))" {
  expect_output '1.01E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('1.0e+15'::float8 + '1.0e+14'::float8))" {
  expect_output '1.1E15'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8.0'::float8))" {
  expect_output '8.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('64.0'::float8))" {
  expect_output '6.4E1'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('512.0'::float8))" {
  expect_output '5.12E2'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8192.0'::float8))" {
  expect_output '8.192E3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('65536.0'::float8))" {
  expect_output '6.5536E4'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('524288.0'::float8))" {
  expect_output '5.24288E5'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8388608.0'::float8))" {
  expect_output '8.388608E6'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('67108864.0'::float8))" {
  expect_output '6.7108864E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('536870912.0'::float8))" {
  expect_output '5.36870912E8'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8589934592.0'::float8))" {
  expect_output '8.589934592E9'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('68719476736.0'::float8))" {
  expect_output '6.8719476736E10'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('549755813888.0'::float8))" {
  expect_output '5.49755813888E11'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8796093022208.0'::float8))" {
  expect_output '8.796093022208E12'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('70368744177664.0'::float8))" {
  expect_output '7.0368744177664E13'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('562949953421312.0'::float8))" {
  expect_output '5.62949953421312E14'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8.0e+3'::float8))" {
  expect_output '8.0E3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('64.0e+3'::float8))" {
  expect_output '6.4E4'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('512.0e+3'::float8))" {
  expect_output '5.12E5'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8192.0e+3'::float8))" {
  expect_output '8.192E6'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('65536.0e+3'::float8))" {
  expect_output '6.5536E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('524288.0e+3'::float8))" {
  expect_output '5.24288E8'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8388608.0e+3'::float8))" {
  expect_output '8.388608E9'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('67108864.0e+3'::float8))" {
  expect_output '6.7108864E10'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('536870912.0e+3'::float8))" {
  expect_output '5.36870912E11'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8589934592.0e+3'::float8))" {
  expect_output '8.589934592E12'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('68719476736.0e+3'::float8))" {
  expect_output '6.8719476736E13'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('549755813888.0e+3'::float8))" {
  expect_output '5.49755813888E14'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_double('8796093022208.0e+3'::float8))" {
  expect_output '8.796093022208E15'
}
