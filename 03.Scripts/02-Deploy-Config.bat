@echo off
REM === AMC :: Deploy 00.Config into MO2 mods ===
set REPO=G:\Skyrim Mods\11-ArchitecturaeModularisCodex
set SRC=%REPO%\00.Config
set MO2=G:\Skyrim Mods\Skyrim-MO2-Portable
set DST=%MO2%\mods\00.Config

if not exist "%SRC%" (
  echo [ERROR] No existe "%SRC%"
  pause
  exit /b 1
)

mkdir "%DST%" 2>nul
xcopy "%SRC%\*" "%DST%\" /E /Y >nul
echo [OK] 00.Config desplegado en: %DST%
pause
