# Halo CE Modding Guide


This is a basic guide for using Halo: Combat Evolved mod tools along with some utility scripts that make it easy to apply & undo changes.


## Tools you'll need

1. Halo MCC with Combat Evolved from Steam
2. Halo MCC CE mod tools from Steam
3. Blender
4. GIMP/Krita


## Other Tutorials
* Reclaimers wiki: [Creating your first Halo level](https://c20.reclaimers.net/h1/guides/levels/box-level/)
* Steam forum post: [Halo Modding Tips - Getting Started](https://steamcommunity.com/sharedfiles/filedetails/?id=2673977984) on Steam forums.
* A [good video tutorial](https://www.youtube.com/watch?v=68C5Y9WEPUE) from Youtube that I followed.


## Concepts/Definitions

| Concept | What is it? |
|---|---|
| Tags | Mostly everything, like a weapon, or enemy, or tree, is a tag *** to be learned / documented *** |
| .scenario files | Basically a level file that you can edit. Each one gets compiled into a map. |
| HSC scripts | Behavioral script customizations. *** to be learned / documented *** |


## How to mod Halo: Combat Evolved

### Setup

1. Install Halo MCC including Halo CE on steam.
2. Install [Halo CE mod tools](https://steamcommunity.com/games/976730/announcements/detail/3007823106801144959) on steam.
3. Download the `CE/scripts/` folder above.
4. Run `scripts\Setup.bat` to initialize. It will ask for your modtools directory and halo1 game directory.
5. Run `scripts\BackupHaloMaps.bat` to backup the original maps to the local folder /maps_backup/.

> WARNING: To prevent unexpected data loss, __NEVER__ delete the `gameConfig\` and `modtools\` folders that are created by Setup.bat. Instead, use the cleanup script mentioned below to delete them safely.


### 1. Create a new level (optional)

You can skip this section if you want to mod an existing level's geometry.

1. Create the level in blender. 
2. Export as JSM file to `modtools\data\levels\test\yourlevel\models` folder.
3. Run `GenerateScenarioFromJSM.bat levels\test\yourlevel` (referencing the path above) to generate the scenario tag file  `modtools\tags\levels\test\yourlevel\yourlevel.scenario`.
4. If there are console errors, check the BSP troubleshooting section below. Otherwise you should now have a scenario file.


### 2. Add spawn points, objects, and other customizations to a level

1. Open `modtools\sapien.exe` and open the scenario you want to edit, e.g. `modtools\tags\levels\test\beavercreek\beavercreek.scenario`
1. For new levels only, place 3 spawn points minimum for testing:
* Single Player spawn points should have default spawn point settings
* Multiplayer spawn points need to be enabled for `all games` and be given team index 0 or 1.
2. Use Sapien to populate the level with scenery, weapons, objects, AI, etc.
3. Customize any tags you want using Guerilla.


### 3. Test your modded map with tag test

1. Open `halo_tag_test.exe` from your `modtools/` folder.
2. Press `~` to open the dev console
3. Run these commands to set gametype to slayer and load your modded scenario (without the .scenario extension):

```
game_variant slayer
map_name levels\test\yourlevel\yourlevel
```

4. Have fun running around and testing your mods.


### 5. Build the map file

When you're satisfied with your testing, compile a map file for the real game to use.

1. Run `BuildMap.bat levels\test\yourlevel\yourlevel`, providing the path to your modded scenario (without the file extension).
2. The compiled .map file will be generated in `modtools\maps`.


### 6. Apply a map to MCC (*note the risks)

> Note: BEFORE doing this, make sure you have backed up your MCC maps using .\BackupHaloMaps.bat. You'll need to restore them to play matchmaking.

1. Run `ApplyHaloScenario levels\test\yourlevel\yourlevel beavercreek` to override the battle creek map with your modded map. You can now play on the map. 
2. Open MCC __with anti-cheat disabled__ to play the map on customs (only matters for host).
3. You can restore the maps to their origsinal backup after quitting the game and running `RestoreHaloMaps.bat`.
4. Make sure to restore maps before playing with anti-cheat enabled.

> Note: ALWAYS disable anti-cheat when testing your mods in MCC! If you get banned it's not my fault!


### 7. Publish the mod

1. Create a folder under /published/ with the mod name.
2. Create folders for /images/, /multiplayer/, and /maps/
3. Copy the modded .map file into /maps/
4. Open Excission (mod upload tool), make sure you add the  /published/ folder under configuration.
5. Use Excission to create the new mod entry, add the map to it, and upload.


# Primary modding tools

| Tool name | What it does |
|---|---|
| Blender | 3d modeler - create level geometry (BSPs) by designing your own level from scratch.|
| Sapien.exe | Level editor - place new objects/enemies, change scenery, move things around in a level |
| Guerilla.exe | Tag editor - edit attributes for entities in a level |
| Tool.exe | A generic command-line tool for various modding tasks (e.g. compiling maps). |


## How to use Sapien

1. Open modtools/sapien.exe.
2. Open any scenario file (inside modtools/tags/levels) for the desired level. (MP levels are under levels/test folder).
3. Edit the map units, vehicles, weapons, scenery, etc.

> TIP: A mouse is required for Sapien. To move the camera, you must click and hold your middle mouse button first. Then you can move with WASD or drag the mouse to look around. Also, R=go Up, F=go Down.


## How to use Guerilla

1. Open modtools/guerilla.exe
2. Open the scenario file for the desired level. (inside modtools/tags/levels. MP levels are under /test/).
3. Adjust tag settings
4. Save the scenario file.


## Notes for modeling levels in Blender

> TIP: Move blender camera with SHIFT+` (~) to use free walk (WASD) mode. Look around by moving the mouse.

### Merging structures into level geometry in blender (fixed)

After modeling a new base or anything else that will be attached to the `level` in the model, you have to merge it with the level so that your level follows the "sealed world" rules.

The advanced tutorial on reclaimers has info on this, but it has an incorrect step. 

FIRST, apply all transforms to the structure/object. In Object mode, select the object and go to Object -> Apply -> All Transforms.

Follow the advanced tutorial to apply the Union modifier to the Level object (with the base/structure).

When applying the Union modifier, select Material: Transfer to keep identitifying materials on a base.

After applying the Union modifier, do this instead of using CTRL+J to join the two -> you should delete the "base" object which was unioned to the level, because its geometry is duplicated inside the level now.

Check the floor of your structure and merge unnecessary vertices that were added.

At this point, we need to merge vertices if any need it. Do this by selecting the Level object -> switch to Edit mode -> 3 (face edit mode) -> A (select all faces in level). Then, press M, B (Merge By distance).

Now, select all the level faces that touch the structure. Press X, L to trigger a limited dissolve for extra edges.

Check for non-manifold edges. From edge edit mode, click Select -> All by trait -> Non-manifold. There shouldn't be any non-manifold edges in your structure (except for render-only edges like ladders, teleporters, streams).

If there are non-manifold edges, connect them (if it's obviously disconnected).
Check the normal face (enable backface culling on the material for an easier way to tell). These must be correct for the edges to be manifold.
If it's not obvious, it could be a duplicated face/object.
Check the specific error given by Tool.exe and look it up on the BSP troubleshooting guide.

Once you've cleaned up the non-manifold edges, you can separate the structure again by highlighting all the structure faces and pressing P, S to separate it into a different object.


### BSP troubleshooting cheat sheet

More troubleshooting steps are listed on this [Halo Maps Forum post](https://forum.halomaps.org/indexf7b6.html).

| Tool.exe error | Meaning | Fix |
|--|--|--|
| Degenerate triangle | There is a triangle with 0 area somewhere. | Find the bad edge. It might have 3 colinear vertices, which is invalid. If so, try merging the vertices. Otherwise, there could be multiple edges in the same spot, so try dissolving the bad edge (try this multiple times until the edge disappears and then reappears). If that doesn't work, there could be multiple overlapping edges with different sizes, in which case you can subdivide the largest edge, and then merge vertices to get the min number of edges needed.|
| Open edge | There is a hole in the level, like a hole in a balloon, but it should be sealed. | Find the bad edge. Use F to fill the face and double-check that the face's normal is flipped correctly with Alt+N , F.| 
| Couldn't update edge | There is an edge adjacent to 3 faces somewhere. | Alter the model so each edge is adjacent to 2 faces. | 


### Finding original BSP models and textures

Get blender assets here on [g drive](https://drive.google.com/drive/folders/1E9S4sesK9B_6AHdLRfhzXw_lNQQvMqic)
1. Import obj file into blender. Apply scaling to fix the size of the level.
2. Add a frame, parent the frame over the imported structure.
3. You may need to rename materials inside the .blend file to match the shader name. (add ! for transparency, %^ for ladders, etc).

