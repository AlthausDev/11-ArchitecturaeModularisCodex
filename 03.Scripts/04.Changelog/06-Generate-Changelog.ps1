#Requires -Version 5.1
<#
  06-Generate-Changelog.ps1
  - Snapshot de mods habilitados
  - Diff vs snapshot anterior
  - Markdown "Core Changelog" (habilitados, deshabilitados, faltantes core, Nemesis + diff)
#>

param(
    [string]$Profile = "AMC-Base-1.6.1170",
    [string]$OutputRoot = $null
)

$ErrorActionPreference = "Stop"

# ----------------------- Helpers -----------------------
function Get-AmcRoot {
    # Resolver path del script sin Split-Path (robusto en dot-sourcing y PS 5/7)
    $scriptPath = $MyInvocation.MyCommand.Path
    if (-not $scriptPath -and $PSCommandPath) { $scriptPath = $PSCommandPath }
    if (-not $scriptPath) { throw "No se pudo determinar la ruta del script." }

    $scriptDir  = [System.IO.Path]::GetDirectoryName($scriptPath)                           # ...\03.Scripts\04.Changelog
    $scriptsDir = [System.IO.Directory]::GetParent($scriptDir).FullName                     # ...\03.Scripts
    $amcRoot    = [System.IO.Directory]::GetParent($scriptsDir).FullName                    # ...\04-ArchitecturaeModularisCodex

    if (-not (Test-Path -LiteralPath $amcRoot)) { throw "No se pudo resolver AMC_ROOT desde '$scriptPath'" }
    return $amcRoot
}

function New-Timestamp { (Get-Date).ToString("yyyy-MM-dd_HHmmss") }

function New-StringHashSet {
    param([string[]]$Items)
    # Crea HashSet[string] con comparador case-insensitive y añade elementos de forma segura
    $set = New-Object 'System.Collections.Generic.HashSet[string]' ([System.StringComparer]::OrdinalIgnoreCase)
    if ($Items) {
        foreach ($i in $Items) {
            if ($i -and $i.Trim().Length -gt 0) { [void]$set.Add($i) }
        }
    }
    return $set
}

function Get-EnabledDisabledFromModlist([string]$modlistPath) {
    if (-not (Test-Path $modlistPath)) { throw "No existe modlist.txt en: $modlistPath" }

    $lines = Get-Content -LiteralPath $modlistPath -Encoding UTF8 |
             Where-Object { $_ -and $_ -notmatch '^\s*#' }

    $enabledList  = New-Object System.Collections.Generic.List[string]
    $disabledList = New-Object System.Collections.Generic.List[string]

    foreach ($l in $lines) {
        $t = $l.Trim()
        if ($t -like '+*') { [void]$enabledList.Add($t.Substring(1).Trim()) }
        elseif ($t -like '-*') { [void]$disabledList.Add($t.Substring(1).Trim()) }
    }

    [PSCustomObject]@{
        EnabledList  = $enabledList
        DisabledList = $disabledList
        EnabledSet   = (New-StringHashSet -Items $enabledList)
        DisabledSet  = (New-StringHashSet -Items $disabledList)
    }
}

function Write-EnabledSnapshot($enabledSet, [string]$outDir) {
    $txt = Join-Path $outDir "EnabledMods.txt"
    $csv = Join-Path $outDir "EnabledMods.csv"
    # Forzar array aunque haya 1 solo
    $sorted = @($enabledSet) | Sort-Object
    Set-Content -LiteralPath $txt -Value ($sorted -join [Environment]::NewLine) -Encoding UTF8
    $sorted | ForEach-Object { [PSCustomObject]@{ Mod = $_ } } | Export-Csv -LiteralPath $csv -NoTypeInformation -Encoding UTF8
    return $txt
}

function Get-PreviousSnapshotDir([string]$root, [string]$currentName) {
    $dirs = Get-ChildItem -LiteralPath $root -Directory -ErrorAction SilentlyContinue | Sort-Object Name
    if (-not $dirs) { return $null }
    $prev = $dirs | Where-Object { $_.Name -lt $currentName } | Select-Object -Last 1
    if ($prev) { return $prev }
    return ($dirs | Select-Object -Last 1)
}

function Compare-EnabledSets($prevSet, $currSet) {
    $added   = New-Object System.Collections.Generic.List[string]
    $removed = New-Object System.Collections.Generic.List[string]
    if ($prevSet -eq $null) {
        foreach ($m in @($currSet)) { [void]$added.Add($m) }
        return ,@($added, $removed)
    }
    foreach ($m in @($currSet)) { if (-not $prevSet.Contains($m)) { [void]$added.Add($m) } }
    foreach ($m in @($prevSet)) { if (-not $currSet.Contains($m)) { [void]$removed.Add($m) } }
    return ,@($added, $removed)
}

# ----------------------- Datos "Core" (como tu script original) -----------------------
$core = @(
  "Unofficial Skyrim Special Edition Patch",
  "SKSE",
  "Address Library for SKSE Plugins",
  "SSE Engine Fixes (skse64 plugin)",
  "SkyUI","Hide SkyUI",
  "SSE Display Tweaks","powerofthree's Tweaks","PapyrusUtil SE","JContainers SE","MCM Helper",
  "XP32 Maximum Skeleton Special Extended",
  "Nemesis Unlimited Behavior Engine",
  "Open Animation Replacer","Animation Motion Revolution","Payload Interpreter","Precision",
  "Spell Perk Item Distributor (SPID)","Base Object Swapper",
  "Scrambled Bugs",
  "Achievements Mods Enabler"
)

$needsNemesis = @(
  "XP32 Maximum Skeleton Special Extended",
  "Animation Motion Revolution",
  "Payload Interpreter",
  "Precision",
  "Nemesis Unlimited Behavior Engine"
)

# ----------------------- MAIN -----------------------
$AMC = Get-AmcRoot
if (-not $OutputRoot) { $OutputRoot = Join-Path $AMC "02.Docs\99.History\01.Changelog" }

$profileDir = Join-Path $AMC ("Profiles\" + $Profile)
$modlist    = Join-Path $profileDir "modlist.txt"

if (-not (Test-Path $profileDir)) { throw "No existe el perfil en repo: $profileDir" }
if (-not (Test-Path $modlist))    { throw "No existe modlist.txt: $modlist" }

New-Item -ItemType Directory -Force -Path $OutputRoot | Out-Null
$ts      = New-Timestamp
$outDir  = Join-Path $OutputRoot $ts
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

Write-Host "[INFO] AMC_ROOT   : $AMC"
Write-Host "[INFO] Perfil     : $Profile"
Write-Host "[INFO] modlist    : $modlist"
Write-Host "[INFO] OutputRoot : $OutputRoot"
Write-Host "[INFO] Snapshot   : $outDir"

# Parsear modlist
$sets = Get-EnabledDisabledFromModlist -modlistPath $modlist
$enabledSet    = $sets.EnabledSet
$enabledList   = $sets.EnabledList
$disabledList  = $sets.DisabledList

# 1) Snapshot de habilitados (txt/csv)
$enabledSnapshotPath = Write-EnabledSnapshot -enabledSet $enabledSet -outDir $outDir

# 2) Diff vs snapshot previo
$prevDir = Get-PreviousSnapshotDir -root $OutputRoot -currentName $ts
$prevEnabledSet = $null
if ($prevDir -and (Test-Path (Join-Path $prevDir.FullName "EnabledMods.txt"))) {
    $prevEnabledLines = Get-Content -LiteralPath (Join-Path $prevDir.FullName "EnabledMods.txt") -Encoding UTF8
    $prevEnabledSet   = New-StringHashSet -Items $prevEnabledLines   # <- compatible
}
$added, $removed = Compare-EnabledSets -prevSet $prevEnabledSet -currSet $enabledSet

# 3) Core analysis y Markdown (como el original + diff)
$modsAll = @($enabledList + $disabledList)
$missingCore = $core | Where-Object { $modsAll -notcontains $_ }
$presentNeedsNemesis = $enabledList | Where-Object { $needsNemesis -contains $_ }

$mdName  = "AMC-Core-Changelog_$($ts.Replace(':','-')).md"
$outFile = Join-Path $outDir $mdName

$lines = @()
$lines += "# AMC Core Changelog"
$lines += ""
$lines += "**Perfil:** $Profile"
$lines += "**Fecha:**  $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
$lines += ""
$lines += "## Instalados (habilitados)"
$lines += (@($enabledSet) | Sort-Object | ForEach-Object { "- $_" })
$lines += ""
$lines += "## Instalados (deshabilitados)"
if ($disabledList.Count -gt 0) {
    $lines += ($disabledList | Sort-Object | ForEach-Object { "- $_" })
} else {
    $lines += "- (ninguno)"
}
$lines += ""
$lines += "## Faltan del core recomendado"
if ($missingCore.Count -gt 0) {
    $lines += ($missingCore | Sort-Object | ForEach-Object { "- $_" })
} else {
    $lines += "- (completo)"
}
$lines += ""
$lines += "## Al tocar estos, **regenera Nemesis**"
if ($presentNeedsNemesis.Count -gt 0) {
    $lines += ($presentNeedsNemesis | Sort-Object | ForEach-Object { "- $_" })
} else {
    $lines += "- (ninguno ahora mismo)"
}
$lines += ""
$lines += "> Nota: Engine Fixes Part 2 se verifica fuera de MO2. Display Tweaks/po3 Tweaks requieren VC++ 2022 x64."
$lines += ""
$lines += "---"
$lines += "## Diff vs snapshot anterior (mods **habilitados**)"
$lines += ("Anterior: " + ($(if ($prevDir) { $prevDir.Name } else { "(no hay)" })))
$lines += ""
$lines += ("### Añadidos ({0})" -f $added.Count)
$lines += (@($added) | Sort-Object | ForEach-Object { "+ $_" })
if ($added.Count -eq 0) { $lines += "(ninguno)" }
$lines += ""
$lines += ("### Eliminados ({0})" -f $removed.Count)
$lines += (@($removed) | Sort-Object | ForEach-Object { "- $_" })
if ($removed.Count -eq 0) { $lines += "(ninguno)" }

$lines | Set-Content -LiteralPath $outFile -Encoding UTF8

# Diff en TXT
$diffTxt = Join-Path $outDir "Diff_vs_Previous.txt"
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine("=== Diff de mods HABILITADOS vs snapshot anterior ===")
[void]$sb.AppendLine("Actual : $ts")
[void]$sb.AppendLine("Previo : " + ($(if ($prevDir) { $prevDir.Name } else { "(no hay)" })))
[void]$sb.AppendLine("")
[void]$sb.AppendLine(("ADD ({0})" -f $added.Count))
foreach ($m in (@($added) | Sort-Object)) { [void]$sb.AppendLine("  + $m") }
[void]$sb.AppendLine("")
[void]$sb.AppendLine(("REM ({0})" -f $removed.Count))
foreach ($m in (@($removed) | Sort-Object)) { [void]$sb.AppendLine("  - $m") }
Set-Content -LiteralPath $diffTxt -Value $sb.ToString() -Encoding UTF8

Write-Host ""
Write-Host "[OK] Snapshot habilitados : $enabledSnapshotPath"
Write-Host "[OK] Diff habilitados     : $diffTxt"
Write-Host "[OK] Markdown             : $outFile"
exit 0
