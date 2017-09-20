@echo off

setlocal

if not exist "%~dp0configure.user.bat" ( call "%%~dp0configure.bat" || exit /b 255 )

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

if "%TOOLSET%" == "msvc-14.0" (
  set BUILD_DIR=msvc14
  call "%%VS140COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
) else if "%TOOLSET%" == "msvc-12.0" (
  set BUILD_DIR=msvc12
  call "%%VS120COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
) else if "%TOOLSET%" == "msvc-10.0" (
  set BUILD_DIR=msvc10
  call "%%VS100COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
)

pushd "%PROJECT_ROOT%\%BUILD_DIR%" && (
  call :BUILD
  popd
)

pause

goto :EOF

:BUILD

set VARIANT_VALUE_INDEX=1

:BUILD_LOOP
set "VARIANT_VALUE="
for /F "tokens=%VARIANT_VALUE_INDEX% delims=," %%i in ("%VARIANT%") do set "VARIANT_VALUE=%%i"
if "%VARIANT_VALUE%" == "" exit /b 0

call :CMD devenv "log4cplus.sln" /build "%%VARIANT_VALUE%%|%%DEVENV_SOLUTION_PLATFORM%%" /project "log4cplus" || goto :EOF
echo.

set /A VARIANT_VALUE_INDEX+=1

goto BUILD_LOOP

:CMD
echo.^>%*
(%*)
