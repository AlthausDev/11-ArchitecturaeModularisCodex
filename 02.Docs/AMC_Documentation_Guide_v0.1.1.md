# AMC Documentation Guide
**Versión:** 0.1.1  
**Autor:** Sam Althaus  
**Fecha:** Octubre 2025  
**Estado:** Estable – Guía oficial de documentación del sistema AMC  

---

## 1. Objetivo

Definir el sistema de documentación modular, versionado y trazable del **Architecturae Modularis Codex (AMC)**, asegurando coherencia entre los archivos técnicos, guías y registros históricos.

Este documento actúa como manual interno de mantenimiento documental y estandarización de versiones.

---

## 2. Estructura documental actual (Volumen Normandy)

```
G:\Skyrim Mods\04-ArchitecturaeModularisCodex\02.Docs\
│
├── 00.Core\                  ← Documentos base activos
│    ├── ARCHITECTURE_v0.1.1.md
│    ├── PORTABILITY_v0.1.1.md
│    └── ...
│
├── 01.Guides\                ← Manuales, protocolos y guías de desarrollo
│    └── AMC_Documentation_Guide_v0.1.1.md
│
└── 99.History\               ← Archivo histórico completo
     ├── 00.Addenda\          ← Addenda y versiones intermedias
     ├── 01.Changelog\        ← Registros automáticos de cambios (por fecha)
     │    └── YYYY-MM-DD_HHMMSS\{Changelog, Diff, EnabledMods.*}
     ├── 02.Releases\         ← Paquetes comprimidos por versión
     │    └── AMC_vW.X.Y_*.zip
     ├── 03.ArchitectureTree\ ← Inventarios de estructura (TreeReports)
     └── 04.Logs\             ← Registros de ejecución de scripts
```

> Las rutas reflejan la organización real del entorno AMC en el volumen **Normandy**.  
> Cada nivel está pensado para integrarse sin conflictos con los scripts de auditoría y despliegue.

---

## 3. Ciclo de versión (SemVer-4)

**Formato:** `W.X.Y.Z`

| Campo | Descripción | Ejemplo |
|:--:|:--|:--|
| **W** | Cambios mayores de arquitectura o runtime | 1.0.0.0 |
| **X** | Nuevas capas o bloques completos | 0.1.0.0 |
| **Y** | Paquetes o conjuntos de funcionalidades | 0.0.2.0 |
| **Z** | Hotfixes, documentación o parches menores | 0.0.1.1 |

> Todas las versiones deben corresponderse con un estado funcional verificable del entorno AMC.

---

## 4. Flujo documental AMC

1. **Validar cambios funcionales o estructurales.**  
   Verificar que el entorno o los scripts estén en estado estable antes de documentar.

2. **Crear Addendum.**  
   Guardar en `99.History\00.Addenda\AMC_Addendum_W.X.Y.Z.md`.  
   El Addendum detalla cambios, contexto y módulos afectados.

3. **Integrar cambios.**  
   Actualizar los documentos base (`ARCHITECTURE`, `PORTABILITY`, etc.) en `00.Core\`.

4. **Archivar el Addendum.**  
   Mover el archivo consolidado a `99.History\00.Addenda\` y registrar el cambio en `01.Changelog\`.

5. **Actualizar índices.**  
   - `VersionIndex.md` dentro de `99.History\` → registro cronológico de Addenda y Releases.  
   - `AMC_Documentation_Index.md` dentro de `01.Guides\` → índice funcional de documentación activa.

6. **Commit y sincronización.**  
   Ejecutar `05-GitQuickPush.bat` para registrar los cambios y subirlos al repositorio remoto.

---

## 5. Convenciones de nomenclatura

| Tipo de documento | Formato | Ejemplo |
|:--|:--|:--|
| Documento base | `AMC_<Nombre>_vW.X.Y.md` | `AMC_ARCHITECTURE_v0.1.1.md` |
| Addendum | `AMC_Addendum_W.X.Y.Z.md` | `AMC_Addendum_0.2.5.0.md` |
| Changelog | `AMC-Core-Changelog_YYYY-MM-DD_HHMMSS.md` | `AMC-Core-Changelog_2025-10-19_032336.md` |
| Release | `AMC_vW.X.Y_<Etiqueta>.zip` | `AMC_v0.4.0_WorldLayer_Final.zip` |
| Índice documental | `AMC_Documentation_Index.md` | — |

> Todos los archivos deben comenzar con el prefijo **AMC_** para mantener compatibilidad con los scripts de auditoría y los procesos de archivado.

---

## 6. Política de mantenimiento documental

- Los archivos en `00.Core` son **documentos vivos**, sujetos a actualización.  
- Las guías y protocolos se alojan en `01.Guides` para mantener independencia semántica.  
- Todo cambio mayor o ruptura estructural incrementa los niveles **W** o **X**.  
- Los Addenda menores pueden agruparse antes de un release consolidado.  
- Cada release comprimido (`99.History\02.Releases`) debe incluir:
  - Los documentos de `00.Core`
  - Los Addenda integrados
  - `VersionIndex.md` y `CHANGELOG.md`
  - Los logs y reports relevantes del ciclo de versión

---

### 📘 Estado del documento

**AMC — Documentation Guide**  
Versión: v0.1.1  
Autor: Sam Althaus  
Revisión: Octubre 2025  
Estado: Consolidado  
Dependencias: `ARCHITECTURE_v0.1.1.md`, `PORTABILITY_v0.1.1.md`
