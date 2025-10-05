# AMC Documentation Guide

## Objetivo
Establecer un sistema modular de documentación para Architecturae Modularis Codex (AMC).

## Estructura
```
Docs/
 ├── 00-Core/                ← Documentos vivos (estado actual)
 │    ├── README.md
 │    ├── ARCHITECTURE.md
 │    ├── PORTABILITY.md
 │    └── _Addenda/          ← Cambios por versión
 ├── 99-History/             ← Histórico
 │    ├── CHANGELOG.md
 │    ├── VersionIndex.md
 │    └── Releases/
 │         ├── AMC_0.1.0.0.zip
 │         └── ...
 ├── AMC_Documentation_Index.md
 └── AMC_Documentation_Guide.md
```

## Ciclo de versión (SemVer-4)
**Formato:** W.X.Y.Z

- W — cambios mayores de arquitectura o runtime
- X — nuevas capas o bloques completos
- Y — paquetes o conjuntos de features
- Z — hotfixes, doc, orden o parches menores

## Flujo
1. Validar cambios en juego
2. Crear Addendum
3. Integrar en documentos principales
4. Archivar Addendum en `99-History`
5. Actualizar `VersionIndex.md` y `AMC_Documentation_Index.md`

## Convenciones
- Prefijo archivos: `AMC_`
- Versión: `vW.X.Y.Z`
- Addendum: `AMC_Addendum_W.X.Y.Z.md`
- Releases: `AMC_W.X.Y.Z.zip`
