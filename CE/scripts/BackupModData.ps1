Remove-Item "$PSScriptRoot\temp" -Recurse -Force -ErrorAction SilentlyContinue

Copy-Item -Path "$PSScriptRoot\..\modtools\data" -Destination "$PSScriptRoot\temp\data" -Recurse -Force
Copy-Item -Path "$PSScriptRoot\..\modtools\tags" -Destination "$PSScriptRoot\temp\tags" -Recurse -Force

if (-not (Test-Path "$PSScriptRoot\..\backups")) {
    New-Item -ItemType Directory -Path "$PSScriptRoot\..\backups"
}

Compress-Archive -Path "$PSScriptRoot\temp\*" -Destination "$PSScriptRoot\..\backups\mod_data_backup.zip" -Force

Remove-Item "$PSScriptRoot\temp" -Recurse -Force