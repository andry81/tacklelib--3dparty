@echo off

(
  echo.@echo off
  echo.
  echo.set SRC_BASE_DIR=log4cplus
  echo.set SRC_DIR=%%SRC_BASE_DIR%%-2.0.5
  echo.set BUILD_DIR=%%SRC_DIR%%-build
  echo.set TOOLSET=msvc-14.1
  echo.set ADDRESS_MODEL=32
  echo.set VARIANT=release,release_unicode,debug,debug_unicode
) > "%~dp0configure.user.bat"
