@echo off

(
  echo.@echo off
  echo.
  echo.set "MINGW_ROOT=c:\Qt\Qt5_11_1\Tools\mingw530_32"
  echo.set "WINDOWS_SDK_ROOT=c:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A"
  echo.set SRC_BASE_DIR=boost
  echo.set SRC_DIR=%%SRC_BASE_DIR%%_1_69_0
  echo.set TOOLSET=msvc-14.0
  echo.rem set TOOLSET=mingw_gcc
  echo.set VARIANT=release,debug
  echo.set ARCHITECTURE=x86
  echo.set ADDRESS_MODEL=32
  echo.set LINK_TYPE=shared
  echo.set RUNTIME_LINK=shared
  echo.set THREADING=multi
  echo.set "BUILD_DIR=__build-%%TOOLSET%%-%%ADDRESS_MODEL%%"
  echo.set BOOST_LIB_CONFIG_ARGS=debug-symbols=on "--build-dir=%%BUILD_DIR%%"
) > "%~dp0configure.user.bat"
