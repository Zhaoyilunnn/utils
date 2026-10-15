Clean Download Names - Windows watcher (prototype)

Install:
1. Extract the ZIP to a folder.
2. Right-click Install.ps1 > Run with PowerShell.
   If that menu is unavailable, open PowerShell in this folder and run:
   powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Install.ps1
3. Keep the current Windows session running. It starts automatically on future logins.

Watches Desktop, Documents, Downloads, recursively. Files already present when the
watcher starts are ignored. A new file is renamed after at least 6 seconds of
stability and an exclusive file-open check. It polls every 3 seconds.

Example: A_B C D.pdf -> 2026-10-15-A-B-C-D.pdf

Cautions:
- Files created while Windows is logged out or the watcher is not running will
  not be processed retroactively.
- Some applications may keep a file open after saving; those files are retried.
- Windows startup may show a PowerShell window briefly on some configurations.
- Files moved or copied into watched folders are also considered new files.
- Very large folders may have noticeable scanning overhead.
- Avoid editing/renaming a file simultaneously with this watcher.
- This prototype is not yet tested on a real Windows machine.

To uninstall: run Uninstall.ps1 with PowerShell.
Log: %LOCALAPPDATA%\CleanDownloadNames\watcher.log

Version 0.2.1: Files already matching YYYY-MM-DD-hyphen-separated-name.ext are left unchanged (even if the date is in the past). Re-run Install.ps1 to update an existing installation.
