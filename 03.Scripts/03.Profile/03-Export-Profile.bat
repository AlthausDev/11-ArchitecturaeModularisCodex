@echo off
setlocal EnableExtensions EnableDelayedExpansion
title [AMC] Import Profile 04 -> 05 + Link
color 0A

REM ============================================================
REM  Perfil opcional por parámetro: /PROFILE:NombrePerfil
REM ============================================================
set "PROFILE=AMC-Base-1.6.1170"
for %%A in (%*) do (
  for /f "tokens=1,2 delims=:" %%K in ("%%~A") do (
    if /I "%%~K"=="/PROFILE" if not "%%~L"=="" set "PROFILE=%%~L"
  )
)

REM ============================================================
REM  Resolver AMC_ROOT por estructura fija:
REM  Este .bat está en ...\04-ArchitecturaeModularisCodex\03.Scripts\03.Profile\
REM  AMC_ROOT = dos niveles arriba = %~dp0..\..
REM ============================================================
set "SCRIPTDIR=%~dp0"
for %%I in ("%SCRIPTDIR%\..\..") do set "AMC_ROOT=%%~fI"

REM  MO2_BASE = hermano en "Skyrim Mods": ...\05-MO2-Portable
for %%I in ("%AMC_ROOT%\..") do set "SKYRIM_MODS=%%~fI"
set "MO2_BASE=%SKYRIM_MODS%\05-MO2-Portable"

REM  Rutas de trabajo
set "SRC=%AMC_ROOT%\Profiles\%PROFILE%"
set "DST=%MO2_BASE%\profiles\%PROFILE%"

echo ----------------------------------------------------------
echo  SCRIPTDIR : %SCRIPTDIR%
echo  AMC_ROOT  : %AMC_ROOT%
echo  MO2_BASE  : %MO2_BASE%
echo  PROFILE   : %PROFILE%
echo  SRC (04)  : %SRC%
echo  DST (05)  : %DST%
echo ----------------------------------------------------------
echo.

REM ============================================================
REM  Validaciones mínimas
REM ============================================================
if not exist "%AMC_ROOT%" (
  echo [ERROR] AMC_ROOT no resuelto desde la estructura esperada.
  echo         Esperado: ...\04-ArchitecturaeModularisCodex\03.Scripts\03.Profile\
  goto :END_ERR
)
if not exist "%SRC%" (
  echo [ERROR] No existe el perfil origen en repo: "%SRC%"
  goto :END_ERR
)
if not exist "%MO2_BASE%" (
  echo [ERROR] No existe MO2 portable: "%MO2_BASE%"
  goto :END_ERR
)

REM Asegurar carpeta profiles
if not exist "%MO2_BASE%\profiles" mkdir "%MO2_BASE%\profiles" 2>nul

REM ============================================================
REM  Copia inicial 04 -> 05 (siembra de ficheros del perfil)
REM ============================================================
if not exist "%DST%" mkdir "%DST%" 2>nul

echo [INFO] Copiando ficheros de perfil desde repo a MO2...
copy /y "%SRC%\modlist.txt"       "%DST%\" >nul 2>&1
copy /y "%SRC%\plugins.txt"       "%DST%\" >nul 2>&1
if exist "%SRC%\categories.dat"   copy /y "%SRC%\categories.dat"   "%DST%\" >nul 2>&1
if exist "%SRC%\skyrim.ini"       copy /y "%SRC%\skyrim.ini"       "%DST%\" >nul 2>&1
if exist "%SRC%\skyrimprefs.ini"  copy /y "%SRC%\skyrimprefs.ini"  "%DST%\" >nul 2>&1
if exist "%SRC%\loadorder.txt"    copy /y "%SRC%\loadorder.txt"    "%DST%\" >nul 2>&1
echo [OK] Copia inicial realizada (si habia diferencias).

REM ============================================================
REM  Sustituir carpeta destino por JUNCTION hacia el origen
REM  Resultado: %MO2_BASE%\profiles\%PROFILE% -> link a %AMC_ROOT%\Profiles\%PROFILE%
REM ============================================================
echo.
echo [INFO] Sustituyendo "%DST%" por un enlace hacia "%SRC%"...

REM ¿DST ya es un enlace? (reparse point)
set "IS_LINK=False"
for /f %%Q in ('powershell -NoProfile -Command "if (Test-Path -LiteralPath ''%DST%'' -PathType Container) { ((Get-Item -LiteralPath ''%DST%'').Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0 } else { $false }" 2^>nul') do set "IS_LINK=%%Q"

if exist "%DST%" (
  if "%IS_LINK%"=="True" (
    echo [INFO] Ya era enlace. Se recrea...
    rmdir "%DST%"
  ) else (
    echo [INFO] Eliminando carpeta real "%DST%"...
    rmdir /S /Q "%DST%"
  )
)

mklink /J "%DST%" "%SRC%"
if errorlevel 1 (
  echo [ERROR] mklink /J ha fallado. ¿Permisos o ruta bloqueada?
  goto :END_ERR
)

echo [OK] "%DST%" ahora es un enlace a "%SRC%"
echo.
echo [CHECK] Enlaces en "%MO2_BASE%\profiles":
dir /AL "%MO2_BASE%\profiles"
echo.
pause
endlocal & exit /b 0

:END_ERR
echo.
pause
endlocal & exit /b 1
