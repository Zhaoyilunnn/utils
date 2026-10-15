$ErrorActionPreference = 'Stop'
$source = Join-Path $PSScriptRoot 'Watch-Files.ps1'
$dir = Join-Path $env:LOCALAPPDATA 'CleanDownloadNames'
New-Item -ItemType Directory -Force -Path $dir | Out-Null
# Stop a previous installed watcher before replacing its script.
$existing = Join-Path $dir 'Watch-Files.ps1'
Get-CimInstance Win32_Process -Filter "Name = 'powershell.exe'" | Where-Object { $_.CommandLine -and $_.CommandLine.Contains($existing) -and $_.ProcessId -ne $PID } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
Copy-Item -LiteralPath $source -Destination (Join-Path $dir 'Watch-Files.ps1') -Force
$script = Join-Path $dir 'Watch-Files.ps1'
$startup = [Environment]::GetFolderPath('Startup')
$link = Join-Path $startup 'Clean Download Names.lnk'
$wsh = New-Object -ComObject WScript.Shell
$shortcut = $wsh.CreateShortcut($link)
$shortcut.TargetPath = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
$shortcut.Arguments = '-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "' + $script + '"'
$shortcut.WorkingDirectory = $dir
$shortcut.Save()
Start-Process -FilePath $shortcut.TargetPath -ArgumentList $shortcut.Arguments -WindowStyle Hidden
Write-Host "Installed and started. Startup shortcut: $link"
Write-Host "Log: $(Join-Path $dir 'watcher.log')"
