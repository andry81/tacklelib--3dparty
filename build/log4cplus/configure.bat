@echo off

(
  echo.@echo off
  echo.
  echo.set SRC_BASE_DIR=log4cplus
  echo.set SRC_DIR=%%SRC_BASE_DIR%%-1.2.0
  echo.set TOOLSET=msvc-14.0
  echo.set ADDRESS_MODEL=64
  echo.set VARIANT=release,release_unicode,debug,debug_unicode
) > "%~dp0configure.user.bat"
