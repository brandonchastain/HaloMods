param(
    [Parameter(Mandatory=$true)]
    [string]$dataPath,
    [Parameter(Mandatory=$true)]
    [string]$scenarioName
)

# Navigate to modtools directory and run the commands
$currentLocation = Get-Location
try {
    Set-Location "$PSScriptRoot\..\modtools"
    
    # Generate structure
    & .\tool.exe structure $dataPath $scenarioName
    
    # Generate lightmaps
    & .\tool.exe lightmaps "$dataPath\$scenarioName" $scenarioName 0 1
}
finally {
    Set-Location $currentLocation
}