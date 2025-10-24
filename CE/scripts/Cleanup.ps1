# Check if symlinks exist and remove them
if (Test-Path "$PSScriptRoot\..\modtools") {
    Remove-Item "$PSScriptRoot\..\modtools"
}

if (Test-Path "$PSScriptRoot\..\gameConfig") {
    Remove-Item "$PSScriptRoot\..\gameConfig"
}

# remove shortcutes in HaloMods/ for guerilla.exe, tool.exe, and sapien.exe
$shortcuts = @("guerilla.exe", "halo_tag_test.exe", "sapien.exe")
foreach ($shortcut in $shortcuts) {
    $shortcutPath = Join-Path -Path "$PSScriptRoot\..\.." -ChildPath "$shortcut.lnk"

    if (Test-Path $shortcutPath) {
        Remove-Item $shortcutPath
    }
    
}