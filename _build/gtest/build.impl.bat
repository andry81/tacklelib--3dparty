@echo off

setlocal

call "%%~dp0__init__.bat" || exit /b

echo.PATH: "%PATH:;="&echo.PATH: "%"

if not exist "%BUILD_ROOT%\" mkdir "%BUILD_ROOT%"

call :CMD pushd "%%BUILD_ROOT%%" && (
  call :BUILD
  call :CMD popd
)

pause

exit /b

:BUILD
if "%TOOLSET%" == "%TOOLSET:msvc-=%" (
  if not "%ADDRESS_MODEL%" == "64" (
    if not "%GTEST_MSVC_SEARCH%" == "MT" (
      set "MSVC_OUT_DIR=gtest-md"
    ) else (
      set "MSVC_OUT_DIR=gtest"
    )
  ) else (
    set "MSVC_OUT_DIR=x64"
  )
)

call :CMD cmake.exe -G "%%CMAKE_GENERATOR%%" -Dgtest_force_shared_crt=ON "%%BUILD_SRC%%" || exit /b 1

set VARIANT_VALUE_INDEX=1

:BUILD_LOOP
set "VARIANT_VALUE="
for /F "tokens=%VARIANT_VALUE_INDEX% delims=," %%i in ("%VARIANT%") do set "VARIANT_VALUE=%%i"
if "%VARIANT_VALUE%" == "" exit /b 0

call :CMD cmake --build . --config "%%VARIANT_VALUE%%" || exit /b

if /i "%VARIANT_VALUE%" == "debug" (
  set "MSVC_LIB_SUFFIX=d"
) else (
  set "MSVC_LIB_SUFFIX="
)

if not "%TOOLSET%" == "%TOOLSET:msvc-=%" (
  if not "%ADDRESS_MODEL%" == "64" (
    call :XCOPY_FILE "%%BUILD_ROOT%%\lib\%%VARIANT_VALUE%%" "gtest%%MSVC_LIB_SUFFIX%%.lib"      "%%BUILD_ROOT%%\lib\x86\%%VARIANT_VALUE%%" /Y /D /H || exit /b
    call :XCOPY_FILE "%%BUILD_ROOT%%\lib\%%VARIANT_VALUE%%" "gtest_main%%MSVC_LIB_SUFFIX%%.lib" "%%BUILD_ROOT%%\lib\x86\%%VARIANT_VALUE%%" /Y /D /H || exit /b
  ) else (
    call :XCOPY_FILE "%%BUILD_ROOT%%\lib\%%VARIANT_VALUE%%" "gtest%%MSVC_LIB_SUFFIX%%.lib"      "%%BUILD_ROOT%%\lib\x64\%%VARIANT_VALUE%%" /Y /D /H || exit /b
    call :XCOPY_FILE "%%BUILD_ROOT%%\lib\%%VARIANT_VALUE%%" "gtest_main%%MSVC_LIB_SUFFIX%%.lib" "%%BUILD_ROOT%%\lib\x64\%%VARIANT_VALUE%%" /Y /D /H || exit /b
  )
)

rem call :XCOPY_DIR "%%BUILD_SRC%%/msvc14" "%%BUILD_ROOT%%/msvc14" /S /Y /D || exit /b
echo.

set /A VARIANT_VALUE_INDEX+=1

goto BUILD_LOOP

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

:CMD
echo.^>%*
(%*)
