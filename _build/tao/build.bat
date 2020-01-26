@echo off

rem double setlocal to restore environment before the call to bash and after
setlocal
setlocal

if not exist "%~dp0configure.user.bat" ( call "%%~dp0configure.bat" || exit /b 255 )

call "%%~dp0configure.user.bat"

call "%%~dp0..\reg_env.bat"

rem if not exist "%CYGWIN_PATH%" (
rem   echo.%~nx0: error: CYGWIN_PATH does not exist.
rem   exit /b 1
rem ) >&2

set MWC_TYPE=%DEV_COMPILER%

rem drop last error level
cd .

set "PATH=%PATH%;%CYGWIN_PATH%\bin"

rem save going to change the current directory into a variable
set "CWD=%BUILD_BASE_PATH%\%BUILD_DIR%"

(
  rem drop all local variables..
  endlocal

  rem ..except this
  set "CWD=%CWD%"
  set "PATH=%PATH%"
  set "ACE_ROOT=%ACE_ROOT%"
  set "MSBUILD_PATH=%MSBUILD_PATH%"
  set "VARIANT=%VARIANT%"
  set "MWC_TYPE=%MWC_TYPE%"

  rem register here more environment before the call to bash shell
  if "%TOOLSET%" == "msvc-14.0" (
    call "%VS140COMNTOOLS%\..\..\VC\vcvarsall.bat" %MSVC_ARCHITECTURE%
  ) else if "%TOOLSET%" == "msvc-12.0" (
    call "%VS120COMNTOOLS%\..\..\VC\vcvarsall.bat" %MSVC_ARCHITECTURE%
  ) else if "%TOOLSET%" == "msvc-10.0" (
    call "%VS100COMNTOOLS%\..\..\VC\vcvarsall.bat" %MSVC_ARCHITECTURE%
  )

  rem call procedure with prepared environment
  rem call :EXEC "%%~dp0build.sh"
  call :EXEC

  rem drop all local variables again
  endlocal
)

pause 

goto :EOF

:EXEC
call :CMD pushd "%%CWD%%" && (
  call :CMD "%%MSBUILD_PATH%%/MSBuild.exe" TAO_ACE_vc12.sln /toolsversion:12.0 "/t:PortableServer;CosNaming;Messaging;BiDir_GIOP;CodecFactory;AnyTypeCode;Valuetype;Naming_Service" /p:Configuration=Release /maxcpucount
  popd
)

exit /b

rem rem replace all backslashes to forward
rem set "EXEC_CMD=%~1"
rem set EXEC_CMD=bash -c "%EXEC_CMD:\=/%"
rem 
rem call :CMD pushd "%%CWD%%" && (
rem   rem make a call with drop of some variables
rem   set "EXEC_CMD="
rem   set "CWD="
rem 
rem   echo.^>%EXEC_CMD%
rem   %EXEC_CMD%
rem 
rem   popd
rem )
rem 
rem exit /b

:CMD
echo.^>%*
(%*)
