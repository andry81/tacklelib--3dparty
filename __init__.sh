#!/bin/bash

# Script can be ONLY included by "source" command.
if [[ -n "$BASH" && (-z "$BASH_LINENO" || ${BASH_LINENO[0]} -gt 0) ]] && (( ! ${#__BASE_INIT__} )); then 

export __BASE_INIT__=1 # including guard

source "/bin/bash_entry" || exit $?

[[ -z "$NEST_LVL" ]] && NEST_LVL=0

MUST_LOAD_CONFIG=${1:-1}

export CONFIGURE_ROOT="$BASH_SOURCE_DIR"

export LOCAL_CONFIG_DIR_NAME=_config

export PYXVCS_SCRIPTS_ROOT="$CONFIGURE_ROOT/_pyxvcs"
export CONTOOLS_ROOT="$PYXVCS_SCRIPTS_ROOT/tools"
export TACKLELIB_ROOT="$PYXVCS_SCRIPTS_ROOT/tools/tacklelib"
export CMDOPLIB_ROOT="$PYXVCS_SCRIPTS_ROOT/tools/cmdoplib"
export TMPL_CMDOP_FILES_DIR="$CONFIGURE_ROOT/$LOCAL_CONFIG_DIR_NAME/tmpl"

function Return()
{
  [[ -n "$1" ]] && return $1
}

function SetError()
{
  if [[ -n "$1" ]]; then
    LastError=$1
    return $LastError
  fi
}

function Call()
{
  echo ">$@"
  echo
  tkl_make_source_file_components_from_file_path "$1"
  "$@"
  LastError=$?
  return $LastError
}

function load_config()
{
  SetError 0

  local is_loaded=0
  local IFS=$' \t\n'
  local i
  for i in "$CONFIGURE_ROOT/$LOCAL_CONFIG_DIR_NAME" "$CONFIGURE_ROOT"; do
    if [[ -e "$i/config.vars.in" && -e "$i/config.vars" ]]; then
      Call "$CONTOOLS_ROOT/load_config.sh" "$i" "config.vars" && {
        is_loaded=1
        break
      }
    fi
  done

  if (( is_loaded == 0 && MUST_LOAD_CONFIG != 0 )); then
    echo "$0: error: \`config.vars\` is not loaded." >&2
    SetError 255
  fi
}

load_config

Return $LastError

fi
