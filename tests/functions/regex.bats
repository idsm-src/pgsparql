load ../psql_tests.bash



####
# regex()
#

@test "sparql.regex_string('abcd'::varchar, 'b'::varchar)" {
  expect_output 't'
}

@test "sparql.regex_string('abcd'::varchar, 'B'::varchar)" {
  expect_output 'f'
}

@test "sparql.regex_string('abcd'::varchar, 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "sparql.regex_string('abcd'::varchar, '['::varchar)" {
  expect_output ''
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'b'::varchar)" {
  expect_output 't'
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'B'::varchar)" {
  expect_output 'f'
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), '['::varchar)" {
  expect_output ''
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'b'::varchar)" {
  expect_output 't'
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar)" {
  expect_output 'f'
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), '['::varchar)" {
  expect_output ''
}

@test "sparql.regex_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output ''
}



####
# replace()
#

@test "sparql.replace_string('abcd'::varchar, 'b'::varchar, 'Z'::varchar)" {
  expect_output 'aZcd'
}

@test "sparql.replace_string('abcd'::varchar, 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output 'aZcd'
}

@test "sparql.replace_string('abcd'::varchar, 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output 'aZd'
}

@test "sparql.replace_string('abcd'::varchar, '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output ''
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'b'::varchar, 'Z'::varchar)" {
  expect_output '"aZcd"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZcd"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZd"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcd'::varchar), '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output ''
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'b'::varchar, 'Z'::varchar)" {
  expect_output '"aZcd"@en'
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZcd"@en'
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZd"@en'
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output ''
}

@test "sparql.replace_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output ''
}
