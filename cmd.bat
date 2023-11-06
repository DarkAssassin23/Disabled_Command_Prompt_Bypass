@echo off
setlocal enabledelayedexpansion

:: Get the current Windows build version and print it
ver > %userprofile%\version.txt
for /f "delims=" %%x in (%userprofile%\version.txt) do set Build=%%x
rm %userprofile%\version.txt
echo %Build%
echo (c) Microsoft Corporation. All rights reserved.
echo.

:: Set the users home directory as the present working directory
echo %userprofile% > %userprofile%\pwd.txt

set setPathCMD=" & cd > %userprofile%\pwd.txt"
:: Strip the quotes
set setPathCMD=!setPathCMD:~1,-1!

: 'prompt'
set /p currentPath=<%userprofile%\pwd.txt
cd /d %currentPath%
set /p input="%CD%>"
set "command=%input:"="%"
if !command! == exit (goto 'close')
cmd.exe /c !command!!setPathCMD!
echo.
goto 'prompt'

: 'close'
if exist  %userprofile%\pwd.txt del %userprofile%\pwd.txt
exit