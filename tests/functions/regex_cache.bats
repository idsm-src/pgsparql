load ../psql_tests.bash


# The cache of the compiled patterns is kept at 8 kB, which holds only the few most recently used patterns, so that
# the tests drop and recompile patterns all the time; a pattern is used more than once, so that its second use
# compiles the machine code and the later uses run it. The first call loads the module, which defines the setting.
setup_file() {
  pg_session_start
  pg_send "select sparql.regex_string('', ''); set pgsparql.regex_cache_size = 8;"
}



####
# pgsparql.regex_cache_size
#

@test "fn: current_setting('pgsparql.regex_cache_size')" {
  expect_output '8kB'
}

@test "fn: set_config('pgsparql.regex_cache_size', '-1', false)" {
  expect_error
}



####
# the cache of the compiled patterns
#

@test "fn: (select count(*) from generate_series(1, 100) i where sparql.regex_string('x' || i, '^x' || i || '\$'))" {
  expect_output '100'
}

@test "fn: (select count(*) from generate_series(1, 100) i where sparql.regex_string('x' || i, '^x' || i || '\$') and sparql.regex_string('x' || i, '^x' || i || '\$'))" {
  expect_output '100'
}

@test "fn: (select string_agg(sparql.regex_string('ab', (array['a', 'b', 'c'])[i % 3 + 1])::text, ',') from generate_series(1, 9) i)" {
  expect_output 'true,false,true,true,false,true,true,false,true'
}

@test "fn: (select string_agg(sparql.regex_string('ab', (array['b\$', '^b'])[i % 2 + 1])::text, ',') from generate_series(1, 4) i)" {
  expect_output 'false,true,false,true'
}

@test "fn: (select string_agg(sparql.regex_string('A', 'a', (array['', 'i'])[i % 2 + 1])::text, ',') from generate_series(1, 4) i)" {
  expect_output 'true,false,true,false'
}

@test "fn: (select string_agg(sparql.regex_rdfbox(sparql.rdfbox_create_from_string('ab'::varchar), 'b\$')::text, ',') from generate_series(1, 3) i)" {
  expect_output 'true,true,true'
}

@test "fn: (select count(*) from generate_series(1, 3) i where sparql.regex_string('a', '[') is null)" {
  expect_output '3'
}

@test "fn: (select string_agg(sparql.replace_string('abcabc', '(b)', '[\$1]'), ',') from generate_series(1, 3) i)" {
  expect_output 'a[b]ca[b]c,a[b]ca[b]c,a[b]ca[b]c'
}

@test "fn: (select string_agg(sparql.replace_rdfbox(sparql.rdfbox_create_from_string('abcabc'::varchar), '(b)', '[\$1]')::text, ',') from generate_series(1, 3) i)" {
  expect_output '"a[b]ca[b]c"^^<http://www.w3.org/2001/XMLSchema#string>,"a[b]ca[b]c"^^<http://www.w3.org/2001/XMLSchema#string>,"a[b]ca[b]c"^^<http://www.w3.org/2001/XMLSchema#string>'
}

@test "fn: (select count(*) from generate_series(1, 3) i where sparql.replace_string('abc', 'x*', 'y') is null)" {
  expect_output '3'
}



####
# the interpreter matching a subject too long for the stack of the machine code
#

@test "fn: (select string_agg(sparql.regex_string(repeat('a', 20000) || 'b', '^(a|b)*b\$')::text, ',') from generate_series(1, 3) i)" {
  expect_output 'true,true,true'
}

@test "fn: (select string_agg(sparql.replace_string(repeat('a', 20000) || 'b', '^(a|b)*b\$', 'x'), ',') from generate_series(1, 3) i)" {
  expect_output 'x,x,x'
}



####
# the setting changed in the session
#

@test "fn: set_config('pgsparql.regex_cache_size', '0', false)" {
  expect_output '0'
}

@test "fn: (select count(*) from generate_series(1, 100) i where sparql.regex_string('x' || i, '^x' || i || '\$') and sparql.regex_string('x' || i, '^x\\d+\$'))" {
  expect_output '100'
}

@test "fn: set_config('pgsparql.regex_cache_size', '1MB', false)" {
  expect_output '1MB'
}

@test "fn: (select count(*) from generate_series(1, 100) i where sparql.regex_string('x' || i, '^x' || i || '\$') and sparql.regex_string('x' || i, '^x[0-9]+\$'))" {
  expect_output '100'
}
