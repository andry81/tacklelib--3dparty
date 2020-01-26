@echo off

setlocal

if not exist "%~dp0configure.user.bat" ( call "%%~dp0configure.bat" || exit /b 255 )

call "%%~dp0configure.user.bat" || exit /b

call "%%~dp0..\reg_env.bat" || exit /b

set "PATH=%PATH%;%QT_ROOT%/bin"

echo.PATH: "%PATH:;="&echo.PATH: "%"

if not exist "%QT_ROOT%" (
  echo.%~nx0: error: QT_ROOT does not exist.
  exit /b 1
) >&2

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
) else if "%TOOLSET%" == "msvc-14.0" (
  call "%%VS140COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
) else if "%TOOLSET%" == "msvc-12.0" (
  call "%%VS120COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
) else if "%TOOLSET%" == "msvc-10.0" (
  call "%%VS100COMNTOOLS%%\..\..\VC\vcvarsall.bat" %%MSVC_ARCHITECTURE%%
)

if not "%TOOLSET%" == "%TOOLSET:msvc-=%" (
  call :CMD where cl || exit /b
  call :CMD where rc || exit /b
)

if not exist "%BUILD_ROOT%\" mkdir "%BUILD_ROOT%"

call :CMD pushd "%%BUILD_ROOT%%" && (
  rem generate nmake
  call :CMD qmake -r "CONFIG += force_debug_info skip_target_version_ext" -spec %%QMAKE_GENERATOR_TOOLSET%% %%QMAKE_CMD_LINE%% "%%BUILD_SRC%%/qwt.pro"
  call :CMD popd
)

if %ERRORLEVEL% NEQ 0 goto EXIT

call :CMD pushd "%%BUILD_ROOT%%" && (
  rem run nmake
  if not "%TOOLSET%" == "%TOOLSET:msvc-=%" (
    call :CMD nmake && call :CMD nmake install
  ) else if not "%TOOLSET%" == "%TOOLSET:mingw_=%" (
    call :CMD make && call :CMD make install
  ) else if not "%TOOLSET%" == "%TOOLSET:cygwin_=%" (
    call :CMD make && call :CMD make install
  )
  call :CMD popd
)

:EXIT
pause

exit /b

:CMD
echo.^>%*
(%*)
