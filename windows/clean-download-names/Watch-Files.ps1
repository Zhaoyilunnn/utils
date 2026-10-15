param([int]$IntervalSeconds = 3)
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
$skipExt = @('.crdownload','.part','.partial','.tmp','.download','.lock','.lnk')
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
  # Exact format: YYYY-MM-DD-name-with-hyphens (Unicode letters/digits permitted).
  if ($stem -cnotmatch '^(\d{4}-\d{2}-\d{2})-([\p{L}\p{Nd}]+(?:-[\p{L}\p{Nd}]+)*)$') { return $false }
  $parsed = [DateTime]::MinValue
  return [DateTime]::TryParseExact($Matches[1], 'yyyy-MM-dd', [Globalization.CultureInfo]::InvariantCulture, [Globalization.DateTimeStyles]::None, [ref]$parsed)
}
function Rename-File($f) {
  $stem = $f.BaseName
  if (Test-CompliantName $stem) { return }
  $clean = $stem -replace '[\s_]+', '-' -replace '[^\p{L}\p{Nd}.-]+', '-' -replace '-+', '-'
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
  try {
    # Open exclusively to ensure no other application is still writing.
    $stream = [System.IO.File]::Open($f.FullName, 'Open', 'ReadWrite', 'None')
    $stream.Close()
    [System.IO.File]::Move($f.FullName, $dest)
    Add-Content -LiteralPath $log -Value "$(Get-Date -Format o) RENAMED $($f.FullName) => $dest" -Encoding UTF8
  } catch {
    Add-Content -LiteralPath $log -Value "$(Get-Date -Format o) RETRY $($f.FullName): $($_.Exception.Message)" -Encoding UTF8
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
    if (([DateTime]::UtcNow - $p.Since).TotalSeconds -lt 6) { continue }
    if (([DateTime]::UtcNow - $f.LastWriteTimeUtc).TotalSeconds -lt 6) { continue }
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
