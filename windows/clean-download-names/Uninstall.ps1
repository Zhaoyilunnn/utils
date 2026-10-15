$dir = Join-Path $env:LOCALAPPDATA 'CleanDownloadNames'
$link = Join-Path ([Environment]::GetFolderPath('Startup')) 'Clean Download Names.lnk'
Remove-Item -LiteralPath $link -Force -ErrorAction SilentlyContinue
$target = Join-Path $dir 'Watch-Files.ps1'
Get-CimInstance Win32_Process -Filter "Name = 'powershell.exe'" | Where-Object { $_.CommandLine -like "*$target*" } | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }
Write-Host 'Stopped and removed startup entry. Logs and script remain in:' $dir
