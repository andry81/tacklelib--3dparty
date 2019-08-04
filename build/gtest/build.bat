@echo off

setlocal

if not exist "%~dp0configure.user.bat" ( call "%%~dp0configure.bat" || exit /b 255 )

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

set BUILD_DIR=build
if "%ADDRESS_MODEL%" == "64" set "BUILD_DIR=%BUILD_DIR%_x64"

set LASTERROR=0

call :CMD md "%%PROJECT_ROOT%%\%%BUILD_DIR%%"
call :CMD pushd "%%PROJECT_ROOT%%\%%BUILD_DIR%%" && (
  rem call :CMD cmake.exe -G "%%CMAKE_GENERATOR_TOOLSET%%" -Dgtest_force_shared_crt=ON .. || ( set LASTERROR=2 & goto EXIT )
  call :CMD cmake.exe -G "%%CMAKE_GENERATOR_TOOLSET%%" .. || ( set LASTERROR=2 & goto EXIT )
  call :CMD cmake --build . --config Debug || ( set LASTERROR=3 & goto EXIT )
  call :CMD cmake --build . --config Release || ( set LASTERROR=4 & goto EXIT )
  cd ..
  echo.F|xcopy "%PROJECT_ROOT%\%BUILD_DIR%\Debug\gtestd.lib" "%PROJECT_ROOT%\msvc\gtest-md\Debug\" /E /I /Y
  echo.F|xcopy "%PROJECT_ROOT%\%BUILD_DIR%\Debug\gtest_maind.lib" "%PROJECT_ROOT%\msvc\gtest-md\Debug\" /E /I /Y
  echo.F|xcopy "%PROJECT_ROOT%\%BUILD_DIR%\Release\gtest.lib" "%PROJECT_ROOT%\msvc\gtest-md\Release\" /E /I /Y
  echo.F|xcopy "%PROJECT_ROOT%\%BUILD_DIR%\Release\gtest_main.lib" "%PROJECT_ROOT%\msvc\gtest-md\Release\" /E /I /Y

  popd
)

:EXIT
pause

exit /b %LASTERROR%

:CMD
echo.^>%*
(%*)
