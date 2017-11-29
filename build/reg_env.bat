@echo off

set "3DPARTY_BASE_PATH=%~dp0.."

if "%TOOLSET%" == "msvc-10.0" (
  set DEV_COMPILER=vc10
) else if "%TOOLSET%" == "msvc-12.0" (
  set DEV_COMPILER=vc12
) else if "%TOOLSET%" == "msvc-14.0" (
  set DEV_COMPILER=vc14
) else set DEV_COMPILER=unknown

if %ADDRESS_MODEL% == 32 (
  set DEV_COMPILER_DIR=%DEV_COMPILER%_x86
) else (
  set DEV_COMPILER_DIR=%DEV_COMPILER%_x%ADDRESS_MODEL%
)

set "BUILD_BASE_PATH=%3DPARTY_BASE_PATH%\%DEV_COMPILER_DIR%\%SRC_BASE_DIR%"
set "PROJECT_ROOT=%BUILD_BASE_PATH%\%SRC_DIR%"

if "%ADDRESS_MODEL%" == "64" (
  rem for vcvarsall.bat call
  set MSVC_ARCHITECTURE=amd64
  rem for devenv call
  set DEVENV_SOLUTION_PLATFORM=x64
) else (
  rem for vcvarsall.bat call
  set MSVC_ARCHITECTURE=x86
  rem for devenv call
  set DEVENV_SOLUTION_PLATFORM=Win32
)

if "%TOOLSET%" == "msvc-14.0" (
  set "CMAKE_GENERATOR_TOOLSET=Visual Studio 14 2015"
  set "QMAKE_GENERATOR_TOOLSET=msvc2015"
) else if "%TOOLSET%" == "msvc-12.0" (
  set "CMAKE_GENERATOR_TOOLSET=Visual Studio 12 2013"
  set "QMAKE_GENERATOR_TOOLSET=msvc2012"
) else if "%TOOLSET%" == "msvc-10.0" (
  set "CMAKE_GENERATOR_TOOLSET=Visual Studio 10 2010"
  set "QMAKE_GENERATOR_TOOLSET=msvc2010"
) else (
  set "CMAKE_GENERATOR_TOOLSET=unknown"
  set "QMAKE_GENERATOR_TOOLSET=unknown"
)

if not "%CMAKE_GENERATOR_TOOLSET%" == "unknown" (
  if "%ADDRESS_MODEL%" == "64" set "CMAKE_GENERATOR_TOOLSET=%CMAKE_GENERATOR_TOOLSET% Win64"
)

if not "%QMAKE_GENERATOR_TOOLSET%" == "unknown" (
  if "%ADDRESS_MODEL%" == "64" set "QMAKE_GENERATOR_TOOLSET=win64-%QMAKE_GENERATOR_TOOLSET%"
  if "%ADDRESS_MODEL%" == "32" set "QMAKE_GENERATOR_TOOLSET=win32-%QMAKE_GENERATOR_TOOLSET%"
)
