@echo off

setlocal

if %UAC_MODE%0 EQU 0 (
  rem request admin permissions
  set UAC_MODE=1
  call :CMD "%%~dp0cmd_admin.lnk" /c "%%~f0" %%*
  exit /b
)

call "%%~dp0configure.user.bat" || exit /b

call "%%~dp0..\reg_env.bat" || exit /b

call :CREATE_DIR_LINK "%%BUILD_ROOT%%\boost" "%%BUILD_SRC%%\boost" || exit /b
call :CREATE_DIR_LINK "%%BUILD_ROOT%%\libs" "%%BUILD_SRC%%\libs" || exit /b
call :CREATE_DIR_LINK "%%BUILD_ROOT%%\tools" "%%BUILD_SRC%%\tools" || exit /b

call :CREATE_FILE_LINK "%%BUILD_ROOT%%\b2.exe" "%%BUILD_SRC%%\b2.exe" || exit /b
call :CREATE_FILE_LINK "%%BUILD_ROOT%%\boost-build.jam" "%%BUILD_SRC%%\boost-build.jam" || exit /b
call :CREATE_FILE_LINK "%%BUILD_ROOT%%\boostcpp.jam" "%%BUILD_SRC%%\boostcpp.jam" || exit /b

call :CREATE_FILE_LINK "%%BUILD_ROOT%%\Jamroot" "%%BUILD_SRC%%\Jamroot" || exit /b
call :CREATE_FILE_LINK "%%BUILD_ROOT%%\project-config.jam" "%%BUILD_SRC%%\project-config.jam" || exit /b

pause

exit /b

:CREATE_DIR_LINK
set "MKLINK_CMD=mklink /D"
call :MKLINK %%*
exit /b

:CREATE_FILE_LINK
set "MKLINK_CMD=mklink"
call :MKLINK %%*
exit /b

:MKLINK
set "LINK_FROM=%~f1"
set "LINK_TO=%~f2"

if exist "%LINK_FROM%" exit /b 0

call :CMD %%MKLINK_CMD%% "%%LINK_FROM%%" "%%LINK_TO%%"
if exist "%LINK_FROM%" (
  echo."%LINK_FROM%" -^> "%LINK_TO%"
) else (
  echo.%~nx0%: error: could not create link: "%LINK_FROM%" -^> "%LINK_TO%"
  exit /b 255
) >&2

exit /b 0

:CMD
echo.^>%*
(%*)
exit /b
