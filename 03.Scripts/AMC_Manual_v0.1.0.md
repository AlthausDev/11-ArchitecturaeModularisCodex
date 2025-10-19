# AMC — Manual de Scripts (v0.1.0)

📍 Versión basada en el estado real del repositorio.  
📍 Incluye únicamente los scripts actualmente presentes en `03.Scripts`.  
📍 Descripciones basadas en comportamiento confirmado (no en diseño futuro).  
📍 Próximas versiones (v0.2+) podrán unificar variables comunes y ampliar funcionalidad.


---

## 📦 Árbol actual de scripts

04-ArchitecturaeModularisCodex
└─ 03.Scripts
   ├─ 01.Reporting
   │   ├─ 01-TreeReport.bat
   │   └─ 01-TreeReport.ps1
   ├─ 02.Deploy
   │   ├─ 02-Deploy-Config.bat
   │   ├─ 04-Deploy-EngineFixesRoot-Rel.bat
   │   └─ 04-Deploy-EngineFixesRoot.bat
   ├─ 03.Profile
   │   └─ 03-Export-Profile.bat
   ├─ 04.Changelog
   │   ├─ 06-Generate-Changelog.bat
   │   └─ 06-Generate-Changelog.ps1
   ├─ 05.Git
   │   └─ 05-GitQuickPush.bat
   └─ _Archive


---

## ✅ Orden recomendado de uso

| Paso | Script                      | Propósito                                         |
|------|-----------------------------|---------------------------------------------------|
| 1    | `02-Deploy-Config.bat`      | Garantiza que `00.Config` esté enlazado en MO2    |
| 2    | `03-Export-Profile.bat`     | Exporta el perfil activo desde MO2 al repositorio |
| 3    | `06-Generate-Changelog.ps1` | Genera snapshot, diff y changelog                 |
| 4    | `05-GitQuickPush.bat`       | Commit + push del estado actual                   |
| 5    | `01-TreeReport.bat` (opt.)  | Auditoría estructural opcional                    |

---

## 📊 Tabla resumen de scripts

| Script                             | Acción principal                                  | Entrada                                  | Salida                                          |
|----------------------------------|--------------------------------------------------|------------------------------------------|-----------------------------------------------|
| `01-TreeReport.bat/.ps1`         | Auditoría estructural del entorno                | Ruta base autodetectada                  | TXT / CSV en `03-ArchitectureTree`            |
| `02-Deploy-Config.bat`          | Copia y enlaza `00.Config` en MO2                | `REPO\00.Config`                         | Link en `MO2\mods\00.Config`                  |
| `04-Deploy-EngineFixesRoot*.bat` | Instala EngineFixes root                        | Staging + ruta del juego                 | `d3dx9_42.dll` en raíz del juego              |
| `03-Export-Profile.bat`         | Exporta perfil MO2                              | Perfil activo                            | `REPO\Profiles\<Perfil>`                      |
| `06-Generate-Changelog.ps1`     | Snapshot + diff + changelog MD                  | Perfil exportado                         | Carpeta `05.Changelog\YYYY-MM-DD_HHMMSS`     |
| `06-Generate-Changelog.bat`     | Launcher para PowerShell                        | Uso directo desde CMD                    | Ejecuta el anterior                           |
| `05-GitQuickPush.bat`           | Commit + push rápido                            | Cambios en repo                          | Sync remoto                                   |

---

## 📂 01.Reporting

### ✅ `01-TreeReport.bat` / `01-TreeReport.ps1`
Genera un inventario estructural del entorno Skyrim Mods / AMC / MO2.

📌 Funcionalidad:
- Genera archivos `.txt` y opcionalmente `.csv`.
- Admite opciones como `/CSV`, `/F`, `/MAXDEPTH`, `/EXCLUDE:"..."`, `/OPEN`.
- Identifica rutas relativas en base al `.bat`.

📁 Salida:
`02.Docs\99.History\03-ArchitectureTree\YYYY-MM-DD\`  
`02.Docs\99.History\04-Logs\`


📅 Uso recomendado: tras cambios mayores en estructura, limpieza o installs.

---

## 📂 02.Deploy

### ✅ `02-Deploy-Config.bat`
Sincroniza la carpeta `00.Config` del repositorio hacia `mods\00.Config` de MO2.

✔ Copia inicial si no existe.  
✔ Si ya existe, se sustituye por enlace simbólico apuntando al REPO.  
📅 Uso: tras modificar configuraciones SKSE/MCM en el repositorio.

---

### ✅ `04-Deploy-EngineFixesRoot.bat` *(versión directa)*
Copia o enlaza el archivo `d3dx9_42.dll` (EngineFixes Part 2) desde `01.Staging` hacia la raíz del juego.

✅ Permite hardlink si es posible, fallback a copia si no.  
📅 Uso: instalación inicial de Engine Fixes.

---

### ✅ `04-Deploy-EngineFixesRoot-Rel.bat` *(versión rutas relativas)*
Versión alternativa del script anterior, orientada a rutas relativas.  
📌 Pensado para mayor portabilidad del repositorio entre equipos.

---

## 📂 03.Profile

### ✅ `03-Export-Profile.bat`
Exporta archivos clave del perfil MO2 hacia el repositorio:

✅ `modlist.txt`  
✅ `plugins.txt`  
✅ `categories.dat`  
✅ `skyrim.ini`, `skyrimprefs.ini` (si existen)

📁 Destino:
`REPO\Profiles\<NombrePerfil>\`


📅 Uso: antes de generar changelogs o realizar commit.

---

## 📂 04.Changelog

### ✅ `06-Generate-Changelog.ps1`
Script avanzado en PowerShell que:
✅ Lee `modlist.txt` desde el perfil exportado en REPO  
✅ Genera snapshot (`EnabledMods.txt`, `EnabledMods.csv`)  
✅ Compara con snapshot anterior → `Diff_vs_Previous.txt`  
✅ Produce changelog Markdown con:
    ✔ Mods habilitados
    ✔ Mods deshabilitados
    ✔ Core faltante
    ✔ Mods que requieren regenerar Nemesis
    ✔ Diff (añadidos / eliminados desde el snapshot anterior)

📁 Salida:
02.Docs\99.History\05.Changelog\YYYY-MM-DD_HHMMSS\


---

### ✅ `06-Generate-Changelog.bat`
Launcher auxiliar que:
- Detecta el PowerShell adecuado (`pwsh` o `powershell.exe`)
- Llama al `.ps1`
- Muestra el estado al finalizar

📅 Uso: ejecución cómoda desde CMD sin abrir PowerShell manualmente.

---

## 📂 05.Git

### ✅ `05-GitQuickPush.bat`
Realiza un commit + push rápido y seguro:

✔ Usa el mensaje pasado como argumento.  
✔ Si no hay mensaje, genera:
        chore(AMC): repo sync - state snapshot @ YYYY-MM-DD HH:mm
✔ No comitea ni pushea si no hay cambios.  
✔ Compatible con `!` y comillas.  
✔ Detecta raíz git automáticamente.

📅 Uso: tras exportar perfil y generar changelog.

---

## 📂 _Archive
Carpeta para guardar scripts antiguos o no utilizados actualmente.
