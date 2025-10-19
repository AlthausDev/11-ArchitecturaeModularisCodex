# AMC Addendum 0.2.0.0 — Interface Layer
**Autor:** Sam Althaus  
**Fecha:** 2025-10-19  
**Runtime:** Skyrim AE 1.6.1170  
**Estado:** Consolidado  
**Ubicación:** `06.Interface`  
**Dependencias:** `00.Core`, `01.Frameworks`, `01.10-Frameworks-UI-SkyUI`  

---

## 1. Contexto y propósito

La versión **0.2.0.0** introduce y consolida la **capa de Interfaz (06.Interface)** sobre SkyUI, con el objetivo de ofrecer una **UI moderna, clara y ergonómica**, sin alterar el gameplay ni los sistemas internos.

---

## 2. Estructura lógica (carpetas)

```
06.Interface
│
├─ 06.01-Interface-HUD
│   ├─ UIExtensions
│   └─ iWant Status Bars
│
├─ 06.02-Interface-Menus
│   ├─ MenuMaid2
│   ├─ ReCleanedMenu
│   └─ HideSkyUI
│
├─ 06.04-Interface-MCM
│   ├─ MCM Helper
│   └─ Wider MCM Menu
│
└─ 06.05-Interface-Maps
    ├─ A Quality World Map
    └─ Viewable Faction Ranks (Castellano)
```

---

## 3. Componentes (tabla técnica)

| Categoría | Mod | Versión | Estado | Descripción | Enlace |
|-----------|-----|---------|--------|-------------|--------|
| HUD | UIExtensions | 1.2 | ✅ | Framework base de menús y widgets | https://www.nexusmods.com/skyrimspecialedition/mods/17561 |
| HUD | iWant Status Bars | 2.09 | ✅ | Barras personalizables (salud/estamina/etc.) | https://www.nexusmods.com/skyrimspecialedition/mods/36460 |
| Menús | MenuMaid2 | 2.2.3 | ✅ | Reestructura y moderniza menús | https://www.nexusmods.com/skyrimspecialedition/mods/67556 |
| Menús | ReCleaned Menu | 1.1 | ✅ | Interfaz limpia, minimalista | https://www.nexusmods.com/skyrimspecialedition/mods/26680 |
| Menús | Hide SkyUI | 5.25E | ✅ | Oculta HUD/menús para capturas | https://www.nexusmods.com/skyrimspecialedition/mods/27807 |
| MCM | MCM Helper | 1.2 | ✅ | Persistencia de configuraciones MCM | https://www.nexusmods.com/skyrimspecialedition/mods/53000 |
| MCM | Wider MCM Menu | 1.2 | ✅ | Amplía tamaño de paneles en MCM | https://www.nexusmods.com/skyrimspecialedition/mods/22825 |
| Mapas | A Quality World Map | 9.0.1 | ✅ | Mapa detallado con relieve/carreteras | https://www.nexusmods.com/skyrimspecialedition/mods/5804 |
| Mapas | Viewable Faction Ranks (ES) | 1.1.1 | ✅ | Muestra rangos de facciones | https://www.nexusmods.com/skyrimspecialedition/mods/17924 |

> Nota: Versiones indicadas según snapshot actual. Verificar contra `modlist.txt` en `Profiles/` ante una reconstrucción.

---

## 4. Cambios técnicos

### 4.1 Incorporaciones
- `06.01-Interface-HUD` → `UIExtensions`, `iWant Status Bars`
- `06.02-Interface-Menus` → `MenuMaid2`, `ReCleaned Menu`, `Hide SkyUI`
- `06.04-Interface-MCM` → `MCM Helper`, `Wider MCM Menu`
- `06.05-Interface-Maps` → `A Quality World Map`, `Viewable Faction Ranks (Castellano)`

### 4.2 Modificaciones
- `Better Dialogue Controls` y `Better MessageBox Controls` **deprecados** (solapados por la nueva capa).
- Fuentes (fonts) **aplazadas** a `04.Visual` (criterio estético unificado).
- Dependencia explícita de `SkyUI` bajo `01.10-Frameworks-UI-SkyUI`.

---

## 5. Validaciones

- AE 1.6.1170 → **OK** (UI estable, sin CTDs ni regresiones funcionales).  
- Revisión manual de **MCMs** y menús principales → **OK**.  
- Integración con **MCM Helper** (persistencia) → **OK**.  
- Compatibilidad con `Address Library` y núcleo `00.Core` → **OK**.

---

## 6. Resultado

La capa **06.Interface** queda integrada y estable sobre AE 1.6.1170, con una interfaz limpia y una base MCM sólida. Se mantiene la neutralidad sobre gameplay; todos los cambios son **puramente de presentación/UX**.

---

## 7. Changelog menor — AMC v0.2.1

```
[+] Implemented modern interface layer (MenuMaid2 + MCM + HUD)
[+] Added ReCleaned Menu and HideSkyUI
[+] Integrated MCM Helper + Wider Menu
[*] Deprecated Better Dialogue Controls & MessageBox Controls
[*] Deferred Fonts to 04.Visual
[*] Validated AE 1.6.1170 compatibility
```

> Este changelog 0.2.1 resume ajustes y confirmaciones posteriores al 0.2.0.0, sin cambios de alcance.

---

## 8. Integración documental

- Registrar este archivo en `99.History/00.Addenda/AMC_Addendum_0.2.0.0.md`.  
- Incorporar referencias en `VersionIndex.md` y `AMC_Documentation_Index.md`.  
- Reflejado en `ARCHITECTURE_v0.1.1.md` (bloque **06.Interface**).  
- Revisar `PORTABILITY_v0.1.1.md` sólo si se agregan fuentes/recursos externos con rutas absolutas.

---

### 📘 Estado del Addendum
**AMC Addendum 0.2.0.0 — Interface Layer**  
Autor: Sam Althaus  
Revisión: Octubre 2025  
Estado: ✅ Consolidado  
Dependencias: `ARCHITECTURE_v0.1.1.md`, `PORTABILITY_v0.1.1.md`
