param(
    [Parameter(Mandatory=$true)]
    [string]$moddedMapName,
    [Parameter(Mandatory=$true)]
    [string]$originalMapName
)

# Run BackupMaps.ps1 to backup existing maps if maps_backup\maps_backup.zip file does not exist
if (-not (Test-Path "$PSScriptRoot\..\maps_backup\maps_backup.zip")) {
    & "$PSScriptRoot\BackupMaps.ps1"
}

# Validate that the modded map exists
if (-not (Test-Path "$PSScriptRoot\..\modtools\maps\$moddedMapName.map")) {
    Write-Error "Error: The specified moddedMapName does not exist: $PSScriptRoot\..\modtools\maps\$moddedMapName.map"
    exit 1
}

# Validate that the original map exists
if (-not (Test-Path "$PSScriptRoot\..\gameConfig\maps\$originalMapName.map")) {
    Write-Error "Error: The specified originalMapName does not exist in gameConfig\maps: $PSScriptRoot\..\gameConfig\maps\$originalMapName.map"
    exit 1
}

# Copy the map from modtools to gameConfig
Copy-Item -Path "$PSScriptRoot\..\modtools\maps\$moddedMapName.map" -Destination "$PSScriptRoot\..\gameConfig\maps\$originalMapName.map" -Force

Write-Host "Successfully updated $originalMapName.map with $moddedMapName.map"