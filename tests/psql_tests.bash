expect_output() {
  if echo "$BATS_TEST_DESCRIPTION" | egrep "'-?infinity'::decimal" && test $(psql -A -t -U postgres -c "show server_version_num") -lt 140000; then
    skip
  fi

  run psql -A -t -U postgres -c "select $BATS_TEST_DESCRIPTION"
  test "$output" = "$1"
}


expect_error() {
  run psql -A -t -U postgres -c "select $BATS_TEST_DESCRIPTION"
  echo "$output" | grep ERROR
}


receive() {
  psql -A -t -U postgres -c "copy (select $1) to stdout (format binary)" |
  psql -q -A -t -U postgres -c "create temp table tmp (val sparql.rdfbox); copy tmp from stdin (format binary); select * from tmp"
}


expect_receive_output() {
  run receive "$BATS_TEST_DESCRIPTION"
  test "$output" = "$1"
}


expect_receive_error() {
    run receive "$BATS_TEST_DESCRIPTION"
    echo "$output" | grep ERROR
}
