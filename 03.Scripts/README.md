# AMC — Manual de Scripts (v0.0.2)

Cada script contiene el bloque de variables comunes: 
`WORKSPACE`, `REPO`, `MO2`, `PROFILE_NAME`, `PROFILE_SRC`, `PROFILE_DST`, `CONFIG_SRC`, `CONFIG_DST`, `STAGING`.

---

## 00-Env-Check.(bat|ps1)
Verifica que el entorno AMC esté correctamente configurado. 
Comprobaciones: rutas, permisos y existencia de carpetas críticas.
Uso: ejecutar antes de `Deploy` o `Export`.

## 01-Tree-Report.(bat|ps1)
Genera un árbol de carpetas y CSVs para auditoría del workspace/MO2.
Salida: `02.Docs\99.History\04-Logs\` y `03-ArchitectureTree\`.

## 02-Deploy-Config.bat
Copia `00.Config` del repositorio hacia `mods\00.Config` en MO2.
Uso: tras actualizar el repositorio o los `.ini`.

## 03-Export-Profile.bat
Exporta `modlist.txt`, `plugins.txt`, `categories.dat`, y los `.ini` del perfil activo.
Destino: `Profiles\<perfil>\` en el repo.
Uso: antes de cada commit o versión.

## 04-Deploy-RootKit.bat
Despliega paquetes externos (RootKits) como ENBSeries o EngineFixes en la raíz del juego.
Origen: `02-Archives\02.02-Releases\RootKits\<KIT>\<VER>\`.
Uso: `04-Deploy-RootKit.bat ENBSeries v0503`.

## 05-Git-QuickPush.bat
Automatiza commit + push:
`git add -A` → `git commit -m "<mensaje>"` → `git push`.

## 06-Generate-Changelog.(bat|ps1)
Genera/actualiza `CHANGELOG.md` en `02.Docs\99.History\01-Changelog\` usando `git log`.
Uso: tras cerrar versión y exportar perfil.

## 07-Backup-Workspace.bat
Crea un backup ligero del workspace (repo + perfiles, sin `mods`).
Destino: `03-Backups\YYYYMMDD_HHMM\`.

## 08-Clean-Temp.bat
Limpia `overwrite/`, cachés temporales y residuos (`*.tmp`) del entorno MO2.
Uso: antes de exportar perfil o realizar build.
