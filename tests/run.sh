#!/bin/bash
set -e

whoami

apk add build-base pcre2-dev ncurses bats

mkdir /build
cd /build

CFLAGS="-O2 -Wall -Werror" /repo/configure
make
make install

psql -U postgres -d postgres <<'EOF'
create extension pgsparql;
EOF

bats /repo/tests/*/*.bats
