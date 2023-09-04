load ../psql_tests.bash



####
# sparql.iblanknode_create()
#

@test "sparql.iblanknode_create('1'::int4, '2'::int4)" {
  expect_output '8589934593'
}

@test "sparql.iblanknode_create('-2147483648'::int4, '-2147483648'::int4)" {
  expect_output '-9223372034707292160'
}

@test "sparql.iblanknode_create('2147483647'::int4, '-2147483648'::int4)" {
  expect_output '-9223372034707292161'
}

@test "sparql.iblanknode_create('-2147483648'::int4, '2147483647'::int4)" {
  expect_output '9223372034707292160'
}

@test "sparql.iblanknode_create('2147483647'::int4, '2147483647'::int4)" {
  expect_output '9223372034707292159'
}



####
# sparql.iblanknode_get_value()
#

@test "sparql.iblanknode_get_value(sparql.iblanknode_create('1'::int4, '2'::int4))" {
  expect_output '1'
}

@test "sparql.iblanknode_get_value(sparql.iblanknode_create('-2147483648'::int4, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.iblanknode_get_value(sparql.iblanknode_create('2147483647'::int4, '-2147483648'::int4))" {
  expect_output '2147483647'
}

@test "sparql.iblanknode_get_value(sparql.iblanknode_create('-2147483648'::int4, '2147483647'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.iblanknode_get_value(sparql.iblanknode_create('2147483647'::int4, '2147483647'::int4))" {
  expect_output '2147483647'
}



####
# sparql.iblanknode_get_value_of_segment()
#

@test "sparql.iblanknode_get_value_of_segment(sparql.iblanknode_create('1'::int4, '2'::int4), '2'::int4)" {
  expect_output '1'
}

@test "sparql.iblanknode_get_value_of_segment(sparql.iblanknode_create('-2147483648'::int4, '-2147483648'::int4), '2147483647'::int4)" {
  expect_output ''
}

@test "sparql.iblanknode_get_value_of_segment(sparql.iblanknode_create('2147483647'::int4, '-2147483648'::int4), '-2147483648'::int4)" {
  expect_output '2147483647'
}

@test "sparql.iblanknode_get_value_of_segment(sparql.iblanknode_create('-2147483648'::int4, '2147483647'::int4), '2147483647'::int4)" {
  expect_output '-2147483648'
}

@test "sparql.iblanknode_get_value_of_segment(sparql.iblanknode_create('2147483647'::int4, '2147483647'::int4), '-2147483648'::int4)" {
  expect_output ''
}



####
# sparql.iblanknode_get_segment()
#

@test "sparql.iblanknode_get_segment(sparql.iblanknode_create('1'::int4, '2'::int4))" {
  expect_output '2'
}

@test "sparql.iblanknode_get_segment(sparql.iblanknode_create('-2147483648'::int4, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.iblanknode_get_segment(sparql.iblanknode_create('2147483647'::int4, '-2147483648'::int4))" {
  expect_output '-2147483648'
}

@test "sparql.iblanknode_get_segment(sparql.iblanknode_create('-2147483648'::int4, '2147483647'::int4))" {
  expect_output '2147483647'
}

@test "sparql.iblanknode_get_segment(sparql.iblanknode_create('2147483647'::int4, '2147483647'::int4))" {
  expect_output '2147483647'
}
