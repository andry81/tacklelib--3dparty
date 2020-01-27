@echo off

if %__REG_ENV_INIT__%0 NEQ 0 exit /b

set "_3DPARTY_BASE_PATH=%~dp0.."
call :CANONICAL_PATH _3DPARTY_BASE_PATH "%%_3DPARTY_BASE_PATH%%"

rem if "%PATH:~-1%" == ";" set "PATH=%PATH:~0,-1%"

set DEV_COMPILER=unknown
set JAM_TOOLSET=%TOOLSET%

if not "%TOOLSET%" == "%TOOLSET:mingw_=%" (
  if not "%TOOLSET%" == "%TOOLSET:_gcc=%" (
    set DEV_COMPILER=mingw_gcc
    set JAM_TOOLSET=gcc-mingw
  )
) else if not "%TOOLSET%" == "%TOOLSET:cygwin_=%" (
  if not "%TOOLSET%" == "%TOOLSET:_gcc=%" (
    set DEV_COMPILER=cygwin_gcc
    set JAM_TOOLSET=gcc-cygwin
  )
) else if "%TOOLSET%" == "msvc-14.2" (
  set DEV_COMPILER=vc2019
) else if "%TOOLSET%" == "msvc-14.1" (
  set DEV_COMPILER=vc2017
) else if "%TOOLSET%" == "msvc-14.0" (
  set DEV_COMPILER=vc14
) else if "%TOOLSET%" == "msvc-12.0" (
  set DEV_COMPILER=vc12
) else if "%TOOLSET%" == "msvc-10.0" (
  set DEV_COMPILER=vc10
) else (
  echo.%~nx0: error: TOOLSET registration is not supported: "%TOOLSET%".
  exit /b 127
) >&2

if %ADDRESS_MODEL% == 32 (
  set DEV_COMPILER_DIR=%DEV_COMPILER%_x86
) else (
  set DEV_COMPILER_DIR=%DEV_COMPILER%_x%ADDRESS_MODEL%
)

set "SRC_BASE_PATH=%_3DPARTY_BASE_PATH%\_src\%SRC_BASE_DIR%"
set "BUILD_BASE_PATH=%_3DPARTY_BASE_PATH%\%DEV_COMPILER_DIR%\%SRC_BASE_DIR%"

set "BUILD_SRC=%SRC_BASE_PATH%\%SRC_DIR%"
set "BUILD_SRC=%BUILD_SRC:\=/%"

set "BUILD_ROOT=%BUILD_BASE_PATH%\%BUILD_DIR%"
set "BUILD_ROOT=%BUILD_ROOT:\=/%"

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

rem collect mingw/cygwin paths from PATH variable
set INDEX=1
set "PREFIX_PATHS="
:PATH_LOOP
set "PATH_VALUE="
for /f "eol=| tokens=%INDEX% delims=;" %%i in ("%PATH%") do set "PATH_VALUE=%%i"
set /A INDEX+=1
if not defined PATH_VALUE goto PATH_LOOP_END

if "%PATH_VALUE%" == "%PATH_VALUE:\mingw=%" ^
if "%PATH_VALUE%" == "%PATH_VALUE:\cygwin=%" ^
if "%PATH_VALUE%" == "%PATH_VALUE:/mingw=%" ^
if "%PATH_VALUE%" == "%PATH_VALUE:/cygwin=%" goto PATH_LOOP

if defined PREFIX_PATHS (
  set "PREFIX_PATHS=%PREFIX_PATHS%;%PATH_VALUE%"
) else (
  set "PREFIX_PATHS=%PATH_VALUE%"
)

goto PATH_LOOP

:PATH_LOOP_END

rem reset PATH variable to defaults

if defined PREFIX_PATHS (
  set "PATH=%PREFIX_PATHS%;%SYSTEMROOT%\system32;%SYSTEMROOT%;%SYSTEMROOT%\system32\Wbem"
) else (
  set "PATH=%SYSTEMROOT%\system32;%SYSTEMROOT%;%SYSTEMROOT%\system32\Wbem"
)

if defined USER_PATH set "PATH=%PATH%;%USER_PATH%"

if "%TOOLSET%" == "%TOOLSET:mingw_=%" goto IGNORE_MINGW_PATH_UPDATE

if defined MINGW_ROOT (
  rem update path variable
  setlocal ENABLEDELAYEDEXPANSION
  for /F "eol=| tokens=* delims=" %%i in ("!PATH!") do (
    endlocal
    set "PATH=%%i;%MINGW_ROOT%\bin"
  )
)

:IGNORE_MINGW_PATH_UPDATE

if "%TOOLSET%" == "%TOOLSET:msvc-=%" ^
if "%TOOLSET%" == "%TOOLSET:mingw_=%" ^
if "%TOOLSET%" == "%TOOLSET:cygwin_=%" goto IGNORE_WINSDK_PATH_UPDATE

if defined WINDOWS_SDK_ROOT (
  rem update path variable
  setlocal ENABLEDELAYEDEXPANSION
  for /F "eol=| tokens=* delims=" %%i in ("!PATH!") do (
    endlocal
    set "PATH=%%i;%WINDOWS_SDK_ROOT%\bin"
  )
)

if defined WINDOWS_KIT_BIN_ROOT (
  rem update path variable
  setlocal ENABLEDELAYEDEXPANSION
  for /F "eol=| tokens=* delims=" %%i in ("!PATH!") do (
    endlocal
    set "PATH=%%i;%WINDOWS_KIT_BIN_ROOT%\%MSVC_ARCHITECTURE%"
  )
)

:IGNORE_WINSDK_PATH_UPDATE

set "PATH=%PATH:\=/%"

rem ### QT/QMAKE ###

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

set "QMAKE_GENERATOR_TOOLSET=unknown"
if not "%TOOLSET%" == "%TOOLSET:mingw_=%" (
  if not "%TOOLSET%" == "%TOOLSET:_gcc=%" (
    set "QMAKE_GENERATOR_TOOLSET=g++"
  )
) else if not "%TOOLSET%" == "%TOOLSET:cygwin_=%" (
  if not "%TOOLSET%" == "%TOOLSET:_gcc=%" (
    set "QMAKE_GENERATOR_TOOLSET=g++"
  )
) else if "%TOOLSET%" == "msvc-14.1" (
  set "QMAKE_GENERATOR_TOOLSET=msvc2017"
) else if "%TOOLSET%" == "msvc-14.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc2015"
) else if "%TOOLSET%" == "msvc-12.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc2012"
) else if "%TOOLSET%" == "msvc-10.0" (
  set "QMAKE_GENERATOR_TOOLSET=msvc2010"
)

goto QMAKE_GENERATOR_VERSION_SELECT_END

:IGNORE_QMAKE_GENERATOR_VERSION_SELECT

set "QMAKE_GENERATOR_TOOLSET=unknown"
if not "%TOOLSET%" == "%TOOLSET:mingw_=%" (
  if not "%TOOLSET%" == "%TOOLSET:_gcc=%" (
    set "QMAKE_GENERATOR_TOOLSET=g++"
  )
) else if not "%TOOLSET%" == "%TOOLSET:cygwin_=%" (
  if not "%TOOLSET%" == "%TOOLSET:_gcc=%" (
    set "QMAKE_GENERATOR_TOOLSET=g++"
  )
) else if not "%TOOLSET%" == "%TOOLSET:msvc-=%" (
  set "QMAKE_GENERATOR_TOOLSET=msvc"
)

:QMAKE_GENERATOR_VERSION_SELECT_END

if "%TOOLSET%" == "msvc-14.1" (
  set "CMAKE_GENERATOR=Visual Studio 15 2017"
) else if "%TOOLSET%" == "msvc-14.0" (
  set "CMAKE_GENERATOR=Visual Studio 14 2015"
) else if "%TOOLSET%" == "msvc-12.0" (
  set "CMAKE_GENERATOR=Visual Studio 12 2013"
) else if "%TOOLSET%" == "msvc-10.0" (
  set "CMAKE_GENERATOR=Visual Studio 10 2010"
) else (
  set "CMAKE_GENERATOR=unknown"
)

if not "%CMAKE_GENERATOR%" == "unknown" (
  if "%ADDRESS_MODEL%" == "64" set "CMAKE_GENERATOR=%CMAKE_GENERATOR% Win64"
)

if not "%TOOLSET%" == "%TOOLSET:mingw_=%" (
  if "%ADDRESS_MODEL%" == "64" set "QMAKE_GENERATOR_TOOLSET=win64-g++"
  if "%ADDRESS_MODEL%" == "32" set "QMAKE_GENERATOR_TOOLSET=win32-g++"
) else if not "%TOOLSET%" == "%TOOLSET:cygwin_=%" (
  if "%ADDRESS_MODEL%" == "64" set "QMAKE_GENERATOR_TOOLSET=win64-g++"
  if "%ADDRESS_MODEL%" == "32" set "QMAKE_GENERATOR_TOOLSET=win32-g++"
) else if not "%TOOLSET%" == "%TOOLSET:msvc-=%" (
  if "%ADDRESS_MODEL%" == "64" set "QMAKE_GENERATOR_TOOLSET=win64-%QMAKE_GENERATOR_TOOLSET%"
  if "%ADDRESS_MODEL%" == "32" set "QMAKE_GENERATOR_TOOLSET=win32-%QMAKE_GENERATOR_TOOLSET%"
)

echo.BUILD_ROOT: "%BUILD_ROOT%"

set __REG_ENV_INIT__=1

exit /b 0

:CANONICAL_PATH
set "%~1=%~f2"
exit /b 0
