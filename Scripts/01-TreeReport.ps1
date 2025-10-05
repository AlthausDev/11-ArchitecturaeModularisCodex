<#
.SYNOPSIS
  Genera inventario de G:\Skyrim Mods en AMC, con salida en 99.History\ArchitectureTree\<fecha>\ o logs\tree\<fecha>\.

.PARAMETER Kind
  report (por defecto) => 11-ArchitecturaeModularisCodex\99.History\ArchitectureTree\<YYYY-MM-DD>\
  log                   => 11-ArchitecturaeModularisCodex\99.History\ArchitectureTree\<YYYY-MM-DD>\

.PARAMETER Csv
  Además del .txt, exporta _TreeReport.csv para comparación/datos.

.NOTES
  Diseñado para AMC. Incluye ocultos/sistema, ordena por ruta y normaliza fecha ISO.
#>

[CmdletBinding()]
param(
  [ValidateSet('report','log')]
  [string]$Kind = 'report',
  [switch]$Csv
)

# Raíces AMC
$RootPath   = 'G:\Skyrim Mods'
$AmcRoot    = Join-Path $RootPath '11-ArchitecturaeModularisCodex'
$OutputBase = Join-Path $AmcRoot '99.History'

# Carpeta objetivo según Kind
$Subpath = if ($Kind -eq 'log') { 'logs\tree' } else { 'ArchitectureTree' }

# Fecha (carpeta por día; si prefieres incluir hora, cambia a yyyy-MM-dd_HHmmss)
$DateTag  = (Get-Date).ToString('yyyy-MM-dd')
$OutDir   = Join-Path (Join-Path $OutputBase $Subpath) $DateTag

# Asegurar estructura
$null = New-Item -ItemType Directory -Path $OutDir -Force

# Rutas destino
$TxtPath = Join-Path $OutDir '_TreeReport.txt'
$CsvPath = Join-Path $OutDir '_TreeReport.csv'

# Consulta base (archivos y carpetas, incluyendo ocultos/sistema)
$items = Get-ChildItem -LiteralPath $RootPath -Recurse -Force -ErrorAction SilentlyContinue

# Proyección con campos limpios
$projection = $items | Select-Object `
    @{Name='Ruta';                Expression = { $_.FullName }},
    @{Name='Tipo';                Expression = { if ($_.PSIsContainer) { 'Directorio' } else { 'Archivo' } }},
    @{Name='Tamaño (bytes)';      Expression = { if ($_.PSIsContainer) { '-' } else { $_.Length } }},
    @{Name='Última Modificación'; Expression = { $_.LastWriteTime.ToString('yyyy-MM-dd HH:mm:ss') }}

# Orden por ruta y salida TXT sin formateadores frágiles
$projection | Sort-Object Ruta | Out-File -FilePath $TxtPath -Encoding UTF8

# Opcional: CSV para diffs/PowerQuery/etc.
if ($Csv) {
    # Para CSV, usa nombres sin espacios
    $projection |
        Select-Object `
            @{Name='FullName';        Expression = { $_.Ruta }},
            @{Name='Kind';            Expression = { $_.Tipo }},
            @{Name='SizeBytes';       Expression = { $_.'Tamaño (bytes)' }},
            @{Name='LastWrite';       Expression = { $_.'Última Modificación' }} |
        Sort-Object FullName |
        Export-Csv -Path $CsvPath -Encoding UTF8 -NoTypeInformation
}

Write-Host "`n✅ Inventario generado en: $TxtPath"
if ($Csv) { Write-Host "📄 CSV adicional: $CsvPath" }
