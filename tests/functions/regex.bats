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

@test "fn: sparql.regex_string('a.c'::varchar, 'a.c'::varchar, 'q'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_string('abc'::varchar, 'a.c'::varchar, 'q'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.regex_string('abc'::varchar, 'a.c'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_string('a['::varchar, 'a['::varchar, 'q'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_string('ABC'::varchar, 'abc'::varchar, 'qi'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_string('Ä'::varchar, 'ä'::varchar, 'qi'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_string('Ä'::varchar, 'ä'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_string('Ä'::varchar, 'ä'::varchar, 'q'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.regex_string('abcd'::varchar, 'B'::varchar, 'z'::varchar)" {
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

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_ltrlangstring('abcd'::varchar, 'en'::varchar), 'b'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_rtllangstring('abcd'::varchar, 'en'::varchar), 'b'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_ltrlangstring('abcd'::varchar, 'en'::varchar), 'B'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_rtllangstring('abcd'::varchar, 'en'::varchar), 'B'::varchar)" {
  expect_output 'f'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_ltrlangstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_rtllangstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output 't'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), '['::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_ltrlangstring('abcd'::varchar, 'en'::varchar), '['::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_rtllangstring('abcd'::varchar, 'en'::varchar), '['::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'B'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.regex_rdfbox(sparql.rdfbox_create_from_tripleterm(sparql.rdfbox_create_from_iri('http://example.org/s'::varchar), 'http://example.org/p'::varchar, sparql.rdfbox_create_from_string('o'::varchar)), 'B'::varchar, 'i'::varchar)" {
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

@test "fn: sparql.replace_string('abc'::varchar, '(b)'::varchar, '[\$1]'::varchar)" {
  expect_output 'a[b]c'
}

@test "fn: sparql.replace_string('abc'::varchar, '(b)'::varchar, '[\$0]'::varchar)" {
  expect_output 'a[b]c'
}

@test "fn: sparql.replace_string('abc'::varchar, '(b)'::varchar, '[\$10]'::varchar)" {
  expect_output 'a[b0]c'
}

@test "fn: sparql.replace_string('abc'::varchar, '(b)'::varchar, '[\$2]'::varchar)" {
  expect_output 'a[]c'
}

@test "fn: sparql.replace_string('abc'::varchar, '(b)|(x)'::varchar, '[\$2]'::varchar)" {
  expect_output 'a[]c'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b'::varchar, '\$\$'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b'::varchar, '\$'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b'::varchar, '\\\$'::varchar)" {
  expect_output 'a$c'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b'::varchar, '\\\\'::varchar)" {
  expect_output 'a\c'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b'::varchar, '\n'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b'::varchar, '\\'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_string('abc'::varchar, 'x*'::varchar, '-'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b*'::varchar, '-'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_string('abc'::varchar, '^'::varchar, '-'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_string('abc'::varchar, ''::varchar, '-'::varchar, 'q'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b+'::varchar, '-'::varchar)" {
  expect_output 'a-c'
}

@test "fn: sparql.replace_string('a.c'::varchar, '.'::varchar, '\\\$1'::varchar, 'q'::varchar)" {
  expect_output 'a\$1c'
}

@test "fn: sparql.replace_string('abc'::varchar, 'b'::varchar, '\$0'::varchar, 'q'::varchar)" {
  expect_output 'a$0c'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abc'::varchar, 'en'::varchar), '(b)'::varchar, '[\$1]'::varchar)" {
  expect_output '"a[b]c"@en'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abc'::varchar), 'x*'::varchar, '-'::varchar)" {
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

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_ltrlangstring('abcd'::varchar, 'en'::varchar), 'b'::varchar, 'Z'::varchar)" {
  expect_output '"aZcd"@en--ltr'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_rtllangstring('abcd'::varchar, 'en'::varchar), 'b'::varchar, 'Z'::varchar)" {
  expect_output '"aZcd"@en--rtl'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZcd"@en'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_ltrlangstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZcd"@en--ltr'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_rtllangstring('abcd'::varchar, 'en'::varchar), 'B'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZcd"@en--rtl'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZd"@en'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_ltrlangstring('abcd'::varchar, 'en'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZd"@en--ltr'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_rtllangstring('abcd'::varchar, 'en'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '"aZd"@en--rtl'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_langstring('abcd'::varchar, 'en'::varchar), '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_ltrlangstring('abcd'::varchar, 'en'::varchar), '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_rtllangstring('abcd'::varchar, 'en'::varchar), '['::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_iri('http://example.org'::varchar), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}

@test "fn: sparql.replace_rdfbox(sparql.rdfbox_create_from_tripleterm(sparql.rdfbox_create_from_iri('http://example.org/s'::varchar), 'http://example.org/p'::varchar, sparql.rdfbox_create_from_string('o'::varchar)), 'B.'::varchar, 'Z'::varchar, 'i'::varchar)" {
  expect_output '(null)'
}
