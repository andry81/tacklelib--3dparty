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

if "%TOOLSET%" == "msvc-14.0" (
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

pushd "%PROJECT_ROOT%" && (
  rem generate nmake
  call :CMD qmake -r "CONFIG += force_debug_info skip_target_version_ext" -spec %%QMAKE_GENERATOR_TOOLSET%% %%QMAKE_CMD_LINE%% "%%PROJECT_ROOT%%/qwt.pro"
  popd
)

if %ERRORLEVEL% NEQ 0 goto EXIT

pushd "%PROJECT_ROOT%" && (
  rem run nmake
  if not "%TOOLSET%" == "%TOOLSET:msvc-=%" (
    nmake && nmake install
  ) else if not "%TOOLSET%" == "%TOOLSET:mingw_=%" (
    make && make install
  ) else if not "%TOOLSET%" == "%TOOLSET:cygwin_=%" (
    make && make install
  )
  popd
)

:EXIT
pause

goto :EOF

:CMD
echo.^>%*
(%*)
