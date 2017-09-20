@echo off

setlocal

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

set "PWD=%BUILD_BASE_PATH%\%BUILD_DIR%"

pushd "%PWD%" && (
  call :CMD "%%MSBUILD_PATH%%/MSBuild.exe" TAO_ACE_vc12.sln /toolsversion:12.0 "/t:Clean" /p:Configuration=Release
  popd
)

pause

exit /b

:CMD
echo.^>%*
(%*)
