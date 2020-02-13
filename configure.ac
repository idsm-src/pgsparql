dnl Process this file with autoconf to produce a configure script.

AC_PREREQ(2.59)
AC_INIT(pgsparql, 1.0.0)
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_AUX_DIR([build])
AC_PROG_CC

AC_CANONICAL_SYSTEM

AC_CONFIG_MACRO_DIR([m4])

dnl Initialize automake
AM_INIT_AUTOMAKE([subdir-objects])

dnl this allows us specify individual liking flags for each target
AM_PROG_CC_C_O 

dnl Initialize Libtool
LT_INIT

dnl check for postgresql
AX_LIB_POSTGRESQL(10.0.0)

dnl check for pcre2
PKG_CHECK_MODULES([PCRE2], [libpcre2-8 >= 10.30])

AC_CONFIG_FILES(Makefile src/Makefile extension/Makefile)
AC_OUTPUT