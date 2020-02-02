@echo off

if %__BASE_INIT__%0 NEQ 0 exit /b

if not defined NEST_LVL set NEST_LVL=0

set "CONFIGURE_ROOT=%~dp0"
set "CONFIGURE_ROOT=%CONFIGURE_ROOT:~0,-1%"

set "LOCAL_CONFIG_DIR_NAME=_config"

set "BASE_SCRIPTS_ROOT=%CONFIGURE_ROOT%\_common"
set "CONTOOLS_ROOT=%BASE_SCRIPTS_ROOT%\tools"
set "TACKLELIB_ROOT=%BASE_SCRIPTS_ROOT%\tools\tacklelib"
set "CMDOPLIB_ROOT=%BASE_SCRIPTS_ROOT%\tools\cmdoplib"
set "TMPL_CMDOP_FILES_DIR=%CONFIGURE_ROOT%\%LOCAL_CONFIG_DIR_NAME%\tmpl"

for %%i in ("%CONFIGURE_ROOT%/%LOCAL_CONFIG_DIR_NAME%" "%CONFIGURE_ROOT%") do ( call :LOAD_CONFIG %%i || exit /b )

if defined CHCP chcp %CHCP%

set __BASE_INIT__=1

exit /b

:LOAD_CONFIG
rem if exist "%~1/config.private.vars" ( call "%%CONTOOLS_ROOT%%\load_config.bat" %%1 "config.private.vars" || exit /b )
if exist "%~1/config.vars" ( call "%%CONTOOLS_ROOT%%\load_config.bat" %%1 "config.vars" || exit /b )

exit /b 0
