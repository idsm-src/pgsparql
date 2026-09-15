load ../psql_tests.bash



####
# strlen()
#

@test "fn: sparql.strlen_string('chat'::varchar)" {
  expect_output '4'
}

@test "fn: sparql.strlen_string(''::varchar)" {
  expect_output '0'
}

@test "fn: sparql.strlen_rdfbox(sparql.rdfbox_create_from_string('chat'::varchar))" {
  expect_output '4'
}

@test "fn: sparql.strlen_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '0'
}

@test "fn: sparql.strlen_rdfbox(sparql.rdfbox_create_from_langstring('chat'::varchar, 'en'::varchar))" {
  expect_output '4'
}

@test "fn: sparql.strlen_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '0'
}

@test "fn: sparql.strlen_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# substr()
#

@test "fn: sparql.substr_string('foobar'::varchar, '4'::decimal)" {
  expect_output 'bar'
}

@test "fn: sparql.substr_string('foobar'::varchar, '4'::decimal, '1'::decimal)" {
  expect_output 'b'
}

@test "fn: sparql.substr_string(''::varchar, '4'::decimal)" {
  expect_output ''
}

@test "fn: sparql.substr_string(''::varchar, '4'::decimal, '1'::decimal)" {
  expect_output ''
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), '4'::decimal)" {
  expect_output '"bar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '"b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_string(''::varchar), '4'::decimal)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_string(''::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), '4'::decimal)" {
  expect_output '"bar"@en'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '"b"@en'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), '4'::decimal)" {
  expect_output '""@en'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '""@en'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), '4'::decimal)" {
  expect_output '(null)'
}

@test "fn: sparql.substr_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '(null)'
}



####
# ucase()
#

@test "fn: sparql.ucase_rdfbox(sparql.rdfbox_create_from_string('foo'::varchar))" {
  expect_output '"FOO"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.ucase_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.ucase_rdfbox(sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar))" {
  expect_output '"FOO"@en'
}

@test "fn: sparql.ucase_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '""@en'
}

@test "fn: sparql.ucase_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# lcase()
#

@test "fn: sparql.lcase_rdfbox(sparql.rdfbox_create_from_string('BAR'::varchar))" {
  expect_output '"bar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.lcase_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.lcase_rdfbox(sparql.rdfbox_create_from_langstring('BAR'::varchar, 'en'::varchar))" {
  expect_output '"bar"@en'
}

@test "fn: sparql.lcase_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '""@en'
}

@test "fn: sparql.lcase_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# strStarts()
#

@test "fn: sparql.strstarts_string_string('foobar'::varchar, 'foo'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_string_string('foobar'::varchar, ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_string_string(''::varchar, ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_string_string('foobar'::varchar, 'oob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'foo'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_string(''::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'oob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'foo'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'oob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('foo'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('foo'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'ge'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# strEnds()
#

@test "fn: sparql.strends_string_string('foobar'::varchar, 'bar'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_string_string('foobar'::varchar, ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_string_string(''::varchar, ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_string_string('foobar'::varchar, 'oob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'bar'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_string(''::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'oob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'bar'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'oob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.strends_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'ge'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# contains()
#

@test "fn: sparql.contains_string_string('foobar'::varchar, 'oob'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_string_string('foobar'::varchar, ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_string_string(''::varchar, ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_string_string('foobar'::varchar, 'xob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'oob'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_string(''::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'xob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'oob'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'xob'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.contains_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('xob'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('xob'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('xob'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xob'::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'ge'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# strbefore()
#

@test "fn: sparql.strbefore_string_string('abc'::varchar, 'b'::varchar)" {
  expect_output 'a'
}

@test "fn: sparql.strbefore_string_string('abc'::varchar, ''::varchar)" {
  expect_output ''
}

@test "fn: sparql.strbefore_string_string('abc'::varchar, 'xyz'::varchar)" {
  expect_output ''
}

@test "fn: sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), 'b'::varchar)" {
  expect_output '"a"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), ''::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), 'xyz'::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'b'::varchar)" {
  expect_output '"a"@en'
}

@test "fn: sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output '""@en'
}

@test "fn: sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'xyz'::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '"a"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('xyz'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '"a"@en'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '""@en'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('xyz'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output '"a"@en'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '""@en'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'en'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'cy'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# strafter()
#

@test "fn: sparql.strafter_string_string('abc'::varchar, 'b'::varchar)" {
  expect_output 'c'
}

@test "fn: sparql.strafter_string_string('abc'::varchar, ''::varchar)" {
  expect_output 'abc'
}

@test "fn: sparql.strafter_string_string('abc'::varchar, 'xyz'::varchar)" {
  expect_output ''
}

@test "fn: sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), 'b'::varchar)" {
  expect_output '"c"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), ''::varchar)" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), 'xyz'::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'b'::varchar)" {
  expect_output '"c"@en'
}

@test "fn: sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output '"abc"@en'
}

@test "fn: sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'xyz'::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '"c"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('xyz'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '"c"@en'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '"abc"@en'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('xyz'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output '"c"@en'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '"abc"@en'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'en'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'cy'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# encode_for_uri()
#

@test "fn: sparql.encode_for_uri_string('Los Angeles'::varchar)" {
  expect_output 'Los%20Angeles'
}

@test "fn: sparql.encode_for_uri_rdfbox(sparql.rdfbox_create_from_string('Los Angeles'::varchar))" {
  expect_output 'Los%20Angeles'
}

@test "fn: sparql.encode_for_uri_rdfbox(sparql.rdfbox_create_from_langstring('Los Angeles'::varchar, 'en'::varchar))" {
  expect_output 'Los%20Angeles'
}

@test "fn: sparql.encode_for_uri_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# concat()
#

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foo'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output '"foobar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output '"foobar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foo'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output '"foobar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output '"foobar"@en'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'cy'::varchar))" {
  expect_output '"foobar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_string('bar'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output '(null)'
}



####
# langMatches()
#

@test "fn: sparql.langmatches_string_string('fr-be'::varchar, 'fr'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.langmatches_string_string('fr-be'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_string('fr-be'::varchar), sparql.rdfbox_create_from_string('fr'::varchar))" {
  expect_output 't'
}

@test "fn: sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_string('fr-be'::varchar), sparql.rdfbox_create_from_string('en'::varchar))" {
  expect_output 'f'
}

@test "fn: sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('fr-be'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('fr'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_string('fr-be'::varchar), sparql.rdfbox_create_from_langstring('en'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}

@test "fn: sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('fr-be'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('fr'::varchar, 'en'::varchar))" {
  expect_output '(null)'
}
