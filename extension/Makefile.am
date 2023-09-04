extensiondir = $(POSTGRESQL_SHAREDIR)/extension
dist_extension_DATA = \
		pgsparql.control  \
		pgsparql--2.0.sql

SQLSOURCES = \
		pgsparql/header.sql \
		pgsparql/numeric.sql \
		pgsparql/zoneddatetime.sql \
		pgsparql/zoneddate.sql \
		pgsparql/blanknode.sql \
		pgsparql/rdfbox.sql \
		pgsparql/extract.sql \
		pgsparql/cast.sql \
		pgsparql/functions.sql \
		pgsparql/aggregate.sql

EXTRA_DIST = $(SQLSOURCES)
MOSTLYCLEANFILES = pgsparql--2.0.sql

pgsparql--2.0.sql : $(SQLSOURCES)
		for F in $(SQLSOURCES); do cat $(srcdir)/$$F; echo -e '\n\n'; done > pgsparql--2.0.sql
