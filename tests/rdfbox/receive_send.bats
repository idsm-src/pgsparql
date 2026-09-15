load ../psql_tests.bash



####
# literals
#

@test "rs: '\"chat\"'::sparql.rdfbox" {
  expect_output '"chat"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "rs: '''chat''@fr'::sparql.rdfbox" {
  expect_output '"chat"@fr'
}

@test "rs: '\"xyz\"^^<http://example.org/ns/userDatatype>'::sparql.rdfbox" {
  expect_output '"xyz"^^<http://example.org/ns/userDatatype>'
}

@test "rs: '''''''The librarian said, \"Perhaps you would enjoy ''War and Peace''.\"'''''''::sparql.rdfbox" {
  expect_output "\"The librarian said, \\\"Perhaps you would enjoy 'War and Peace'.\\\"\"^^<http://www.w3.org/2001/XMLSchema#string>"
}

@test "rs: '1'::sparql.rdfbox" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "rs: '1.3'::sparql.rdfbox" {
  expect_output '"1.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '1.300'::sparql.rdfbox" {
  expect_output '"1.300"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '1.0e6'::sparql.rdfbox" {
  expect_output '"1.0e6"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: 'true'::sparql.rdfbox" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "rs: 'false'::sparql.rdfbox" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}



####
# xsd:boolean
#

@test "rs: '\"true\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "rs: '\"false\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "rs: '\"1\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"1"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "rs: '\"0\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "rs: '\"TRUE\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"TRUE"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "rs: '\"T\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_output '"T"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}



####
# xsd:short
#

@test "rs: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "rs: '\"122\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "rs: '\"0\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "rs: '\"-1231\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"-1231"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "rs: '\"32770\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"32770"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "rs: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#short>'
}



####
# xsd:int
#

@test "rs: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "rs: '\"122\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "rs: '\"0\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "rs: '\"-12312\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"-12312"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "rs: '\"2147483650\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"2147483650"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "rs: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#int>'
}



####
# xsd:long
#

@test "rs: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "rs: '\"122\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "rs: '\"0\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "rs: '\"-1231235555\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"-1231235555"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "rs: '\"9223372036854775810\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"9223372036854775810"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "rs: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#long>'
}



####
# xsd:integer
#

@test "rs: '\"122\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"122"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "rs: '\"00122\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"00122"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "rs: '\"0\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "rs: '\"+3\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"+3"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "rs: '\"-3\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"-3"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "rs: '\"3.\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"3."^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "rs: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}



####
# xsd:decimal
#

@test "rs: '\"3.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"-3.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"-3.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"+3.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\".3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '".3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"3.\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3."^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"-.3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"-.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"0003.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"0003.0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"3.0000\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3.0000"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "rs: '\"3,5\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_output '"3,5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}



####
# xsd:float
#

@test "rs: '\"-3E2\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"-3E2"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"4268.22752E11\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"4268.22752E11"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"+24.3e-3\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"+24.3e-3"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"12\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"12"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"+3.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"-INF\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"NaN\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"-3E2.4\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"-3E2.4"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"12E\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"12E"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "rs: '\"NAN\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_output '"NAN"^^<http://www.w3.org/2001/XMLSchema#float>'
}



####
# xsd:double
#

@test "rs: '\"-3E2\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"-3E2"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"4268.22752E11\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"4268.22752E11"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"+24.3e-3\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"+24.3e-3"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"12\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"12"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"+3.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"-INF\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"-0\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"-0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"NaN\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"-3E2.4\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"-3E2.4"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"12E\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"12E"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "rs: '\"NAN\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_output '"NAN"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# xsd:dateTime
#

@test "rs: '\"2004-04-12T13:20:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:20:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rs: '\"2004-04-12T13:20:15.5\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:20:15.5"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rs: '\"2004-04-12T13:20:00-05:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:20:00-05:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rs: '\"2004-04-12T13:20:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:20:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rs: '\"2004-04-12T13:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12T13:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rs: '\"2004-04-1213:20:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-1213:20:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rs: '\"99-04-12T13:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"99-04-12T13:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "rs: '\"2004-04-12\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_output '"2004-04-12"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}



####
# xsd:date
#

@test "rs: '\"2004-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"-0045-01-01\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"-0045-01-01"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"12004-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"12004-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"2004-04-12-05:00\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-04-12-05:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"2004-04-12Z\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-04-12Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"99-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"99-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"2004-4-2\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-4-2"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"2004/04/02\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004/04/02"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"04-12-2004\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"04-12-2004"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "rs: '\"2004-04-31\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_output '"2004-04-31"^^<http://www.w3.org/2001/XMLSchema#date>'
}



####
# xsd:dayTimeDuration
#

@test "rs: '\"P1DT2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P1DT2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"PT20M\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT20M"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"PT120M\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT120M"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"P0DT1H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P0DT1H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"P0D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P0D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"-P60D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"-P60D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"PT1M30.5S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT1M30.5S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"P2Y6M5DT12H35M30S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P2Y6M5DT12H35M30S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"P-20D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P-20D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"P20DT\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P20DT"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"PT1HM3S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT1HM3S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"P15.5D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P15.5D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"P1D2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P1D2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"1DT2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"1DT2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"PT15M5H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT15M5H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"P\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"P"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "rs: '\"PT15.S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_output '"PT15.S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}



####
# xsd:string
#

@test "rs: '\"value\"'::sparql.rdfbox" {
  expect_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "rs: '\"\"\"value\"\"\"'::sparql.rdfbox" {
  expect_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "rs: '''value'''::sparql.rdfbox" {
  expect_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "rs: '''''''value'''''''::sparql.rdfbox" {
  expect_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "rs: '\"value'::sparql.rdfbox" {
  expect_error
}

@test "rs: '\"\"\"value\"\"'::sparql.rdfbox" {
  expect_error
}



####
# IRIs
#

@test "rs: '<http://example.org/book/book1>'::sparql.rdfbox" {
  expect_output '<http://example.org/book/book1>'
}

@test "rs: '<example.org/book/book1>'::sparql.rdfbox" {
  expect_error
}



####
# blank nodes
#

@test "rs: '_:i0123456789abcdef'::sparql.rdfbox" {
  expect_output '_:i0123456789abcdef'
}

@test "rs: '_:ifedcba9876543210'::sparql.rdfbox" {
  expect_output '_:ifedcba9876543210'
}

@test "rs: '_:sffffffffid'::sparql.rdfbox" {
  expect_output '_:sffffffffid'
}

@test "rs: '_:s00000000id'::sparql.rdfbox" {
  expect_output '_:s00000000id'
}

@test "rs: '_:i0123456789abcdef0'::sparql.rdfbox" {
  expect_error
}

@test "rs: '_:xfedcba9876543210'::sparql.rdfbox" {
  expect_error
}

@test "rs: '_:i123456789abcdef'::sparql.rdfbox" {
  expect_error
}

@test "rs: '_:iedcba9876543210'::sparql.rdfbox" {
  expect_error
}

@test "rs: '_:sfffffffid'::sparql.rdfbox" {
  expect_error
}

@test "rs: '_:s0000000id'::sparql.rdfbox" {
  expect_error
}
