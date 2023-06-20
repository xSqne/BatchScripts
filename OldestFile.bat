@echo off
setlocal EnableDelayedExpansion
if "%~1"=="" (
	echo Please provide a path!
	exit /b
) else (
	if "%~1"=="/?" (
	echo Outputs the oldest file/folder in a path
	echo Usage: OldestFile.bat [PathtoFolder]
	exit /b
	) else (
		if exist "%~1" (
			dir %1 /o:d /t:c > temp1.txt
		) else (
			echo Path does not exist!
			exit /b
		)
	)
)

set arg1=%~1
set driveCheck=%arg1:~-2%

if "%driveCheck%"==":\" (findstr /R /C:".*" /N temp1.txt | find /N "6:" | find "[6]" > temp2.txt) else (
	findstr /R /C:".*" /N temp1.txt | find /N "8:" | find "[8]" > temp2.txt
)

for /F "tokens=1,2,3,4,5" %%A in (temp2.txt) do (
	set initial=%%A
	set final=!initial:~5!
	
	echo "<^DIR>"
	if "%%D"=="<^DIR>" (
	echo The path is %~1%%E
	echo The oldest folder is %%E, created on !final! at %%B %%C
	) else (
	echo The path is %~1\%%E
	echo The oldest file is %%E, created on !final! at %%B %%C
	)
)

del /Q temp1.txt temp2.txt

echo.
dir %1 /o:d /t:c 
endlocal