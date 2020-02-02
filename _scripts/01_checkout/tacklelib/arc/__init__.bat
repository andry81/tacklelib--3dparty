@echo off

call "%%~dp0..\__init__.bat" || exit /b

set "CONFIGURE_DIR=%~dp0"
set "CONFIGURE_DIR=%CONFIGURE_DIR:~0,-1%"

if exist "%CONFIGURE_DIR%/config.vars.in" (
  call "%%CONTOOLS_ROOT%%\load_config.bat" "%%CONFIGURE_DIR%%" "config.vars" || exit /b
)
