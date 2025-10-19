<#
.SYNOPSIS
  Genera inventario separado (TXT árbol SOLO carpetas + CSV) de:
    - Skyrim Mods (raiz)
    - AMC (carpeta del proyecto)
    - MO2 Portable (si existe)

.SALIDA
  <AMC>\02.Docs\99.History\03.ArchitectureTree\<YYYY-MM-DD>\Tree_<NAME>.txt
  <AMC>\02.Docs\99.History\03.ArchitectureTree\<YYYY-MM-DD>\Tree_<NAME>.csv

.PARAMETER Kind
  report (por defecto) => 03.ArchitectureTree\<YYYY-MM-DD>\
  log                  => logs\tree\<YYYY-MM-DD>\

.PARAMETER AmcRoot
  Permite forzar la ruta de AMC si no quieres autodeteccion.
#>

[CmdletBinding()]
param(
  [ValidateSet('report','log')]
  [string]$Kind = 'report',
  [string]$AmcRoot
)

# ----------------------- Utilidades (ASCII) -------------------------------
function _San([string]$p) { if(-not $p){return $null} ; ($p -replace '[\\/]+','\').TrimEnd('\') }
function _Info($m) { Write-Host "[INFO]  $m" -ForegroundColor Cyan }
function _Ok($m)   { Write-Host "[ OK ]  $m" -ForegroundColor Green }
function _Warn($m) { Write-Warning $m }

# ----------------------- 1) Autodeteccion de AMC --------------------------
if (-not $AmcRoot) {
  $scriptDir = Split-Path -Parent $PSCommandPath
  $cand = Resolve-Path (Join-Path $scriptDir '..\..') -ErrorAction SilentlyContinue
  if ($cand) { $AmcRoot = $cand.Path }

  foreach ($c in @(
    'G:\Skyrim Mods\04-ArchitecturaeModularisCodex'
  )) {
    if (-not $AmcRoot -or -not (Test-Path (Join-Path $AmcRoot '02.Docs'))) {
      if (Test-Path (Join-Path $c '02.Docs')) { $AmcRoot = $c }
    }
  }
}
if (-not $AmcRoot -or -not (Test-Path (Join-Path $AmcRoot '02.Docs'))) {
  throw "No localice AMC. Pasa -AmcRoot (p.ej. 'G:\Skyrim Mods\04-ArchitecturaeModularisCodex')."
}
$AmcRoot = _San $AmcRoot
_Info "AMC_ROOT:      $AmcRoot"

# ----------------------- 2) SkyrimMods y MO2Portable ----------------------
$SkyrimModsRoot = _San (Split-Path -Parent $AmcRoot)
if (-not (Test-Path $SkyrimModsRoot)) { $SkyrimModsRoot = 'G:\Skyrim Mods' }
$SkyrimModsRoot = _San $SkyrimModsRoot
_Info "SkyrimMods:    $SkyrimModsRoot"

$Mo2PortableRoot = $null
foreach ($cand in @('05-MO2-Portable','Skyrim-MO2-Portable')) {
  $p = Join-Path $SkyrimModsRoot $cand
  if (Test-Path $p) { $Mo2PortableRoot = _San $p; break }
}
if ($Mo2PortableRoot) {
  _Info "MO2Portable:   $Mo2PortableRoot"
} else {
  _Warn "MO2Portable no encontrado; se omitira ese objetivo."
}

# ----------------------- 3) Carpeta de salida -----------------------------
$Subpath = if ($Kind -eq 'log') { 'logs\tree' } else { '03.ArchitectureTree' }
$OutputBase = Join-Path $AmcRoot "02.Docs\99.History\$Subpath"
$OutDir = Join-Path $OutputBase (Get-Date -Format 'yyyy-MM-dd')
$null = New-Item -ItemType Directory -Path $OutDir -Force
_Info "Salida:        $OutDir"

# ----------------------- 4) Helpers (arbol y CSV) -------------------------
# Profundidad relativa
function Get-DirDepth {
  param([string]$Root, [string]$Full)
  return ($Full.Substring($Root.Length).TrimStart('\').Split('\').Count)
}

# Construye un mapa padre->hijos (solo directorios)
function Build-ChildrenMap {
  param([string]$BasePath, [System.IO.DirectoryInfo[]]$Dirs)
  $map = @{}
  # incluir root
  $map[$BasePath] = New-Object System.Collections.Generic.List[System.IO.DirectoryInfo]
  foreach ($d in $Dirs) { $map[$d.FullName] = New-Object System.Collections.Generic.List[System.IO.DirectoryInfo] }
  foreach ($d in $Dirs) {
    $parent = Split-Path -Parent $d.FullName
    if ($map.ContainsKey($parent)) {
      [void]$map[$parent].Add($d)
    } else {
      # por si acaso (carpetas fuera de la raiz esperada)
      $map[$parent] = New-Object System.Collections.Generic.List[System.IO.DirectoryInfo]
      [void]$map[$parent].Add($d)
    }
  }
  return $map
}

# Escribe lineas del arbol ASCII (|-- y \--)
function Add-TreeLines {
  param(
    [string]$NodePath,
    [hashtable]$Map,
    [System.Collections.Generic.List[string]]$Lines,
    [string]$Prefix,
    [string]$BasePath
  )
  if (-not $Map.ContainsKey($NodePath)) { return }
  $children = $Map[$NodePath] | Sort-Object Name
  for ($i=0; $i -lt $children.Count; $i++) {
    $c = $children[$i]
    $isLast = ($i -eq $children.Count - 1)
    $branch = ( $isLast ? "\-- " : "|-- " )
    $Lines.Add("$Prefix$branch$($c.Name)")
    $nextPrefix = $Prefix + ( $isLast ? "    " : "|   " )
    Add-TreeLines -NodePath $c.FullName -Map $Map -Lines $Lines -Prefix $nextPrefix -BasePath $BasePath
  }
}

# Inventario de un objetivo (solo carpetas en TXT; CSV con metadatos de carpetas)
function Invoke-Inventory {
  param(
    [string]$Name,
    [string]$BasePath
  )

  if (-not (Test-Path $BasePath)) {
    _Warn "Omitido $Name (no existe): $BasePath"
    return
  }

  $txtPath = Join-Path $OutDir ("Tree_{0}.txt" -f $Name)
  $csvPath = Join-Path $OutDir ("Tree_{0}.csv" -f $Name)

  # Solo directorios (recursivo, incluye ocultos/sistema)
  $dirs = Get-ChildItem -LiteralPath $BasePath -Directory -Recurse -Force -ErrorAction SilentlyContinue

# --- Limites de profundidad SOLO para la carpeta 'mods' de MO2-Portable ---
# Regla:
#   - Si el objetivo es 'MO2Portable' → limitar a 1 nivel bajo '<Base>\mods\'.
#   - Si el objetivo es 'SkyrimMods'  → inventariar TODO excepto que,
#       dentro de '...\05-MO2-Portable\mods\' o '...\Skyrim-MO2-Portable\mods\',
#       se limita a 1 nivel igual que MO2Portable.
if ($Name -eq 'MO2Portable' -or $Name -eq 'SkyrimMods') {
  # Posibles rutas 'mods' a limitar
  $modsRoots = @()

  if ($Name -eq 'MO2Portable') {
    $modsRoots += (Join-Path $BasePath 'mods')
  } elseif ($Name -eq 'SkyrimMods') {
    $modsRoots += (Join-Path $BasePath '05-MO2-Portable\mods')
    $modsRoots += (Join-Path $BasePath 'Skyrim-MO2-Portable\mods')
  }

  # Normaliza y filtra
  $modsRoots = $modsRoots | Where-Object { Test-Path $_ } | ForEach-Object { $_.TrimEnd('\') }

  if ($modsRoots.Count -gt 0) {
    $dirs = $dirs | Where-Object {
      $full = $_.FullName
      $insideLimitedRoot = $false
      foreach ($mr in $modsRoots) {
        if ($full -like "$mr*") {
          $insideLimitedRoot = $true
          $depthRel = $full.Substring($mr.Length).TrimStart('\').Split('\').Count
          if ($depthRel -le 1) { return $true } else { return $false }
        }
      }
      # Fuera de 'mods' (o si no coincide), no limitamos
      if (-not $insideLimitedRoot) { return $true }
    }
  }
}

  # --- TXT: arbol ASCII bonito ---
  $lines = New-Object System.Collections.Generic.List[string]
  $lines.Add("ROOT: $BasePath")
  $map = Build-ChildrenMap -BasePath $BasePath -Dirs $dirs
  Add-TreeLines -NodePath $BasePath -Map $map -Lines $lines -Prefix "" -BasePath $BasePath
  $lines | Out-File -FilePath $txtPath -Encoding UTF8

  # --- CSV: solo carpetas con datos utiles ---
  $rows = foreach ($d in $dirs) {
    $parent = Split-Path -Parent $d.FullName
    [pscustomobject]@{
      FullName   = $d.FullName
      Name       = $d.Name
      Parent     = $parent
      Depth      = Get-DirDepth -Root $BasePath -Full $d.FullName
      LastWrite  = $d.LastWriteTime
      ChildDirs  = (Get-ChildItem -LiteralPath $d.FullName -Directory -Force -ErrorAction SilentlyContinue).Count
      ChildFiles = (Get-ChildItem -LiteralPath $d.FullName -File      -Force -ErrorAction SilentlyContinue).Count
    }
  }
  $rows | Sort-Object FullName | Export-Csv -Path $csvPath -Encoding UTF8 -NoTypeInformation

  # Resumen (solo carpetas)
  _Ok ("{0,-12} -> TXT:{1}  CSV:{2}  | dirs:{3}" -f `
    $Name, (Split-Path $txtPath -Leaf), (Split-Path $csvPath -Leaf), $dirs.Count)
}

# ----------------------- 5) Ejecutar -------------------------------------
Write-Host ""
Write-Host "Generando inventarios..." -ForegroundColor Yellow

Invoke-Inventory -Name 'SkyrimMods' -BasePath $SkyrimModsRoot
Invoke-Inventory -Name 'AMC'         -BasePath $AmcRoot
if ($Mo2PortableRoot) {
  Invoke-Inventory -Name 'MO2Portable' -BasePath $Mo2PortableRoot
}

Write-Host ""
_Ok "Inventario(s) generado(s) en: $OutDir"
