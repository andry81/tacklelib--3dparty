#!/bin/bash

# Script ONLY for execution.
if [[ -n "$BASH" && (-z "$BASH_LINENO" || BASH_LINENO[0] -eq 0) ]]; then 

source "/bin/bash_entry" || exit $?
tkl_include "__init__.sh" 0 || exit $?

{
  cat "$CONFIGURE_ROOT/environment.vars.in"
} > "$CONFIGURE_ROOT/environment.vars"

fi
