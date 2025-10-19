# AMC — VersionIndex (Addenda & Releases)
**Generado:** 2025-10-19  
**Mantenimiento:** Estándar AMC v0.1.1 (Documentation Guide)  

---

## 1) Addenda
| Orden | Versión | Fecha | Título | Bloque | Estado |
|:--:|:--:|:--|:--|:--|:--:|
| 1 | **0.1.0.0** | 2025-10-05 09:59 | Core & Frameworks Consolidation | 00/01 | ✅ |
| 2 | **0.2.0.0** | 2025-10-19 | Interface Layer | 06.Interface | ✅ |
| 3 | **0.2.5.0** | 2025-10-12 | Gameplay Layer | 02.Gameplay | ✅ |
| 4 | **0.3.0.0** | 2025-10-19 | Animation Layer (Naming & Structure) | 03.Animation | ✅ |
| 5 | **0.4.0.0** | 2025-10-19 | World Layer (Final) | 07.World | ✅ |
| 6 | **0.5.0.0** | 2025-10-19 | NPC Creatures & Entities Layer | 08.NPCs | ✅ |
| 7 | **0.5.1.0** | 2025-10-19 | Final Stabilization: Generators, Patches & Packaging | 12/13/14/15 | ✅ |

> Fechas según los documentos generados y el árbol histórico actual. Ajustar si existe un registro oficial alternativo en `99.History/01.Changelog`.

---

## 2) Releases (99.History/02.Releases)
| Versión | Paquete | Descripción |
|:--:|:--|:--|
| 0.1.0.0 | AMC_0.1.0.0.zip | Bloques Core + Frameworks |
| 0.2.1.0 | AMC_v0.2.1_Interface_Layer.zip | Capa UI moderna (MCM/HUD) |
| 0.2.2.0 | AMC_v0.2.2_Audio_Layer.zip | Base sonora y efectos |
| 0.2.5.0 | AMC_v0.2.5_GameplayLayer.zip | Sistema de juego completo |
| 0.3.0.0 | AMC_v0.3.0_Animation_Naming.zip | Animaciones y nomenclatura definitiva |
| 0.4.0.0 | AMC_v0.4.0_WorldLayer_Final.zip | Entorno completo y estable |
| 0.5.1.0 | AMC_v0.5.1_DoctrineAesthetica.zip | Estabilización final + paquete técnico (manifiesto aparte) |

---

## 3) Dependencias entre Addenda
```
0.1.0  →  0.2.0  →  0.2.5  →  0.3.0  →  0.4.0  →  0.5.0  →  0.5.1
(Core)    (UI)      (Gameplay) (Animation) (World)  (Creatures) (Final)
```

---

## 4) Notas de mantenimiento
- Cada Addendum debe enlazar a **ARCHITECTURE_v0.1.1.md** y **PORTABILITY_v0.1.1.md**.  
- El `CHANGELOG` por snapshot se mantiene bajo `99.History/01.Changelog/YYYY-MM-DD_HHMMSS/`.  
- Los scripts de soporte (TreeReport, Deploy, Export) permanecen en `03.Scripts` del repositorio.  
