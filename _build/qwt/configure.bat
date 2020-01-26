@echo off

(
  echo.@echo off
  echo.
  echo.set QT_ROOT=c:/Qt/Qt5_11_1/5.11.1/msvc2015
  echo.rem set QT_ROOT=c:/Qt/Qt5_11_1/5.11.1/mingw53_32
  echo.set SRC_BASE_DIR=qwt
  echo.set SRC_DIR=qwt-6.1.3-src
  echo.set TOOLSET=msvc-14.0
  echo.rem set TOOLSET=mingw_gcc
  echo.rem set TOOLSET=cygwin_gcc
  echo.set ADDRESS_MODEL=32
  echo.set "WINDOWS_KIT_BIN_ROOT=c:/Program Files (x86)/Windows Kits/10/bin/10.0.17763.0"
  echo.rem set QMAKE_CMD_LINE="QMAKE_LFLAGS+=-mno-cygwin"
) > "%~dp0configure.user.bat"
