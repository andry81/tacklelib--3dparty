@echo off

set "_3DPARTY_BASE_PATH=%~dp0.."

if "%TOOLSET%" == "msvc-14.1" (
  set DEV_COMPILER=vc2017
) else if "%TOOLSET%" == "msvc-14.0" (
  set DEV_COMPILER=vc14
) else if "%TOOLSET%" == "msvc-12.0" (
  set DEV_COMPILER=vc12
) else if "%TOOLSET%" == "msvc-10.0" (
  set DEV_COMPILER=vc10
) else (
  set DEV_COMPILER=unknown
)

if %ADDRESS_MODEL% == 32 (
  set DEV_COMPILER_DIR=%DEV_COMPILER%_x86
) else (
  set DEV_COMPILER_DIR=%DEV_COMPILER%_x%ADDRESS_MODEL%
)

set "BUILD_BASE_PATH=%_3DPARTY_BASE_PATH%\%DEV_COMPILER_DIR%\%SRC_BASE_DIR%"
set "PROJECT_ROOT=%BUILD_BASE_PATH%\%SRC_DIR%"
set "PROJECT_ROOT=%PROJECT_ROOT:\=/%"

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

rem Qt beginning from version 5.9.0 has changed the generator toolset naming, so we have to test the QT version to select platform correctly
for /F "usebackq tokens=* delims=" %%i in (`where qmake.exe 2^> nul`) do (
  set "QMAKE_EXECUTABLE_PATH=%%i"
)

if not defined QMAKE_EXECUTABLE_PATH goto IGNORE_QMAKE_GENERATOR_VERSION_SELECT

:PARSE_QMAKE_VERSION
echo.Found qmake.exe: "%QMAKE_EXECUTABLE_PATH%"

chcp 65001

for /F "usebackq tokens=* delims=" %%i in (`%QMAKE_EXECUTABLE_PATH% --version`) do (
  set "QMAKE_VERSION_LINE=%%i"
  call :PARSE_QMAKE_VERSION_LINE
)

goto SELECT_MAKE_GENERATORS

:PARSE_QMAKE_VERSION_LINE
if not "%QMAKE_VERSION_LINE:~0,16%" == "Using Qt version" exit /b 0

for /F "tokens=1,* delims= " %%i in ("%QMAKE_VERSION_LINE:~17%") do (
  set "QT_VERSION=%%i"
)

exit /b 0

:SELECT_MAKE_GENERATORS

if not defined QT_VERSION goto IGNORE_QMAKE_GENERATOR_VERSION_SELECT

for /F "tokens=1,2,* delims=." %%i in ("%QT_VERSION%") do (
  set "QT_VERSION_MAJOR=%%i"
  set "QT_VERSION_MINOR=%%j"
  set "QT_VERSION_PATCH=%%k"
)

if not defined QT_VERSION_MAJOR goto IGNORE_QMAKE_GENERATOR_VERSION_SELECT
if not defined QT_VERSION_MINOR goto IGNORE_QMAKE_GENERATOR_VERSION_SELECT

if %QT_VERSION_MAJOR% GTR 5 goto IGNORE_QMAKE_GENERATOR_VERSION_SELECT
if %QT_VERSION_MAJOR% GEQ 5 if %QT_VERSION_MINOR% GEQ 9 goto IGNORE_QMAKE_GENERATOR_VERSION_SELECT

if "%TOOLSET%" == "msvc-14.1" (
  set "QMAKE_GENERATOR_TOOLSET=msvc2017"
) else if "%TOOLSET%" == "msvc-14.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc2015"
) else if "%TOOLSET%" == "msvc-12.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc2012"
) else if "%TOOLSET%" == "msvc-10.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc2010"
) else (
  set "QMAKE_GENERATOR_TOOLSET=unknown"
)

goto QMAKE_GENERATOR_VERSION_SELECT_END

:IGNORE_QMAKE_GENERATOR_VERSION_SELECT

if "%TOOLSET%" == "msvc-14.1" (
  set "QMAKE_GENERATOR_TOOLSET=msvc"
) else if "%TOOLSET%" == "msvc-14.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc"
) else if "%TOOLSET%" == "msvc-12.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc"
) else if "%TOOLSET%" == "msvc-10.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc"
) else (
  set "QMAKE_GENERATOR_TOOLSET=unknown"
)

:QMAKE_GENERATOR_VERSION_SELECT_END

if "%TOOLSET%" == "msvc-14.1" (
  set "CMAKE_GENERATOR_TOOLSET=Visual Studio 15 2017"
) else if "%TOOLSET%" == "msvc-14.0" (
  set "CMAKE_GENERATOR_TOOLSET=Visual Studio 14 2015"
) else if "%TOOLSET%" == "msvc-12.0" (
  set "CMAKE_GENERATOR_TOOLSET=Visual Studio 12 2013"
) else if "%TOOLSET%" == "msvc-10.0" (
  set "CMAKE_GENERATOR_TOOLSET=Visual Studio 10 2010"
) else (
  set "CMAKE_GENERATOR_TOOLSET=unknown"
)

if not "%CMAKE_GENERATOR_TOOLSET%" == "unknown" (
  if "%ADDRESS_MODEL%" == "64" set "CMAKE_GENERATOR_TOOLSET=%CMAKE_GENERATOR_TOOLSET% Win64"
)

if not "%QMAKE_GENERATOR_TOOLSET%" == "unknown" (
  if "%ADDRESS_MODEL%" == "64" set "QMAKE_GENERATOR_TOOLSET=win64-%QMAKE_GENERATOR_TOOLSET%"
  if "%ADDRESS_MODEL%" == "32" set "QMAKE_GENERATOR_TOOLSET=win32-%QMAKE_GENERATOR_TOOLSET%"
)

echo.PROJECT_ROOT="%PROJECT_ROOT%"
