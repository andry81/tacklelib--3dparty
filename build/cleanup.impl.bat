@echo off

setlocal

pushd "%PROJECT_ROOT%" && (
  call :REMOVE_ALL %%*
  popd
)

pause

goto :EOF

:REMOVE_ALL
for /F "usebackq eol=' tokens=* delims=" %%i in ("%~1") do (
  call :REMOVE "%%i"
)

goto :EOF

:REMOVE
set "FILE=%PROJECT_ROOT%\%~1"

call :DECODE_FILE_PATH "%%FILE%%"
echo "%FILE_PATH%"

rem just in case
if "%~1" == "" (
  echo.%~nx0: error: invalid cleanup path: FILE_PATH="%FILE_PATH%".
  exit /b 255
) >&2

if "%FILE_PATH:~-1%" == "\" (
  rem if FILE_PATH contains wildcards pattern
  if %FILE_BY_PTTN% NEQ 0 (
    for /F "usebackq tokens=* delims=" %%i in (`dir /B /A:D "%FILE_PATH:~0,-1%" 2^>nul`) do (
      set "DIR_PATH=%FILE_DIR%%%i"
      call :DEL_DIR
    )
  ) else (
    set "DIR_PATH=%FILE_PATH:~0,-1%"
    call :DEL_DIR
  )
) else if %FILE_BY_PTTN% NEQ 0 (
  del /S /F /Q /A:-D "%FILE_PATH%"
) else (
  del /F /Q /A:-D "%FILE_PATH%"
)
exit /b 0

:DECODE_FILE_PATH
set "FILE_PATH=%~dpf1"
set "FILE_DIR=%~1"
set FILE_BY_PTTN=0
if not "%FILE_DIR%" == "" (
  if "%FILE_DIR:~-1%" == "\" set "FILE_DIR=%FILE_DIR:~0,-1%"
  call :DECODE_FILE_DIR "%%FILE_DIR%%"
)
goto :EOF

:DECODE_FILE_DIR
set "FILE_NAME=%~nx1"
if not "%FILE_NAME%" == "" (
  rem if FILE_NAME does not contain wildcards pattern
  if "%FILE_NAME:**=%|%FILE_NAME:?=%" == "%FILE_NAME%|%FILE_NAME%" (
    set "FILE_DIR=%~dp1"
  ) else (
    set "FILE_DIR=%~dpf1\"
    set FILE_BY_PTTN=1
  )
) else (
  set "FILE_DIR=%~dp1"
)
goto :EOF

:DEL_DIR
if %FILE_BY_PTTN% NEQ 0 echo   "%DIR_PATH%"
rmdir /S /Q "%DIR_PATH%"
