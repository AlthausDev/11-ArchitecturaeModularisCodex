# Architecturae Modularis Codex (AMC)

Framework modular para *Skyrim Special Edition* **1.6.1170** (AE runtime) diseñado por Sam Althaus.
Objetivo: **arquitectura limpia, portable y versionable** para un modlist curado a mano, con control jerárquico y rollback fácil.

---

## 🎯 Principios
- **Portabilidad:** rutas relativas y MO2 en modo *portable*.
- **Modularidad:** categorías finas alineadas con el impacto en el juego.
- **Trazabilidad:** perfiles y cambios versionados (Git / snapshots).
- **Reversibilidad:** *rollback* inmediato por perfil/patch.
- **Documentación:** decisiones y estructura en texto claro.

---

## 🧭 Estructura de carpetas (resumen)
```
Skyrim Mods/
├─ 00_Tools/
│  ├─ ModOrganizer2/
│  ├─ LOOT/ ─ xEdit/ ─ BethINI/ ─ CAO/ ─ Nemesis/
├─ 01_Downloads/           (zips de Nexus)
├─ 02_Archives/            (backups manuales)
├─ 03_Docs/                (PDFs, guías, notas)
├─ 04_Profiles/            (backups de perfiles MO2)
├─ 05_Backups/             (vanilla, INIs, saves limpios)
└─ Skyrim_MO2_Portable/
   ├─ mods/
   ├─ profiles/
   ├─ overwrite/
   └─ logs/
```

> En MO2 (**Settings → Paths**) usar rutas relativas:  
> `Base="."  | Mods="mods" | Profiles="profiles" | Overwrite="overwrite" | Downloads="..\01_Downloads"`

---

## 🧱 Categorías AMC
El archivo `categories.dat` incluye **13 bloques principales y subcategorías** (ver `categories.dat`).  
Colócalo en el perfil activo de MO2:

```
Skyrim_MO2_Portable\profiles\<Perfil_Activo>\categories.dat
```

Sugerencia de perfil: `AMC_Base_1.6.1170`

---

## 🧰 Herramientas base
- **MO2 (portable)** — gestor central
- **SKSE64 2.2.6** — scripts extendidos (para 1.6.1170)
- **Address Library (AE 1.6.1170)** — soporte DLLs
- **Nemesis** — animaciones/behaviors (ejecutable externo + mod de datos)
- **LOOT / xEdit / BethINI / CAO** — orden, limpieza, INIs y optimización

> Nota: no se recomienda comprar el *AE Full Upgrade* en este proyecto; añadimos contenido CC **a mano** si aporta valor.

---

## 🔧 Flujo de trabajo recomendado
1. **Instalación limpia** (no abrir el juego antes de configurar).
2. **MO2 portable + rutas relativas**.
3. **Perfiles AMC** (INIs/Saves por perfil).
4. **Importar `categories.dat`** y ordenar el árbol por categoría.
5. **SKSE + Address Library** (Address como mod en MO2).
6. **Frameworks base** → **Visuales** → **Gameplay** → **Áreas** → **Quests** → **UI** → **Parches**.
7. **Generadores** (Nemesis, LOD) y **Bashed/Smashed/Merged** al final.
8. **Commits pequeños y descriptivos** (un bloque o mod por commit).

---

## 🧩 Adult frameworks
AMC contempla un bloque dedicado (08b) para **OStim/OSex**, expansiones y animaciones NSFW, aislado del resto de animaciones para control total y fácil parcheo.

---

## 🗂️ Git (sugerencia de `.gitignore`)
```
01_Downloads/
Skyrim_MO2_Portable/mods/*
!Skyrim_MO2_Portable/mods/.keep
Skyrim_MO2_Portable/overwrite/
*.zip
*.rar
*.7z
*.log
*.tmp
```

Se recomienda **versionar** `profiles/`, `categories.dat`, `modlist.txt`, `plugins.txt`, y documentación `03_Docs/`.

---

## 📌 Compatibilidad
- **Runtime**: 1.6.1170 (AE)  
- **SKSE**: 2.2.6  
- **Address Library**: AE (incluye 1.6.1170)  

---

## 🖊️ Créditos / Inspiración
- Halls of Ysgramor (LLO)
- Lexy's LOTD / The Phoenix Flavour (metodología)
- Prácticas de *modding* profesional y control de versiones

---

## 📜 Licencia
Privado/personal por ahora. Ajustar si se publica.
```

