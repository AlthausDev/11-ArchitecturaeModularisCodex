# AMC Addendum 0.3.0.0 — Animation Layer (Naming & Structure)
**Autor:** Sam Althaus  
**Fecha:** 2025-10-19  
**Runtime:** Skyrim AE 1.6.1170  
**Versión:** v0.3.0  
**Estado:** ✅ Consolidado  
**Ubicación:** `03.Animation`  
**Dependencias:** `00.Core`, `01.Frameworks` (SKSE/Address Library/Nemesis), `06.Interface` (SmoothCam/TDM UI)  

---

## 1) Propósito
Definir los **nombres oficiales** y la **estructura de carpetas** del bloque `03.Animation` en AMC, junto con el orden recomendado en MO2 y un script opcional para **normalizar nombres en disco**.  
El objetivo es asegurar **determinismo**, **compatibilidad con Nemesis** y **lectura humana** consistente.

---

## 2) Subbloques activos en v0.3.0

### 03.01 — Animation Frameworks
- `03.01-Animation-Frameworks-TDM`
- `03.01-Animation-Frameworks-MCOUniversalSupport`
- `03.01-Animation-Frameworks-NemesisOutput` *(autogenerado tras compilar)*

### 03.02 — Animation Combat
- `03.02-Animation-Combat-AttackMCO_DXP`
- `03.02-Animation-Combat-MovementMCO_DXP`
- `03.02-Animation-Combat-ValhallaCombat`

### 03.03 — Animation Locomotion
- `03.03-Animation-Locomotion-EVGConditionalIdles`
- `03.03-Animation-Locomotion-EVGAnimationVariance`
- `03.03-Animation-Locomotion-SmoothCam`

> Los subbloques **03.04–03.10** quedan reservados para expansiones futuras (Creatures/1stPerson/Patches/etc.).

---

## 3) Prioridades y orden (MO2)
Consultar `Install_Order_03-Animation.csv` para importar el orden de instalación.  
**Regla:** Ejecuta **Nemesis** cada vez que añadas/elimines módulos **MCO/DXP** o **Valhalla**.

---

## 4) Renombrado por script (opcional)
Script opcional de PowerShell `rename_03_animation.ps1` para normalizar nombres en `...\ModOrganizer\mods`.  
**Edita el diccionario `$map`** con *tu nombre actual* (izquierda) → *nombre AMC* (derecha):

```powershell
# rename_03_animation.ps1  (ejecutar desde la carpeta "mods" de MO2)
param(
  [string]$Root = "."
)

$map = @{
  "TDM (True Directional Movement)" = "03.01-Animation-Frameworks-TDM"
  "Attack - MCO DXP v1.6.0.6"       = "03.02-Animation-Combat-AttackMCO_DXP"
  "Movement - MCO DXP"              = "03.02-Animation-Combat-MovementMCO_DXP"
  "Valhalla Combat SE"              = "03.02-Animation-Combat-ValhallaCombat"
  "EVG Conditional Idles"           = "03.03-Animation-Locomotion-EVGConditionalIdles"
  "EVG Animation Variance"          = "03.03-Animation-Locomotion-EVGAnimationVariance"
  "SmoothCam"                       = "03.03-Animation-Locomotion-SmoothCam"
}

foreach ($kv in $map.GetEnumerator()) {
  $src = Join-Path $Root $kv.Key
  $dst = Join-Path $Root $kv.Value
  if (Test-Path -LiteralPath $src) {
    if (-not (Test-Path -LiteralPath $dst)) {
      Write-Host "[REN] $($kv.Key)  ->  $($kv.Value)"
      Rename-Item -LiteralPath $src -NewName $kv.Value
    } else {
      Write-Warning "[SKIP] Ya existe destino: $($kv.Value)"
    }
  } else {
    Write-Warning "[MISS] No encontrado: $($kv.Key)"
  }
}
```

**Ejecutar:**
```powershell
# Desde la raíz de mods (ej. ...\ModOrganizer\mods)
.ename_03_animation.ps1
```

---

## 5) Checklist de prueba rápida
1. Activar los módulos **03.01–03.03** con las prioridades propuestas.  
2. Ejecutar **Nemesis** → marcar `Attack-MCO|DXP`, `Dodge-MCO|DXP`, `Valhalla Combat` → `Update Engine` → `Launch`.  
3. Verificar en `Data/SKSE/Plugins/` la presencia de:  
   `AttackMCO.dll`, `DodgeMCO.dll`, `MovementMCO.dll`, `MCOUniversalSupport.dll`.  
4. En juego comprobar:  
   - **TDM**: movimiento 360°, target-lock + cámara **SmoothCam**.  
   - **Attack-MCO**: combos direccionales.  
   - **Dodge-MCO**: esquiva funcionando (tecla asignada).  
   - **Valhalla**: parry/hitstop sin daño extra espurio.  
   - **EVG**: idles/variaciones activas.

Si todo es correcto, crear snapshot: **AMC_03.0_LocomotionCore_OK**.

---

## 6) Resultado
Queda establecida la **nomenclatura oficial** del bloque 03.Animation y su **estructura determinista** en MO2.  
La compilación con Nemesis es **repetible**, y el mapeo de carpetas permite mantener **consistencia** entre equipos.

---

## 7) Integración documental
- Registrar como `99.History\00.Addenda\AMC_Addendum_0.3.0.0.md`.  
- Actualizar `VersionIndex.md` y `AMC_Documentation_Index.md`.  
- Referenciar en `ARCHITECTURE_v0.1.1.md` (bloque **03.Animation**).

---

### 📘 Estado del Addendum
**AMC Addendum 0.3.0.0 — Animation Layer (Naming & Structure)**  
Autor: Sam Althaus — Revisión: Octubre 2025 — Estado: ✅ Consolidado
