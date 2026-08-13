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



@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('0.0'::float4))" {
  expect_output '0.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('-0.0'::float4))" {
  expect_output '-0.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.0'::float4))" {
  expect_output '1.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('-1.0'::float4))" {
  expect_output '-1.0E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('NAN'::float4))" {
  expect_output 'NaN'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('INFINITY'::float4))" {
  expect_output 'INF'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('-INFINITY'::float4))" {
  expect_output '-INF'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.1754944E-38'::float4))" {
  expect_output '1.1754944E-38'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('3.355445E7'::float4))" {
  expect_output '3.355445E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('8.999999E9'::float4))" {
  expect_output '9.0E9'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('3.4366717E10'::float4))" {
  expect_output '3.436672E10'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('3.0540412E5'::float4))" {
  expect_output '3.0540412E5'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('8.0990312E3'::float4))" {
  expect_output '8.0990312E3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('2.4414062E-4'::float4))" {
  expect_output '2.4414062E-4'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('2.4414062E-3'::float4))" {
  expect_output '2.4414062E-3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('4.3945312E-3'::float4))" {
  expect_output '4.3945312E-3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('6.3476562E-3'::float4))" {
  expect_output '6.3476562E-3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('4.7223665E21'::float4))" {
  expect_output '4.7223665E21'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('8388608.0'::float4))" {
  expect_output '8.388608E6'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.6777216E7'::float4))" {
  expect_output '1.6777216E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('3.3554436E7'::float4))" {
  expect_output '3.3554436E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('6.7131496E7'::float4))" {
  expect_output '6.7131496E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.9310392E-38'::float4))" {
  expect_output '1.9310392E-38'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('-2.47E-43'::float4))" {
  expect_output '-2.47E-43'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.993244E-38'::float4))" {
  expect_output '1.993244E-38'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('4103.9003'::float4))" {
  expect_output '4.1039004E3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('5.3399997E9'::float4))" {
  expect_output '5.3399997E9'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('6.0898E-39'::float4))" {
  expect_output '6.0898E-39'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('0.0010310042'::float4))" {
  expect_output '1.0310042E-3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('2.8823261E17'::float4))" {
  expect_output '2.882326E17'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('7.038531E-26'::float4))" {
  expect_output '7.038531E-26'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('7.0385309E-26'::float4))" {
  expect_output '7.038531E-26'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('9.2234038E17'::float4))" {
  expect_output '9.223404E17'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('6.7108872E7'::float4))" {
  expect_output '6.710887E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.0E-44'::float4))" {
  expect_output '1.0E-44'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('2.816025E14'::float4))" {
  expect_output '2.816025E14'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('9.223372E18'::float4))" {
  expect_output '9.223372E18'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.5846085E29'::float4))" {
  expect_output '1.5846086E29'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.1811161E19'::float4))" {
  expect_output '1.1811161E19'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('5.368709E18'::float4))" {
  expect_output '5.368709E18'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('4.6143165E18'::float4))" {
  expect_output '4.6143166E18'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('0.007812537'::float4))" {
  expect_output '7.812537E-3'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.4E-45'::float4))" {
  expect_output '1.4E-45'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.18697724E20'::float4))" {
  expect_output '1.18697725E20'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.00014165E-36'::float4))" {
  expect_output '1.00014165E-36'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('200.0'::float4))" {
  expect_output '2.0E2'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('3.3554432E7'::float4))" {
  expect_output '3.3554432E7'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.2'::float4))" {
  expect_output '1.2E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.23'::float4))" {
  expect_output '1.23E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.234'::float4))" {
  expect_output '1.234E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.2345'::float4))" {
  expect_output '1.2345E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.23456'::float4))" {
  expect_output '1.23456E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.234567'::float4))" {
  expect_output '1.234567E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.2345678'::float4))" {
  expect_output '1.2345678E0'
}

@test "sparql.str_rdfbox(sparql.rdfbox_create_from_float('1.23456735E-36'::float4))" {
  expect_output '1.23456735E-36'
}
