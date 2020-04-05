#!/bin/bash

# Script can be ONLY included by "source" command.
if [[ -n "$BASH" && (-z "$BASH_LINENO" || BASH_LINENO[0] -gt 0) ]] && (( ! __BASE_INIT__ )); then

__BASE_INIT__=1 # including guard

source "/bin/bash_entry" || exit $?

[[ -z "$NEST_LVL" ]] && NEST_LVL=0

MUST_LOAD_CONFIG=${1:-1}

export CONFIGURE_ROOT="$BASH_SOURCE_DIR"

export LOCAL_CONFIG_DIR_NAME=_config

export PYXVCS_SCRIPTS_ROOT="$CONFIGURE_ROOT/_pyxvcs"
export CONTOOLS_ROOT="$PYXVCS_SCRIPTS_ROOT/tools"
export TACKLELIB_ROOT="$PYXVCS_SCRIPTS_ROOT/tools/python/tacklelib"
export CMDOPLIB_ROOT="$PYXVCS_SCRIPTS_ROOT/tools/python/cmdoplib"
export TMPL_CMDOP_FILES_DIR="$CONFIGURE_ROOT/$LOCAL_CONFIG_DIR_NAME/tmpl"

tkl_include "$CONTOOLS_ROOT/bash/tacklelib/buildlib.sh" || exit $?

function load_config()
{
  tkl_set_error 0

  local is_loaded=0
  local IFS=$' \t\n'
  local i
  for i in "$CONFIGURE_ROOT/$LOCAL_CONFIG_DIR_NAME" "$CONFIGURE_ROOT"; do
    if [[ -e "$i/config.vars.in" && -e "$i/config.vars" ]]; then
      tkl_call_inproc_entry load_config "$CONTOOLS_ROOT/load_config.sh" "$i" "config.vars" && {
        is_loaded=1
        break
      }
    fi
  done

  if (( ! is_loaded && MUST_LOAD_CONFIG != 0 )); then
    echo "$0: error: \`config.vars\` is not loaded." >&2
    tkl_set_error 255
  fi
}

load_config

tkl_set_return $tkl__last_error

fi
