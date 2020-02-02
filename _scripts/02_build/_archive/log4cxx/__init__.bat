@echo off

set "CONFIGURE_DIR=%~dp0"
set "CONFIGURE_DIR=%CONFIGURE_DIR:~0,-1%"

if not exist "%~dp0configure.user.bat" ( call "%%~dp0configure.bat" || exit /b 255 )

call "%%~dp0configure.user.bat" || exit /b

call "%%~dp0..\__init__.bat" || exit /b
