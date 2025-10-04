@echo off
setlocal enabledelayedexpansion

set "REPO=G:\Skyrim Mods\11-ArchitecturaeModularisCodex"

REM Concatenar manualmente todos los argumentos pasados (funciona en PowerShell)
set "MSG="
:loop
if "%~1"=="" goto afterloop
set MSG=!MSG! %~1
shift
goto loop
:afterloop

if "%MSG%"=="" (
    set "MSG=chore: quick push %date% %time%"
)

pushd "%REPO%" >nul
echo [AMC] Commit message: !MSG!
git add -A
git commit -m "!MSG!"
git push
popd >nul

echo [OK] Push realizado correctamente.
pause
endlocal
