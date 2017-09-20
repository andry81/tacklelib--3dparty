@echo off

setlocal

set TOOLSET=msvc-14.0
set ADDRESS_MODEL=32
set SRC_BASE_DIR=tao

call "%%~dp0..\reg_env.bat"

set SRC_DIR=6.4.1
set "ACE_ROOT=%BUILD_BASE_PATH%\%SRC_DIR%"

echo ACE_ROOT=%ACE_ROOT%

(
  echo.@echo off
  echo.
  rem echo.set CYGWIN_PATH=c:\cygwin
  rem echo.set "MSBUILD_PATH=c:\Program Files (x86)\MSBuild\12.0\Bin"
  echo.set "MSBUILD_PATH=c:\Program Files (x86)\MSBuild\14.0\Bin"
  echo.set SRC_BASE_DIR=%SRC_BASE_DIR%
  echo.set SRC_DIR=%SRC_DIR%
  echo.set "BUILD_DIR=%%SRC_DIR%%\tao"
  echo.set "ACE_ROOT=%ACE_ROOT%"
  echo.set "TAO_ROOT=%%ACE_ROOT%%\TAO"
  echo.set TOOLSET=%TOOLSET%
  echo.set ADDRESS_MODEL=%ADDRESS_MODEL%
  echo.set VARIANT=release,debug
  echo.set PATH=%%ACE_ROOT%%\lib;%%PATH%%
) > "%~dp0configure.user.bat"

(
  rem echo #define ACE_DISABLE_WIN32_ERROR_WINDOWS
  rem echo #define ACE_DISABLE_WIN32_INCREASE_PRIORITY
  echo #include "ace/config-win32.h"
) > "%ACE_ROOT%\ace\config.h"
