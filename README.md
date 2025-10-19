# Architecturae Modularis Codex (AMC)
**Versión:** 0.5.1  
**Autor:** Sam Althaus  
**Estado:** Estable — Octubre 2025  

---

## 📘 Descripción general
**Architecturae Modularis Codex (AMC)** es una **arquitectura técnica y estética** para *Skyrim AE (1.6.1170)*, orientada a la **modularidad**, **portabilidad** y **reproducibilidad total** del entorno.  

AMC no es una simple lista de mods, sino un **sistema de diseño** que combina documentación, scripts y estructura determinista, garantizando trazabilidad y reconstrucción exacta del entorno.

---

## 🧱 1. Principios fundamentales
Inspirados en la *Doctrine Aesthetica* (v0.5.1):

- **Forma es estructura:** cada carpeta, nombre y archivo tiene una razón funcional.  
- **Determinismo visual:** la posición y prefijo definen su función.  
- **Coherencia total:** todo lo que existe está documentado; lo que se documenta, existe.  
- **Portabilidad:** ningún archivo escribe en `Data\`.  
- **Reproducibilidad:** scripts y logs garantizan reconstrucción exacta.  
- **Disciplina estética:** claridad, ritmo, simetría y silencio técnico.

---

## 📂 2. Layout del sistema

```
G:\Skyrim Mods\
```

**Top-level:**
```
├─ 00-Tools\                    → Herramientas externas (MO2, LOOT, xEdit, BethINI, CAO, Nemesis.exe, etc.)
├─ 01-Downloads\                → Descargas crudas (Nexus, manuales)
├─ 02-Archives\                 → Snapshots/versiones comprimidas
├─ 03-Backups\                  → Backups automáticos/rápidos
├─ 04-ArchitecturaeModularisCodex\   → Repositorio Git (docs, perfiles, scripts, config)
└─ 05-MO2-Portable\             → Entorno portable de MO2 (mods, profiles, overwrite, webcache)

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
04-ArchitecturaeModularisCodex\
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
│   ├─ 00-CreateStructure_v2.bat     → genera estructura AMC en `mods\`
│   ├─ 02-Deploy-Config.bat          → copia `00.00-Config` → `mods\00.00-Config`
│   ├─ 03-Export-Profile.bat         → exporta `modlist/plugins/categories/ini` del perfil activo
│   ├─ 04-Deploy-EngineFixesRoot.bat → instala Engine Fixes Part 2 en raíz del juego
│   └─ 05-GitQuickPush.bat           → add/commit/push rápido (PowerShell/CMD safe)
│
├─ Docs\
│   ├─ ARCHITECTURE_v0.1.1.md        → arquitectura base
│   ├─ PORTABILITY_v0.1.1.md         → portabilidad y migración
│   ├─ Doctrine_Aesthetica_v0.5.1.md → fundamentos filosóficos y estructurales
│   └─ AMC_Documentation_Guide.md    → guía modular de documentación
│
└─ README.md

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
| Nº | Nombre | Descripción |
|----|---------|-------------|
| 00 | Core | Núcleo técnico, librerías, fixers |
| 01 | Frameworks | Extensores y dependencias SKSE |
| 02 | Gameplay | Mecánicas, progresión, supervivencia |
| 03 | Animation | Movimiento, combate, locomotion |
| 04 | Visual | Texturas, iluminación, clima |
| 05 | Audio | Música, ambiente, SFX |
| 06 | Interface | HUD, menús, MCM, mapas |
| 07 | World | Entorno, ciudades, flora, LOD |
| 08 | NPCs | Entidades, criaturas, overhauls |
| 09 | Items | Armas, armaduras, economía |
| 10 | Quests | Misiones, diálogos, expansiones |
| 11 | Adult | Frameworks, animaciones, UI |
| 12 | Patches | Conflicts, merges, load order fixes |
| 13 | Overrides | Ajustes tardíos y cosméticos |
| 14 | Generators | Nemesis, DynDOLOD, TexGen, Synthesis |
| 15 | DevTools | Logs, debug y herramientas |
| 99 | Unsorted | Zona de triage temporal |

---

## 🧩 5. Scripts principales
| Script | Descripción | Uso |
|---|---|---|
| `02-Deploy-Config.bat` | Copia o enlaza `00.Config` hacia MO2 | Tras clonar el repo |
| `03-Export-Profile.bat` | Exporta perfil activo a `Profiles\` | Antes de commit |
| `04-Deploy-EngineFixesRoot.bat` | Copia `d3dx9_42.dll` (Engine Fixes Part 2) | En instalación inicial |
| `06-Generate-Changelog.ps1` | Genera snapshot de mods habilitados y diffs | Al cerrar versión |
| `05-GitQuickPush.bat` | Commit + Push rápido con mensaje formateado | Tras cada cambio significativo |

---

## 🧭 6. Flujo recomendado
1. Instalar Skyrim AE limpio.  
2. Configurar MO2 portable.  
3. Ejecutar `00-CreateStructure_v2.bat`.  
4. Desplegar configuración con `02-Deploy-Config.bat`.  
5. Instalar núcleo técnico (Address Library, Engine Fixes, po3, Display Tweaks).  
6. Activar frameworks (`Nemesis`, `DAR`, `AMR`, etc.).  
7. Ejecutar `Nemesis` → mover `overwrite` a `14.01-Generators-NemesisOutput`.  
8. Generar LODs con `TexGen` / `DynDOLOD`.  
9. Exportar perfil con `03-Export-Profile.bat`.  
10. Commit final con `05-GitQuickPush.bat "AMC vX.Y.Z - <Descripción>"`.

---

## 🗃️ 7. Versionado y documentación
- Addenda y releases en `02.Docs\99.History`.  
- VersionIndex.md → catálogo oficial de Addenda (0.1–0.5.1).  
- Doctrine Aesthetica → filosofía de forma, coherencia e intención.  
- Portability.md → replicación exacta del entorno.  
- Architecture.md → definición estructural y técnica.  

---

## 🚀 8. Estado actual (v0.5.1)
- **Doctrina consolidada** (forma + intención).  
- **Bloques 00–15** completos y funcionales.  
- **Releases** hasta `AMC_v0.5.1_DoctrineAesthetica.zip`.  
- **Documentación viva** y trazable.  

---

## 🧭 9. Roadmap AMC v1.0
- Ampliar Doctrine Aesthetica con subprincipios aplicados.  
- Integrar automatización total del flujo (CLI único).  
- Publicar *AMC Modular Core* como entorno reproducible (GitHub).  
- Documentar casos de portabilidad multiusuario.

---

## 🕯️ 10. Créditos
- **Diseño y estructura:** Sam Althaus  
- **Frameworks base:** meh321, aers, ousnius, powerofthree  
- **Metodología:** Lexy’s LOTD, The Phoenix Flavour  
- **Inspiración filosófica:** Doctrine Aesthetica (Codex Internum)
