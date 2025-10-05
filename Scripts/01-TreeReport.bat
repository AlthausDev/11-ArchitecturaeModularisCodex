@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

REM ============================================================
REM 🧩 TreeReport.bat — Genera inventario AMC (modo automático)
REM Salida: ArchitectureTree/<fecha>/_TreeReport.txt + _TreeReport.csv
REM ============================================================

REM 🔹 Configuración base
set "ROOT=G:\Skyrim Mods"
set "AMC_ROOT=%ROOT%\11-ArchitecturaeModularisCodex"
set "SCRIPT=%AMC_ROOT%\Scripts\01-TreeReport.ps1"

REM 🎨 Consola
color 0A
title [AMC] Generador de TreeReport (Automático)

echo.
echo ╔═══════════════════════════════════════════════════════╗
echo ║    ARCHITECTURAE MODULARIS CODEX  —  TREE REPORT       ║
echo ║                 (modo automático)                      ║
echo ╚═══════════════════════════════════════════════════════╝
echo.

REM 🚀 Ejecutar PowerShell en modo report + CSV siempre
powershell -NoProfile -ExecutionPolicy Bypass ^
  -File "%SCRIPT%" -Kind report -Csv

echo.
echo ✅ Inventario completo generado en:
echo   99.History\ArchitectureTree\[fecha]\_TreeReport.txt / .csv
echo.
pause
endlocal
