@echo off

setlocal

call "%%~dp0__init__.bat" || exit /b

set /A NEST_LVL+=1

for %%i in ("%CONFIGURE_ROOT%/%LOCAL_CONFIG_DIR_NAME%" "%CONFIGURE_ROOT%") do ( call :GEN_VARS_CONFIG %%i || exit /b )

set /A NEST_LVL-=1

if %NEST_LVL% LEQ 0 pause

exit /b

:GEN_VARS_CONFIG
set "CONFIG_DIR_NATIVE=%~1"
set "CONFIG_DIR_NATIVE=%CONFIG_DIR_NATIVE:/=\%"

if exist "%~1/config.vars.in" (
  echo."%~1/config.vars.in" -^> "%~1/config.vars"
  (
    type "%CONFIG_DIR_NATIVE%\config.vars.in" || exit /b 255
  ) > "%~1/config.vars"
)

exit /b 0
