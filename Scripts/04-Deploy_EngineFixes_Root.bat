@echo on
setlocal EnableExtensions

rem === CONFIG SENCILLA ===
set "SRC=G:\Skyrim Mods\11-ArchitecturaeModularisCodex\01.Frameworks\EngineFixes\Part2-Root"
set "GAME=%AMC_SKYRIM_ROOT%"
if not defined GAME set "GAME=G:\Games\Steam\steamapps\common\Skyrim Special Edition"

echo SRC=%SRC%
echo GAME=%GAME%

if not exist "%SRC%\d3dx9_42.dll" (
  echo [ERROR] No existe "%SRC%\d3dx9_42.dll"
  goto :END
)

if not exist "%GAME%\SkyrimSE.exe" (
  echo [ERROR] GAME no apunta a la raiz correcta: "%GAME%"
  goto :END
)

rem --- Desplegar (hardlink si se puede; si no, copia) ---
if exist "%GAME%\d3dx9_42.dll" del /f /q "%GAME%\d3dx9_42.dll"
mklink /H "%GAME%\d3dx9_42.dll" "%SRC%\d3dx9_42.dll"
if errorlevel 1 copy /y "%SRC%\d3dx9_42.dll" "%GAME%\d3dx9_42.dll"

echo.
echo [CHECK] Deberias ver el archivo listado aqui:
dir /b "%GAME%\d3dx9_42.dll"

:END
echo.
pause
