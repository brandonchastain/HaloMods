# Halo Mod Tool Utility Scripts (Windows)
Author: Brandon Chastain
----

## Description
This is a basic guide for using Halo: Combat Evolved mod tools along with some utility scripts that make it easy to apply & undo changes.


# Combat Evolved


## Setup
1. Install Halo MCC and Halo CE mod tools on steam.
2. Run `scripts\Setup.bat` to initialize. It will ask for your modtools directory and halo1 game directory.
3. Run `scripts\BackupHaloMaps.bat` to backup the original maps to the local folder /maps_backup/.


## Editing levels and tags


### Sapien
Level editor - move things around, place new objects/enemies, change scenery, for a level


#### How to use
1. Open modtools/sapien.exe.
2. Open any scenario file (inside modtools/tags/levels) for the desired level. (MP levels are under levels/test folder).
3. Edit the map units, vehicles, weapons, scenery, etc.


### Guerilla
Tag editor - edit attributes for entities in a level


#### How to use
1. Open modtools/guerilla.exe
2. Open the scenario file for the desired level. (inside modtools/tags/levels. MP levels are under /test/).
3. Adjust tag settings
4. Save the scenario file.


## Building the map and applying to the game
1. Run `ApplyHaloScenario.bat "path\to\level" originalMapName`. Example: `ApplyHaloScenario.bat "levels\test\bloodgulch\bloodgulch_moddedByMe" bloodgulch`, which generates the map in modtools\maps and copies that to your MCC folder.
2. You can now play on the map. Open MCC with anti-cheat disabled, play the map on customs.
3. You can restore the maps to their original backup after quitting the game and running `RestoreHaloMaps.bat`.

## Cleanup generated files
WARNING: be careful deleting the gameConfig and modtools folders. Let this cleanup script handle it to avoid accidentally deleting your game or tools.
You can cleanup all the generated symlinks using `Cleanup.bat`.


# Appendix


## Update map lighting after changing the skybox
After changing the skybox for a scenario using Guerilla,
you can update its lighting in Sapien.

Save it in Guerilla, open it in Sapien, then trigger the cmd prompt by pressing ~.

Enter this command:
```
radiosity_start
```

Wait a few seconds, all 3 numbers at the top left should reach zero and stop changing. Then you can run this command to apply the change:

```
radiosity_save
```

Then, save the scenario file and compile the map like usual.