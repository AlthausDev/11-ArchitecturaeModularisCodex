# Architecturae Modularis Codex — Portabilidad y Migración
**Versión:** 0.1.1  
**Autor:** Sam Althaus  
**Fecha:** Octubre 2025  
**Estado:** Estable – Guía oficial de despliegue y replicación AMC  

---

## 1. Objetivo

Permitir la **replicación exacta** o **migración completa** del entorno AMC con **cero fricción** y **resultado determinista**, garantizando consistencia entre equipos o instalaciones.

---

## 2. Estrategias de replicación

### 🟩 A) Copia 1:1 (recomendada)

Copiar a la nueva máquina las siguientes carpetas:
```
00-Tools\
01-Downloads\
02-Archives\
03-Backups\
04-ArchitecturaeModularisCodex\
05-MO2-Portable\
```

> Luego, en MO2, ajustar la ruta del juego en **Settings → Paths → Game Location**.

---

### 🟦 B) Cloud Sync (sincronización híbrida)

Sincronizar los elementos pesados mediante OneDrive, Syncthing o Resilio Sync:

```
00-Tools\
01-Downloads\
05-MO2-Portable\
```

El repositorio (`04-ArchitecturaeModularisCodex`) se mantiene en GitHub o GitLab para control de versiones y despliegue colaborativo.

---

### 🟨 C) Reconstrucción desde manifiestos

1. Clonar el repositorio AMC.  
2. Ejecutar `Scripts\00-CreateStructure_v2.bat` → genera el árbol de carpetas AMC.  
3. Ejecutar `Scripts\02-Deploy-Config.bat` → despliega INIs base y crea el enlace simbólico.  
4. Descargar los mods según `modlist.txt` y las prioridades definidas.  
5. Instalar dependencias técnicas: Address Library, SKSE, Engine Fixes.  
6. Ejecutar Nemesis y mover `overwrite` → `14.01-Generators-NemesisOutput`.

---

## 3. Configuración de rutas relativas (MO2)

Configuración estándar recomendada en `ModOrganizer.ini`:

```
Base="."
Mods="mods"
Profiles="profiles"
Overwrite="overwrite"
Downloads="..\01-Downloads"
```

> Mantener rutas relativas asegura portabilidad completa del entorno MO2 sin necesidad de reconfigurar paths absolutos.

---

## 4. Control de versiones

Versionar siempre los siguientes elementos críticos:

```
Profiles\AMC-Base-1.6.1170\{categories.dat, modlist.txt, plugins.txt, Skyrim*.ini}
00.00-Config\
03.Scripts\
02.Docs\
ARCHITECTURE.md
PORTABILITY.md
README.md
```

> Esto garantiza que cualquier entorno AMC pueda reconstruirse de forma determinista con solo clonar el repositorio y sincronizar `Downloads`.

---

## 5. Normalización de fin de línea (CRLF / LF)

Crear un archivo `.gitattributes` en la raíz del repositorio para asegurar coherencia entre plataformas:

```
# Textos Unix
*.md   text eol=lf
*.json text eol=lf
*.yml  text eol=lf
*.yaml text eol=lf

# Config/Batch Windows
*.ini  text eol=crlf
*.toml text eol=crlf
*.bat  text eol=crlf
*.ps1  text eol=crlf

# Fallback
* text=auto
```

> Esta configuración previene inconsistencias entre desarrolladores o máquinas con distinto sistema operativo.

---

## 6. Política general de portabilidad AMC

- Las rutas de trabajo son **absolutamente replicables**: basta mantener la jerarquía raíz `G:\Skyrim Mods\`.  
- Se prioriza el uso de **enlaces simbólicos** (`mklink`) para mantener sincronía entre REPO y MO2.  
- Ningún script debe requerir edición manual de rutas; todos resuelven automáticamente su contexto.  
- Cada copia AMC debe ser funcional sin acceso a Internet, siempre que disponga de los archivos locales.  
- La sincronización en nube es opcional, nunca dependiente.

---

### 📘 Estado del documento

**AMC — Portabilidad y Migración**  
Versión: v0.1.1  
Autor: Sam Althaus  
Revisión: Octubre 2025  
Estado: Consolidado  
Dependencias: `ARCHITECTURE_v0.1.1.md`, `AMC_Manual_v0.1.1.md`
