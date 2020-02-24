@echo off

setlocal

call "%%~dp0__init__.bat" || exit /b

set /A NEST_LVL+=1

set LASTERROR=0

set CONFIG_GENERATED=0
for %%i in ("%CONFIGURE_ROOT%/%LOCAL_CONFIG_DIR_NAME%" "%CONFIGURE_ROOT%") do ( call :GEN_CONFIG %%i && goto END )

:END
if %CONFIG_GENERATED% EQU 0 (
  echo.%~nx0: error: `config.private.yaml` is not generated.
  set LASTERROR=255
) >&2

set /A NEST_LVL-=1

if %NEST_LVL% LEQ 0 pause

exit /b %LASTERROR%

:GEN_CONFIG
set "CONFIG_DIR_NATIVE=%~1"
set "CONFIG_DIR_NATIVE=%CONFIG_DIR_NATIVE:/=\%"

if exist "%~1/config.private.yaml.in" (
  echo."%~1/config.private.yaml.in" -^> "%~1/config.private.yaml"
  (
    type "%CONFIG_DIR_NATIVE%\config.private.yaml.in" || exit /b 255
  ) > "%~1/config.private.yaml"

  set CONFIG_GENERATED=1
  exit /b 0
)

exit /b 1
