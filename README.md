# Halo Mod Tool Utility Scripts (Windows)
Author: Brandon Chastain


## What is this?
This is a basic guide for using Halo: Combat Evolved mod tools along with some utility scripts that make it easy to apply & undo changes.


# Combat Evolved

## Setup
1. Install Halo MCC including Halo CE on steam.
2. Install [Halo CE mod tools](https://steamcommunity.com/games/976730/announcements/detail/3007823106801144959) on steam.
3. Download the `scripts/` folder
2. Run `scripts\Setup.bat` to initialize. It will ask for your modtools directory and halo1 game directory.
3. Run `scripts\BackupHaloMaps.bat` to backup the original maps to the local folder /maps_backup/.


## Modding concepts
| Concept | What is it? |
|---|---|
| Tags | Mostly everything, like a weapon, or enemy, or tree, is a tag *** to be learned / documented *** |
| .scenario files | Basically a level file that you can edit. Each one gets compiled into a map. |
| HSC scripts | Behavioral script customizations. *** to be learned / documented *** |


## Primary modding tools

| Tool name | What it does |
|---|---|
| Sapien.exe | Level editor - move things around, place new objects/enemies, change scenery, for a level |
| Guerilla.exe | Tag editor - edit attributes for entities in a level |
| Tool.exe | A generic command-line tool for various modding tasks (e.g. compiling maps). |
|             |

### How to use Sapien
1. Open modtools/sapien.exe.
2. Open any scenario file (inside modtools/tags/levels) for the desired level. (MP levels are under levels/test folder).
3. Edit the map units, vehicles, weapons, scenery, etc.

> TIP:  To move the camera in Sapien, you must click and hold your middle mouse button first. Then you can move with WASD or drag the mouse to look around. Also, R=go Up, F=go Down.


### How to use Guerilla
1. Open modtools/guerilla.exe
2. Open the scenario file for the desired level. (inside modtools/tags/levels. MP levels are under /test/).
3. Adjust tag settings
4. Save the scenario file.


### Tutorials
I got most of this info from the writeup [Halo Modding Tips - Getting Started](https://steamcommunity.com/sharedfiles/filedetails/?id=2673977984) on Steam forums.

Here's a [good video tutorial](https://www.youtube.com/watch?v=68C5Y9WEPUE) from Youtube.


## Building the map and applying to the game
1. Run `ApplyHaloScenario.bat "path\to\level" originalMapName`. Example: `ApplyHaloScenario.bat "levels\test\bloodgulch\bloodgulch_moddedByMe" bloodgulch`, which generates the map in modtools\maps and copies that to your MCC folder.
2. You can now play on the map. Open MCC with anti-cheat disabled, play the map on customs.
3. You can restore the maps to their original backup after quitting the game and running `RestoreHaloMaps.bat`.

## Cleanup generated files
WARNING: be careful deleting the gameConfig and modtools folders. Let this cleanup script handle it to avoid accidentally deleting your game or tools.
You can cleanup all the generated symlinks using `Cleanup.bat`.


# Other tips & tricks


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