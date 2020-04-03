@echo off

setlocal

call "%%~dp0__init__.bat" 0 || exit /b

(
  type "%CONFIGURE_ROOT%\environment.vars.in"
) > "%CONFIGURE_ROOT%/environment.vars"
