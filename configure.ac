#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.59])
AC_INIT([libpsf],[0.2],[henrik@johome.net])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([1.9 -Wall no-define])

AC_LANG([C++])

dnl Checks for programs.
AC_PROG_CXX
AC_PROG_AWK
AC_PROG_CC
AC_PROG_CPP
AC_PROG_LIBTOOL
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB
AM_PROG_LIBTOOL

dnl Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([arpa/inet.h fcntl.h stdint.h stdlib.h string.h unistd.h])

dnl Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL
AC_TYPE_INT32_T
AC_TYPE_INT8_T
AC_TYPE_OFF_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T

dnl Check existence of tr1::unordered_map
AC_CHECK_HEADERS([tr1/unordered_map])

dnl Checks for boost 
AX_BOOST_BASE([1.32.0])
if test "$succeeded" != "yes" ; then
  echo "Error: You need to install the boost library!"
  exit
fi


AM_CONDITIONAL(WITH_PYTHONBINDINGS, test ! -z "$BOOST_PYTHON_LIB" -a "x$NUMPY_HEADER" == "xyes" )

dnl Checks for library functions.
AC_FUNC_MMAP

dnl Include libtool to build shared libraries
dnl LT_INIT

dnl Check if we should build tests
AC_ARG_ENABLE([tests], AS_HELP_STRING([--enable-tests], [Enable tests]))

AM_CONDITIONAL([ENABLE_TESTS], [test "$enable_tests" = yes])

AC_CONFIG_FILES([Makefile
		 include/Makefile
                 src/Makefile
		 libpsf.pc
		 libpsf-uninstalled.pc
		 ])
AC_OUTPUT

