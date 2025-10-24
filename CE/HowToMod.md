# Halo CE Modding Guide


This is a basic guide for using Halo: Comps1 Evolved mod tools along with some utility scripts that make it easy to apply & undo changes.


## Tools you'll need

1. Halo MCC with Comps1 Evolved from Steam
2. Halo MCC CE mod tools from Steam
3. (Optional) Blender for modeling 3D assets
4. (Optional) Krita / Photoshop for editing textures


## Supplemental Tutorials

I'm trying to make this guide easy to understand. However, it is by no means a complete guide. I recommend checking out these resources for more details whenever needed:

* [Creating your first Halo level](https://c20.reclaimers.net/h1/guides/levels/box-level/) (reclaimers.net)
* [Halo Modding Tips - Getting Started](https://steamcommunity.com/sharedfiles/filedetails/?id=2673977984) (steamcommunity.com)
* Videos from YouTube channel **Halo: Comps1 Eclipsed** like [this one on spawning AI characters](https://www.youtube.com/watch?v=bs0h4vaCd-k) (youtube.com)

---
## Halo Modding 101: Introduction to Concepts


### Tags

* A "tag" is just a file with some settings inside that affect what the Halo game engine executes.
* This is our main interface for customizing Halo behavior.
* There are tags for most "things" in Halo, including scenarios, weapons, items, scenery, allies/enemies, and more.
* You can edit all tags with Guerilla.exe.
* All the existing tags can be found in `modtools\tags\`.


### .scenario tag files

* The tag file for a level, including its vehicles, scenery, items, AI/chars, etc. 
* You can edit a .scenario file using `modtools\sapien.exe`.
* All the existing .scenario tags can be found in `modtools\tags\levels\`. MP maps are under `modtools\tags\levels\test\`.
* You can quickly test your .scenario files as you edit them using `modtools\halo_tag_test.exe`.


### HSC scripts
* A .scenario file can also include some HaloScript scripts. 
* These scripts are used for spawning AI encounters, among other things.
* All the existing scripts can be found in `modtools\data\levels\*\scripts\`. They all have the file extension `.hsc`.


### Guerilla.exe

* Halo CE tag editor - edit attributes for any entity in a level.

### Sapien.exe

* Halo CE scenario editor - place new objects/enemies, change scenery, move things around in a level.

> TIP: To move the camera in Sapien, you must click and hold your middle mouse button first. Then you can move with WASD or drag the mouse to look around. Also, R=go Up, F=go Down.


---
## Halo Modding 201: Modding & testing a level

### Setup

1. Clone this repo or download it from this page. 
2. Open cmd or Powershell. Navigate to the downloaded scripts folder using `cd`. 
3. Run `Setup.ps1` to initialize. It will ask for your modtools directory and halo1 game directory.

```ps1
cd Downloads\HaloMods\scripts
.\Setup.ps1 ...
```

4. Shortcuts for Halo CE mod tools `guerilla.exe`, `sapien.exe`, and `halo_tag_test.exe` will be created under the HaloMods/ folder for easy access.
Also, the following directories will be added to the `HaloMods\CE` folder:
* `modtools\` - a symlink to HCEEK folder
* `gameConfig\` - a symlink to halo1 folder under steam

> WARNING: To prevent unexpected data loss, __NEVER__ delete the `gameConfig\` and `modtools\` folders that are created by Setup.ps1. Instead, use the cleanup script mentioned below to delete them safely.


### 1. Create a new level or find one to modify


#### Option A - Find an existing level
1. Browse your Halo CE mod tool files for an existing .scenario tag to focus on. You can find them in the folder: `modtools\tags\levels\`. 
2. Once you find a scenario you want to edit, you can move on to the next step.

#### Option B - Create a new level (requires Blender)

1. Create a model for the level in Blender.  (see [Creating your first Halo level](https://c20.reclaimers.net/h1/guides/levels/box-level/))
2. Export the model as a JSM file to `modtools\data\levels\test\yourlevel\models` folder.
3. Run `GenerateScenario.ps1 levels\test\yourlevel` to generate a scenario tag from your model. The generated scenario will be stored at  `modtools\tags\levels\test\yourlevel\yourlevel.scenario`. 
4. If there are console errors, check the BSP troubleshooting section below. Otherwise you should now have a scenario file.



### 2. Customize spawn points, objects, vehicles, weapons, etc, in a level

1. Open the `sapien.exe` shortcut from your `HaloMods` folder and open the scenario you want to edit, e.g. `modtools\tags\levels\test\beavercreek\beavercreek.scenario`
1. For new levels only, place 3 spawn points minimum for testing:
* Single Player spawn points should have default spawn point settings
* Multiplayer spawn points need to be enabled for `all games` and be given team index 0 or 1.
2. Use Sapien to populate the level with scenery, weapons, objects, AI, etc.
3. Customize any tags you want using Guerilla.


### 3. Test your modded map with tag test

1. Open the `halo_tag_test.exe` shortcut from your `HaloMods` folder.
2. Press `~` to open the dev console
3. Run these commands to set gametype to slayer and load your modded scenario (without the .scenario extension):
Alternatively, you can edit the file at `modtools\init.txt` to include these lines:

```
game_variant slayer
map_name levels\test\yourlevel\yourlevel
```

4. Have fun running around and testing your mods.


---
## Halo Modding 301: Testing your mod on MCC

### 1. Build the map file

When you're satisfied with your halo_tag_test.exe testing, compile a map file for the real game to use.

1. Run `BuildMap.ps1 levels\test\yourlevel\yourlevel`, providing the path to your modded scenario (without the file extension).
2. The compiled .map file will be generated in `modtools\maps`.


### 2. Apply a map to MCC (*note the risks)

> Note: BEFORE doing this, the script will back up your MCC maps using .\BackupMaps.ps1. You'll need to restore them before you jump back in to matchmaking.

1. Run `ApplyMap.ps1 levels\test\yourlevel\yourlevel beavercreek` to override the ps1tle creek map with your modded map. You can now play on the map. 
2. Open MCC __with anti-cheat disabled__ to play the map on customs (only matters for host).
3. You can restore the maps to their original state by running `RestoreMaps.ps1`. Make sure to do this before playing the game with anti-cheat enabled.

> Note: ALWAYS disable anti-cheat when testing your mods in MCC! If you get banned it's not my fault!


---
## Halo Modding 401: Publishing your mod to Steam Workshop

1. Create a folder under /published/ with the mod name.
2. Create folders for /images/, /multiplayer/, and /maps/
3. Copy your modded .map file from `\modtools\maps\` into the new `/published/maps/` folder.
4. Open Excission (mod upload tool), make sure you add the  /published/ folder under configuration.
5. Use Excission to create the new mod entry, add the map to it, and upload.
6. You should see the mod in Steam Workshop now. It will be private by default and only visible by you.


## Notes for modeling levels in Blender

> TIP: Move blender camera with SHIFT+` (~) to use free walk (WASD) mode. Look around by moving the mouse.


### Importing original BSP models and textures

Get blender assets here on [g drive](https://drive.google.com/drive/folders/1E9S4sesK9B_6AHdLRfhzXw_lNQQvMqic)
1. Import the obj w/materials file into blender. Apply scaling options in the Import Dialog to fix the size of the level.
2. Add a frame, parent the frame over the imported structure.
3. You may need to rename materials inside the .blend file to match the shader name. (add ! for transparency, %^ for ladders, etc).


### BSP troubleshooting cheat sheet

More troubleshooting steps are listed on this [Halo Maps Forum post](https://forum.halomaps.org/indexf7b6.html).

| Tool.exe error | Meaning | Fix |
|--|--|--|
| Degenerate triangle | There is a triangle with 0 area somewhere. | Find the bad edge. It might have 3 colinear vertices, which is invalid. If so, try merging the vertices. Otherwise, there could be multiple edges in the same spot, so try dissolving the bad edge (try this multiple times until the edge disappears and then reappears). If that doesn't work, there could be multiple overlapping edges with different sizes, in which case you can subdivide the largest edge, and then merge vertices to get the min number of edges needed.|
| Open edge | There is a hole in the level, like a hole in a balloon, but it should be sealed. | Find the bad edge. Use F to fill the face and double-check that the face's normal is flipped correctly with Alt+N , F.| 
| Couldn't update edge | There is an edge adjacent to 3 faces somewhere. | Alter the model so each edge is adjacent to 2 faces. | 


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

