extensiondir = $(POSTGRESQL_SHAREDIR)/extension
dist_extension_DATA = \
		pgsparql.control  \
		pgsparql--0.1.sql

SQLSOURCES = \
		pgsparql-0.1/header.sql \
		pgsparql-0.1/zoneddate.sql \
		pgsparql-0.1/zoneddatetime.sql \
		pgsparql-0.1/rdfbox.sql \
		pgsparql-0.1/cast.sql \
		pgsparql-0.1/logical.sql \
		pgsparql-0.1/arithmetic.sql \
		pgsparql-0.1/comparison.sql \
		pgsparql-0.1/functions.sql \
		pgsparql-0.1/extract.sql

EXTRA_DIST = $(SQLSOURCES)
MOSTLYCLEANFILES = pgsparql--0.1.sql

pgsparql--0.1.sql : $(SQLSOURCES)
		for F in $(SQLSOURCES); do cat $(srcdir)/$$F; echo -e '\n\n'; done > pgsparql--0.1.sql
