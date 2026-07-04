#! /usr/bin/bash

# professor's Makefile doesn't set a C++ standard itself, and the Eigen
# conda-forge ships now requires at least c++14 ("Eigen requires at
# least c++14 support"). Exported (not folded into OVERRIDES) since
# $CXXFLAGS has embedded spaces (-march=... -O2 ...) that would break
# word-splitting when make $OVERRIDES expands unquoted below.
export CXXFLAGS="${CXXFLAGS} -std=c++17"

OVERRIDES="PROF_VERSION=${PKG_VERSION} CPPFLAGS=-I${PREFIX}/include/eigen3 PREFIX=${PREFIX}"
make $OVERRIDES
make install $OVERRIDES
