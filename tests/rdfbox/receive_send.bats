load ../psql_tests.bash



####
# literals
#

@test "'\"chat\"'::sparql.rdfbox" {
  expect_receive_output '"chat"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "'''chat''@fr'::sparql.rdfbox" {
  expect_receive_output '"chat"@fr'
}

@test "'\"xyz\"^^<http://example.org/ns/userDatatype>'::sparql.rdfbox" {
  expect_receive_output '"xyz"^^<http://example.org/ns/userDatatype>'
}

@test "'''''''The librarian said, \"Perhaps you would enjoy ''War and Peace''.\"'''''''::sparql.rdfbox" {
  expect_receive_output "\"The librarian said, \\\"Perhaps you would enjoy 'War and Peace'.\\\"\"^^<http://www.w3.org/2001/XMLSchema#string>"
}

@test "'1'::sparql.rdfbox" {
  expect_receive_output '"1"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "'1.3'::sparql.rdfbox" {
  expect_receive_output '"1.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'1.300'::sparql.rdfbox" {
  expect_receive_output '"1.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'1.0e6'::sparql.rdfbox" {
  expect_receive_output '"1000000"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'true'::sparql.rdfbox" {
  expect_receive_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "'false'::sparql.rdfbox" {
  expect_receive_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}



####
# xsd:boolean
#

@test "'\"true\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_receive_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "'\"false\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_receive_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "'\"1\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_receive_output '"true"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "'\"0\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_receive_output '"false"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "'\"TRUE\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_receive_output '"TRUE"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}

@test "'\"T\"^^<http://www.w3.org/2001/XMLSchema#boolean>'::sparql.rdfbox" {
  expect_receive_output '"T"^^<http://www.w3.org/2001/XMLSchema#boolean>'
}



####
# xsd:short
#

@test "'\"+3\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "'\"122\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_receive_output '"122"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "'\"0\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_receive_output '"0"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "'\"-1231\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_receive_output '"-1231"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "'\"32770\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_receive_output '"32770"^^<http://www.w3.org/2001/XMLSchema#short>'
}

@test "'\"3.0\"^^<http://www.w3.org/2001/XMLSchema#short>'::sparql.rdfbox" {
  expect_receive_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#short>'
}



####
# xsd:int
#

@test "'\"+3\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "'\"122\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_receive_output '"122"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "'\"0\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_receive_output '"0"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "'\"-12312\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_receive_output '"-12312"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "'\"2147483650\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_receive_output '"2147483650"^^<http://www.w3.org/2001/XMLSchema#int>'
}

@test "'\"3.0\"^^<http://www.w3.org/2001/XMLSchema#int>'::sparql.rdfbox" {
  expect_receive_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#int>'
}



####
# xsd:long
#

@test "'\"+3\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "'\"122\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_receive_output '"122"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "'\"0\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_receive_output '"0"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "'\"-1231235555\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_receive_output '"-1231235555"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "'\"9223372036854775810\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_receive_output '"9223372036854775810"^^<http://www.w3.org/2001/XMLSchema#long>'
}

@test "'\"3.0\"^^<http://www.w3.org/2001/XMLSchema#long>'::sparql.rdfbox" {
  expect_receive_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#long>'
}



####
# xsd:integer
#

@test "'\"122\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_receive_output '"122"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "'\"00122\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_receive_output '"122"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "'\"0\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_receive_output '"0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "'\"+3\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "'\"-3\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_receive_output '"-3"^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "'\"3.\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_receive_output '"3."^^<http://www.w3.org/2001/XMLSchema#integer>'
}

@test "'\"3.0\"^^<http://www.w3.org/2001/XMLSchema#integer>'::sparql.rdfbox" {
  expect_receive_output '"3.0"^^<http://www.w3.org/2001/XMLSchema#integer>'
}



####
# xsd:decimal
#

@test "'\"3.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"-3.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"-3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"3.5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\".3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"0.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"3.\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"0"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"-.3\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"-0.3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"0003.0\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"3.0000\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"3"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}

@test "'\"3,5\"^^<http://www.w3.org/2001/XMLSchema#decimal>'::sparql.rdfbox" {
  expect_receive_output '"3,5"^^<http://www.w3.org/2001/XMLSchema#decimal>'
}



####
# xsd:float
#

@test "'\"-3E2\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"-300"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"4268.22752E11\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"4.2682274e+14"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"+24.3e-3\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"0.0243"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"12\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"12"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"3.5"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"-INF\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"-0\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"-0"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"NaN\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"-3E2.4\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"-3E2.4"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"12E\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"12E"^^<http://www.w3.org/2001/XMLSchema#float>'
}

@test "'\"NAN\"^^<http://www.w3.org/2001/XMLSchema#float>'::sparql.rdfbox" {
  expect_receive_output '"NAN"^^<http://www.w3.org/2001/XMLSchema#float>'
}



####
# xsd:double
#

@test "'\"-3E2\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"-300"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"4268.22752E11\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"426822752000000"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"+24.3e-3\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"0.0243"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"12\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"12"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"+3.5\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"3.5"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"-INF\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"-INF"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"-0\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"-0"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"NaN\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"NaN"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"-3E2.4\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"-3E2.4"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"12E\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"12E"^^<http://www.w3.org/2001/XMLSchema#double>'
}

@test "'\"NAN\"^^<http://www.w3.org/2001/XMLSchema#double>'::sparql.rdfbox" {
  expect_receive_output '"NAN"^^<http://www.w3.org/2001/XMLSchema#double>'
}



####
# xsd:dateTime
#

@test "'\"2004-04-12T13:20:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12T13:20:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "'\"2004-04-12T13:20:15.5\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12T13:20:15.5"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "'\"2004-04-12T13:20:00-05:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12T13:20:00-05:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "'\"2004-04-12T13:20:00Z\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12T13:20:00Z"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "'\"2004-04-12T13:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12T13:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "'\"2004-04-1213:20:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-1213:20:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "'\"99-04-12T13:00\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_receive_output '"99-04-12T13:00"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}

@test "'\"2004-04-12\"^^<http://www.w3.org/2001/XMLSchema#dateTime>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12"^^<http://www.w3.org/2001/XMLSchema#dateTime>'
}



####
# xsd:date
#

@test "'\"2004-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"-0045-01-01\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"-0045-01-01"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"12004-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"12004-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"2004-04-12-05:00\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12-05:00"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"2004-04-12Z\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-12Z"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"99-04-12\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"99-04-12"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"2004-4-2\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"2004-4-2"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"2004/04/02\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"2004/04/02"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"04-12-2004\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"04-12-2004"^^<http://www.w3.org/2001/XMLSchema#date>'
}

@test "'\"2004-04-31\"^^<http://www.w3.org/2001/XMLSchema#date>'::sparql.rdfbox" {
  expect_receive_output '"2004-04-31"^^<http://www.w3.org/2001/XMLSchema#date>'
}



####
# xsd:dayTimeDuration
#

@test "'\"P1DT2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"P1DT2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"PT20M\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"PT20M"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"PT120M\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"PT2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"P0DT1H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"PT1H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"P0D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"PT0S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"-P60D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"-P60D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"PT1M30.5S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"PT1M30.5S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"P2Y6M5DT12H35M30S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"P2Y6M5DT12H35M30S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"P-20D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"P-20D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"P20DT\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"P20DT"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"PT1HM3S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"PT1HM3S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"P15.5D\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"P15.5D"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"P1D2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"P1D2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"1DT2H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"1DT2H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"PT15M5H\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"PT15M5H"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"P\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"P"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}

@test "'\"PT15.S\"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'::sparql.rdfbox" {
  expect_receive_output '"PT15.S"^^<http://www.w3.org/2001/XMLSchema#dayTimeDuration>'
}



####
# xsd:string
#

@test "'\"value\"'::sparql.rdfbox" {
  expect_receive_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "'\"\"\"value\"\"\"'::sparql.rdfbox" {
  expect_receive_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "'''value'''::sparql.rdfbox" {
  expect_receive_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "'''''''value'''''''::sparql.rdfbox" {
  expect_receive_output '"value"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "'\"value''::sparql.rdfbox" {
  expect_receive_error
}

@test "'\"\"\"value\"\"''::sparql.rdfbox" {
  expect_receive_error
}



####
# IRIs
#

@test "'<http://example.org/book/book1>'::sparql.rdfbox" {
  expect_receive_output '<http://example.org/book/book1>'
}

@test "'<example.org/book/book1>'::sparql.rdfbox" {
  expect_receive_error
}



####
# blank nodes
#

@test "'_:i0123456789abcdef'::sparql.rdfbox" {
  expect_receive_output '_:i0123456789abcdef'
}

@test "'_:ifedcba9876543210'::sparql.rdfbox" {
  expect_receive_output '_:ifedcba9876543210'
}

@test "'_:sffffffffid'::sparql.rdfbox" {
  expect_receive_output '_:sffffffffid'
}

@test "'_:s00000000id'::sparql.rdfbox" {
  expect_receive_output '_:s00000000id'
}

@test "'_:i0123456789abcdef0'::sparql.rdfbox" {
  expect_receive_error
}

@test "'_:xfedcba9876543210'::sparql.rdfbox" {
  expect_receive_error
}

@test "'_:i123456789abcdef'::sparql.rdfbox" {
  expect_receive_error
}

@test "'_:iedcba9876543210'::sparql.rdfbox" {
  expect_receive_error
}

@test "'_:sfffffffid'::sparql.rdfbox" {
  expect_receive_error
}

@test "'_:s0000000id'::sparql.rdfbox" {
  expect_receive_error
}
