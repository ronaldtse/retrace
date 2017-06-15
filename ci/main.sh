#!/bin/bash
set -eu

LD_LIBRARY_PATH="${CMOCKA_INSTALL}/lib"
LDFLAGS="-L${CMOCKA_INSTALL}/lib"
CFLAGS="-I${CMOCKA_INSTALL}/include"

CHECKPATCH_FLAGS+=" --no-tree"
CHECKPATCH_FLAGS+=" --ignore COMPLEX_MACRO"
CHECKPATCH_FLAGS+=" --ignore TRAILING_SEMICOLON"
CHECKPATCH_FLAGS+=" --ignore LONG_LINE"
CHECKPATCH_FLAGS+=" --ignore LONG_LINE_STRING"
CHECKPATCH_FLAGS+=" --ignore LONG_LINE_COMMENT"
CHECKPATCH_FLAGS+=" --ignore SYMBOLIC_PERMS"
CHECKPATCH_FLAGS+=" --ignore NEW_TYPEDEFS"
CHECKPATCH_FLAGS+=" --ignore SPLIT_STRING"
CHECKPATCH_FLAGS+=" --ignore USE_FUNC"
CHECKPATCH_FLAGS+=" --ignore COMMIT_LOG_LONG_LINE"
CHECKPATCH_FLAGS+=" --ignore FILE_PATH_CHANGES"
CHECKPATCH_FLAGS+=" --ignore MISSING_SIGN_OFF"

export LD_LIBRARY_PATH CFLAGS LDFLAGS

make -j2
make test

# checkpatch
git format-patch -1 --stdout | $CHECKPATCH_INSTALL/checkpatch.pl $CHECKPATCH_FLAGS -
