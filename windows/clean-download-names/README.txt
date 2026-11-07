Clean Download Names - Windows watcher (prototype)

Install:
1. Extract the ZIP to a folder.
2. Right-click Install.ps1 > Run with PowerShell.
   If that menu is unavailable, open PowerShell in this folder and run:
   powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Install.ps1
3. Keep the current Windows session running. It starts automatically on future logins.

Watches Desktop, Documents, Downloads, recursively. Files already present when the
watcher starts are ignored. A new file is renamed after at least 60 seconds of
stability, no companion download marker, and a file-open check excluding writers.
The handle stays open through the rename to avoid a check/rename race. It polls every 3 seconds.

Example: A_B C D.pdf -> 2026-10-15-A-B-C-D.pdf

Cautions:
- Files created while Windows is logged out or the watcher is not running will
  not be processed retroactively.
- Some applications may keep a file open after saving; those files are retried.
- Windows startup may show a PowerShell window briefly on some configurations.
- Files moved or copied into watched folders are also considered new files.
- Very large folders may have noticeable scanning overhead.
- Avoid editing/renaming a file simultaneously with this watcher.
- Regression tests run with Windows PowerShell: .\Test-Watcher.ps1
- Download completion is inferred from inactivity. A downloader that closes its
  handle and pauses without a temporary marker for over 60 seconds may still be
  processed early. Increase -StableSeconds when starting Watch-Files.ps1 if needed.

To uninstall: run Uninstall.ps1 with PowerShell.
Log: %LOCALAPPDATA%\CleanDownloadNames\watcher.log

Version 0.2.1: Files already matching YYYY-MM-DD-hyphen-separated-name.ext are left unchanged (even if the date is in the past). Re-run Install.ps1 to update an existing installation.

Version 0.2.2: Preserve dots consistently, prevent repeated date prefixes, record
renamed destinations, repair repeated leading dates on newly processed files,
wait 60 seconds by default, skip more download artifacts and companion markers,
and retain the writer-excluding handle through rename with metadata revalidation.
Existing files at watcher startup remain untouched, including previously affected
files. Re-run Install.ps1 to update the running watcher.
