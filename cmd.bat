@echo off
ver
echo (c) Microsoft Corporation. All rights reserved.
echo.
set currentPath="%userprofile%"
cd /d %currentPath%

set /p input="%CD%>"
set command=%input:"=""%
if "%command%" == "exit" (goto 'close')
cmd.exe /c "%command% & cd > %userprofile%\pwd.txt"
echo.
goto 'prompt'

: 'prompt'
set /p currentPath=<%userprofile%\pwd.txt
cd /d %currentPath%
set /p input="%CD%>"
set command=%input:"=""%
if "%command%" == "exit" (goto 'close')
cmd.exe /c "%command% & cd > %userprofile%\pwd.txt"
echo.
goto 'prompt'

: 'close'
if exist  %userprofile%\pwd.txt del %userprofile%\pwd.txt
exit
