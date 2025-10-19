# ⚙️ Architecturae Modularis Codex — Bloque 02: Gameplay Layer
**Versión:** v0.2.5  **Estado:** 🟢 Completado  
**Fecha de cierre:** 12 / 10 / 2025  
**Estructura AE:** Validada  **Revisión general pendiente:** fase final de AMC v1.0.0

## 🧩 Resumen funcional
El Gameplay Layer define la base mecánica del universo AE. Integra combate, economía, supervivencia, progresión racial y poderes sobrenaturales, manteniendo coherencia interna y estabilidad técnica.

## 🧱 Subbloques implementados
| Nº | Bloque | Mods principales | Estado | Descripción funcional |
|----|---------|------------------|---------|-----------------------|
| **02.01** | 🗡️ Combat | Wildcat, Smart NPC Potions (+Castellano) | ✅ | IA táctica y combate equilibrado. |
| **02.05** | ⚖️ Balance | Timing is Everything, Trade & Barter | ✅ | Control de progresión y economía global. |
| **02.06** | 🧭 Progression | *(vacante)* | ⚪ | Experience eliminado. |
| **02.07** | ❄️ Survival & 🧛 Vampirism | SunHelm, Sacrilege, Cover Your Head, Night Eye Overhaul, Sunlight Dispels Night Eye (+Castellano) | ✅ | Hambre/sed/sueño ligeros y vampirismo pasivo estable. |
| **02.10** | 💰 Economy | Trade & Barter (+Castellano) | ✅ | Economía escalada. |
| **02.12** | 🪶 Standing Stones | Andromeda (+Castellano) | ✅ | Bendiciones reequilibradas. |
| **02.14** | 🌙 Races | Imperious (+Castellano) | ✅ | Diversidad racial Simonrim. |

## 🩸 Vampirism Layer — Sanguis Quietus Profile
| Módulo | Descripción | Compatibilidad |
|---------|--------------|----------------|
| Sacrilege (Core) | Núcleo vampírico AE-friendly. | Total |
| Cover Your Head | Protección solar condicional. | Total |
| Night Eye Overhaul / Sunlight Dispels Night Eye | Visión nocturna estable. | Total |
| Subtle Appearance / Less Sun Damage (opc.) | Estética discreta. | Total |

## 🔧 Compatibilidad general
| Sistema | Estado | Observaciones |
|----------|---------|----------------|
| SunHelm Survival | 🟢 | Sin duplicaciones. |
| SKSE / Nemesis / Po3 | 🟢 | Frameworks actualizados. |
| Experience | ⚪ | Retirado por decisión de jugabilidad. |
| Simonrim suite | 🟢 | Coherencia completa. |

## 📂 Estructura de carpetas
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


