@echo off
setlocal EnableExtensions

REM ============================================================
REM TreeReport.bat — Ejecuta 01-TreeReport.ps1 (ASCII safe)
REM - Consola visible (pause al final)
REM - Log en <AMC>\02.Docs\99.History\04.Logs
REM - Sin Unicode, sin cambiar codepage
REM ============================================================

REM Deteccion de rutas (segun ubicacion de este .bat)
set "SCRIPTDIR=%~dp0"
for %%I in ("%SCRIPTDIR%\..") do set "SCRIPTS=%%~fI"
for %%I in ("%SCRIPTS%\..")  do set "AMC_ROOT=%%~fI"
for %%I in ("%AMC_ROOT%\..") do set "ROOT=%%~fI"
set "SCRIPT=%SCRIPTDIR%01-TreeReport.ps1"

REM Validaciones
if not exist "%SCRIPT%" (
  echo [ERROR] No se encuentra el script PowerShell: "%SCRIPT%"
  echo Asegura que 01-TreeReport.ps1 existe en esta carpeta.
  echo.
  pause
  exit /b 2
)

REM Motor PowerShell (pwsh si existe; si no, powershell.exe)
set "PSEXE="
for /f "delims=" %%P in ('where pwsh 2^>NUL') do set "PSEXE=%%P"
if not defined PSEXE set "PSEXE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"

REM Timestamp simple (dependiente de locale, pero ASCII)
REM Esperado: dd/mm/aaaa y hh:mm:ss,xx  -> lo normal en ES
set "TS=%DATE:~-4%-%DATE:~3,2%-%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%"
set "TS=%TS: =0%"
set "TS=%TS:/=-%"
set "TS=%TS::=-%"

REM Log
set "LOGDIR=%AMC_ROOT%\02.Docs\99.History\04.Logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%" >NUL 2>&1
set "LOGFILE=%LOGDIR%\TreeReport_%TS%.log"

title [AMC] TreeReport (ASCII)
color 0A

echo.
echo ==========================================================
echo  ARCHITECTURAE MODULARIS CODEX - TREE REPORT (ASCII)
echo ==========================================================
echo   ROOT     : %ROOT%
echo   AMC_ROOT : %AMC_ROOT%
echo   SCRIPT   : %SCRIPT%
echo   PSEXE    : %PSEXE%
echo   LOGFILE  : %LOGFILE%
echo.

echo [%DATE% %TIME%] INFO Inicio de ejecucion > "%LOGFILE%"
echo [%DATE% %TIME%] INFO PowerShell: "%PSEXE%" >> "%LOGFILE%"

REM Llamada SIMPLE: -File con argumentos directos; nada de -Command ni tuberias
REM Mantiene salida en consola y tambien escribe en log via redireccion
"%PSEXE%" -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%" -Kind report -AmcRoot "%AMC_ROOT%" 1>>"%LOGFILE%" 2>>&1
set "RC=%ERRORLEVEL%"

echo.>>"%LOGFILE%"
if not "%RC%"=="0" (
  echo ERROR: El script devolvio codigo %RC%.
  echo [%DATE% %TIME%] ERROR Codigo %RC% >> "%LOGFILE%"
  echo Revisa el log: "%LOGFILE%"
  echo.
  pause
  endlocal & exit /b %RC%
)

REM Intentar resolver la carpeta de salida mas reciente para mostrar contenido (sin PowerShell)
set "TREEBASE=%AMC_ROOT%\02.Docs\99.History\03.ArchitectureTree"
set "OUT_DAY="
if exist "%TREEBASE%" (
  for /f "delims=" %%D in ('dir /b /ad /o-d "%TREEBASE%" 2^>NUL') do (
    set "OUT_DAY=%TREEBASE%\%%D"
    goto :resolved_outday
  )
)
:resolved_outday


echo OK: Inventarios generados correctamente.
if defined OUT_DAY (
  echo   Carpeta: %OUT_DAY%
  echo   Archivos:
  dir /b "%OUT_DAY%\Tree_*.txt" 2>NUL
  dir /b "%OUT_DAY%\Tree_*.csv" 2>NUL
) else (
  echo   Aviso: No pude resolver la carpeta de salida.
  echo   Revisa: %AMC_ROOT%\02.Docs\99.History\03.ArchitectureTree
)

echo.
echo Log: %LOGFILE%
echo.
pause
endlocal & exit /b 0
