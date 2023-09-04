pglibdir = $(POSTGRESQL_LIBDIR)
pglib_LTLIBRARIES = libpgsparql.la


libpgsparql_la_SOURCES = \
    call.h \
    compare.h \
    constants.c \
    constants.h \
    pgsparql.c \
    pgsparql.h \
    try-catch.h \
    cast/boolean.c \
    cast/cast.h \
    cast/date.c \
    cast/datetime.c \
    cast/daytimeduration.c \
    cast/decimal.c \
    cast/double.c \
    cast/float.c \
    cast/int.c \
    cast/integer.c \
    cast/long.c \
    cast/short.c \
    cast/string.c \
    functions/aggregate.c \
    functions/datetime.c \
    functions/numeric.c \
    functions/logical.c \
    functions/rdfterm.c \
    functions/regex.c \
    functions/string.c \
    rdfbox/arithmetic.c \
    rdfbox/comparison.c \
    rdfbox/constructors.c \
    rdfbox/derivate.c \
    rdfbox/getters.c \
    rdfbox/order.c \
    rdfbox/order.h \
    rdfbox/promotion.h \
    rdfbox/rdfbox.c \
    rdfbox/rdfbox.h \
    rdfbox/syntax.c \
    rdfbox/syntax.h \
    rdfbox/xsd.h \
    types/date.c \
    types/date.h \
    types/datetime.c \
    types/datetime.h \
    types/daytimeduration.c \
    types/daytimeduration.h \
    types/double.c \
    types/decimal.c \
    types/double.h \
    types/float.c \
    types/float.h \
    types/iblanknode.c \
    types/iblanknode.h \
    types/sblanknode.c \
	types/sblanknode.h \
    types/timezone.c \
    types/timezone.h

libpgsparql_la_LDFLAGS = $(PCRE2_LIBS)
libpgsparql_la_CPPFLAGS = $(POSTGRESQL_CPPFLAGS) $(PCRE2_CFLAGS) -DPCRE2_CODE_UNIT_WIDTH=8
