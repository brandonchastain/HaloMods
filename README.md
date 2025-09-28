# Halo Mod Tool Utility Scripts (Windows)
Author: Brandon Chastain


## What is this?
This is a basic guide for using Halo: Combat Evolved mod tools along with some utility scripts that make it easy to apply & undo changes.


## How to use these scripts

### Setup
1. Install Halo MCC including Halo CE on steam.
2. Install [Halo CE mod tools](https://steamcommunity.com/games/976730/announcements/detail/3007823106801144959) on steam.
3. Download the `CE/scripts/` folder above.
2. Run `scripts\Setup.bat` to initialize. It will ask for your modtools directory and halo1 game directory.
3. Run `scripts\BackupHaloMaps.bat` to backup the original maps to the local folder /maps_backup/.

> WARNING: To prevent unexpected data loss, __NEVER__ delete the `gameConfig\` and `modtools\` folders that are created by Setup.bat. Instead, use the below cleanup script to delete them safely.

### How to create a new level
1. Create the level in blender, export as JSM file to `modtools\data\levels\...\yourlevel\models` folder.
2. Run `GenerateScenarioFromJSM.bat levels\...\yourlevel` (referencing the level's path under `data\` which contains the `models` folder) to generate the file `yourlevel.scenario` under `tags\levels\yourlevel`.

### How to add objects and customize levels
1. Populate the level using Sapien to place objects.
2. Adjust any tags using Guerilla.

### Building the map and applying to the game
1. Run `ApplyHaloScenario levels\...\yourlevel\yourlevel beavercreek` to override the battle creek map with the modded one.
2. You can now play on the map. Open MCC with anti-cheat disabled, play the map on customs.
3. You can restore the maps to their original backup after quitting the game and running `RestoreHaloMaps.bat`.

### Cleanup generated files
You can cleanup all the generated symlinks using `Cleanup.bat`.

# Modding Tips

## Concepts/Definitions
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


## Other Modding Tutorials

* Most info here comes from [Halo Modding Tips - Getting Started](https://steamcommunity.com/sharedfiles/filedetails/?id=2673977984) on Steam forums.
* A [good video tutorial](https://www.youtube.com/watch?v=68C5Y9WEPUE) from Youtube that I followed.
* The "official" halo modding wiki site: [c20.reclaimers.net](https://c20.reclaimers.net/h1/tags/) - linked is their guide to tags.
* [Creating your first level](https://c20.reclaimers.net/h1/guides/levels/box-level/)