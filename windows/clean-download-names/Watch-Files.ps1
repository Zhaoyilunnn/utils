param(
  [ValidateRange(1, 3600)][int]$IntervalSeconds = 3,
  [ValidateRange(10, 86400)][int]$StableSeconds = 60
)
$ErrorActionPreference = 'Continue'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$log = Join-Path $env:LOCALAPPDATA 'CleanDownloadNames\watcher.log'
New-Item -ItemType Directory -Force -Path (Split-Path $log) | Out-Null
$folders = @(
  [Environment]::GetFolderPath('Desktop'),
  [Environment]::GetFolderPath('MyDocuments'),
  (Join-Path $env:USERPROFILE 'Downloads')
) | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Container) } | Select-Object -Unique
$seen = @{}
$pending = @{}
$skipExt = @('.crdownload','.part','.partial','.tmp','.download','.lock','.lnk','.aria2','.bc!','.!qb','.!ut')
function Is-Candidate($f) {
  if ($f.Name.StartsWith('~$') -or $f.Name.StartsWith('.~') -or $f.Name.EndsWith('.tmp')) { return $false }
  if ($skipExt -contains $f.Extension.ToLowerInvariant()) { return $false }
  return $true
}
function Get-Files {
  foreach ($folder in $folders) {
    Get-ChildItem -LiteralPath $folder -File -Recurse -ErrorAction SilentlyContinue |
      Where-Object { Is-Candidate $_ }
  }
}
function Test-CompliantName($stem) {
  if ($stem -cnotmatch '^(\d{4}-\d{2}-\d{2})-([\p{L}\p{Nd}]+(?:[.-][\p{L}\p{Nd}]+)*)$') { return $false }
  $parsed = [DateTime]::MinValue
  if (-not [DateTime]::TryParseExact($Matches[1], 'yyyy-MM-dd', [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::None, [ref]$parsed)) { return $false }
  return $Matches[2] -notmatch '^\d{4}-\d{2}-\d{2}-'
}
function Test-Ready($f, $p, $seconds) {
  if ($p.Length -ne $f.Length -or $p.LastWrite -ne $f.LastWriteTimeUtc) { return $false }
  if (([DateTime]::UtcNow - $p.Since).TotalSeconds -lt $seconds) { return $false }
  if (([DateTime]::UtcNow - $f.LastWriteTimeUtc).TotalSeconds -lt $seconds) { return $false }
  foreach ($suffix in @('.crdownload','.part','.partial','.tmp','.download','.aria2','.bc!','.!qb','.!ut')) {
    if (Test-Path -LiteralPath ($f.FullName + $suffix)) { return $false }
  }
  return $true
}
function Rename-File($f) {
  $stem = $f.BaseName
  if (Test-CompliantName $stem) { $seen[$f.FullName] = $true; return }
  # Remove old/repeated prefixes before adding exactly one date.
  $stem = $stem -replace '^(?:\d{4}-\d{2}-\d{2}-)+', ''
  $clean = $stem -replace '[\s_]+', '-' -replace '[^\p{L}\p{Nd}.-]+', '-' -replace '-+', '-' -replace '[.-]{2,}', '-' -replace '\.-|-\.', '-'
  $clean = $clean.Trim(' ', '-', '.')
  if (-not $clean) { $clean = 'file' }
  $date = Get-Date -Format 'yyyy-MM-dd'
  $name = "$date-$clean"
  $dest = Join-Path $f.DirectoryName ($name + $f.Extension)
  $n = 2
  while (Test-Path -LiteralPath $dest) {
    $dest = Join-Path $f.DirectoryName ("$name-$n" + $f.Extension)
    $n++
  }
  $stream = $null
  try {
    # Exclude writers and retain the handle through the rename (Windows allows
    # moving an open file when FileShare.Delete is specified).
    $stream = [System.IO.File]::Open($f.FullName, 'Open', 'ReadWrite', 'Delete')
    $current = Get-Item -LiteralPath $f.FullName -ErrorAction Stop
    if ($stream.Length -ne $f.Length -or $current.LastWriteTimeUtc -ne $f.LastWriteTimeUtc) { return }
    [System.IO.File]::Move($f.FullName, $dest)
    $seen[$dest] = $true
    Add-Content -LiteralPath $log -Value "$(Get-Date -Format o) RENAMED $($f.FullName) => $dest" -Encoding UTF8
  } catch {
    Add-Content -LiteralPath $log -Value "$(Get-Date -Format o) RETRY $($f.FullName): $($_.Exception.Message)" -Encoding UTF8
  } finally {
    if ($null -ne $stream) { $stream.Dispose() }
  }
}
# Snapshot existing files so installing the tool never bulk-renames older documents.
foreach ($f in Get-Files) { $seen[$f.FullName] = $true }
Add-Content -LiteralPath $log -Value "$(Get-Date -Format o) START folders=$($folders -join '; ')" -Encoding UTF8
while ($true) {
  foreach ($f in Get-Files) {
    $path = $f.FullName
    if ($seen.ContainsKey($path)) { continue }
    if (-not $pending.ContainsKey($path)) {
      $pending[$path] = @{ Length=$f.Length; LastWrite=$f.LastWriteTimeUtc; Since=[DateTime]::UtcNow }
      continue
    }
    $p = $pending[$path]
    if ($p.Length -ne $f.Length -or $p.LastWrite -ne $f.LastWriteTimeUtc) {
      $p.Length = $f.Length; $p.LastWrite = $f.LastWriteTimeUtc; $p.Since = [DateTime]::UtcNow
      continue
    }
    if (-not (Test-Ready $f $p $StableSeconds)) { continue }
    if (Test-CompliantName $f.BaseName) {
      $seen[$path] = $true
      $pending.Remove($path)
      continue
    }
    Rename-File $f
    if (-not (Test-Path -LiteralPath $path)) { $pending.Remove($path) }
  }
  # Clear disappeared candidates, including renamed files and finished temp downloads.
  foreach ($path in @($pending.Keys)) {
    if (-not (Test-Path -LiteralPath $path)) { $pending.Remove($path) }
  }
  Start-Sleep -Seconds $IntervalSeconds
}
