@echo off

(
  echo.@echo off
  echo.
  echo.set SRC_BASE_DIR=googletest
  echo.set SRC_DIR=%%SRC_BASE_DIR%%-release-1.8.0\googletest
  echo.set TOOLSET=msvc-14.0
  echo.set ADDRESS_MODEL=32
) > "%~dp0configure.user.bat"
