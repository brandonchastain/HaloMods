# See https://c20.reclaimers.net/h1/h1-ek/h1-standalone-build/#profile-files
# Try to fix crashes in halo_tag_test.exe by clearing the profile
# delete all files in C:\Users\brand\OneDrive\Documents\My Games\Halo1A
$profilePath = "$env:USERPROFILE\OneDrive\Documents\My Games\Halo1A"
if (Test-Path $profilePath) {
    Get-ChildItem -Path $profilePath -Recurse | Remove-Item -Force -Recurse
    Write-Host "Cleared profile data in $profilePath"
} else {
    Write-Host "Profile path $profilePath does not exist."
}