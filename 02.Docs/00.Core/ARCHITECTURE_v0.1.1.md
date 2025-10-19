# Architecturae Modularis Codex — Arquitectura Técnica Base
**Versión:** 0.1.1  
**Autor:** Sam Althaus  
**Fecha:** Octubre 2025  
**Estado:** Estable – Base de referencia técnica del sistema AMC  

---

## 1. Principios rectores

- **Diseño modular:** cada bloque del sistema puede reemplazarse o actualizarse sin afectar al resto.  
- **Determinismo en carga:** la categoría define explícitamente quién sobrescribe a quién.  
- **Reproducibilidad:** scripts y documentación garantizan reconstrucción exacta del entorno.  
- **Documentación viva:** toda decisión técnica debe quedar registrada, nunca implícita.  
- **Trazabilidad modular:** cada cambio debe poder rastrearse desde su bloque hasta el commit asociado.  

---

## 2. Layout del sistema

```
G:\Skyrim Mods\
├─ 00-Tools\
├─ 01-Downloads\
├─ 02-Archives\
├─ 03-Backups\
├─ 04-ArchitecturaeModularisCodex\
└─ 05-MO2-Portable\
    ├─ mods\
    ├─ profiles\
    ├─ overwrite\
    └─ webcache\
```

> La estructura AMC debe mantenerse idéntica entre entornos para asegurar portabilidad y compatibilidad absoluta con los scripts.

---

## 3. Bloques AMC (descripción funcional)

| Bloque | Función principal | Contenido y ejemplos |
|:--:|:--|:--|
| **00.Core** | Núcleo técnico | Address Library, Engine Fixes, po3 libs, Display Tweaks, BOS, INI Tweaks |
| **01.Frameworks** | Estructuras y extensiones base | SKSE Scripts, Nemesis-data, DAR/AMR, Keywords, Animation Events, UI frameworks |
| **02.Gameplay** | Sistemas de jugabilidad | Combat, Magic, AI, Progression, Survival, Crafting, Economy, Races |
| **03.Animation** | Sistema de animaciones | Combat, Locomotion, Idle, Creatures, PCEA, FirstPerson, Patches |
| **04.Visual** | Componentes gráficos | Textures, Lighting, Weather, ENB, Water, Flora, Parallax, LOD |
| **05.Audio** | Entorno sonoro | Music, Ambience, SFX, Footsteps, Voices, UI |
| **06.Interface** | Interfaz de usuario | HUD, Menus, Inventory, Maps, Fonts, Icons, Hotkeys |
| **07.World** | Diseño de mundo | Cities, Dungeons, Interiors, Flora, Roads, Clutter, PlayerHomes, MapLOD |
| **08.NPCs** | Personajes y criaturas | AI Overhauls, Appearances, Followers, Enemies, Creature Overhauls |
| **09.Items** | Objetos y economía | Weapons, Armors, Artifacts, Crafting, Food, Books, Leveled Lists |
| **10.Quests** | Misiones y narrativa | VanillaFixes, Expansions, Guilds, Dialogue, Legacy Collections |
| **11.Adult** | Extensiones de contenido adulto | Frameworks, OStim, Animations, Addons, UI, Patches |
| **12.Patches** | Integración y corrección | Bashed, Merged, Conflict Resolutions, Consistency |
| **13.Overrides** | Ajustes finales | Late Fixes, Cosmetic, Replacers, Cleanup |
| **14.Generators** | Herramientas de compilación | NemesisOutput, LODGen, TexGen, DynDOLOD, Synthesis, zEdit |
| **99.Unsorted** | Zona de trabajo temporal | Mods en fase de prueba o sin clasificación definitiva |

---

## 4. Reglas de integración

- **Ningún mod escribe en `Data\`** del juego. Todo se gestiona bajo MO2.  
- Los **outputs de generadores** se guardan en `overwrite\` y luego se convierten en un mod dentro de `14.Generators-*`.  
- Cada mod se clasifica **por función**, no por nombre comercial.  
- Se prioriza el uso de **enlaces simbólicos o hardlinks** para conservar integridad entre REPO y MO2.  
- Toda modificación o sustitución debe documentarse en un Addendum o commit asociado.

---

## 5. Scripts AMC

| Script | Descripción | Uso |
|:--|:--|:--|
| `00-CreateStructure_v2.bat` | Genera el árbol AMC base dentro de `mods\` (solo carpetas). | Instalación inicial. |
| `02-Deploy-Config.bat` | Despliega `00.Config` con INIs base y crea el enlace simbólico hacia MO2. | Tras actualizaciones de configuración. |
| `03-Export-Profile.bat` | Exporta snapshot de perfil (modlist, plugins, categories, inis). | Antes de generar changelog. |
| `05-GitQuickPush.bat` | Commit + push rápido y seguro del estado actual. | Tras exportar o documentar cambios. |

> Los scripts están diseñados para operar desde el entorno raíz (`04-ArchitecturaeModularisCodex\03.Scripts`), sin necesidad de editar rutas absolutas.

---

## 6. Nemesis bien configurado (Anexo A)

- **Mod de datos activo:** `01.03-Frameworks-Nemesis` (contiene meshes/scripts).  
- **Ejecutable:** `00-Tools\Nemesis_Engine\Nemesis Unlimited Behavior Engine.exe`  
- **Start in:** `...\Skyrim Special Edition\Data`  
- Procedimiento:  
  1. Ejecutar `Update Engine`  
  2. Ejecutar `Launch`  
  3. Mover `overwrite` generado a `14.01-Generators-NemesisOutput`  

---

## 7. Política de vínculos y portabilidad (Anexo B)

- Todos los enlaces deben ser creados mediante `mklink` (simbólicos o de directorio) para permitir sincronización entre repositorios.  
- Las rutas del sistema AMC son portables:  
  ```
  04-ArchitecturaeModularisCodex → REPO
  05-MO2-Portable → MO2_BASE
  ```
- No se deben usar rutas absolutas codificadas en scripts; se resuelven dinámicamente.  
- En caso de clonado en otra máquina, basta con replicar la jerarquía raíz `G:\Skyrim Mods\`.

---

### 📘 Estado del documento

**AMC — Arquitectura Técnica Base**  
Versión: v0.1.1  
Autor: Sam Althaus  
Revisión: Octubre 2025  
Estado: Consolidado  
Dependencias: `PORTABILITY.md`, `AMC_Manual_v0.1.1.md`
