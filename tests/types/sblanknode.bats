load ../psql_tests.bash



####
# sparql.sblanknode_create()
#

@test "sparql.sblanknode_create('id'::varchar, '1'::int4)" {
  expect_output '00000001id'
}

@test "sparql.sblanknode_create(''::varchar, '-2147483648'::int4)" {
  expect_output '80000000'
}

@test "sparql.sblanknode_create(' '::varchar, '-2147483648'::int4)" {
  expect_output '80000000 '
}

@test "sparql.sblanknode_create(''::varchar, '2147483647'::int4)" {
  expect_output '7fffffff'
}

@test "sparql.sblanknode_create('ff'::varchar, '2147483647'::int4)" {
  expect_output '7fffffffff'
}



####
# sparql.sblanknode_get_value()
#

@test "sparql.sblanknode_get_value(sparql.sblanknode_create('id'::varchar, '1'::int4))" {
  expect_output 'id'
}

@test "sparql.sblanknode_get_value(sparql.sblanknode_create(''::varchar, '-2147483648'::int4))" {
  expect_output ''
}

@test "sparql.sblanknode_get_value(sparql.sblanknode_create(' '::varchar, '-2147483648'::int4))" {
  expect_output ' '
}

@test "sparql.sblanknode_get_value(sparql.sblanknode_create(''::varchar, '2147483647'::int4))" {
  expect_output ''
}

@test "sparql.sblanknode_get_value(sparql.sblanknode_create('ff'::varchar, '2147483647'::int4))" {
  expect_output 'ff'
}



####
# sparql.sblanknode_get_value_of_segment()
#

@test "sparql.sblanknode_get_value_of_segment(sparql.sblanknode_create('id'::varchar, '1'::int4), '1'::int4)" {
  expect_output 'id'
}

@test "sparql.sblanknode_get_value_of_segment(sparql.sblanknode_create(''::varchar, '-2147483648'::int4), '2147483647'::int4)" {
  expect_output ''
}

@test "sparql.sblanknode_get_value_of_segment(sparql.sblanknode_create(' '::varchar, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output ' '
}

@test "sparql.sblanknode_get_value_of_segment(sparql.sblanknode_create(''::varchar, '2147483647'::int4), '2147483647'::int4)" {
  expect_output ''
}

@test "sparql.sblanknode_get_value_of_segment(sparql.sblanknode_create('ff'::varchar, '2147483647'::int4), '-2147483648'::int4)" {
  expect_output ''
}



####
# sparql.sblanknode_get_segment()
#

@test "sparql.sblanknode_get_segment(sparql.sblanknode_create('id'::varchar, '1'::int4))" {
  expect_output '1'
}

@test "sparql.sblanknode_get_segment(sparql.sblanknode_create(''::varchar, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.sblanknode_get_segment(sparql.sblanknode_create(' '::varchar, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.sblanknode_get_segment(sparql.sblanknode_create(''::varchar, '2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.sblanknode_get_segment(sparql.sblanknode_create('ff'::varchar, '2147483647'::int4))" {
  expect_output '2147483647'
}
