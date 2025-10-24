Copy-Item -Path "$PSScriptRoot\..\gameConfig\maps\*" -Destination "$PSScriptRoot\..\maps_backup" -Recurse -Force
Compress-Archive -Path "$PSScriptRoot\..\maps_backup\*" -Destination "$PSScriptRoot\..\maps_backup\maps_backup.zip" -Force

# Delete all files from "$PSScriptRoot\..\maps_backup" except the zip
Get-ChildItem -Path "$PSScriptRoot\..\maps_backup" | Where-Object { $_.Name -ne "maps_backup.zip" } | Remove-Item -Recurse -Force