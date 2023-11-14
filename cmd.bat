@echo off
setlocal enabledelayedexpansion

:: Set temporary directory
set tempDir=%userprofile%\.cmd_tmp
if not exist %tempDir% mkdir %tempDir%

:: Get the current Windows build version and print it
ver > %tempDir%\version.txt
for /f "delims=" %%x in (%tempDir%\version.txt) do set Build=%%x
del %tempDir%\version.txt
echo %Build%
echo (c) Microsoft Corporation. All rights reserved.
echo.

:: Export current environment variables
set > %tempDir%\env.txt

:: Create batch file to update environment variables
echo @echo off > %tempDir%\updateEnvs.bat
echo. >> %tempDir%\updateEnvs.bat
echo for /f "delims=" %%%%x in (%tempDir%\env.txt) do set %%%%x >> %tempDir%\updateEnvs.bat

set currentPath=%userprofile%

:: Commands to be run before and after the user entered command
:: to support environment variables and change directories
set initCMD="call %tempDir%\updateEnvs.bat"
set postCMD="cd > %tempDir%\pwd.txt & set > %tempDir%\env.txt"

:: Strip the quotes
set initCMD=!initCMD:~1,-1!
set postCMD=!postCMD:~1,-1!

: 'prompt'
cd /d %currentPath%
set /p input="%currentPath%>"
set "command=%input:"="%"
if !command! == exit (goto 'close')

:: Create batch file to run the pre, post, and actual command to run
:: Note: This allows for enviornment variables to be modified
echo @echo off > %tempDir%\run.bat
echo setlocal enabledelayedexpansion >> %tempDir%\run.bat
echo !initCMD! >> %tempDir%\run.bat
echo !command! >> %tempDir%\run.bat
echo !postCMD! >> %tempDir%\run.bat

cmd.exe /c call %tempDir%\run.bat

set /p currentPath=<%tempDir%\pwd.txt

echo.
goto 'prompt'

: 'close'
if exist %tempDir% rmdir /s /q %tempDir%
exit