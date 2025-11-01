# Halo Mod Tool Utility Scripts
A small suite of scripts to help Halo modders work quickly and stay organized.

* Author: Brandon Chastain
* Platform: Windows
* Supported Games: Halo CE (more coming soon hopefully)


## Features

* Get quick access to your mod tools with automatically created shortcuts
* Compile a map and apply it to MCC for testing
* Backup and restore your modded `data`, `tags`, and `maps`
* Backup and restore the official game `maps`

## Included Scripts

|Script|Description|
|---|---|
|Setup.bat|Initializes the shortcuts for your modtools and official Halo install folders.|
|GenerateScenario.bat|Generates a scenario tag from an exported blender model with tool.exe and runs lightmaps on it.|
|BackupModData.bat|Backs up your `data/`, `tag/`, and `maps/` folders from the mod tools.|
|RestoreModData.bat|Restores your mod tool `data/`, `tag/`, and `maps/` folders from the backup.|
|BackupGameData.bat|Backs up the game's `maps/` folder.|
|RestoreGameData.bat|Restores the game's `maps/` folder from the backup.|
|BuildHaloMap.bat|Compiles a map cache file (`.map`) from a scenario tag file (`.scenario`) using tool.exe|
|ApplyHaloMap.bat|Copies a custom map to the MCC game's `maps/` folder.|
|Cleanup.bat|Uninstalls the shortcuts that were created.|

## How to Use
See [CE/HowToMod.md](CE/HowToMod.md)
