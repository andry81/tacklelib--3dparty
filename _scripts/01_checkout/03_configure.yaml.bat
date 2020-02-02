@echo off

setlocal

call "%%~dp0__init__.bat" || exit /b

set "CONFIGURE_DIR=%~dp0"
set "CONFIGURE_DIR=%CONFIGURE_DIR:~0,-1%"

call "%%BASE_SCRIPTS_ROOT%%\%%CONFIGURE_BASE_SCRIPT_FILE_NAME%%" "%%CONFIGURE_DIR%%" --gen_yaml %%* || exit /b
