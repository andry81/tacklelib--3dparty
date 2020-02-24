@echo off

setlocal

call "%%~dp0__init__.bat" || exit /b

set /A NEST_LVL+=1

set "CONFIGURE_DIR=%~dp0"
set "CONFIGURE_DIR=%CONFIGURE_DIR:~0,-1%"

call "%%PYXVCS_SCRIPTS_ROOT%%\%%CONFIGURE_BASE_SCRIPT_FILE_NAME%%" "%%CONFIGURE_DIR%%" --gen_yaml %%*
set LASTERROR=%ERRORLEVEL%

set /A NEST_LVL-=1

if %NEST_LVL% LEQ 0 pause

exit /b %LASTERROR%
