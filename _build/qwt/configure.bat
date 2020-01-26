@echo off

(
  echo.@echo off
  echo.
  echo.set QT_ROOT=c:/Qt/Qt5_12_6/5.12.6/msvc2017
  echo.rem set QT_ROOT=c:/Qt/Qt5_12_6/5.12.7/mingw73_32
  echo.set SRC_BASE_DIR=qwt
  echo.set SRC_DIR=qwt-6.1.4
  echo.set BUILD_DIR=%%SRC_DIR%%-build
  echo.set TOOLSET=msvc-14.1
  echo.rem set TOOLSET=mingw_gcc
  echo.rem set TOOLSET=cygwin_gcc
  echo.set ADDRESS_MODEL=32
  echo.set "WINDOWS_KIT_BIN_ROOT=c:/Program Files (x86)/Windows Kits/10/bin/10.0.17763.0"
  echo.rem set QMAKE_CMD_LINE="QMAKE_LFLAGS+=-mno-cygwin"
) > "%~dp0configure.user.bat"
