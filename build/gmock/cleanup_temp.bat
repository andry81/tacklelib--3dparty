@echo off

setlocal

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

call "%%~dp0..\cleanup.impl.bat" "%%~dpn0.lst" %%*

rem just in case switch in to directory with script
pushd "%PROJECT_ROOT%" && (
  call :DEL_FILE_PTTN "%%PROJECT_ROOT%%" "*" "obj."
  call :DEL_FILE_PTTN "%%PROJECT_ROOT%%" "*" "exp."
  call :DEL_FILE_PTTN "%%PROJECT_ROOT%%" "*" "ilk."
  call :DEL_FILE_PTTN "%%PROJECT_ROOT%%" "*" "sdf."
  call :DEL_FILE_PTTN "%%PROJECT_ROOT%%" "*" "tlog."
  popd
)

pause

exit /b

:DEL_FILE_PTTN
call "%%~dp0..\del_file_pttn.bat" %%*
