# Shared psql session for bats tests.
#
# setup_file starts one background psql for the whole test file; the tests
# talk to it through two FIFOs and detect the end of a response by a marker
# printed with \echo. This removes the cost of starting psql and opening
# a new connection in every test.
#
# The SQL from a test is sent wrapped in dollar quoting and executed with
# \gexec, so the server receives exactly the same text as before with -c and
# it is the server, not psql, that lexes it. Should a description ever be
# malformed (e.g. an unterminated literal), only that test fails with an
# ERROR instead of psql swallowing the rest of the input and hanging the file.
#
# If a test file defines its own setup_file/teardown_file, they must call
# pg_session_start/pg_session_stop.


setup_file() {
	pg_session_start;
}


teardown_file() {
	pg_session_stop;
}


# Takes the type that receive() round-trips in this file, sparql.rdfbox by default.
# The table it copies into is named after that type, so the files of different
# types never mean the same table.
pg_session_start() {
  local type="${1:-sparql.rdfbox}"

  export PG_REQ="$BATS_FILE_TMPDIR/req" PG_RESP="$BATS_FILE_TMPDIR/resp"
  export PG_COPY="$BATS_FILE_TMPDIR/copy.bin" PG_PID="$BATS_FILE_TMPDIR/psql.pid"
  export PG_TABLE="tmp_${type//[^a-zA-Z0-9]/_}"

  mkfifo "$PG_REQ" "$PG_RESP"

  # <> opens the FIFOs read-write, so psql never sees EOF or SIGPIPE.
  # 3>&- is required, otherwise bats waits for the background process.
  psql -P null='(null)' -XAtq -U postgres 0<>"$PG_REQ" 1<>"$PG_RESP" 2>&1 3>&- &

  echo $! > "$PG_PID"

  # Waits until psql is connected and creates the table used by receive.
  # Any output means something went wrong (connection error, missing type).
  local out=$(pg_send "create temp table $PG_TABLE (val $type);" 2>&1) && [[ -z $out ]] || { echo "$out" >&2; return 1; }
}


pg_session_stop() {
  printf '\\q\n' 1<>"$PG_REQ"
}


# Sends text to psql and prints its output up to the marker.
pg_send() {
  local marker="__END_${BATS_TEST_NUMBER}_${RANDOM}__" line
  {
    printf '%s\n\\echo %s\n' "$1" "$marker" >&8
    
    while :; do
      if IFS= read -r -t 1 -u 9 line; then
        [[ $line == "$marker" ]] && return 0
        printf '%s\n' "$line"
      elif (( $? > 128 )) && kill -0 "$(< "$PG_PID")" 2>/dev/null; then
        :   # timeout, but psql is alive - the query is still running
      else
        echo "psql session is not running" >&2
        return 1
      fi
    done
  } 8<>"$PG_REQ" 9<>"$PG_RESP"
}


# Wraps an SQL command so that psql passes it to the server unchanged.
pg_wrap() {
  local tag="q$RANDOM"
  
  while [[ $1 == *"\$$tag\$"* ]]; do tag="q$RANDOM"; done
  
  printf 'select $%s$%s$%s$ \\gexec' "$tag" "$1" "$tag"
}


query() {
  pg_send "$(pg_wrap "select $1")"
}


# Binary copy out goes through \o to a file on the client and back through
# \copy, so send/recv are exercised the same way as before (the data travels
# through the client). The table is created once per session by
# pg_session_start and truncated before each use.
receive() {
  pg_send "truncate $PG_TABLE;
\\o $PG_COPY
$(pg_wrap "copy (select $1) to stdout (format binary)")
\\o
\\copy $PG_TABLE from '$PG_COPY' (format binary)
select * from $PG_TABLE;"
}


# A test description is "<prefix>: <SQL>". The prefix says what the test
# exercises: io the text input and output, rs the binary send and receive, op
# an operator, fn a function, oc an operator class. Only rs changes how the
# test is run, the others just tell the families apart, so that for example
# "bats -f 'op: '" runs the operator tests alone. A description that carries no
# prefix is the SQL itself and is run like io.
PG_TEST_PREFIXES='io|rs|op|fn|oc'


# Runs the SQL of the current test the way its prefix asks for.
pg_test() {
  local sql="$BATS_TEST_DESCRIPTION" prefix=

  if [[ $sql =~ ^($PG_TEST_PREFIXES):[[:space:]](.*)$ ]]; then
    prefix="${BASH_REMATCH[1]}"
    sql="${BASH_REMATCH[2]}"
  fi

  if [[ $prefix == rs ]]; then
    receive "$sql"
  else
    query "$sql"
  fi
}


expect_output() {
  run pg_test
  test "$output" = "$1"
}


expect_error() {
  run pg_test
  echo "$output" | grep ERROR
}
