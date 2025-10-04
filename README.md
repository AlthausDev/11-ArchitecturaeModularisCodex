# Architecturae Modularis Codex (AMC)
**Versión:** 0.0.1  
**Autor:** Sam Althaus  
**Estado:** Address Library + Nemesis instalados; estructura AMC y scripts operativos.  

AMC es una **arquitectura técnica** para Skyrim SE/AE (1.6.1170) orientada a **portabilidad**, **modularidad** y **versionado**.  
No es una “lista de mods”, sino un **marco de trabajo reproducible** con documentación, scripts y jerarquía funcional.

---

## 1) Principios de diseño
- **Separación estricta de responsabilidades:** ejecutables en `00-Tools\`, datos en `Skyrim-MO2-Portable\mods\`, documentación y perfiles en el **repo**.
- **Portabilidad total:** MO2 **portable** con rutas relativas; scripts que despliegan configuración sin tocar `Data\` del juego.
- **Orden de carga determinista:** la **categoría** define la prioridad (arriba = base técnica, abajo = parches/overrides/generadores).
- **Trazabilidad y rollback:** perfiles versionados y cambios pequeños con commits atómicos.
- **Elegancia y consistencia:** convención `XX.YY-Parent-SubgroupPascal` y nombres sin underscores.

---

## 2) Estructura general del entorno
**Raíz del workspace:**
```
G:\Skyrim Mods\
```

**Top-level:**
```
├─ 00-Tools\                    → Herramientas externas (MO2, LOOT, xEdit, BethINI, CAO, Nemesis.exe, etc.)
├─ 01-Downloads\                → Descargas crudas (Nexus, manuales)
├─ 02-Archives\                 → Snapshots/versiones comprimidas
├─ 03-Backups\                  → Backups automáticos/rápidos
├─ 11-ArchitecturaeModularisCodex\   → Repositorio Git (docs, perfiles, scripts, config)
└─ Skyrim-MO2-Portable\         → Entorno portable de MO2 (mods, profiles, overwrite, webcache)
```

**MO2 (Settings → Paths)** — usar rutas relativas:
```
Base="."
Mods="mods"
Profiles="profiles"
Overwrite="overwrite"
Downloads="..\01-Downloads"
```

---

## 3) Estructura interna del repositorio
```
11-ArchitecturaeModularisCodex\
│
├─ Profiles\
│   └─ AMC-Base-1.6.1170\
│       ├─ categories.dat
│       ├─ modlist.txt
│       ├─ plugins.txt
│       ├─ Skyrim.ini
│       └─ SkyrimPrefs.ini
│
├─ 00.00-Config\                ← Mod de configuración versionado
│   └─ Data\SKSE\Plugins\
│       ├─ SSEDisplayTweaks.ini
│       ├─ EngineFixes.toml
│       └─ ScrambledBugs.json
│
├─ Scripts\
│   ├─ 00-CreateStructure_v2.bat     → crea estructura AMC en mods\
│   ├─ 02-Deploy-Config.bat          → copia 00.00-Config → mods\00.00-Config
│   ├─ 03-Export-Profile.bat         → exporta modlist/plugins/categories/ini del perfil activo
│   └─ 05-GitQuickPush.bat           → add/commit/push rápido (PowerShell/CMD safe)
│
├─ Docs\
│   ├─ ARCHITECTURE.md               → arquitectura en detalle
│   └─ PORTABILITY.md                → portabilidad y migración
└─ README.md
```

---

## 4) Convención de categorías AMC
**Formato:** `XX.YY-Parent-SubgroupPascal`

- `XX` → bloque principal (00, 01, …, 14, 99).  
- `YY` → identificador único incremental dentro del bloque.  
- `Parent/Subgroup` → semántica funcional (Core, Frameworks, Combat, Lighting, etc.).  
- `PascalCase` → legible y alineado con nombres de proyectos.

**Ejemplos:**
```
00.01-Core-AddressLibrary
01.03-Frameworks-Nemesis
04.03-Visual-Lighting
14.01-Generators-NemesisOutput
```

**Bloques (orden real de carga):**
- **00.Core** — Núcleo del motor y librerías críticas: Address Library, Engine Fixes, po3 libs, Display Tweaks, BOS, INI Tweaks.
- **01.Frameworks** — Extensores y frameworks globales: SKSE, Nemesis (datos), DAR, AMR, Keywords, Animation Events, UI frameworks, compat AE.
- **02.Gameplay** — Reglas/mechanics: Combat, Magic, Stealth, AI, Balance, Progression, Needs/Survival, Crafting, Economy, Crime, Races.
- **03.Animation** — Movesets/Locomotion/Idle/Creatures/FirstPerson/Camera/PCEA/Patches.
- **04.Visual** — Textures/Models/Lighting/Weather/ENB/Particles/Water/Flora/Parallax/LOD/Performance.
- **05.Audio** — Music/Ambience/SFX/Combat/Footsteps/Voices/UI.
- **06.Interface** — HUD/Menus/Inventory/MCM/Maps/Fonts/Icons/WheelMenus.
- **07.World** — Overhauls/Cities/Towns/Villages/Dungeons/Interiors/Landscapes/MapLOD.
- **08.NPCs** — Behavior/AIOverhauls/Appearance/Followers/Enemies/Creatures.
- **09.Items** — Weapons/Armors/Artifacts/Crafting/Enchanting/Alchemy/Food/Books/Economy/LeveledLists.
- **10.Quests** — VanillaFixes/New/Expansions/Guilds/Radiant/Dialogue/Legacy.
- **11.Adult** — Frameworks/OStim/Animations/Addons/UI/Patches (aislado).
- **12.Patches** — Bashed/Smashed/Merged/ConflictResolutions/LoadOrderFixes/Consistency.
- **13.Overrides** — LateFixes/Cosmetic/Replacers/Cleanup (muy abajo).
- **14.Generators** — NemesisOutput/TexGen/DynDOLOD/xLODGen/Synthesis/zEdit.
- **99.Unsorted** — Triage temporal (evitar que crezca).

---

## 5) Scripts AMC
| Script | Qué hace | Uso |
|---|---|---|
| `00-CreateStructure_v2.bat` | Genera **toda** la jerarquía AMC en `mods\` | Justo después de crear un perfil |
| `02-Deploy-Config.bat` | Copia `00.00-Config` del repo a `mods\00.00-Config` | Tras clonar/actualizar el repo |
| `03-Export-Profile.bat` | Exporta `modlist.txt`, `plugins.txt`, `categories.dat` y `*.ini` a `Profiles\` | Antes de commitear o crear snapshot |
| `05-GitQuickPush.bat` | `git add -A` + `git commit -m "<msg>"` + `git push` | Commit push rápido (compatible PowerShell/CMD) |

**Notas técnicas del 05-GitQuickPush.bat**
- Reconstruye el mensaje con `shift` para evitar problemas de comillas en PowerShell.
- Usa **delayed expansion** para preservar espacios y caracteres.

---

## 6) Flujo recomendado
1. **Instalación limpia** de Skyrim (no ejecutar vanilla).  
2. **Configurar MO2 portable** con las rutas relativas indicadas.  
3. Colocar `categories.dat` en `profiles\AMC-Base-1.6.1170\`.  
4. Ejecutar `00-CreateStructure_v2.bat`.  
5. Ejecutar `02-Deploy-Config.bat` y activar **00.00-Config** (cat. `00.Core`).  
6. Instalar: **Address Library**, **Engine Fixes**, **po3 stack**, **SSE Display Tweaks**.  
7. Activar **01.03-Frameworks-Nemesis** (datos) → `Update Engine` → `Launch`.  
8. Convertir `overwrite` en **14.01-Generators-NemesisOutput**.  
9. `03-Export-Profile.bat` → snapshot de perfil.  
10. `05-GitQuickPush.bat "AMC v0.0.1 - Base y estructura"` → subir a Git.

---

## 7) Estado actual (snapshot)
- **Address Library (AE 1.6.1170)** → instalado y activo.  
- **Nemesis (datos)** → instalado; compilación pendiente/realizada según perfil.  
- **00.00-Config** → activo con INIs seguros.  
- **Documentación** → README, ARCHITECTURE y PORTABILITY completados (v0.0.1).

---

## 8) Roadmap de versiones
- `0.1.0` → Cerrar **00.Core + 01.Frameworks** (Engine Fixes, po3, SKSE scripts) + smoke test.  
- `0.2.0` → Visual base y generadores (TexGen/DynDOLOD/xLODGen).  
- `0.3.0` → Gameplay core + CR inicial en xEdit.  
- `1.0.0` → Build estable documentada.

---

## 9) Créditos
- Lexy’s LOTD, Phoenix Flavour — metodologías y documentación.  
- PowerofThree, meh321, ousnius, aers — frameworks base.  
- AMC Design Standards — Sam Althaus, 2025.
