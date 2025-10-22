param(
  [string]$MO2Base   = "G:\Skyrim Mods\05-MO2-Portable",
  [string]$GameRoot  = $env:AMC_SKYRIM_ROOT,
  [string]$RepoRoot  = "G:\Skyrim Mods\04-ArchitecturaeModularisCodex"
)

if (-not $GameRoot -or -not (Test-Path $GameRoot)) {
  # fallback común
  $GameRoot = "G:\Games\Steam\steamapps\common\Skyrim Special Edition"
}

$logsRoot = Join-Path $RepoRoot "02.Docs\99.History\04.Logs"
$ts = (Get-Date).ToString("yyyy-MM-dd_HHmmss")
$session = Join-Path $logsRoot ("Run_"+$ts)
$null = New-Item -ItemType Directory -Force -Path $session

Write-Host "[AMC] Log session: $session"

# 1) Antes de jugar: foto de estado (versiones rápidas)
$envInfo = @()
$envInfo += "Timestamp: $(Get-Date)"
$envInfo += "MO2Base : $MO2Base"
$envInfo += "GameRoot: $GameRoot"
$envInfo += "UserDocs: $([Environment]::GetFolderPath('MyDocuments'))\My Games\Skyrim Special Edition"
$envInfo | Set-Content -Encoding UTF8 (Join-Path $session "00_Env.txt")

# 2) Esperar a que termine la sesión del juego
#    Vale para SKSE64 o SkyrimSE directos (cualquiera que cierre primero)
$procs = @("skse64_loader","SkyrimSE")
Write-Host "[AMC] Esperando sesión de juego (skse64_loader/SkyrimSE)..."
while ($true) {
  $p = Get-Process | Where-Object { $procs -contains $_.ProcessName }
  if ($p) {
    Write-Host "[AMC] Detectado proceso: $($p.ProcessName). Esperando a que cierre..."
    $p | Wait-Process
    break
  }
  Start-Sleep -Milliseconds 800
}

Start-Sleep -Seconds 2  # pequeña gracia para flush de disco

# 3) Copiar logs relevantes
$docsSkyrim = Join-Path ([Environment]::GetFolderPath("MyDocuments")) "My Games\Skyrim Special Edition"
$skseDocs   = Join-Path $docsSkyrim "SKSE"

$pairs = @(
  # Game root
  @{ From = (Join-Path $GameRoot "EngineFixes.log")          ; Name="EngineFixes.log" },
  @{ From = (Join-Path $GameRoot "SSEDisplayTweaks.log")     ; Name="SSEDisplayTweaks.log" },
  @{ From = (Join-Path $GameRoot "enbseries.log")            ; Name="enbseries.log" },
  @{ From = (Join-Path $GameRoot "skse64.log")               ; Name="skse64.log" },
  # MO2
  @{ From = (Join-Path $MO2Base "logs")                      ; Name="MO2_logs" },
  # SKSE user logs
  @{ From = (Join-Path $skseDocs "Crashlogs")                ; Name="Crashlogs" },
  @{ From = (Join-Path $skseDocs "po3_PapyrusExtender.log")  ; Name="po3_PapyrusExtender.log" }
)

foreach ($p in $pairs) {
  $src = $p.From
  $dst = Join-Path $session $p.Name
  if (Test-Path $src) {
    if ((Get-Item $src).PSIsContainer) {
      robocopy "$src" "$dst" * /E /R:1 /W:1 /NFL /NDL /NP | Out-Null
    } else {
      Copy-Item -LiteralPath $src -Destination $dst -Force
    }
  } else {
    Add-Content -Path (Join-Path $session "Z_Missing.txt") -Value $p.Name
  }
}

# 4) Resumen de tamaños (rápido “smoke”)
Get-ChildItem -LiteralPath $session -Recurse |
  Select-Object FullName, Length, LastWriteTime |
  Sort-Object FullName |
  Format-Table | Out-String | Set-Content -Encoding UTF8 (Join-Path $session "00_Summary.txt")

Write-Host "[AMC] Logs copiados en: $session"
