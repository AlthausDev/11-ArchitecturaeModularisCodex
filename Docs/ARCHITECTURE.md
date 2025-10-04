# Architecturae Modularis Codex — Arquitectura Base
**Versión:** 0.0.1  
**Autor:** Sam Althaus  
**Fecha:** Octubre 2025

---

## 1. Principios rectores
- **Diseño modular**: cada bloque puede reemplazarse sin afectar al resto.
- **Determinismo en carga**: la categoría define quién sobrescribe a quién.
- **Reproducibilidad**: scripts y docs garantizan reconstrucción sin ambigüedad.
- **Documentación viva**: decisiones anotadas, no implícitas.

## 2. Layout del sistema
```
G:\Skyrim Mods\
├─ 00-Tools\
├─ 01-Downloads\
├─ 02-Archives\
├─ 03-Backups\
├─ 11-ArchitecturaeModularisCodex\
└─ Skyrim-MO2-Portable\
    ├─ mods\
    ├─ profiles\
    ├─ overwrite\
    └─ webcache\
```

## 3. Bloques AMC (descripción funcional)
**00.Core**  
- Address Library, Engine Fixes, po3 libs, Display Tweaks, BOS, INI Tweaks, Utilities.

**01.Frameworks**  
- SKSE Scripts, Nemesis-data, DAR/AMR, Keywords, Animation Events, UI frameworks, AE compatibility.

**02.Gameplay**  
- Combat, Magic, Stealth, AI, Balance, Progression, Needs/Survival, Crafting, Economy, Crime, Stones, Races.

**03.Animation**  
- Combat/Locomotion/Idle/Creatures/FirstPerson/Camera/PCEA/Patches.

**04.Visual**  
- Textures/Models/Lighting/Weather/ENB/Particles/Water/Flora/Parallax/LOD/Effects/Performance.

**05.Audio**  
- Music/Ambience/SFX/Combat/Footsteps/Voices/UI.

**06.Interface**  
- HUD/Menus/Inventory/MCM/Maps/CursorsFonts/IconsHotkeys/WheelMenus.

**07.World**  
- Overhauls/Cities/Towns/Villages/Dungeons/Interiors/Landscapes/FloraGrass/Roads/Clutter/PlayerHomes/NewWorldspaces/MapLOD.

**08.NPCs**  
- Behavior/AIOverhauls/Appearance/FaceReplacers/Followers frameworks & new/Enemies/CreaturesOverhauls/New.

**09.Items**  
- Weapons/Armors/Artifacts/Crafting/Enchanting/Alchemy/Food/BooksScrolls/Misc/Economy/LeveledLists.

**10.Quests**  
- VanillaFixes/New/Expansions/Guilds/Radiant/Dialogue/LegacyCollections.

**11.Adult**  
- Frameworks/OStim/Animations/Addons/UI/Patches.

**12.Patches**  
- Bashed/Smashed/Merged/ConflictResolutions/LoadOrderFixes/Consistency.

**13.Overrides**  
- LateFixes/Cosmetic/Replacers/Cleanup.

**14.Generators**  
- NemesisOutput/LODGen/TexGen/DynDOLOD/Synthesis/zEdit/xLODGen.

**99.Unsorted**  
- Triage temporal.

## 4. Reglas de integración
- **Nada** escribe en `Data\` del juego. Todo es **mod** bajo MO2.
- Outputs de generadores → `overwrite\` → convertir a **mod** bajo `14.Generators-*`.
- Un mod se ubica por **función**, no por su nombre comercial.

## 5. Scripts
- `00-CreateStructure_v2.bat` → genera árbol AMC en `mods\` (solo carpetas).
- `02-Deploy-Config.bat` → despliega `00.00-Config` con INIs base.
- `03-Export-Profile.bat` → snapshot de perfil (modlist/plugins/categories/ini).
- `05-GitQuickPush.bat` → commit + push seguro (PowerShell/CMD).

## 6. Nemesis bien configurado
- **Mod de datos** activo: `01.03-Frameworks-Nemesis` (meshes/scripts).
- **Ejecutable** en `00-Tools\Nemesis_Engine\...` con `Start In = ...\Skyrim Special Edition\Data`.
- `Update Engine` → `Launch` → mover `overwrite` a `14.01-Generators-NemesisOutput`.

## 7. Estado actual (0.0.1)
- Estructura AMC y docs consolidados.
- Address Library activo; Nemesis base instalado.
- 00.00-Config OK (DisplayTweaks/EngineFixes/ScrambledBugs).
- Listo para `0.1.0` (Core + Frameworks completos).
