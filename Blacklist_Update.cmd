@echo off

rem =====
rem For more information on ScriptTiger and more ScriptTiger scripts visit the following URL:
rem https://scripttiger.github.io/
rem Or visit the following URL for the latest information on this ScriptTiger script:
rem https://github.com/ScriptTiger/DualServer
rem =====

rem Check for admin rights, and exit if none present
"%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\Prefetch\" > nul || goto Admin

rem Enabledelayed expansion to be used during for loops
setlocal ENABLEDELAYEDEXPANSION

rem Set Source and target locations
set DIR=%~dp0
set CACHE=%TEMP%\DualServer
set INI=%~dp0DualServer.ini
set CINI=%CACHE%\DualServer.ini
set CBLACKLIST=%CACHE%\blacklist
set IGNORE=%~dp0ignore.txt
set URL=https://scripttiger.github.io/dualserver/blacklist-

rem Check access to BITS and set BITS strings or report error
set BITS=0
bitsadmin /list > nul && set /a BITS=%BITS%+1
powershell get-bitstransfer > nul && set /a BITS=%BITS%+2
if %BITS% geq 2 (
	set BITS_FROM=powershell Start-BitsTransfer -source
	set BITS_TO= -destination
)
if %BITS%==1 (
	set BITS_FROM=bitsadmin /transfer "" 
	set BITS_TO=
)
if %BITS%==0 goto BITS

rem Create temporary cache if does not exist
if not exist "%CACHE%" md "%CACHE%"

rem Make sure the DualServer.ini can be found
if not exist "%INI%" goto INI

rem If the ignore list doesn't exist, make one
rem This CANNOT be empty
if not exist "%IGNORE%" (
	(
		echo # Ignore list written in regular expressions
		echo # If you decide to delete the below entries, DO NOT delete these above comment lines
		echo # If this file is left completely empty, the script will break
		echo ^^^www.google.com=0.0.0.0$
	) > "%IGNORE%"
)

rem Initialize MARKED to 0 for no markings yet verified
set MARKED=0

rem Check that markings are correctly positioned within [DNS_HOSTS] section
for /f "tokens=*" %%0 in (
	'findstr /b /i "[[] ####.BEGIN.UNIFIED.HOSTS.#### ####.END.UNIFIED.HOSTS.####" "%INI%"'
) do (
	if !MARKED!==2 if /i not "%%0"=="#### END UNIFIED HOSTS ####" (set MARKED=-2) else (set MARKED=3)
	if !MARKED!==1 if /i not "%%0"=="#### BEGIN UNIFIED HOSTS ####" (set MARKED=-1) else (set MARKED=2)
	if "%%0"=="[DNS_HOSTS]" set MARKED=1
)

rem If the markings are not correct, explain why and exit
if not !MARKED!==3 goto Mark

echo Checking blacklist version...

rem Grab date from remote Unified Hosts, and error out if can't
%BITS_FROM% %URL:~,-1%.txt %BITS_TO% %CBLACKLIST% || goto Connectivity
for /f "tokens=*" %%0 in ('findstr #.Date: "%CBLACKLIST%"') do set NEW=%%0

rem rem Grab date from the local DualServer.ini Unified Hosts blacklist
for /f "tokens=*" %%0 in ('findstr #.Date: "%INI%"') do set OLD=%%0

rem If the remote and local dates are not the same, update
if "%OLD%"=="%NEW%" (
	echo You already have the latest version.
	choice.exe /M "Would you like to update anyway?"
	if !ERRORLEVEL!==1 (goto Update) else (goto Exit)
) else (
	echo Your version is out of date
)

:Update

rem If the generic URL is in place and not a specific one, prompt the user to select one
if not "%URL:~-4%"==".txt" (

	echo The Unified Hosts will automatically block malware and adware.

	choice.exe /m "Would you also like to block fake news?"
	if !errorlevel!==1 set URL=!URL!f

	choice.exe /m "Would you also like to block gambling?"
	if !errorlevel!==1 set URL=!URL!g

	choice.exe /m "Would you also like to block porn?"
	if !errorlevel!==1 set URL=!URL!p

	choice.exe /m "Would you also like to block social?"
	if !errorlevel!==1 set URL=!URL!s

	if "!URL:~-1!"=="-" set URL=!URL:~,-1!
	set URL=!URL!.txt
)

echo Updating blacklist...

%BITS_FROM% %URL% %BITS_TO% %CBLACKLIST% || goto Connectivity

rem Enable writing to file
rem To be disabled later to skip old hosts section, and then re-enable to continue after #### END UNIFIED HOSTS ####
set WRITE=1

rem Rewrite DualServer.ini to a temporary file and inject new Unified Hosts after #### BEGIN UNIFIED HOSTS ####
(
	for /f "tokens=1* delims=:" %%a in (
		'findstr /n .* "%INI%"'
	) do (
		if !WRITE!==1 (
			if "%%b"=="" (echo.) else (echo %%b)
			if /i "%%b"=="#### BEGIN UNIFIED HOSTS ####" (
				findstr /r /v /g:"%IGNORE%" "%CBLACKLIST%"
				set WRITE=0
			)
		)
		if /i "%%b"=="#### END UNIFIED HOSTS ####" (
			echo %%b
			set WRITE=1
		)
	)
) > "%CINI%"

rem Replace the old DualServer.ini with the new one
copy "%CINI%" "%INI%" /y > nul

rem Restart DualServer and exit
echo Your blacklist has been updated
echo The changes will not take effect until after DualServer is restarted
choice.exe /m "Would you like to restart DualServer now?"
if !errorlevel!==1 (
	echo DualServer is being restarted...
	call :Service stop
	call :Service start
	echo Your DualServer has been successfully restarted with the new blacklist
	pause
)
goto Exit

rem Service control function with error handling
:Service
net %1 DUALServer > nul && goto Exit

echo DualServer could not %1
choice.exe /m "Would you like to try to %1 it again?"
if !errorlevel!==1 goto Service

echo DualServer did not finish restarting
echo Please try to do so manually

choice.exe /m "Would you like to open the latest DualServer log?"
if !errorlevel!==1 (
	for /f %%0 in ('dir /b /od /tc "%DIR%log"') do set LOG=%%~0
	start notepad "%DIR%!LOG!"
)

choice.exe /m "Would you like to open the services management window?"
if !errorlevel!==1 start services.msc
goto Exit

:BITS
echo BITS cannot be found
echo This script requires BITS to be installed on you system in order to function
pause
goto Exit

:Connectivity
echo This script cannot connect to the Internet
echo This script requires an active Internet connection to update your hosts file
pause
goto Exit

:INI
echo The DualServer.ini cannot be found
echo You can do either of the following
echo 1.] Put these files in the DualServer root directory
echo 2.] Edit the "DIR" variable of this script
pause
goto Exit

:Admin
echo You must run this with administrator privileges!
pause
goto Exit

:Mark
if !MARKED!==0 echo "[DNS_HOSTS]" section not found^^!
if !MARKED!==-1 echo "#### BEGIN UNIFIED HOSTS ####" not properly marked in "[DNS_HOSTS]" section^^!
if !MARKED!==-2 echo "#### END UNIFIED HOSTS ####" not properly marked in "[DNS_HOSTS]" section^^!
echo.
echo Your DualServer.ini is not properly marked
echo Please ensure the following lines mark where to insert the blacklist:
echo.
echo #### BEGIN UNIFIED HOSTS ####
echo #### END UNIFIED HOSTS ####
echo.
echo Notes: You should only have to manually mark this once
echo Updates automatically overwite between the above lines
echo The blacklist must be somewhere in the [DNS_HOSTS] section to work
pause
goto Exit

:Exit
echo Cleaning temporary files and exiting...
rmdir /s /q "%CACHE%"
exit