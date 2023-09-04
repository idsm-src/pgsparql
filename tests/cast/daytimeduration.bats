load ../psql_tests.bash



@test "sparql.cast_as_daytimeduration_from_string(' P1DT2H '::varchar)" {
  expect_output '93600000000'
}

@test "sparql.cast_as_daytimeduration_from_string(' PT20M '::varchar)" {
  expect_output '1200000000'
}

@test "sparql.cast_as_daytimeduration_from_string(' PT120M '::varchar)" {
  expect_output '7200000000'
}

@test "sparql.cast_as_daytimeduration_from_string(' P0DT1H '::varchar)" {
  expect_output '3600000000'
}

@test "sparql.cast_as_daytimeduration_from_string(' P0D '::varchar)" {
  expect_output '0'
}

@test "sparql.cast_as_daytimeduration_from_string(' -P60D '::varchar)" {
  expect_output '-5184000000000'
}

@test "sparql.cast_as_daytimeduration_from_string(' PT1M30.5S '::varchar)" {
  expect_output '90500000'
}

@test "sparql.cast_as_daytimeduration_from_string(' -P106751991DT4H54.775808S '::varchar)" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_daytimeduration_from_string(' -P106751991DT4H54.775807S '::varchar)" {
  expect_output '-9223372036854775807'
}

@test "sparql.cast_as_daytimeduration_from_string(' P106751991DT4H54.775807S '::varchar)" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_daytimeduration_from_string(' -P106751991DT4H54.775809S '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' P106751991DT4H54.775808S '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' P2Y6M5DT12H35M30S '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' P-20D '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' P20DT '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' PT1HM3S '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' P15.5D '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' P1D2H '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' 1DT2H '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' PT15M5H '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' P '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' PT15.S '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(' '::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_string(''::varchar)" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P1DT2H '::varchar))" {
  expect_output '93600000000'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' PT20M '::varchar))" {
  expect_output '1200000000'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' PT120M '::varchar))" {
  expect_output '7200000000'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P0DT1H '::varchar))" {
  expect_output '3600000000'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P0D '::varchar))" {
  expect_output '0'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' -P60D '::varchar))" {
  expect_output '-5184000000000'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' PT1M30.5S '::varchar))" {
  expect_output '90500000'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' -P106751991DT4H54.775808S '::varchar))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' -P106751991DT4H54.775807S '::varchar))" {
  expect_output '-9223372036854775807'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P106751991DT4H54.775807S '::varchar))" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' -P106751991DT4H54.775809S '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P106751991DT4H54.775808S '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P2Y6M5DT12H35M30S '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P-20D '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P20DT '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' PT1HM3S '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P15.5D '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P1D2H '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' 1DT2H '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' PT15M5H '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' P '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' PT15.S '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(' '::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_string(''::varchar))" {
  expect_output ''
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_daytimeduration('-9223372036854775808'::int8))" {
  expect_output '-9223372036854775808'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_daytimeduration('9223372036854775807'::int8))" {
  expect_output '9223372036854775807'
}

@test "sparql.cast_as_daytimeduration_from_rdfbox(sparql.rdfbox_create_from_iri('http://false.org'::varchar))" {
  expect_output ''
}
