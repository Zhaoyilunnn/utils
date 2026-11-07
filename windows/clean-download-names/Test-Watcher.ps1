$ErrorActionPreference = 'Stop'
$source = Get-Content (Join-Path $PSScriptRoot 'Watch-Files.ps1') -Raw
$tokens = $null; $errors = $null
$ast = [Management.Automation.Language.Parser]::ParseInput($source, [ref]$tokens, [ref]$errors)
if ($errors.Count) { throw $errors[0] }
$ast.FindAll({ param($node) $node -is [Management.Automation.Language.FunctionDefinitionAst] }, $false) | ForEach-Object { Invoke-Expression $_.Extent.Text }
$dir = Join-Path $env:TEMP ('clean-names-test-' + [Guid]::NewGuid())
New-Item -ItemType Directory $dir | Out-Null
$log = Join-Path $dir 'test.log'
$seen = @{}
$skipExt = @('.crdownload','.part','.partial','.tmp','.download','.lock','.lnk','.aria2','.bc!','.!qb','.!ut')
function Assert($condition, $message) { if (-not $condition) { throw $message } }
try {
  foreach ($original in @('archive.tar.gz', 'archive.zip', 'my_file.v1.pdf', '2026-01-01-2026-01-02-archive.tar.gz')) {
    $path = Join-Path $dir $original
    [IO.File]::WriteAllText($path, 'fixture')
    1..3 | ForEach-Object {
      $null = Rename-File (Get-Item $path)
      $file = Get-ChildItem $dir -File | Where-Object Name -ne 'test.log' | Select-Object -First 1
      $path = $file.FullName
    }
    Assert (([regex]::Matches($file.Name, '\d{4}-\d{2}-\d{2}-')).Count -eq 1) "Repeated dates: $($file.Name)"
    Assert (Test-CompliantName $file.BaseName) "Noncompliant output: $($file.Name)"
    Assert ($seen.ContainsKey($path)) 'Destination not recorded'
    Remove-Item $path
  }
  $path = Join-Path $dir 'download.zip'
  [IO.File]::WriteAllText($path, 'fixture')
  $file = Get-Item $path
  $p = @{ Length=$file.Length; LastWrite=$file.LastWriteTimeUtc; Since=[DateTime]::UtcNow.AddSeconds(-120) }
  Assert (-not (Test-Ready $file $p 60)) 'Fresh file considered ready'
  [IO.File]::SetLastWriteTimeUtc($path, [DateTime]::UtcNow.AddSeconds(-120))
  $file = Get-Item $path; $p.LastWrite = $file.LastWriteTimeUtc
  Assert (Test-Ready $file $p 60) 'Stable file rejected'
  [IO.File]::WriteAllText(($path + '.aria2'), 'active')
  Assert (-not (Test-Ready $file $p 60)) 'Active download marker ignored'
  Remove-Item ($path + '.aria2')
  $stream = [IO.File]::Open($path, 'Open', 'Write', 'Read')
  try { $null = Rename-File $file; Assert (Test-Path $path) 'Open download renamed' } finally { $stream.Close() }
  [IO.File]::AppendAllText($path, 'more')
  Assert (-not (Test-Ready (Get-Item $path) $p 60)) 'Resumed download considered ready'
  $null = Rename-File $file
  Assert (Test-Path $path) 'Stale metadata allowed rename'
  Write-Output 'PASS: names, repeated prefixes, destination tracking, stability, download markers, open writers, stale metadata'
} finally { Remove-Item $dir -Recurse -Force }
