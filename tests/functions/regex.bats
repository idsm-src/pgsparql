load ../psql_tests.bash



####
# regex()
#

@test "fn: sparql.regex_string('abcd'::varchar, 'b'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_string('abcd'::varchar, 'B'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.regex_string('abcd'::varchar, 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_string('abcd'::varchar, '['::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'b'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'B'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), '['::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'b'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), '['::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}



####
# replace()
#

@test "fn: sparql.replace_string('abcd'::varchar, 'b'::varchar, 'Z'::varchar)" {
  expect_output 'aZcd'
}

@test "fn: sparql.replace_string('abcd'::varchar, 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output 'aZcd'
}

@test "fn: sparql.replace_string('abcd'::varchar, 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output 'aZd'
}

@test "fn: sparql.replace_string('abcd'::varchar, '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'b'::varchar, 'Z'::varchar)" {
  expect_output '"aZcd"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZcd"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZd"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'b'::varchar, 'Z'::varchar)" {
  expect_output '"aZcd"@en'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZcd"@en'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZd"@en'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}
