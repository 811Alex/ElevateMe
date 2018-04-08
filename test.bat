:: This script can be used to test elevateMe.vbs
:: try executing it directly (using a normal user) and then through elevateMe.vbs
:: the first one should fail, while the latter should succeed.
::
:: It changes the start type of the service "TabletInputService", which can only be done 
:: with elevated privileges. The default value in Windows 10 is auto (2).
:: Then it prints any arguments it was executed with, so you can test those too.

@echo off
echo This script will only run successfully if ran with elevated privileges!
call:showValue
echo. & echo Attempting to change to "disabled"...
sc config TabletInputService start=disabled
call:showValue
echo. & echo Attempting to change to "auto"...
sc config TabletInputService start=auto
call:showValue
echo. & echo Arguments: %*
pause
exit /b

:showValue
for /F "tokens=4" %%i in ('sc qc TabletInputService ^| findstr START_TYPE') do set outp=%%i
echo. & echo Current value: %outp%
exit /b
