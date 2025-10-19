# AMC Addendum 0.1.0.0 — Core & Frameworks Consolidation
**Autor:** Sam Althaus  
**Fecha:** 2025-10-05 09:59  
**Runtime:** Skyrim AE 1.6.1170  
**Estado:** Consolidado  
**Dependencias:** ARCHITECTURE_v0.1.1.md, PORTABILITY_v0.1.1.md  

---

## 1. Contexto general

Versión que consolida los bloques **00-Core** y **01-Frameworks** bajo el runtime **Skyrim AE 1.6.1170**.  
Marca el inicio del entorno AMC en estado funcional y reproducible.

---

## 2. Cambios técnicos

| Tipo | Bloque | Acción | Detalle |
|:--:|:--|:--|:--|
| ➕ | 00.04-Core-BugFixes | Añadido | `Bug Fixes SSE` (v10, AE 1.6.629+) |
| ➕ | 01.02-Frameworks-Behavior | Añadido | `Animation Queue Fix NG` |
| ➕ | 01.06-Frameworks-UI | Añadido | `TrueHUD` *(API-only)* |
| ⚙️ | 01.06-Frameworks-UI | Sustitución | `MCM Helper` reemplaza a `FISSES` (incompatible con AE 1.6.1170) |

---

## 3. Validaciones realizadas

- Revisión de logs:  
  - `bugfixesSSE.log` → ✅ OK  
  - `AnimationQueueFix.log` → ✅ OK  
  - `TrueHUD.log` → ✅ OK  
- Pruebas in-game realizadas sin incidentes.  
- Verificación de compatibilidad con `Address Library` (AE runtime).  

---

## 4. Resultado

El entorno base AMC queda **estable en bloques 00 y 01**:  
- Todos los frameworks esenciales funcionan sobre AE 1.6.1170.  
- Los logs confirman ejecución limpia de librerías y plugins.  
- Se sienta la base para la integración de `02-Gameplay`.

---

## 5. Integración documental

- Registrado en `99.History/00.Addenda/` como `AMC_Addendum_0.1.0.0.md`.  
- Referenciado en `VersionIndex.md` y `AMC_Documentation_Index.md`.  
- Integrado en `ARCHITECTURE_v0.1.1.md` (bloques **00-Core** y **01-Frameworks**).  
- Validado en entorno Normandy (Win10, MO2 Portable).

---

### 📘 Estado del Addendum
**AMC Addendum 0.1.0.0 — Core & Frameworks Consolidation**  
Autor: Sam Althaus  
Revisión: Octubre 2025  
Estado: ✅ Consolidado  
Dependencias: `ARCHITECTURE_v0.1.1.md`, `PORTABILITY_v0.1.1.md`
