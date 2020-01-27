@echo off

setlocal

call "%%~dp0__init__.bat" || exit /b

echo.PATH: "%PATH:;="&echo.PATH: "%"

if not "%TOOLSET%" == "%TOOLSET:msvc-=%" (
  echo.Registering %TOOLSET% %MSVC_ARCHITECTURE%...
)

rem msvc 2017 search based on: https://renenyffenegger.ch/notes/Windows/development/Visual-Studio/environment-variables/index
rem

if "%TOOLSET%" == "msvc-14.1" (
  for /f "usebackq tokens=* delims=" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere" -latest -property installationPath`) do (
    set "MSVC2017_INSTALL_ROOT=%%i"
    call "%%MSVC2017_INSTALL_ROOT%%\Common7\Tools\VsDevCmd.bat"
    call "%%VCINSTALLDIR%%\Auxiliary\Build\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
  )
  set "DEVENV_BUILD_DIR=msvc14"
) else if "%TOOLSET%" == "msvc-14.0" (
  call "%%VS140COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
  set "DEVENV_BUILD_DIR=msvc14"
) else (
  echo.%~nx0: error: TOOLSET build is not supported: "%TOOLSET%"
  exit /b 127
) >&2

if not "%TOOLSET%" == "%TOOLSET:msvc-=%" (
  call :CMD where cl || exit /b
  call :CMD where rc || exit /b
)

if not exist "%BUILD_ROOT%\" mkdir "%BUILD_ROOT%"

call :CMD pushd "%%BUILD_ROOT%%" && (
  call :BUILD
  call :CMD popd
)

goto EXIT

:BUILD

set VARIANT_VALUE_INDEX=1

:BUILD_LOOP
set "VARIANT_VALUE="
for /F "tokens=%VARIANT_VALUE_INDEX% delims=," %%i in ("%VARIANT%") do set "VARIANT_VALUE=%%i"
if "%VARIANT_VALUE%" == "" exit /b 0

call :CMD devenv "%BUILD_SRC:/=\%\%DEVENV_BUILD_DIR%\log4cplus.sln" /build "%%VARIANT_VALUE%%|%%DEVENV_SOLUTION_PLATFORM%%" /project "log4cplus" || exit /b
echo.

set /A VARIANT_VALUE_INDEX+=1

goto BUILD_LOOP

:EXIT
pause

exit /b

:CMD
echo.^>%*
(%*)
