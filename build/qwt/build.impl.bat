@echo off

setlocal

if not exist "%~dp0configure.user.bat" ( call "%%~dp0configure.bat" || exit /b 255 )

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

if not exist "%QT_PATH%" (
  echo.%~nx0: error: QT_PATH does not exist.
  exit /b 1
) >&2

set "PATH=%PATH%;%QT_PATH%\bin"

if "%TOOLSET%" == "msvc-14.0" (
  call "%%VS140COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
) else if "%TOOLSET%" == "msvc-12.0" (
  call "%%VS120COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
) else if "%TOOLSET%" == "msvc-10.0" (
  call "%%VS100COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
)

pushd "%PROJECT_ROOT%" && (
  rem generate nmake
  call :CMD qmake -r "CONFIG += force_debug_info skip_target_version_ext" -spec %%QMAKE_GENERATOR_TOOLSET%% "%%PROJECT_ROOT%%\qwt.pro"
  popd
)

if %ERRORLEVEL% NEQ 0 goto EXIT

pushd "%PROJECT_ROOT%" && (
  rem run nmake
  nmake && nmake install
  popd
)

:EXIT
pause

goto :EOF

:CMD
setlocal
set CMD_LINE=%*
echo.^>%CMD_LINE:\=/%
(%*)
