@echo on
setlocal EnableExtensions EnableDelayedExpansion
title [AMC] Deploy Engine Fixes Part2 (d3dx9_42.dll)

REM ============================================================
REM  Deducción robusta de AMC_ROOT relativa al propio .BAT
REM  Busca la carpeta "04-ArchitecturaeModularisCodex" hacia arriba
REM ============================================================
set "SCRIPTDIR=%~dp0"
set "AMC_ROOT="
set "SEARCH=04-ArchitecturaeModularisCodex"

for %%L in (0 1 2 3 4 5) do (
  if "%%L"=="0" set "CAND=%SCRIPTDIR%"
  if "%%L"=="1" for %%I in ("%SCRIPTDIR%\..") do set "CAND=%%~fI\"
  if "%%L"=="2" for %%I in ("%SCRIPTDIR%\..\..") do set "CAND=%%~fI\"
  if "%%L"=="3" for %%I in ("%SCRIPTDIR%\..\..\..") do set "CAND=%%~fI\"
  if "%%L"=="4" for %%I in ("%SCRIPTDIR%\..\..\..\..") do set "CAND=%%~fI\"
  if "%%L"=="5" for %%I in ("%SCRIPTDIR%\..\..\..\..\..") do set "CAND=%%~fI\"
  if exist "%CAND%%SEARCH%\" (
    set "AMC_ROOT=%CAND%%SEARCH%"
    goto :found_amc
  )
)
:found_amc

if not defined AMC_ROOT (
  echo [ERROR] No se encontro "%SEARCH%" ascendiendo desde "%SCRIPTDIR%".
  echo         Mueve este BAT dentro de la jerarquia de AMC o exporta AMC_ROOT.
  echo         (Ej.: set AMC_ROOT=D:\Skyrim Mods\04-ArchitecturaeModularisCodex)
  goto :END
)

REM ============================================================
REM  Rutas principales (todas relativas a AMC_ROOT)
REM ============================================================
set "SRC=%AMC_ROOT%\01.Staging\EngineFixes\Part2-Root"

REM  Juego: permite override por variable de entorno; si no, fallback tipico Steam
set "GAME=%AMC_SKYRIM_ROOT%"
if not defined GAME set "GAME=%ProgramFiles(x86)%\Steam\steamapps\common\Skyrim Special Edition"
if not exist "%GAME%\SkyrimSE.exe" (
  REM Fallback adicional por si Steam no esta en Program Files (x86)
  if exist "G:\Games\Steam\steamapps\common\Skyrim Special Edition\SkyrimSE.exe" (
    set "GAME=G:\Games\Steam\steamapps\common\Skyrim Special Edition"
  )
)

echo -----------------------------------------------
echo SCRIPTDIR=%SCRIPTDIR%
echo AMC_ROOT =%AMC_ROOT%
echo SRC     =%SRC%
echo GAME    =%GAME%
echo -----------------------------------------------

REM ============================================================
REM  Validaciones
REM ============================================================
if not exist "%SRC%\d3dx9_42.dll" (
  echo [ERROR] No existe "%SRC%\d3dx9_42.dll"
  goto :END
)

if not exist "%GAME%\SkyrimSE.exe" (
  echo [ERROR] GAME no apunta a la raiz correcta: "%GAME%"
  echo         Exporta AMC_SKYRIM_ROOT o edita este BAT.
  goto :END
)

REM ============================================================
REM  Despliegue: intentar hardlink (misma unidad) y si falla, copiar
REM  Nota: /H requiere que SRC y GAME esten en el MISMO volumen.
REM ============================================================
if exist "%GAME%\d3dx9_42.dll" del /f /q "%GAME%\d3dx9_42.dll"

echo [INFO] Creando hardlink (si es posible)...
mklink /H "%GAME%\d3dx9_42.dll" "%SRC%\d3dx9_42.dll"
if errorlevel 1 (
  echo [WARN] Hardlink no disponible (volumen distinto o permisos). Copiando...
  copy /y "%SRC%\d3dx9_42.dll" "%GAME%\d3dx9_42.dll" || (
    echo [ERROR] No se pudo copiar d3dx9_42.dll
    goto :END
  )
) else (
  echo [OK] Hardlink creado.
)

echo.
echo [CHECK] Deberias ver el archivo listado aqui:
dir /b "%GAME%\d3dx9_42.dll"

:END
echo.
pause
endlocal
