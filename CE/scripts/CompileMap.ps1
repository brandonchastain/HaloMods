param(
    [Parameter(Mandatory=$true)]
    [string]$moddedScenarioPath
)

# Validate that the modded scenario exists
if (-not (Test-Path "$PSScriptRoot\..\modtools\tags\$moddedScenarioPath.scenario")) {
    Write-Error "Error: The specified moddedScenarioPath does not exist: $PSScriptRoot\..\modtools\tags\$moddedScenarioPath.scenario"
    exit 1
}

# Compile the map with modtools/tool.exe
$currentLocation = Get-Location
try {
    Set-Location "$PSScriptRoot\..\modtools"
    $result = & .\tool.exe build-cache-file $moddedScenarioPath classic
    if ($LASTEXITCODE -ne 0) {
        Write-Error "Error: Failed to compile the modded map. Please check the moddedScenarioPath and try again."
        exit 1
    }
}
finally {
    Set-Location $currentLocation
}