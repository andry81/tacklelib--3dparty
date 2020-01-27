@echo off

(
  echo.@echo off
  echo.
  echo.set "USER_PATH=c:/Program Files/CMake3/bin"
  echo.set SRC_BASE_DIR=googletest
  echo.set SRC_DIR=%%SRC_BASE_DIR%%-release-1.10.0/googlemock
  echo.set BUILD_DIR=%%SRC_DIR%%-build
  echo.set TOOLSET=msvc-14.1
  echo.set ADDRESS_MODEL=32
  echo.set VARIANT=release,debug
  echo.rem set GTEST_MSVC_SEARCH=MT
) > "%~dp0configure.user.bat"
