# 🎬 AMC — Bloque 03.Animation (v0.3.0) — Estructura y nombres definitivos

Este paquete define los **nombres oficiales** para todas las carpetas/mods del bloque 03.Animation en AMC.  
Incluye la plantilla de **orden y prioridades** para MO2 y un script opcional de PowerShell para renombrar carpetas en disco.

---

## ✅ Subbloques activos en v0.3.0

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

> Los subbloques 03.04–03.10 quedan reservados para futuras expansiones.

---

## 📐 Prioridades recomendadas (MO2)

Ver `Install_Order_03-Animation.csv`. Importante: ejecuta **Nemesis** cada vez que añadas/elimines módulos MCO/DXP o Valhalla.

---

## 🛠️ Renombrado por script (opcional)

En Windows PowerShell puedes usar `rename_03_animation.ps1` para renombrar carpetas en el árbol de mods de MO2.  
**Edita las claves del diccionario `$map`** con *tus* nombres actuales como clave (izquierda) y los nombres AMC como valor (derecha).  
Ejemplo:
```
$map = @{
  "TDM (True Directional Movement)" = "03.01-Animation-Frameworks-TDM"
  "Attack - MCO DXP v1.6.0.6"       = "03.02-Animation-Combat-AttackMCO_DXP"
}
```
Luego ejecuta la consola en la carpeta raíz de mods de MO2 (por ejemplo, `...\ModOrganizer\mods`) y corre:
```
.
ename_03_animation.ps1
```

---

## 🧪 Checklist de prueba rápida

1. Activar los módulos 03.01–03.03 con las prioridades propuestas.
2. Ejecutar **Nemesis** → marcar `Attack-MCO|DXP`, `Dodge-MCO|DXP`, `Valhalla Combat` → `Update Engine` → `Launch`.
3. Verificar en `Data/SKSE/Plugins/` la presencia de: `AttackMCO.dll`, `DodgeMCO.dll`, `MovementMCO.dll`, `MCOUniversalSupport.dll`.
4. En juego: comprobar
   - Movimiento 360° (TDM), target-lock y cámara SmoothCam.
   - Combos direccionales de Attack-MCO.
   - Esquiva de Dodge-MCO (asigna tecla).
   - Parry/Hitstop de Valhalla sin daño extra.
   - Idles y variaciones EVG.

Si todo es correcto, crear snapshot: **AMC_03.0_LocomotionCore_OK**.
