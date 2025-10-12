@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul

REM ============================================================
REM 🧩 TreeReport.bat — Genera inventario AMC (modo automático)
REM Salida: ArchitectureTree/<fecha>/_TreeReport.txt + _TreeReport.csv
REM ============================================================

REM 📁 Deducción de rutas basada en la ubicación de este BAT
REM    Estructura esperada: ...\11-ArchitecturaeModularisCodex\03.Scripts\TreeReport.bat
set "SCRIPTDIR=%~dp0"
for %%I in ("%SCRIPTDIR%\..") do set "AMC_ROOT=%%~fI"
for %%I in ("%AMC_ROOT%\..") do set "ROOT=%%~fI"
set "SCRIPT=%SCRIPTDIR%01-TreeReport.ps1"

REM 🧪 Validaciones básicas
if not exist "%SCRIPT%" (
  echo [ERROR] No se encuentra el script PowerShell: "%SCRIPT%"
  echo Asegura que "01-TreeReport.ps1" existe en la carpeta Scripts.
  exit /b 2
)

REM 🎨 Consola
color 0A
title [AMC] Generador de TreeReport (Automático)

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║    ARCHITECTURAE MODULARIS CODEX  —  TREE REPORT       ║
echo ║                 (modo automático)                      ║
echo ╚═══════════════════════════════════════════════════════╝
echo.
echo   ROOT     : %ROOT%
echo   AMC_ROOT : %AMC_ROOT%
echo   SCRIPT   : %SCRIPT%
echo.

REM 🔎 Elegir motor de PowerShell: pwsh (Core) o powershell.exe (Windows)
set "PSEXE="
for /f "delims=" %%P in ('where pwsh 2^>nul') do set "PSEXE=%%P"
if not defined PSEXE set "PSEXE=powershell.exe"

REM 🚀 Ejecutar (siempre report + CSV)
"%PSEXE%" -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%" -Kind report -Csv
set "RC=%ERRORLEVEL%"

echo.
if %RC% NEQ 0 (
  echo ❌ Hubo un error generando el inventario. Codigo: %RC%
  echo Revisa la salida anterior y la configuracion de rutas/permisos.
  pause
  endlocal & exit /b %RC%
)

echo ✅ Inventario completo generado.
echo   Revisa: 11-ArchitecturaeModularisCodex\02.Docs\99.History\ArchitectureTree\[YYYY-MM-DD]\_TreeReport.txt / .csv
echo.
pause
endlocal
