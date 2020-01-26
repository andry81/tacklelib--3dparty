@echo off

setlocal

call "%%~dp0configure.user.bat" || exit /b

call "%%~dp0..\reg_env.bat" || exit /b

call "%%~dp0..\cleanup.impl.bat" "%%~dpn0.lst" %%*
