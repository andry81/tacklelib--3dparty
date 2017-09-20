@echo off

(
  echo.@echo off
  echo.
  echo.set CYGWIN_PATH=c:\cygwin
  echo.set PYTHON_PATH=c:\Python34
  echo.set PYTHON64_PATH=c:\Python34-x64
  echo.set SRC_BASE_DIR=omniORB
  echo.set SRC_DIR=omniORB_branch_4_2_6333
  echo.set TOOLSET=msvc-14.0
  echo.set ADDRESS_MODEL=32
) > "%~dp0configure.user.bat"
