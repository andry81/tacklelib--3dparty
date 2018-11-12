@echo off

(
  echo.@echo off
  echo.
  echo.set WINDOWS_SDK_ROOT=c:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A
  echo.set SRC_BASE_DIR=boost
  echo.set SRC_DIR=%%SRC_BASE_DIR%%_1_63_0
  echo.set TOOLSET=msvc-14.0
  echo.set VARIANT=release,debug
  echo.set ARCHITECTURE=x86
  echo.set ADDRESS_MODEL=32
  echo.set LINK_TYPE=shared
  echo.set RUNTIME_LINK=shared
  echo.set THREADING=multi
  echo.set "BUILD_DIR=__build-%%TOOLSET%%-%%ADDRESS_MODEL%%"
  echo.set BOOST_LIB_CONFIG_ARGS=debug-symbols=on "--build-dir=%%BUILD_DIR%%"
) > "%~dp0configure.user.bat"
