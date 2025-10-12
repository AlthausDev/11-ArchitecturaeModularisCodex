@echo off
REM === AMC :: Export MO2 profile files into repo ===
set MO2=G:\Skyrim Mods\Skyrim-MO2-Portable
set PROFILE=AMC-Base-1.6.1170
set SRC=%MO2%\profiles\%PROFILE%
set REPO=G:\Skyrim Mods\11-ArchitecturaeModularisCodex
set DST=%REPO%\Profiles\%PROFILE%

if not exist "%SRC%" (
  echo [ERROR] Perfil no encontrado: %SRC%
  pause
  exit /b 1
)

mkdir "%DST%" 2>nul
copy "%SRC%\modlist.txt"    "%DST%\" >nul
copy "%SRC%\plugins.txt"    "%DST%\" >nul
copy "%SRC%\categories.dat" "%DST%\" >nul
if exist "%SRC%\skyrim.ini" copy "%SRC%\skyrim.ini" "%DST%\" >nul
if exist "%SRC%\skyrimprefs.ini" copy "%SRC%\skyrimprefs.ini" "%DST%\" >nul

echo [OK] Exportado a: %DST%
pause
