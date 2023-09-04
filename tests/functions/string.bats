load ../psql_tests.bash



####
# strlen()
#

@test "sparql.strlen_string('chat'::varchar)" {
  expect_output '4'
}

@test "sparql.strlen_string(''::varchar)" {
  expect_output '0'
}

@test "sparql.strlen_rdfbox(sparql.rdfbox_create_from_string('chat'::varchar))" {
  expect_output '4'
}

@test "sparql.strlen_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '0'
}

@test "sparql.strlen_rdfbox(sparql.rdfbox_create_from_langstring('chat'::varchar, 'en'::varchar))" {
  expect_output '4'
}

@test "sparql.strlen_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '0'
}

@test "sparql.strlen_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# substr()
#

@test "sparql.substr_string('foobar'::varchar, '4'::decimal)" {
  expect_output 'bar'
}

@test "sparql.substr_string('foobar'::varchar, '4'::decimal, '1'::decimal)" {
  expect_output 'b'
}

@test "sparql.substr_string(''::varchar, '4'::decimal)" {
  expect_output ''
}

@test "sparql.substr_string(''::varchar, '4'::decimal, '1'::decimal)" {
  expect_output ''
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), '4'::decimal)" {
  expect_output '"bar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '"b"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_string(''::varchar), '4'::decimal)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_string(''::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), '4'::decimal)" {
  expect_output '"bar"@en'
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '"b"@en'
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), '4'::decimal)" {
  expect_output '""@en'
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), '4'::decimal, '1'::decimal)" {
  expect_output '""@en'
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), '4'::decimal)" {
  expect_output ''
}

@test "sparql.substr_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), '4'::decimal, '1'::decimal)" {
  expect_output ''
}



####
# ucase()
#

@test "sparql.ucase_rdfbox(sparql.rdfbox_create_from_string('foo'::varchar))" {
  expect_output '"FOO"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.ucase_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.ucase_rdfbox(sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar))" {
  expect_output '"FOO"@en'
}

@test "sparql.ucase_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '""@en'
}

@test "sparql.ucase_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# lcase()
#

@test "sparql.lcase_rdfbox(sparql.rdfbox_create_from_string('BAR'::varchar))" {
  expect_output '"bar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.lcase_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.lcase_rdfbox(sparql.rdfbox_create_from_langstring('BAR'::varchar, 'en'::varchar))" {
  expect_output '"bar"@en'
}

@test "sparql.lcase_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '""@en'
}

@test "sparql.lcase_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# strStarts()
#

@test "sparql.strstarts_string_string('foobar'::varchar, 'foo'::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_string_string('foobar'::varchar, ''::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_string_string(''::varchar, ''::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_string_string('foobar'::varchar, 'oob'::varchar)" {
  expect_output 'f'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'foo'::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_string(''::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'oob'::varchar)" {
  expect_output 'f'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'foo'::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'oob'::varchar)" {
  expect_output 'f'
}

@test "sparql.strstarts_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('foo'::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 'f'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('foo'::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 'f'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'ge'::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strstarts_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# strEnds()
#

@test "sparql.strends_string_string('foobar'::varchar, 'bar'::varchar)" {
  expect_output 't'
}

@test "sparql.strends_string_string('foobar'::varchar, ''::varchar)" {
  expect_output 't'
}

@test "sparql.strends_string_string(''::varchar, ''::varchar)" {
  expect_output 't'
}

@test "sparql.strends_string_string('foobar'::varchar, 'oob'::varchar)" {
  expect_output 'f'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'bar'::varchar)" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_string(''::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'oob'::varchar)" {
  expect_output 'f'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'bar'::varchar)" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'oob'::varchar)" {
  expect_output 'f'
}

@test "sparql.strends_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 'f'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 'f'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'ge'::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strends_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# contains()
#

@test "sparql.contains_string_string('foobar'::varchar, 'oob'::varchar)" {
  expect_output 't'
}

@test "sparql.contains_string_string('foobar'::varchar, ''::varchar)" {
  expect_output 't'
}

@test "sparql.contains_string_string(''::varchar, ''::varchar)" {
  expect_output 't'
}

@test "sparql.contains_string_string('foobar'::varchar, 'xob'::varchar)" {
  expect_output 'f'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'oob'::varchar)" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_string(''::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_string('foobar'::varchar), 'xob'::varchar)" {
  expect_output 'f'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'oob'::varchar)" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), ''::varchar)" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), 'xob'::varchar)" {
  expect_output 'f'
}

@test "sparql.contains_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_string('xob'::varchar))" {
  expect_output 'f'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('oob'::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('xob'::varchar))" {
  expect_output 'f'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foobar'::varchar), sparql.rdfbox_create_from_langstring('xob'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('oob'::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output 't'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foobar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xob'::varchar, 'en'::varchar))" {
  expect_output 'f'
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'ge'::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_string(''::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.contains_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# strbefore()
#

@test "sparql.strbefore_string_string('abc'::varchar, 'b'::varchar)" {
  expect_output 'a'
}

@test "sparql.strbefore_string_string('abc'::varchar, ''::varchar)" {
  expect_output ''
}

@test "sparql.strbefore_string_string('abc'::varchar, 'xyz'::varchar)" {
  expect_output ''
}

@test "sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), 'b'::varchar)" {
  expect_output '"a"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), ''::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), 'xyz'::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'b'::varchar)" {
  expect_output '"a"@en'
}

@test "sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output '""@en'
}

@test "sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'xyz'::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output ''
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '"a"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('xyz'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '"a"@en'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '""@en'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('xyz'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output '"a"@en'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '""@en'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'en'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'cy'::varchar))" {
  expect_output ''
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strbefore_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# strafter()
#

@test "sparql.strafter_string_string('abc'::varchar, 'b'::varchar)" {
  expect_output 'c'
}

@test "sparql.strafter_string_string('abc'::varchar, ''::varchar)" {
  expect_output 'abc'
}

@test "sparql.strafter_string_string('abc'::varchar, 'xyz'::varchar)" {
  expect_output ''
}

@test "sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), 'b'::varchar)" {
  expect_output '"c"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), ''::varchar)" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_string('abc'::varchar), 'xyz'::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'b'::varchar)" {
  expect_output '"c"@en'
}

@test "sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), ''::varchar)" {
  expect_output '"abc"@en'
}

@test "sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), 'xyz'::varchar)" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_string(sparql.rdfbox_create_from_iri('http://example.org'::varchar), ''::varchar)" {
  expect_output ''
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '"c"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '"abc"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_string('xyz'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('b'::varchar))" {
  expect_output '"c"@en'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output '"abc"@en'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('xyz'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('b'::varchar, 'en'::varchar))" {
  expect_output '"c"@en'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output '"abc"@en'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'en'::varchar))" {
  expect_output '""^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('xyz'::varchar, 'cy'::varchar))" {
  expect_output ''
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring(''::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.strafter_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# encode_for_uri()
#

@test "sparql.encode_for_uri_string('Los Angeles'::varchar)" {
  expect_output 'Los%20Angeles'
}

@test "sparql.encode_for_uri_rdfbox(sparql.rdfbox_create_from_string('Los Angeles'::varchar))" {
  expect_output 'Los%20Angeles'
}

@test "sparql.encode_for_uri_rdfbox(sparql.rdfbox_create_from_langstring('Los Angeles'::varchar, 'en'::varchar))" {
  expect_output 'Los%20Angeles'
}

@test "sparql.encode_for_uri_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# concat()
#

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foo'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output '"foobar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output '"foobar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_string('foo'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output '"foobar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output '"foobar"@en'
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('foo'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'cy'::varchar))" {
  expect_output '"foobar"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_string('bar'::varchar))" {
  expect_output ''
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_string('bar'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('bar'::varchar, 'en'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}

@test "sparql.concat_rdfbox_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), sparql.rdfbox_create_from_iri('http://example.org'::varchar))" {
  expect_output ''
}



####
# langMatches()
#

@test "sparql.langmatches_string_string('fr-be'::varchar, 'fr'::varchar)" {
  expect_output 't'
}

@test "sparql.langmatches_string_string('fr-be'::varchar, 'en'::varchar)" {
  expect_output 'f'
}

@test "sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_string('fr-be'::varchar), sparql.rdfbox_create_from_string('fr'::varchar))" {
  expect_output 't'
}

@test "sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_string('fr-be'::varchar), sparql.rdfbox_create_from_string('en'::varchar))" {
  expect_output 'f'
}

@test "sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('fr-be'::varchar, 'en'::varchar), sparql.rdfbox_create_from_string('fr'::varchar))" {
  expect_output ''
}

@test "sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_string('fr-be'::varchar), sparql.rdfbox_create_from_langstring('en'::varchar, 'en'::varchar))" {
  expect_output ''
}

@test "sparql.langmatches_rdfbox_rdfbox(sparql.rdfbox_create_from_langstring('fr-be'::varchar, 'en'::varchar), sparql.rdfbox_create_from_langstring('fr'::varchar, 'en'::varchar))" {
  expect_output ''
}
