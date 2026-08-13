expect_output() {
  run psql -P null='(null)' -A -t -U postgres -c "select $BATS_TEST_DESCRIPTION"
  test "$output" = "$1"
}


expect_error() {
  run psql -P null='(null)' -A -t -U postgres -c "select $BATS_TEST_DESCRIPTION"
  echo "$output" | grep ERROR
}


receive() {
  psql -P null='(null)' -A -t -U postgres -c "copy (select $1) to stdout (format binary)" |
  psql -P null='(null)' -q -A -t -U postgres -c "create temp table tmp (val sparql.rdfbox)" -c "copy tmp from stdin (format binary)" -c "select * from tmp"
}


expect_receive_output() {
  run receive "$BATS_TEST_DESCRIPTION"
  test "$output" = "$1"
}


expect_receive_error() {
    run receive "$BATS_TEST_DESCRIPTION"
    echo "$output" | grep ERROR
}
