@echo off

if %__BASE_INIT__%0 NEQ 0 exit /b

if not defined NEST_LVL set NEST_LVL=0

set "MUST_LOAD_CONFIG=%~1"
if not defined MUST_LOAD_CONFIG set "MUST_LOAD_CONFIG=1"

set "CONFIGURE_ROOT=%~dp0"
set "CONFIGURE_ROOT=%CONFIGURE_ROOT:~0,-1%"

set "LOCAL_CONFIG_DIR_NAME=_config"

set "PYXVCS_SCRIPTS_ROOT=%CONFIGURE_ROOT%\_pyxvcs"
set "CONTOOLS_ROOT=%PYXVCS_SCRIPTS_ROOT%\tools"
set "TACKLELIB_ROOT=%PYXVCS_SCRIPTS_ROOT%\tools\tacklelib"
set "CMDOPLIB_ROOT=%PYXVCS_SCRIPTS_ROOT%\tools\cmdoplib"
set "TMPL_CMDOP_FILES_DIR=%CONFIGURE_ROOT%\%LOCAL_CONFIG_DIR_NAME%\tmpl"

set LASTERROR=0

set CONFIG_LOADED=0
for %%i in ("%CONFIGURE_ROOT%/%LOCAL_CONFIG_DIR_NAME%" "%CONFIGURE_ROOT%") do ( call :LOAD_CONFIG %%i && goto END )

:END
if %CONFIG_LOADED% EQU 0 ^
if %MUST_LOAD_CONFIG% NEQ 0 (
  echo.%~nx0: error: `config.vars` is not loaded.
  set LASTERROR=255
) >&2

if defined CHCP chcp %CHCP%

set __BASE_INIT__=1

(
  set "MUST_LOAD_CONFIG="
  set "CONFIG_LOADED="
  set "LASTERROR="
  exit /b %LASTERROR%
)

:LOAD_CONFIG
if exist "%~1/config.vars.in" (
  if exist "%~1/config.vars" (
    call "%%CONTOOLS_ROOT%%\load_config.bat" %%1 "config.vars" && (
      set CONFIG_LOADED=1
      exit /b 0
    )
  )
)

exit /b 1
