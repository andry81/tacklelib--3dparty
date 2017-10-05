@echo off

setlocal

if not exist "%~dp0configure.user.bat" ( call "%%~dp0configure.bat" || exit /b 255 )

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

rem parameters order are important here, it will produce corresponding nested directories!
set "BOOST_BUILD_CMD_LINE="
if not "%VARIANT%" == "" set "BOOST_BUILD_CMD_LINE=%BOOST_BUILD_CMD_LINE% variant=%VARIANT%"
if not "%TOOLSET%" == "" set "BOOST_BUILD_CMD_LINE=%BOOST_BUILD_CMD_LINE% toolset=%TOOLSET%"
if not "%ARCHITECTURE%" == "" set "BOOST_BUILD_CMD_LINE=%BOOST_BUILD_CMD_LINE% architecture=%ARCHITECTURE%"
if not "%ADDRESS_MODEL%" == "" set "BOOST_BUILD_CMD_LINE=%BOOST_BUILD_CMD_LINE% address-model=%ADDRESS_MODEL%"
if not "%LINK_TYPE%" == "" set "BOOST_BUILD_CMD_LINE=%BOOST_BUILD_CMD_LINE% link=%LINK_TYPE%"
if not "%RUNTIME_LINK%" == "" set "BOOST_BUILD_CMD_LINE=%BOOST_BUILD_CMD_LINE% runtime-link=%RUNTIME_LINK%"
if not "%THREADING%" == "" set "BOOST_BUILD_CMD_LINE=%BOOST_BUILD_CMD_LINE% threading=%THREADING%"

if "%ADDRESS_MODEL%" == "64" (
  set "BOOST_BUILD_CMD_LINE=%BOOST_BUILD_CMD_LINE% --stagedir=stage-x64"
)

rem extract include library names from first parameter
set HAS_WITH_PYTHON=0

if "%~1" == "" goto IGNORE_GEN_WITH_LIBS

set INDEX=1

:GEN_WITH_LIBS_LOOP
set "LIB_NAME="
for /F "eol=	 tokens=%INDEX% delims=, " %%i in ("%~1") do set "LIB_NAME=%%i"
if not defined LIB_NAME goto GEN_WITH_LIBS_LOOP_END

set BOOST_LIB_CONFIG_ARGS=%BOOST_LIB_CONFIG_ARGS% --with-%LIB_NAME%

if /i "%LIB_NAME%" == "python" set HAS_WITH_PYTHON=1

set /A INDEX+=1

goto GEN_WITH_LIBS_LOOP

:GEN_WITH_LIBS_LOOP_END
:IGNORE_GEN_WITH_LIBS

rem extract exclude library names from second parameter
if "%~2" == "" goto IGNORE_GEN_WITHOUT_LIBS

set INDEX=1

:GEN_WITHOUT_LIBS_LOOP
set "LIB_NAME="
for /F "eol=	 tokens=%INDEX% delims=, " %%i in ("%~2") do set "LIB_NAME=%%i"
if not defined LIB_NAME goto GEN_WITHOUT_LIBS_LOOP_END

set BOOST_LIB_CONFIG_ARGS=%BOOST_LIB_CONFIG_ARGS% --without-%LIB_NAME%

if /i "%LIB_NAME%" == "python" set HAS_WITH_PYTHON=1

set /A INDEX+=1

goto GEN_WITHOUT_LIBS_LOOP

:GEN_WITHOUT_LIBS_LOOP_END
:IGNORE_GEN_WITHOUT_LIBS

rem rem default excludes
rem if %HAS_WITH_PYTHON% EQU 0 (
rem   set BOOST_LIB_CONFIG_ARGS=%BOOST_LIB_CONFIG_ARGS% --without-python
rem )

pushd "%BUILD_BASE_PATH%\%SRC_DIR%" && (
  call :CMD bjam %%BOOST_BUILD_CMD_LINE%% %%BOOST_LIB_CONFIG_ARGS%% stage %%3 %%4 %%5 %%6 %%7 %%8 %%9
  popd
)

pause

exit /b 0

:CMD
echo.^>%*
(%*)
