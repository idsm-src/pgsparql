extensiondir = $(POSTGRESQL_SHAREDIR)/extension
dist_extension_DATA = \
		pgsparql.control  \
		pgsparql--1.0.sql

SQLSOURCES = \
		pgsparql/header.sql \
		pgsparql/blanknode.sql \
		pgsparql/zoneddate.sql \
		pgsparql/zoneddatetime.sql \
		pgsparql/rdfbox.sql \
		pgsparql/cast.sql \
		pgsparql/logical.sql \
		pgsparql/arithmetic.sql \
		pgsparql/comparison.sql \
		pgsparql/functions.sql \
		pgsparql/extract.sql \
		pgsparql/aggregate.sql

EXTRA_DIST = $(SQLSOURCES)
MOSTLYCLEANFILES = pgsparql--1.0.sql

pgsparql--1.0.sql : $(SQLSOURCES)
		for F in $(SQLSOURCES); do cat $(srcdir)/$$F; echo -e '\n\n'; done > pgsparql--1.0.sql
