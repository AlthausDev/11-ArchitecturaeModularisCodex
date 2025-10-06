# AMC v0.2.0.0 — Interface Layer

**Estado:** ✅ Estable  
**Versión:** AMC v0.2.0  
**Ubicación:** `06.Interface`  
**Dependencias:** `01.10-Frameworks-UI-SkyUI`, `00.Core`, `01.Frameworks`  
**AE Compatible:** ✔️ 1.6.1170  
**Autor:** Sam Althaus  

---

## 📘 Propósito
El bloque **06.Interface** constituye la capa visual y de interacción del jugador.  
Su objetivo es ofrecer una interfaz moderna, clara y ergonómica sobre el entorno base de SkyUI, sin alterar el gameplay ni los sistemas internos.

---

## ⚙️ Estructura

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
├─ 06.05-Interface-Maps
   ├─ A Quality World Map
   └─ Viewable Faction Ranks (Castellano)

```

---

## 🧩 Tabla de componentes

| Categoría | Mod | Versión | Estado | Descripción | Enlace |
|------------|------|----------|---------|--------------|--------|
| HUD | UIExtensions | 1.2 | ✅ | Framework base de menús y widgets | https://www.nexusmods.com/skyrimspecialedition/mods/17561 |
| HUD | iWant Status Bars | 2.09 | ✅ | Barras personalizables para salud, estamina y hambre | https://www.nexusmods.com/skyrimspecialedition/mods/36460 |
| Menús | MenuMaid2 | 2.2.3 | ✅ | Reestructura y moderniza los menús | https://www.nexusmods.com/skyrimspecialedition/mods/67556 |
| Menús | ReCleaned Menu | 1.1 | ✅ | Interfaz limpia, minimalista y funcional | https://www.nexusmods.com/skyrimspecialedition/mods/26680 |
| Menús | Hide SkyUI | 5.25E | ✅ | Permite ocultar HUD o interfaz para capturas | https://www.nexusmods.com/skyrimspecialedition/mods/27807 |
| MCM | MCM Helper | 1.2 | ✅ | Persistencia de configuraciones MCM | https://www.nexusmods.com/skyrimspecialedition/mods/53000 |
| MCM | Wider MCM Menu | 1.2 | ✅ | Amplía tamaño de paneles en MCM | https://www.nexusmods.com/skyrimspecialedition/mods/22825 |
| Mapas | A Quality World Map | 9.0.1 | ✅ | Mapa detallado con relieve y carreteras | https://www.nexusmods.com/skyrimspecialedition/mods/5804 |
| Mapas | Viewable Faction Ranks | 1.1.1 | ✅ | Muestra rangos de facciones | https://www.nexusmods.com/skyrimspecialedition/mods/17924 |


---

## 📜 Changelog AMC v0.2.1

```
[+] Implemented modern interface layer (MenuMaid2 + MCM + HUD)
[+] Added ReCleaned Menu and HideSkyUI
[+] Integrated MCM Helper + Wider Menu
[*] Deprecated Better Dialogue Controls & MessageBox Controls
[*] Deferred Fonts to 04.Visual
[*] Validated AE 1.6.1170 compatibility
```
