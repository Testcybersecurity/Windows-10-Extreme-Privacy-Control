@echo off
title Windows 10 Extreme Privacy Control
color 0A

set BASEDIR=%~dp0
set BACKUP_DIR=%BASEDIR%RegistryBackup
set LOGFILE=%BASEDIR%privacy_tool.log
set HOSTS_FILE=%SystemRoot%\System32\drivers\etc\hosts

:: ---------- ADMIN CHECK ----------
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Run this script as Administrator!
    pause
    exit
)

:: ---------- LOG FUNCTION ----------
:LOG
echo [%date% %time%] %1>>"%LOGFILE%"
exit /b

:: ---------- MENU ----------
:MENU
cls
echo =========================================
echo   Windows 10 Extreme Privacy Control
echo =========================================
echo.
echo 1 - Disable Telemetry (Enhanced)
echo 2 - Disable Telemetry (EXTREME MODE)
echo 3 - Restore Telemetry (Default)
echo 4 - Restore from Backup
echo 5 - Exit
echo.
set /p choice=Select option [1-5]:

if "%choice%"=="1" goto DISABLE
if "%choice%"=="2" goto EXTREME
if "%choice%"=="3" goto RESTORE
if "%choice%"=="4" goto RESTORE_BACKUP
if "%choice%"=="5" exit
goto MENU

:: ---------- BACKUP ----------
:BACKUP
if not exist "%BACKUP_DIR%" mkdir "%BACKUP_DIR%"
call :LOG Creating registry backup
reg export HKLM\SOFTWARE\Policies\Microsoft "%BACKUP_DIR%\HKLM_Policies.reg" /y >nul
reg export HKCU\Software\Microsoft "%BACKUP_DIR%\HKCU_User.reg" /y >nul
exit /b

:: ---------- ENHANCED DISABLE ----------
:DISABLE
cls
call :BACKUP
call :LOG Enhanced telemetry disable started

sc stop DiagTrack >nul
sc config DiagTrack start= disabled >nul

sc stop dmwappushservice >nul
sc config dmwappushservice start= disabled >nul

sc stop WerSvc >nul
sc config WerSvc start= disabled >nul

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul

call :LOG Enhanced telemetry disabled
echo Done. Reboot required.
pause
goto MENU

:: ---------- EXTREME MODE ----------
:EXTREME
cls
call :BACKUP
call :LOG EXTREME MODE started

:: Services
for %%S in (DiagTrack dmwappushservice WerSvc diagnosticshub.standardcollector.service) do (
    sc stop %%S >nul 2>&1
    sc config %%S start= disabled >nul 2>&1
)

:: Registry hardening
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v DisableInventory /t REG_DWORD /d 1 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v CEIPEnable /t REG_DWORD /d 0 /f >nul

:: Scheduled tasks nuke
for %%T in (
"Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
"Microsoft\Windows\Application Experience\ProgramDataUpdater"
"Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
"Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
) do schtasks /Change /TN %%T /Disable >nul 2>&1

:: HOSTS blocking
call :LOG Writing HOSTS telemetry block
attrib -r "%HOSTS_FILE%"
echo.>>"%HOSTS_FILE%"
echo 0.0.0.0 vortex.data.microsoft.com>>"%HOSTS_FILE%"
echo 0.0.0.0 settings-win.data.microsoft.com>>"%HOSTS_FILE%"
echo 0.0.0.0 telemetry.microsoft.com>>"%HOSTS_FILE%"
attrib +r "%HOSTS_FILE%"

:: Firewall rules
call :LOG Creating firewall rules
netsh advfirewall firewall add rule name="Block Microsoft Telemetry" dir=out action=block remoteip=13.64.0.0/11 enable=yes >nul

call :LOG EXTREME MODE completed
echo EXTREME MODE ENABLED.
echo Reboot REQUIRED.
pause
goto MENU

:: ---------- RESTORE DEFAULT ----------
:RESTORE
cls
call :LOG Restoring defaults

for %%S in (DiagTrack dmwappushservice WerSvc) do (
    sc config %%S start= auto >nul 2>&1
    sc start %%S >nul 2>&1
)

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f >nul

netsh advfirewall firewall delete rule name="Block Microsoft Telemetry" >nul 2>&1

call :LOG Defaults restored
echo Defaults restored. Reboot recommended.
pause
goto MENU

:: ---------- RESTORE FROM BACKUP ----------
:RESTORE_BACKUP
cls
if not exist "%BACKUP_DIR%" (
    echo No backup found.
    pause
    goto MENU
)

call :LOG Restoring registry from backup
reg import "%BACKUP_DIR%\HKLM_Policies.reg"
reg import "%BACKUP_DIR%\HKCU_User.reg"

echo Registry restored from backup.
echo Reboot REQUIRED.
pause
goto MENU
