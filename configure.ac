dnl Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)
AC_INIT(pgsparql, 2.0.0)
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([build-aux])
AC_PROG_CC

AC_CONFIG_MACRO_DIR([m4])

dnl Initialize automake
AM_INIT_AUTOMAKE([subdir-objects])

dnl this allows us specify individual liking flags for each target
AM_PROG_CC_C_O 

dnl Initialize Libtool
LT_INIT

dnl check for postgresql
AX_LIB_POSTGRESQL(15.0.0)

dnl check for pcre2
PKG_CHECK_MODULES([PCRE2], [libpcre2-8 >= 10.30])

AC_ARG_ENABLE([extra-checks],
    [AS_HELP_STRING([--enable-extra-checks],
        [check the arguments of the constructors and the syntax read by the receive function (slow, off by default)])],
    [], [enable_extra_checks=no])

AS_IF([test "x$enable_extra_checks" = xyes],
    [EXTRA_CHECKS_CPPFLAGS=-DPGSPARQL_EXTRA_CHECKS], [EXTRA_CHECKS_CPPFLAGS=])
AC_SUBST([EXTRA_CHECKS_CPPFLAGS])

AC_CONFIG_FILES(Makefile src/Makefile extension/Makefile)
AC_OUTPUT
