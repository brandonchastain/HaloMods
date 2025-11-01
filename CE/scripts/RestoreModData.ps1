
Remove-Item "$PSScriptRoot\temp" -Recurse -Force -ErrorAction SilentlyContinue
Expand-Archive -Path "$PSScriptRoot\..\backups\mod_data_backup.zip" -DestinationPath "$PSScriptRoot\temp\" -Force
Copy-Item -Path "$PSScriptRoot\temp\*" -Destination "$PSScriptRoot\..\modtools\" -Recurse -Force
Remove-Item "$PSScriptRoot\temp" -Recurse -Force