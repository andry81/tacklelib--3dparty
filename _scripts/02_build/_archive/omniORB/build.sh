#!/bin/bash

# for gnu make debugging
# "SHELL=\$(warning \$@: \$(word \$(words \$(MAKEFILE_LIST)),\$(MAKEFILE_LIST)): \$(CURDIR): \$(if \$<, (from \$<))\$(if \$?, (\$? newer)))${SHELL} -x"

# build from the root of src
function build() {
  echo ">$@"
  eval '"$@"'
}

build make export #platform=$OMNIORB_PLATFORM #IMPORT_CPPFLAGS='-FIvld_link.h' IMPORT_LIBRARY_FLAGS='vld.lib'
