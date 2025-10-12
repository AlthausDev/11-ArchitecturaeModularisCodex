# Architecturae Modularis Codex — Portabilidad y Migración
**Versión:** 0.0.1  
**Autor:** Sam Althaus  
**Fecha:** Octubre 2025

---

## 1) Objetivo
Replicar o mover el entorno AMC con **cero fricción** y **resultado determinista**.

## 2) Estrategias

### A) Copia 1:1 (recomendada)
Copiar a la nueva máquina:
```
00-Tools\
01-Downloads\
02-Archives\
03-Backups\
Skyrim-MO2-Portable\
11-ArchitecturaeModularisCodex\
```
Ajustar en MO2 la ruta del juego (**Game Location**).

### B) Cloud Sync (lo pesado en nube)
Sincroniza con OneDrive/Syncthing/Resilio:
```
00-Tools\
01-Downloads\
Skyrim-MO2-Portable\
```
El repo va en GitHub/GitLab.

### C) Reconstrucción (manifiestos)
1. Clonar repo.  
2. `Scripts\00-CreateStructure_v2.bat` → genera árbol.  
3. `Scripts\02-Deploy-Config.bat` → despliega INIs base.  
4. Descargar `modlist.txt` según prioridades AMC.  
5. Address Library / SKSE / Engine Fixes.  
6. Nemesis → `14.01-Generators-NemesisOutput`.

## 3) Rutas relativas MO2
```
Base="."
Mods="mods"
Profiles="profiles"
Overwrite="overwrite"
Downloads="..\01-Downloads"
```

## 4) Control de versiones
Versionar siempre:
```
Profiles\AMC-Base-1.6.1170\{categories.dat, modlist.txt, plugins.txt, Skyrim*.ini}
00.00-Config\
Scripts\
Docs\
ARCHITECTURE.md
PORTABILITY.md
README.md
```

## 5) Normalización CRLF/LF (Windows-friendly)
Crear `.gitattributes` en la raíz del repo:
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
