Expand-Archive -Path "$PSScriptRoot\..\maps_backup\maps_backup.zip" -DestinationPath "$PSScriptRoot\..\maps_backup\" -Force
Copy-Item -Path "$PSScriptRoot\..\maps_backup\*" -Destination "$PSScriptRoot\..\gameConfig\maps\" -Recurse -Force

# Delete all files from "$PSScriptRoot\..\maps_backup" except the zip
Get-ChildItem -Path "$PSScriptRoot\..\maps_backup" | Where-Object { $_.Name -ne "maps_backup.zip" } | Remove-Item -Recurse -Force