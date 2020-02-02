@echo off

setlocal

call "%%~dp0__init__.bat" || exit /b

set "CONFIGURE_DIR=%~dp0"
set "CONFIGURE_DIR=%CONFIGURE_DIR:~0,-1%"

set VARS_CONFIG_FOUND=0
for %%i in ("%CONFIGURE_ROOT%/%LOCAL_CONFIG_DIR_NAME%" "%CONFIGURE_ROOT%") do ( call :CHECK_VARS_CONFIG %%i || goto CHECK_VARS_CONFIG_END )
:CHECK_VARS_CONFIG_END

if %VARS_CONFIG_FOUND% EQU 0 (
  echo.%~nx0: error: `config.vars` configuration file is not found or not generated.
  exit /b 255
) >&2

call "%%BASE_SCRIPTS_ROOT%%\%%CONFIGURE_BASE_SCRIPT_FILE_NAME%%" "%%CONFIGURE_DIR%%" --gen_scripts %%* || exit /b
exit /b 0

:CHECK_VARS_CONFIG
if exist "%~1/config.vars" (
  set VARS_CONFIG_FOUND=1
  exit /b 1
)
exit /b 0

