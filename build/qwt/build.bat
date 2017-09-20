@echo off

setlocal

if exist "%~dp0build.log" (
  rem shift logs
  if exist "%~dp0build.old.2.log" copy /Y /B "%~dp0build.old.2.log" "%~dp0build.old.3.log"
  if exist "%~dp0build.old.log" copy /Y /B "%~dp0build.old.log" "%~dp0build.old.2.log"
  copy /Y /B "%~dp0build.log" "%~dp0build.old.log"

  del /F /Q /A:-D "%~dp0build.log"
)

"%COMSPEC%" /C call "%~dp0build.impl.bat" %* 2>&1 | "%~dp0..\wtee.exe" -a "%~dp0build.log"
