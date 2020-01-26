@echo off

setlocal

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

set "PROJECT_ROOT=%BUILD_BASE_PATH%\%APR_DIR%"

call "%%~dp0..\cleanup.impl.bat" "%%~dpn0.lst" %%*
