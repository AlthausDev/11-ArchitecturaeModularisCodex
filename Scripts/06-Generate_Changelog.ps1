# --- Config ---
$AMC = "G:\Skyrim Mods\11-ArchitecturaeModularisCodex"
$MO2 = "G:\Skyrim Mods\Skyrim-MO2-Portable"
$Profile = "AMC-Base-1.6.1170"
$outDir = Join-Path $AMC "99.History\Chagelog"
$outFile = Join-Path $outDir ("AMC-Core-Changelog_{0:yyyy-MM-dd_HH-mm}.md" -f (Get-Date))
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

# Lista "core" (claves por nombre de mod en panel izquierdo)
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

# Lee modlist.txt y plugins.txt del perfil
$profPath = Join-Path $MO2 ("profiles\"+$Profile)
$modlist = Get-Content (Join-Path $profPath "modlist.txt") | Where-Object {$_ -and $_ -notmatch "^#"}

# Normaliza
$modsEnabled   = $modlist | Where-Object { $_ -match "^\+" } | ForEach-Object { $_.Substring(1) }
$modsDisabled  = $modlist | Where-Object { $_ -match "^-" } | ForEach-Object { $_.Substring(1) }
$modsAll = $modsEnabled + $modsDisabled

$missing = $core | Where-Object { $modsAll -notcontains $_ }
$presentNeedsNemesis = $modsEnabled | Where-Object { $needsNemesis -contains $_ }

# Escribe changelog
$lines = @()
$lines += "# AMC Core Changelog"
$lines += ""
$lines += "Perfil: **$Profile**"
$lines += "Fecha:  $(Get-Date)"
$lines += ""
$lines += "## Instalados (habilitados)"
$lines += ($modsEnabled | Sort-Object | ForEach-Object { "- $_" })
$lines += ""
$lines += "## Instalados (deshabilitados)"
$lines += (if ($modsDisabled) { $modsDisabled | Sort-Object | ForEach-Object { "- $_" } } else { "- (ninguno)" })
$lines += ""
$lines += "## Faltan del core recomendado"
$lines += (if ($missing) { $missing | Sort-Object | ForEach-Object { "- $_" } } else { "- (completo)" })
$lines += ""
$lines += "## Al tocar estos, **regenera Nemesis**"
$lines += (if ($presentNeedsNemesis) { $presentNeedsNemesis | Sort-Object | ForEach-Object { "- $_" } } else { "- (ninguno ahora mismo)" })
$lines += ""
$lines += "> Nota: el log de Engine Fixes Part 2 se verifica fuera de MO2. Display Tweaks/po3 Tweaks requieren VC++ 2022 x64."
$lines | Set-Content -Encoding UTF8 $outFile

Write-Host "Changelog escrito en: $outFile"
