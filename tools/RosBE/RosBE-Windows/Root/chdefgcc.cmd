::
:: PROJECT:     RosBE - ReactOS Build Environment for Windows
:: LICENSE:     GNU General Public License v2. (see LICENSE.txt)
:: FILE:        Root/chdefgcc.cmd
:: PURPOSE:     Tool to change the current gcc in RosBE.
:: COPYRIGHT:   Copyright 2007 Daniel Reimer <reimer.daniel@freenet.de>
::                             Peter Ward <dralnix@gmail.com>
::
@echo off
if not defined _ROSBE_DEBUG set _ROSBE_DEBUG=0
if %_ROSBE_DEBUG% == 1 (
    @echo on
)

if "%_ROSBE_MODE%" == "RosBE" (
    title Change the current MinGW/GCC directory...
)

::
:: Parse the command line arguments.
::
for /f "usebackq tokens=*" %%i in (`""%_ROSBE_BASEDIR%\Tools\rquote.exe" %1"`) do set _1=%%i
if "%_1%" == "" (
    call :INTERACTIVE
)

if exist "%_ROSBE_BASEDIR%\%_1%\." (
    set _1="%_ROSBE_BASEDIR%\%_1%"
) else if not exist "%_1%\." (
    echo ERROR: The path specified doesn't seem to exist.
    goto :EOC
)

if not exist "%_1%\bin\gcc.exe" (
    echo ERROR: No MinGW/GCC found in the specified path.
    goto :EOC
)

set _ROSBE_MINGWPATH=%_1%
echo Location: %_ROSBE_MINGWPATH%
call "%_ROSBE_BASEDIR%\rosbe-gcc-env.cmd"

goto :EOC

:INTERACTIVE
    set /p _1="Please enter a MinGW/GCC directory (don't use quotes): "
    if "%_1%" == "" (
        echo ERROR: You must enter a MinGW/GCC directory.
        goto :EOC
    )
goto :EOF

:EOC
if defined _ROSBE_VERSION (
    title ReactOS Build Environment %_ROSBE_VERSION%
)

::
:: Unload all used Vars.
::
set _1=
