@echo off

(
  echo.@echo off
  echo.
  echo.set SRC_BASE_DIR=log4cxx
  echo.set SRC_DIR=%%SRC_BASE_DIR%%-0.10.0
  echo.set BUILD_DIR=%%SRC_DIR%%-build
  echo.set APR_UTIL_DIR=apr-util
  echo.set APR_DIR=apr
  echo.set TOOLSET=msvc-14.1
  echo.set ADDRESS_MODEL=32
  echo.set VARIANT=release,debug
) > "%~dp0configure.user.bat"
