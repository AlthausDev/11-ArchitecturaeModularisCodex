# Architecturae Modularis Codex (AMC)

> Arquitectura modular, portable y reproducible para construir y mantener un entorno de modding de **Skyrim Anniversary Edition 1.6.1170** con trazabilidad técnica y una estructura deliberada.

**Versión documental:** 0.5.1  
**Autor:** Sam Althaus  
**Estado:** estable / documentación viva

---

## Qué es AMC

**Architecturae Modularis Codex** no pretende ser una lista de mods cerrada. Es un **sistema de organización y operación** para un entorno de Skyrim moddeado: define dónde vive cada pieza, cómo se nombra, cómo se despliega, cómo se exporta un perfil y cómo puede reconstruirse el conjunto sin depender de una instalación opaca o artesanal.

El objetivo es tratar el modding como trataríamos un sistema técnico mantenible:

- **modularidad**, para poder sustituir piezas sin desmontar el conjunto;
- **portabilidad**, evitando dependencias innecesarias de una máquina concreta;
- **reproducibilidad**, de forma que el estado pueda reconstruirse;
- **trazabilidad**, manteniendo configuración, perfiles, scripts e historial bajo control de versiones;
- **separación de responsabilidades**, diferenciando configuración, staging, documentación, automatización y perfiles;
- **coherencia visual y semántica**, porque la estructura también debe comunicar intención.

AMC se apoya en **Mod Organizer 2 portable** como frontera entre el juego base y el entorno gestionado. La regla general es sencilla: el sistema debe poder entenderse mirando su estructura y reconstruirse siguiendo su documentación.

---

## Principios de diseño

La *Doctrine Aesthetica* resume la filosofía del proyecto en unas pocas reglas:

1. **La forma es estructura.** Los nombres, prefijos y ubicaciones tienen significado funcional.
2. **Lo explícito gana.** Un estado documentado es preferible a una dependencia implícita.
3. **La instalación del juego permanece limpia.** Siempre que sea posible, los cambios viven fuera de `Data\` y son gestionados por MO2.
4. **El orden debe ser legible.** La posición de cada bloque ayuda a entender su responsabilidad y prioridad.
5. **Todo cambio importante debe poder rastrearse.** Perfiles, configuración y documentación forman parte del estado del sistema.
6. **La estética sirve a la comprensión.** Claridad, ritmo y consistencia no son decoración: reducen fricción operativa.

La doctrina completa está en [`02.Docs/00.Core/AMC — Doctrine Aesthetica.md`](02.Docs/00.Core/AMC%20%E2%80%94%20Doctrine%20Aesthetica.md).

---

## Arquitectura del workspace

AMC está pensado para vivir dentro de un workspace similar a este:

```text
G:\Skyrim Mods\
├─ 00-Tools\
├─ 01-Downloads\
├─ 02-Archives\
├─ 03-Backups\
├─ 04-ArchitecturaeModularisCodex\
└─ 05-MO2-Portable\
```

Una configuración portable típica de MO2 mantiene rutas relativas:

```text
Base="."
Mods="mods"
Profiles="profiles"
Overwrite="overwrite"
Downloads="..\01-Downloads"
```

Esto permite mantener herramientas, descargas, snapshots, repositorio y entorno de ejecución claramente separados.

---

## Estructura real del repositorio

```text
11-ArchitecturaeModularisCodex/
├─ 00.Config/          # configuración versionada y desplegable
├─ 01.Staging/         # área de preparación y trabajo intermedio
├─ 02.Docs/            # arquitectura, doctrina, portabilidad e histórico
│  ├─ 00.Core/
│  └─ 99.History/
├─ 03.Scripts/         # automatización operativa
│  ├─ 01.Reporting/
│  ├─ 02.Deploy/
│  ├─ 03.Profile/
│  ├─ 04.Changelog/
│  └─ 05.Git/
├─ Profiles/           # snapshots reproducibles de perfiles MO2
├─ .gitattributes
├─ .gitignore
└─ README.md
```

Esta estructura refleja el modelo actual del repositorio y sustituye a las referencias antiguas a carpetas genéricas `Docs/` y `Scripts/`.

---

## Convención de categorías AMC

Los mods se ordenan con el formato:

```text
XX.YY-Parent-SubgroupPascal
```

Donde:

- `XX` identifica el bloque funcional principal;
- `YY` mantiene un orden estable dentro del bloque;
- `Parent/Subgroup` expresa la responsabilidad funcional;
- `PascalCase` mantiene nombres compactos y legibles.

Ejemplos:

```text
00.01-Core-AddressLibrary
01.03-Frameworks-Nemesis
04.03-Visual-Lighting
14.01-Generators-NemesisOutput
```

### Bloques funcionales

| Bloque | Área | Responsabilidad |
|---:|---|---|
| 00 | Core | Núcleo técnico, librerías y fixes |
| 01 | Frameworks | Extensores, SKSE y dependencias compartidas |
| 02 | Gameplay | Mecánicas, progresión y supervivencia |
| 03 | Animation | Movimiento, combate y locomoción |
| 04 | Visual | Texturas, iluminación y clima |
| 05 | Audio | Música, ambiente y SFX |
| 06 | Interface | HUD, menús, MCM y mapas |
| 07 | World | Mundo, ciudades, flora y LOD |
| 08 | NPCs | NPC, criaturas y overhauls |
| 09 | Items | Armas, armaduras, economía y objetos |
| 10 | Quests | Misiones, diálogos y expansiones |
| 11 | Adult | Frameworks, animaciones e interfaz asociada |
| 12 | Patches | Resolución de conflictos y compatibilidad |
| 13 | Overrides | Ajustes tardíos y sustituciones deliberadas |
| 14 | Generators | Nemesis, DynDOLOD, TexGen, Synthesis, etc. |
| 15 | DevTools | Diagnóstico, logs y utilidades de desarrollo |
| 99 | Unsorted | Triage temporal antes de clasificación |

---

## Automatización

La automatización está agrupada por responsabilidad dentro de [`03.Scripts/`](03.Scripts/):

| Área | Propósito |
|---|---|
| `01.Reporting` | inspección, reporting y estado del entorno |
| `02.Deploy` | despliegue de configuración y componentes externos |
| `03.Profile` | importación/exportación y mantenimiento de perfiles |
| `04.Changelog` | snapshots y generación de historial de cambios |
| `05.Git` | operaciones Git repetitivas del flujo AMC |

El manual de scripts se encuentra en [`03.Scripts/AMC_Manual_v0.1.0.md`](03.Scripts/AMC_Manual_v0.1.0.md).

---

## Flujo de trabajo recomendado

```text
Skyrim limpio
   ↓
MO2 portable
   ↓
Estructura AMC
   ↓
Configuración base
   ↓
Core + frameworks
   ↓
Gameplay / visual / contenido
   ↓
Patches + overrides
   ↓
Generators
   ↓
Exportar perfil
   ↓
Documentar + versionar
```

En términos prácticos:

1. partir de una instalación limpia de Skyrim AE compatible;
2. configurar MO2 en modo portable;
3. desplegar la estructura y configuración AMC;
4. instalar primero núcleo técnico y frameworks;
5. incorporar módulos funcionales respetando las categorías;
6. resolver compatibilidad en `12.Patches` y ajustes tardíos en `13.Overrides`;
7. regenerar outputs derivados en `14.Generators`;
8. exportar el perfil activo a `Profiles/`;
9. revisar cambios y documentación;
10. cerrar el estado mediante Git.

---

## Documentación principal

La documentación de referencia vive en [`02.Docs/`](02.Docs/):

- [`ARCHITECTURE_v0.1.1.md`](02.Docs/00.Core/ARCHITECTURE_v0.1.1.md) — arquitectura y responsabilidades del sistema.
- [`PORTABILITY_v0.1.1.md`](02.Docs/00.Core/PORTABILITY_v0.1.1.md) — criterios de portabilidad y reconstrucción.
- [`AMC — Doctrine Aesthetica.md`](02.Docs/00.Core/AMC%20%E2%80%94%20Doctrine%20Aesthetica.md) — principios de diseño y coherencia.
- [`AMC_Documentation_Guide_v0.1.1.md`](02.Docs/AMC_Documentation_Guide_v0.1.1.md) — convención para mantener la documentación.
- [`Estado actual y roadmap.txt`](02.Docs/00.Core/Estado%20actual%20y%20roadmap.txt) — estado y líneas de evolución.
- [`99.History/`](02.Docs/99.History/) — histórico y addenda del proyecto.

---

## Estado del proyecto

La rama `master` representa el estado versionado del sistema. AMC mantiene actualmente:

- estructura modular consolidada;
- configuración separada del contenido instalado;
- perfiles MO2 versionables;
- documentación técnica y doctrinal;
- scripts agrupados por responsabilidad;
- histórico de evolución del sistema.

El objetivo hacia `v1.0` no es aumentar complejidad por sí misma, sino reducir trabajo manual y hacer que reconstruir, auditar o migrar AMC sea cada vez más determinista.

---

## Alcance y filosofía

AMC es un proyecto personal de ingeniería aplicada al modding. No intenta imponer una única selección de mods ni competir con una modlist automatizada. Su interés está en la **arquitectura que hace mantenible una instalación compleja**.

Si una pieza puede sustituirse sin romper el modelo, si un perfil puede reconstruirse sin depender de memoria informal y si otro estado del sistema puede compararse con Git, AMC está cumpliendo su función.

---

## Licencia y atribución

La documentación, scripts y material original de AMC pueden reutilizarse bajo la [licencia de atribución](LICENSE).

Si reutilizas una parte sustancial del proyecto, incluye una referencia razonable a **Sam Althaus / AlthausDev** y, cuando sea práctico, al repositorio original. Mods, herramientas, assets y otros componentes de terceros conservan sus propias licencias y derechos.

---

## Créditos

**Diseño y arquitectura:** Sam Althaus  
**Ecosistema técnico:** comunidad de Skyrim modding y autores de las herramientas integradas  
**Referencias metodológicas:** proyectos y modlists que han demostrado el valor de la reproducibilidad, separación por capas y documentación mantenible
