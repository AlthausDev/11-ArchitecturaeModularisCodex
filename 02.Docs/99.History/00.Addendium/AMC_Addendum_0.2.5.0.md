# AMC Addendum 0.2.5.0 — Gameplay Layer
**Autor:** Sam Althaus  
**Fecha:** 2025-10-12  
**Runtime:** Skyrim AE 1.6.1170  
**Versión:** v0.2.5  
**Estado:** 🟢 Completado  
**Dependencias:** `ARCHITECTURE_v0.1.1.md`, `PORTABILITY_v0.1.1.md`  
**Ubicación:** `02.Gameplay`  
**Revisión general:** Pendiente (fase final AMC v1.0.0)  

---

## 1. Contexto y propósito

El **Gameplay Layer (Bloque 02)** define la base mecánica del universo AE.  
Integra combate, economía, supervivencia, progresión racial y poderes sobrenaturales, manteniendo **coherencia interna**, **rendimiento estable** y **compatibilidad completa con AE 1.6.1170**.

---

## 2. Subbloques implementados

| Nº | Bloque | Mods principales | Estado | Descripción funcional |
|:--:|:--|:--|:--:|:--|
| 02.01 | 🗡️ **Combat** | Wildcat, Smart NPC Potions *(+Castellano)* | ✅ | IA táctica y combate equilibrado. |
| 02.05 | ⚖️ **Balance** | Timing is Everything, Trade & Barter | ✅ | Control de progresión y economía global. |
| 02.06 | 🧭 **Progression** | *(vacante)* | ⚪ | `Experience` eliminado (replanteo futuro). |
| 02.07 | ❄️ **Survival & Vampirism** | SunHelm, Sacrilege, Cover Your Head, Night Eye Overhaul, Sunlight Dispels Night Eye *(+Castellano)* | ✅ | Hambre/sed/sueño ligeros y vampirismo pasivo estable. |
| 02.10 | 💰 **Economy** | Trade & Barter *(+Castellano)* | ✅ | Economía escalada. |
| 02.12 | 🪶 **Standing Stones** | Andromeda *(+Castellano)* | ✅ | Bendiciones reequilibradas. |
| 02.14 | 🌙 **Races** | Imperious *(+Castellano)* | ✅ | Diversidad racial **Simonrim**. |

---

## 3. Vampirism Layer — *Sanguis Quietus* Profile

| Módulo | Descripción | Compatibilidad |
|:--|:--|:--|
| **Sacrilege (Core)** | Núcleo vampírico AE-friendly | ✅ Total |
| **Cover Your Head** | Protección solar condicional | ✅ Total |
| **Night Eye Overhaul / Sunlight Dispels Night Eye** | Visión nocturna estable | ✅ Total |
| **Subtle Appearance / Less Sun Damage (opc.)** | Estética discreta y coherente | ✅ Total |

> Esta configuración unifica el perfil vampírico **Sanguis Quietus**, priorizando inmersión y coherencia visual sin alterar el balance de combate.

---

## 4. Compatibilidad general

| Sistema | Estado | Observaciones |
|:--|:--:|:--|
| **SunHelm Survival** | 🟢 | Integración completa, sin duplicaciones. |
| **SKSE / Nemesis / Po3** | 🟢 | Frameworks actualizados y funcionales. |
| **Experience** | ⚪ | Retirado voluntariamente (interferencia con pacing). |
| **Simonrim suite** | 🟢 | Coherencia completa con filosofía de diseño. |

---

## 5. Estructura de carpetas

```
02-Gameplay/
 ├── 02.01-Combat/
 ├── 02.05-Balance/
 ├── 02.06-Progression/
 ├── 02.07-Vampires/
 │    ├── Sacrilege/
 │    ├── CoverYourHead/
 │    ├── NightEyeOverhaul/
 │    ├── SunlightDispelsNightEye/
 │    └── VisualTweaks/
 ├── 02.08-Survival/
 ├── 02.10-Economy/
 ├── 02.12-StandingStones/
 └── 02.14-Races/
```

> Estructura validada contra `TreeReport_2025-10-12.txt`.

---

## 6. Validaciones

- Pruebas in-game (SunHelm + Sacrilege) → ✅ Estables  
- Scripts revisados y sin duplicación de hooks SKSE  
- Integración de AI Overhauls y balance económico sin conflictos  
- Vampirismo estable (sin softlocks ni reinicios de efectos)  
- 0 CTDs registrados en 3h de testing AE 1.6.1170  

---

## 7. Resultado

El bloque **02.Gameplay** queda plenamente operativo:  
- Mecanismos principales equilibrados.  
- Compatibilidad confirmada con los frameworks base (SKSE, Po3, Simonrim).  
- Estética y dificultad ajustadas al tono Aeteris / AMC.

> Este bloque constituye la **base jugable estable** del entorno AMC previo a la integración de Animation Layer (v0.3.0).

---

## 8. Integración documental

- Registrado en `99.History/00.Addenda/AMC_Addendum_0.2.5.0.md`.  
- Referenciado en `VersionIndex.md` y `AMC_Documentation_Index.md`.  
- Integrado en `ARCHITECTURE_v0.1.1.md` (bloque **02.Gameplay**).  
- Validado y documentado en entorno Normandy (Win10, MO2 Portable).  

---

### 📘 Estado del Addendum
**AMC Addendum 0.2.5.0 — Gameplay Layer**  
Autor: Sam Althaus  
Revisión: Octubre 2025  
Estado: ✅ Consolidado  
Dependencias: `ARCHITECTURE_v0.1.1.md`, `PORTABILITY_v0.1.1.md`
