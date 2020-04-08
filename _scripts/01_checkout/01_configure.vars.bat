@echo off

setlocal

call "%%~dp0__init__.bat" 0 || exit /b

set "CONFIGURE_DIR=%~dp0"
set "CONFIGURE_DIR=%CONFIGURE_DIR:~0,-1%"

if %IMPL_MODE%0 NEQ 0 goto IMPL

rem no local logging if nested call
set WITH_LOGGING=0
if %NEST_LVL%0 EQU 0 set WITH_LOGGING=1

if %WITH_LOGGING% EQU 0 goto IMPL

if not exist "%CONFIGURE_DIR%\.log" mkdir "%CONFIGURE_DIR%\.log"

rem use stdout/stderr redirection with logging
call "%%CONTOOLS_ROOT%%\get_datetime.bat"
set "LOG_FILE_NAME_SUFFIX=%RETURN_VALUE:~0,4%'%RETURN_VALUE:~4,2%'%RETURN_VALUE:~6,2%_%RETURN_VALUE:~8,2%'%RETURN_VALUE:~10,2%'%RETURN_VALUE:~12,2%''%RETURN_VALUE:~15,3%"

set IMPL_MODE=1
rem CAUTION:
rem   We should avoid use handles 3 and 4 while the redirection has take a place because handles does reuse
rem   internally from left to right when being redirected externally.
rem   Example: if `1` is redirected, then `3` is internally reused, then if `2` redirected, then `4` is internally reused and so on.
rem   The discussion of the logic:
rem   https://stackoverflow.com/questions/9878007/why-doesnt-my-stderr-redirection-end-after-command-finishes-and-how-do-i-fix-i/9880156#9880156
rem   A partial analisis:
rem   https://www.dostips.com/forum/viewtopic.php?p=14612#p14612
rem
"%COMSPEC%" /C call %0 %* 2>&1 | "%CONTOOLS_ROOT%\wtee.exe" "%CONFIGURE_DIR%\.log\%LOG_FILE_NAME_SUFFIX%.%~nx0.log"
exit /b

:IMPL
set /A NEST_LVL+=1

set LASTERROR=0

set CONFIG_GENERATED=0
for %%i in ("%CONFIGURE_ROOT%/%LOCAL_CONFIG_DIR_NAME%" "%CONFIGURE_ROOT%") do ( call :GEN_CONFIG %%i && goto END )

:END
if %CONFIG_GENERATED% EQU 0 (
  echo.%~nx0: error: `config.vars` is not generated.
  set LASTERROR=255
) >&2

set /A NEST_LVL-=1

if %NEST_LVL% LEQ 0 pause

exit /b %LASTERROR%

:GEN_CONFIG
set "CONFIG_DIR_NATIVE=%~1"
set "CONFIG_DIR_NATIVE=%CONFIG_DIR_NATIVE:/=\%"

if exist "%~1/config.vars.in" (
  echo."%~1/config.vars.in" -^> "%~1/config.vars"
  (
    type "%CONFIG_DIR_NATIVE%\config.vars.in" || exit /b 255
  ) > "%~1/config.vars"

  set CONFIG_GENERATED=1
  exit /b 0
)

exit /b 1
