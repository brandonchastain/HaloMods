@echo off

REM sets up shortcuts for modtools and gameConfig, needed before other scripts will work

REM check if symlinks already exist
if exist "%~dp0..\modtools" (
    rmdir "%~dp0..\modtools"
)

if exist "%~dp0..\gameConfig" (
    rmdir "%~dp0..\gameConfig"
)

REM prompt user for their modtools folder e.g. C:\SteamLibrary\steamapps\common\HCEEK
set /p modtoolsPath="Enter the full path to your modtools folder (e.g. C:\SteamLibrary\steamapps\common\HCEEK): "
if not exist "%modtoolsPath%\tags" (
    echo Error: The specified modtools path does not contain a tags folder. Please check the path and try again.
    exit /b 1
)

REM prompt user for their gameConfig folder e.g. D:\SteamLibrary\steamapps\common\Halo The Master Chief Collection\halo1
set /p gameConfigPath="Enter the full path to your gameConfig folder (e.g. D:\SteamLibrary\steamapps\common\Halo The Master Chief Collection\halo1): "
if not exist "%gameConfigPath%\maps" (
    echo Error: The specified gameConfig path does not contain a maps folder. Please check the path and try again.
    exit /b 1
)

REM create symlink from modtools to CE/modtools
mklink /D "%~dp0..\modtools" "%modtoolsPath%"
if errorlevel 1 (
    echo Error: Failed to create symlink to modtools. Please check the path and try again.
    exit /b 1
)

REM create symlink from gameConfig to CE/gameConfig
mklink /D "%~dp0..\gameConfig" "%gameConfigPath%"
if errorlevel 1 (
    echo Error: Failed to create symlink to gameConfig. Please check the path and try again.
    exit /b 1
)