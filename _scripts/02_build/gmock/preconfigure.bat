@echo off

setlocal

call "%%~dp0__init__.bat" || exit /b

if %UAC_MODE%0 EQU 0 (
  rem request admin permissions
  set UAC_MODE=1
  call :CMD "%%CONTOOLS_ROOT%%\cmd_admin.lnk" /c "%%~f0" %%*
  exit /b
)

if not exist "%BUILD_ROOT%\" mkdir "%BUILD_ROOT%"

call :CREATE_DIR_LINK "%%BUILD_ROOT%%\src" "%%BUILD_SRC%%\src" || exit /b
call :CREATE_DIR_LINK "%%BUILD_ROOT%%\include" "%%BUILD_SRC%%\include" || exit /b

rem call :XCOPY_DIR "%%BUILD_SRC%%/msvc14" "%%BUILD_ROOT%%/msvc14" /S /Y /D || exit /b

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

:XCOPY_DIR
if not exist "%CONTOOLS_ROOT%/std/xcopy_dir.bat" (
  echo.%?~nx0%: error: xcopy_dir.bat is not found: "%CONTOOLS_ROOT%/std/xcopy_dir.bat".
  exit /b 6
) >&2
if not exist "%~2" mkdir "%~2"
call "%%CONTOOLS_ROOT%%/std/xcopy_dir.bat" %%* || exit /b
exit /b 0

:XCOPY_FILE
if not exist "%CONTOOLS_ROOT%/std/xcopy_file.bat" (
  echo.%?~nx0%: error: xcopy_file.bat is not found: "%CONTOOLS_ROOT%/std/xcopy_file.bat".
  exit /b 5
) >&2
if not exist "%~3" mkdir "%~3"
call "%%CONTOOLS_ROOT%%/std/xcopy_file.bat" %%* || exit /b
exit /b 0

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
