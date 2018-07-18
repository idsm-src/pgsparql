#######################################
# The list of libraries we are building seperated by spaces.
# The 'lib_' indicates that these build products will be installed
# in the $(libdir) directory. For example /usr/lib
lib_LTLIBRARIES = libpgsparql.la

#######################################
# Build information for each library

# Sources for pgsparql
libpgsparql_la_SOURCES = \
		call.h \
		create.c \
		create.h \
		pgsparql.c \
		rdfbox.c \
		rdfbox.h \
		try-catch.h \
		xsd.h \
		arithmetic/addition.c \
		arithmetic/division.c \
		arithmetic/multiplication.c \
		arithmetic/subtraction.c \
		arithmetic/uminus.c \
		date/date.c \
		date/date.h \
		date/datetime.c \
		date/datetime.h \
		date/timezone.c \
		date/timezone.h \
		cast/boolean.c \
		cast/cast.h \
		cast/decimal.c \
		cast/double.c \
		cast/float.c \
		cast/int.c \
		cast/integer.c \
		cast/long.c \
		cast/rdfbox.c \
		cast/short.c \
		cast/string.c

# Linker options libTestProgram
libpgsparql_la_LDFLAGS = 

# Compiler options. Here we are adding the include directory
# to be searched for headers included in the source code.
libpgsparql_la_CPPFLAGS = $(POSTGRESQL_CPPFLAGS)
