@echo off

setlocal

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

call "%%~dp0..\cleanup.impl.bat" "%%~dpn0.lst" %%*
