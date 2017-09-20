@echo off

(
  echo.@echo off
  echo.
  echo.rem set QT_PATH=c:\Qt\Qt5.6.0_vc12\5.6\msvc2013
  echo.set QT_PATH=c:\Qt\Qt5.7.1_vc14_x86\5.7\msvc2015
  echo.set SRC_BASE_DIR=qwt
  echo.set SRC_DIR=qwt-6.1_branch_2522
  echo.set TOOLSET=msvc-14.0
  echo.set ADDRESS_MODEL=32
) > "%~dp0configure.user.bat"
