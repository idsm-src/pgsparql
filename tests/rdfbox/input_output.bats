load ../psql_tests.bash



####
# literals
#

@test "io: '\"chat\"'::sparql.rdfbox" {
  expect_output '"chat"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "io: '''chat''@fr'::sparql.rdfbox" {
  expect_output '"chat"@fr'
}

@test "io: '\"xyz\"^^<http://example.org/ns/userDatatype>'::sparql.rdfbox" {
  expect_output '"xyz"^^<http://example.org/ns/userDatatype>'
}

@test "io: '''''''The librarian said, \"Perhaps you would enjoy ''War and Peace''.\"'''''''::sparql.rdfbox" {
  expect_output "\"The librarian said, \\\"Perhaps you would enjoy \\'War and Peace\\'.\\\"\"^^<http://www.w3.org/2001/XMLSchema#string>"
}

@test "io: '1'::sparql.rdfbox" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '1.3'::sparql.rdfbox" {
  expect_output '"1.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '1.300'::sparql.rdfbox" {
  expect_output '"1.300"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '1.0e6'::sparql.rdfbox" {
  expect_output '"1.0e6"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '-1'::sparql.rdfbox" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '+1'::sparql.rdfbox" {
  expect_output '"+1"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '-1.3'::sparql.rdfbox" {
  expect_output '"-1.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '1.0E6'::sparql.rdfbox" {
  expect_output '"1.0E6"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '-1.0e6'::sparql.rdfbox" {
  expect_output '"-1.0e6"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '1.0e-6'::sparql.rdfbox" {
  expect_output '"1.0e-6"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '+1.0e+6'::sparql.rdfbox" {
  expect_output '"+1.0e+6"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '1-2'::sparql.rdfbox" {
  expect_error
}

@test "io: '1e2e3'::sparql.rdfbox" {
  expect_error
}

@test "io: '--1'::sparql.rdfbox" {
  expect_error
}

@test "io: 'true'::sparql.rdfbox" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "io: 'false'::sparql.rdfbox" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}



####
# xsd:boolean
#

@test "io: '\"true\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "io: '\"false\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "io: '\"1\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "io: '\"TRUE\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"TRUE"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "io: '\"T\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"T"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}



####
# xsd:short
#

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "io: '\"122\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "io: '\"-1231\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"-1231"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "io: '\"32770\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"32770"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#short>'
}



####
# xsd:int
#

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "io: '\"122\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "io: '\"-12312\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"-12312"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "io: '\"2147483650\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"2147483650"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#int>'
}



####
# xsd:long
#

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "io: '\"122\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "io: '\"-1231235555\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"-1231235555"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "io: '\"9223372036854775810\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"9223372036854775810"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#long>'
}



####
# xsd:byte
#

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#byte>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#byte>'
}

@test "io: '\"122\"^^<http://www.w3.org/2001/XMLSchema#byte>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#byte>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#byte>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#byte>'
}

@test "io: '\"-128\"^^<http://www.w3.org/2001/XMLSchema#byte>'::sparql.rdfbox" {
  expect_output '"-128"^^<http://www.w3.org/2001/XMLSchema#byte>'
}

@test "io: '\"128\"^^<http://www.w3.org/2001/XMLSchema#byte>'::sparql.rdfbox" {
  expect_output '"128"^^<http://www.w3.org/2001/XMLSchema#byte>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#byte>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#byte>'
}



####
# xsd:unsignedByte
#

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "io: '\"255\"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'::sparql.rdfbox" {
  expect_output '"255"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "io: '\"-1\"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'::sparql.rdfbox" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "io: '\"256\"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'::sparql.rdfbox" {
  expect_output '"256"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#unsignedByte>'
}



####
# xsd:unsignedShort
#

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'
}

@test "io: '\"65535\"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'::sparql.rdfbox" {
  expect_output '"65535"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'
}

@test "io: '\"-1\"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'::sparql.rdfbox" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'
}

@test "io: '\"65536\"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'::sparql.rdfbox" {
  expect_output '"65536"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#unsignedShort>'
}



####
# xsd:unsignedInt
#

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'
}

@test "io: '\"4294967295\"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'::sparql.rdfbox" {
  expect_output '"4294967295"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'
}

@test "io: '\"-1\"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'::sparql.rdfbox" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'
}

@test "io: '\"4294967296\"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'::sparql.rdfbox" {
  expect_output '"4294967296"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#unsignedInt>'
}



####
# xsd:unsignedLong
#

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}

@test "io: '\"18446744073709551615\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox" {
  expect_output '"18446744073709551615"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}

@test "io: '\"-1\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}

@test "io: '\"18446744073709551616\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox" {
  expect_output '"18446744073709551616"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#unsignedLong>'
}



####
# xsd:integer
#

@test "io: '\"122\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '\"00122\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"00122"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '\"-3\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"-3"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '\"3.\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"3."^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}



####
# xsd:nonPositiveInteger
#

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'
}

@test "io: '\"+0\"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'::sparql.rdfbox" {
  expect_output '"+0"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'
}

@test "io: '\"-18446744073709551616\"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'::sparql.rdfbox" {
  expect_output '"-18446744073709551616"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'
}

@test "io: '\"-003\"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'::sparql.rdfbox" {
  expect_output '"-003"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'
}

@test "io: '\"1\"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'::sparql.rdfbox" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#nonPositiveInteger>'
}



####
# xsd:negativeInteger
#

@test "io: '\"-1\"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'::sparql.rdfbox" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'
}

@test "io: '\"-18446744073709551616\"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'::sparql.rdfbox" {
  expect_output '"-18446744073709551616"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'
}

@test "io: '\"-003\"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'::sparql.rdfbox" {
  expect_output '"-003"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'
}

@test "io: '\"1\"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'::sparql.rdfbox" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#negativeInteger>'
}



####
# xsd:nonNegativeInteger
#

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}

@test "io: '\"18446744073709551616\"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'::sparql.rdfbox" {
  expect_output '"18446744073709551616"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}

@test "io: '\"003\"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'::sparql.rdfbox" {
  expect_output '"003"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}

@test "io: '\"-1\"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'::sparql.rdfbox" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#nonNegativeInteger>'
}



####
# xsd:positiveInteger
#

@test "io: '\"1\"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'::sparql.rdfbox" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'
}

@test "io: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'
}

@test "io: '\"18446744073709551616\"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'::sparql.rdfbox" {
  expect_output '"18446744073709551616"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'
}

@test "io: '\"003\"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'::sparql.rdfbox" {
  expect_output '"003"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'
}

@test "io: '\"-1\"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'::sparql.rdfbox" {
  expect_output '"-1"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'
}

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#positiveInteger>'
}



####
# xsd:decimal
#

@test "io: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"-3.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"-3.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"+3.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\".3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '".3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"3.\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3."^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"-.3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"-.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"0003.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"0003.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"3.0000\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3.0000"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"3,5\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3,5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}



####
# xsd:float
#

@test "io: '\"-3E2\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"-3E2"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"4268.22752E11\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"4268.22752E11"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"+24.3e-3\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"+24.3e-3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"12\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"12"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"+3.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"-INF\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"NaN\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"-3E2.4\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"-3E2.4"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"12E\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"12E"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "io: '\"NAN\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"NAN"^^<http://www.w3.org/2001/XMLSchema#float>'
}



####
# xsd:double
#

@test "io: '\"-3E2\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"-3E2"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"4268.22752E11\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"4268.22752E11"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"+24.3e-3\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"+24.3e-3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"12\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"12"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"+3.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"-INF\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"NaN\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"-3E2.4\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"-3E2.4"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"12E\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"12E"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "io: '\"NAN\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"NAN"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# xsd:dateTime
#

@test "io: '\"2004-04-12T13:20:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:20:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "io: '\"2004-04-12T13:20:15.5\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:20:15.5"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "io: '\"2004-04-12T13:20:00-05:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:20:00-05:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "io: '\"2004-04-12T13:20:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:20:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "io: '\"2004-04-12T13:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "io: '\"2004-04-1213:20:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-1213:20:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "io: '\"99-04-12T13:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"99-04-12T13:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "io: '\"2004-04-12\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}



####
# xsd:date
#

@test "io: '\"2004-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"-0045-01-01\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"-0045-01-01"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"12004-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"12004-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"2004-04-12-05:00\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-04-12-05:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"2004-04-12Z\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-04-12Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"99-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"99-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"2004-4-2\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-4-2"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"2004/04/02\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004/04/02"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"04-12-2004\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"04-12-2004"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "io: '\"2004-04-31\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-04-31"^^<http://www.w3.org/2001/XMLSchema#date>'
}



####
# xsd:dayTimeDuration
#

@test "io: '\"P1DT2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P1DT2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"PT20M\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT20M"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"PT120M\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT120M"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"P0DT1H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P0DT1H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"P0D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P0D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"-P60D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"-P60D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"PT1M30.5S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT1M30.5S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"P2Y6M5DT12H35M30S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P2Y6M5DT12H35M30S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"P-20D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P-20D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"P20DT\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P20DT"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"PT1HM3S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT1HM3S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"P15.5D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P15.5D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"P1D2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P1D2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"1DT2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"1DT2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"PT15M5H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT15M5H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"P\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "io: '\"PT15.S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT15.S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}



####
# xsd:string
#

@test "io: '\"value\"'::sparql.rdfbox" {
  expect_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "io: '\"\"\"value\"\"\"'::sparql.rdfbox" {
  expect_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "io: '''value'''::sparql.rdfbox" {
  expect_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "io: '''''''value'''''''::sparql.rdfbox" {
  expect_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "io: '\"value'::sparql.rdfbox" {
  expect_error
}

@test "io: '\"\"\"value\"\"'::sparql.rdfbox" {
  expect_error
}



####
# user literals
#

@test "io: '''1:integer''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'1:integer'^^<http://example.org/type>"
}

@test "io: '''1:int4''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'1:integer'^^<http://example.org/type>"
}

@test "io: '''1:  integer  ''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'1:integer'^^<http://example.org/type>"
}

@test "io: '''  1  :integer''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'  1  :integer'^^<http://example.org/type>"
}

@test "io: '''abc:text''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'abc:pg_catalog.text'^^<http://example.org/type>"
}

@test "io: '''1.50:numeric''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'1.50:numeric'^^<http://example.org/type>"
}

@test "io: '''2010-11-18:date''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'2010-11-18:pg_catalog.date'^^<http://example.org/type>"
}

@test "io: '''a\''b:character varying''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'a\'b:character varying'^^<http://example.org/type>"
}

@test "io: '''a\tb:character varying''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'a\tb:character varying'^^<http://example.org/type>"
}

@test "io: '''a\"b:character varying''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'a\\\"b:character varying'^^<http://example.org/type>"
}

@test "io: '''''''abc:character varying''''''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'abc:character varying'^^<http://example.org/type>"
}

@test "io: '''1:integer:sparql.ubox''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output "'1:integer:sparql.ubox'^^<http://example.org/type>"
}

@test "io: '''1:integer'''::sparql.rdfbox" {
  expect_output '"1:integer"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "io: '\"1:integer\"^^<http://example.org/type>'::sparql.rdfbox" {
  expect_output '"1:integer"^^<http://example.org/type>'
}

@test "io: '''1:nosuchtype''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_error
}

@test "io: '''noseparator''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_error
}

@test "io: '''abc:integer''^^<http://example.org/type>'::sparql.rdfbox" {
  expect_error
}

@test "io: '''1:integer''^^<example.org/type>'::sparql.rdfbox" {
  expect_error
}



####
# IRIs
#

@test "io: '<http://example.org/book/book1>'::sparql.rdfbox" {
  expect_output '<http://example.org/book/book1>'
}

@test "io: '<example.org/book/book1>'::sparql.rdfbox" {
  expect_error
}



####
# blank nodes
#

@test "io: '_:i0123456789abcdef'::sparql.rdfbox" {
  expect_output '_:i0123456789abcdef'
}

@test "io: '_:ifedcba9876543210'::sparql.rdfbox" {
  expect_output '_:ifedcba9876543210'
}

@test "io: '_:sffffffffid'::sparql.rdfbox" {
  expect_output '_:sffffffffid'
}

@test "io: '_:s00000000id'::sparql.rdfbox" {
  expect_output '_:s00000000id'
}

@test "io: '_:i0123456789abcdef0'::sparql.rdfbox" {
  expect_error
}

@test "io: '_:xfedcba9876543210'::sparql.rdfbox" {
  expect_error
}

@test "io: '_:i123456789abcdef'::sparql.rdfbox" {
  expect_error
}

@test "io: '_:iedcba9876543210'::sparql.rdfbox" {
  expect_error
}

@test "io: '_:sfffffffid'::sparql.rdfbox" {
  expect_error
}

@test "io: '_:s0000000id'::sparql.rdfbox" {
  expect_error
}



####
# a lexical form is escaped like any other string: the parsers honour the
# whitespace facet of XSD, so it may hold a line break, and a raw CR or LF is
# rejected inside a literal delimited by a single quotation mark
#

@test "io: '\"\\n1\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"\n1"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "io: '\"\\r1\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"\r1"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "io: '\"\\ttrue\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"\ttrue"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "io: '\"\\n2000-01-01T00:00:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"\n2000-01-01T00:00:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "io: '\"\\n1.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox::varchar::sparql.rdfbox" {
  expect_output '"\n1.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "io: '\"\\n1.0E0\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox::varchar::sparql.rdfbox" {
  expect_output '"\n1.0E0"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# a blank node with an empty label: eleven characters, and it has to read back
#

@test "io: '_:s00000001'::sparql.rdfbox" {
  expect_output '_:s00000001'
}

@test "io: sparql.rdfbox_create_from_sblanknode(''::varchar, 1)::varchar::sparql.rdfbox" {
  expect_output '_:s00000001'
}



####
# a label that decodes to bytes which are not valid in the server encoding
#

@test "io: '_:s00000001a-ff'::sparql.rdfbox" {
  expect_error
}



####
# memcpy_escaped() writes a backslash as "\\", so the input function has to
# decode it again -- a value holding one could not be read back from its own
# text representation
#

@test "io: sparql.rdfbox_create_from_string(('a' || chr(92) || 'b')::varchar)" {
  expect_output '"a\\b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "io: sparql.rdfbox_create_from_string(('a' || chr(92) || 'b')::varchar)::varchar::sparql.rdfbox" {
  expect_output '"a\\b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "io: sparql.rdfbox_create_from_langstring(('a' || chr(92) || 'b')::varchar, 'en'::varchar)::varchar::sparql.rdfbox" {
  expect_output '"a\\b"@en'
}

@test "io: sparql.rdfbox_create_from_typedliteral(('a' || chr(92) || 'b')::varchar, 'http://example.org/t'::varchar)::varchar::sparql.rdfbox" {
  expect_output '"a\\b"^^<http://example.org/t>'
}

# every escape memcpy_escaped() can write, in one value
@test "io: sparql.rdfbox_get_string(sparql.rdfbox_create_from_string((chr(92) || chr(9) || chr(8) || chr(10) || chr(13) || chr(12) || chr(34) || chr(39))::varchar)::varchar::sparql.rdfbox) = (chr(92) || chr(9) || chr(8) || chr(10) || chr(13) || chr(12) || chr(34) || chr(39))::varchar" {
  expect_output 't'
}
