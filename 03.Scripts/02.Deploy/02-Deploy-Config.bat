@echo off
setlocal EnableExtensions EnableDelayedExpansion
title [AMC] Deploy 00.Config
color 0A

REM === RUTAS FIJAS ===
set "AMC_ROOT=G:\Skyrim Mods\04-ArchitecturaeModularisCodex"
set "SRC=%AMC_ROOT%\00.Config"
set "MO2_MODS=G:\Skyrim Mods\05-MO2-Portable\mods"
set "DST=%MO2_MODS%\00.Config"

REM === TIMESTAMP robusto (PowerShell, no depende de locale) ===
for /f %%T in ('powershell -NoProfile -Command "(Get-Date).ToString(\"yyyy-MM-dd_HHmmss\")"') do set "TS=%%T"

REM === Log ===
set "LOGDIR=%AMC_ROOT%\02.Docs\99.History\04.Logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%" >nul 2>&1
set "LOGFILE=%LOGDIR%\Deploy_Config_%TS%.log"

echo [START] AMC Deploy 00.Config
echo  AMC_ROOT = "%AMC_ROOT%"
echo  SRC      = "%SRC%"
echo  MO2_MODS = "%MO2_MODS%"
echo  DST      = "%DST%"
echo  LOGFILE  = "%LOGFILE%"
echo.

REM === Validaciones (sin paréntesis en echo) ===
if not exist "%AMC_ROOT%" (
  echo [ERROR] No existe AMC_ROOT: "%AMC_ROOT%"
  echo [ERROR] No existe AMC_ROOT: "%AMC_ROOT%" > "%LOGFILE%"
  goto PAUSE_ERR
)

if not exist "%SRC%" (
  echo [ERROR] No existe SRC -> 00.Config: "%SRC%"
  echo [ERROR] No existe SRC: "%SRC%" > "%LOGFILE%"
  goto PAUSE_ERR
)

if not exist "%MO2_MODS%" (
  echo [ERROR] No existe MO2_MODS: "%MO2_MODS%"
  echo [ERROR] No existe MO2_MODS: "%MO2_MODS%" > "%LOGFILE%"
  goto PAUSE_ERR
)

if not exist "%DST%" (
  echo [INFO] Creando destino "%DST%"
  echo [INFO] Creando destino "%DST%" > "%LOGFILE%"
  mkdir "%DST%" 2>nul
)

REM === Copia con ROBOCOPY ===
echo [INFO] Copiando... (esto puede tardar)
echo [INFO] Copiando desde "%SRC%" hacia "%DST%" >> "%LOGFILE%"
robocopy "%SRC%" "%DST%" * /E /R:1 /W:1 /NFL /NDL /NP >> "%LOGFILE%" 2>&1
set "RC=%ERRORLEVEL%"

REM Robocopy: 0,1 OK; 2-7 OK con diferencias; >=8 error
if %RC% GEQ 8 (
  echo [ERROR] ROBOCOPY fallo code %RC%. Revisa el log.
  echo [ERROR] Robocopy code %RC% >> "%LOGFILE%"
  goto PAUSE_RC
) else (
  echo [OK] Despliegue completado. Robocopy code %RC%
  echo [OK] Robocopy code %RC% >> "%LOGFILE%"
)
REM === Sustituir la carpeta destino por una JUNCTION ===
echo.
echo [INFO] Sustituyendo "%DST%" por un enlace hacia "%SRC%"...

REM Detectar si DST es actualmente un enlace (junction/symlink)
set "IS_LINK=False"
for /f %%Q in ('powershell -NoProfile -Command "if (Test-Path -LiteralPath ''%DST%'' -PathType Container) { ((Get-Item -LiteralPath ''%DST%'').Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0 } else { $false }" 2^>nul') do set "IS_LINK=%%Q"

REM Si existe y no es enlace, eliminar la carpeta real
if exist "%DST%" (
  if "%IS_LINK%"=="True" (
    echo [INFO] Ya era un enlace. Se recrea para asegurar origen correcto...
    rmdir "%DST%"
  ) else (
    echo [INFO] Eliminando carpeta real "%DST%" para sustituirla por enlace...
    rmdir /S /Q "%DST%"
  )
)

REM Crear la junction directamente
mklink /J "%DST%" "%SRC%"
if errorlevel 1 (
  echo [ERROR] mklink /J ha fallado. ¿Permisos?, ¿ruta existente bloqueada?
  goto PAUSE_ERR
)

echo [OK] "%DST%" ahora es un enlace a "%SRC%"
echo [OK] Enlace creado correctamente "%DST%" -> "%SRC%" >> "%LOGFILE%"

echo.
echo Log: "%LOGFILE%"
echo Pulsa una tecla para cerrar...
pause >nul
endlocal & exit /b 0

:PAUSE_ERR
echo.
echo Log (si existe): "%LOGFILE%"
echo Pulsa una tecla para cerrar...
pause >nul
endlocal & exit /b 1

:PAUSE_RC
echo.
echo Log: "%LOGFILE%"
echo Pulsa una tecla para cerrar...
pause >nul
endlocal & exit /b %RC%
