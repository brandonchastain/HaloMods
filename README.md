# Halo Mod Tool Utility Scripts

* Author: Brandon Chastain
* Platform: Windows
* Supported Games: Halo CE (more coming soon hopefully)

## Description

A small suite of scripts to help Halo modders work quickly and stay organized.

* Automatically creates shortcuts to provide easy access to your mod tools and official game files.
* Backs up and restores the official .map files.
* Various wrappers for tool.exe with a more consistent interface.

## Included Scripts

|Script|Description|
|---|---|
|Setup.bat|Initializes the shortcuts for your modtools and official Halo install folders.|
|GenerateScenario.bat|Generates a scenario tag from an exported blender model with tool.exe and runs lightmaps on it.|
|BackupHaloMaps.bat|Copies the official halo maps so that they can be restored later.|
|RestoreHaloMaps.bat|Restores the maps from the backup.|
|BuildHaloMap.bat|Compiles a scenario tag into a map cache file using tool.exe|
|ApplyHaloMap.bat|Applies a map to the official game folder.|
|Cleanup.bat|Uninstalls the shortcuts that were created.|

## How to Use
See [CE/HowToMod.md](CE/HowToMod.md)
