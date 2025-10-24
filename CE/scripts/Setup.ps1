# Check if symlinks already exist
if (Test-Path "$PSScriptRoot\..\modtools") {
    Remove-Item "$PSScriptRoot\..\modtools"
}

if (Test-Path "$PSScriptRoot\..\gameConfig") {
    Remove-Item "$PSScriptRoot\..\gameConfig"
}

# Prompt user for their modtools folder
$modtoolsPath = Read-Host "Enter the full path to your modtools folder (e.g. C:\SteamLibrary\steamapps\common\HCEEK)"
if (-not (Test-Path "$modtoolsPath\tags")) {
    Write-Error "Error: The specified modtools path does not contain a tags folder. Please check the path and try again."
    exit 1
}

# Prompt user for their gameConfig folder
$gameConfigPath = Read-Host "Enter the full path to your gameConfig folder (e.g. D:\SteamLibrary\steamapps\common\Halo The Master Chief Collection\halo1)"
if (-not (Test-Path "$gameConfigPath\maps")) {
    Write-Error "Error: The specified gameConfig path does not contain a maps folder. Please check the path and try again."
    exit 1
}

# Create symlink from modtools to CE/modtools
try {
    New-Item -ItemType SymbolicLink -Path "$PSScriptRoot\..\modtools" -Target $modtoolsPath
}
catch {
    Write-Error "Error: Failed to create symlink to modtools. Please check the path and try again."
    exit 1
}

# Create symlink from gameConfig to CE/gameConfig
try {
    New-Item -ItemType SymbolicLink -Path "$PSScriptRoot\..\gameConfig" -Target $gameConfigPath
}
catch {
    Write-Error "Error: Failed to create symlink to gameConfig. Please check the path and try again."
    exit 1
}

# Create normal shortcuts in HaloMods/ for guerilla.exe, tool.exe, and sapien.exe from modtools
$shortcuts = @("guerilla.exe", "halo_tag_test.exe", "sapien.exe")
foreach ($shortcut in $shortcuts) {
    $targetPath = Join-Path -Path $modtoolsPath -ChildPath $shortcut
    $shortcutPath = Join-Path -Path "$PSScriptRoot\..\.." -ChildPath "$shortcut.lnk"

    if (Test-Path $shortcutPath) {
        Remove-Item $shortcutPath
    }

    $WshShell = New-Object -ComObject WScript.Shell
    $shortcutObject = $WshShell.CreateShortcut($shortcutPath)
    $shortcutObject.TargetPath = $targetPath
    $shortcutObject.Save()
}

start "$PSScriptRoot\..\..\"