@echo off

setlocal

if not exist "%~dp0configure.user.bat" ( call "%%~dp0configure.bat" || exit /b 255 )

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

set BUILD_DIR=build
if "%ADDRESS_MODEL%" == "64" set "BUILD_DIR=%BUILD_DIR%_x64"

call :CMD md "%%PROJECT_ROOT%%\%%BUILD_DIR%%"
call :CMD pushd "%%PROJECT_ROOT%%\%%BUILD_DIR%%" && (
  call :CMD cmake.exe -G "%%CMAKE_GENERATOR_TOOLSET%%" -Dgtest_force_shared_crt=ON .. || exit /b 2
  call :CMD cmake --build . --config Debug || exit /b 3
  call :CMD cmake --build . --config Release || exit /b 4
  cd ..
  if not exist "%PROJECT_ROOT%\Debug\" mkdir "%PROJECT_ROOT%\Debug\"
  if not exist "%PROJECT_ROOT%\Release\" mkdir "%PROJECT_ROOT%\Release\"
  echo.F|xcopy "%PROJECT_ROOT%\%BUILD_DIR%\Debug\gmock.lib" "%PROJECT_ROOT%\Debug\" /E /I /Y
  echo.F|xcopy "%PROJECT_ROOT%\%BUILD_DIR%\Debug\gmock_main.lib" "%PROJECT_ROOT%\Debug\" /E /I /Y
  echo.F|xcopy "%PROJECT_ROOT%\%BUILD_DIR%\Release\gmock.lib" "%PROJECT_ROOT%\Release\" /E /I /Y
  echo.F|xcopy "%PROJECT_ROOT%\%BUILD_DIR%\Release\gmock_main.lib" "%PROJECT_ROOT%\Release\" /E /I /Y

  popd
)

pause

exit /b

:CMD
echo.^>%*
(%*)
