@echo off
setlocal EnableExtensions DisableDelayedExpansion

REM --- Requiere git en PATH ---
where git >nul 2>&1 || (echo [ERROR] Git no encontrado.& goto :ERR)

REM --- Raiz del repo desde la carpeta del BAT (o la del BAT si no hay .git arriba) ---
set "HERE=%~dp0"
set "REPO="
for /f "delims=" %%R in ('git -C "%HERE%" rev-parse --show-toplevel 2^>nul') do set "REPO=%%R"
if not defined REPO set "REPO=%HERE%"

REM --- Mensaje: usa todos los args; si vacío, formato B estándar ---
set "MSG=%*"
if "%MSG%"=="" (
  for /f %%T in ('powershell -NoProfile -Command "(Get-Date).ToString(\"yyyy-MM-dd HH:mm\")"') do set "TS=%%T"
  set "MSG=chore(AMC): repo sync - state snapshot @ %TS%"
)

pushd "%REPO%" >nul 2>&1 || goto :ERR

REM --- Stage ---
git add -A || goto :ERR

REM --- Si no hay cambios staged, salir en verde ---
git diff --cached --quiet
if not errorlevel 1 (
  echo [OK] No hay cambios que commitear.
  goto :OK
)

REM --- Commit (soporta '!' y comillas) ---
setlocal DisableDelayedExpansion
git commit -m "%MSG%" || (endlocal & goto :ERR)
endlocal

REM --- Push ---
git push || goto :ERR

:OK
popd >nul
echo [OK] Push realizado (o repo ya limpio).
pause
endlocal & exit /b 0

:ERR
popd >nul 2>&1
echo [ERROR] Operacion git fallida.
pause
endlocal & exit /b 1
