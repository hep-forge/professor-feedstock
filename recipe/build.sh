#! /usr/bin/bash
set -eo pipefail

# The Eigen conda-forge ships requires at least C++14; professor doesn't set
# a standard itself before 2.5. Exported (not folded into OVERRIDES) since
# $CXXFLAGS has embedded spaces that would break word-splitting below.
export CXXFLAGS="${CXXFLAGS} -std=c++17"

# 2.5 added a configure step that writes Makefile.inc (C++ standard, Python,
# Cython, Eigen path, install prefix) and dropped the Makefile's own
# PYTHON/CYTHON defaults; its Makefile also uses bash syntax ([[ ]]).
export CXXSTD=c++17
export CYTHON="${PREFIX}/bin/cython"
if [ -x ./configure ]; then
    ./configure --prefix="${PREFIX}" --with-eigen="${PREFIX}"
fi

OVERRIDES="SHELL=/bin/bash PROF_VERSION=${PKG_VERSION} CPPFLAGS=-I${PREFIX}/include/eigen3 PREFIX=${PREFIX} PYTHON=${PYTHON} CYTHON=${CYTHON}"
make $OVERRIDES
make install $OVERRIDES
