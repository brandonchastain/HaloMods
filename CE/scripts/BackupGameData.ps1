Remove-Item "$PSScriptRoot\temp" -Recurse -Force -ErrorAction SilentlyContinue

Copy-Item -Path "$PSScriptRoot\..\gameConfig\maps" -Destination "$PSScriptRoot\temp\maps" -Recurse -Force

if (-not (Test-Path "$PSScriptRoot\..\backups")) {
    New-Item -ItemType Directory -Path "$PSScriptRoot\..\backups"
}

Compress-Archive -Path "$PSScriptRoot\temp\*" -Destination "$PSScriptRoot\..\backups\game_data_backup.zip" -Force

Remove-Item "$PSScriptRoot\temp" -Recurse -Force