REM check if symlinks already exist
if exist "%~dp0..\modtools" (
    rmdir "%~dp0..\modtools"
)

if exist "%~dp0..\gameConfig" (
    rmdir "%~dp0..\gameConfig"
)