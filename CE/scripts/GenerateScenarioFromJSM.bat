rem First, make a level in blender. Follow the tutorials linked in the readme.
rem Then, export the blender file as JSM using te Halo mod extension in blender.
rem Save the JSM file in the data\levels\...\yourlevel folder.
rem Then, run this script to generate the scenario and lightmaps.
rem Example usage:
rem GenerateScenarioFromJSM.bat levels\test\myfirstmap myfirstmap

rem take in parameter for level path e.g. levels\test\myfirstmap
@echo off
set dataPath=%1
if "%dataPath%"=="" (
    echo "Error: dataPath parameter is required (e.g. levels\test\myfirstmap)"
    exit /b 1
)

rem take parameter for the scenario name
set scenarioName=%2
if "%scenarioName%"=="" (
    echo "Error: scenarioName parameter is required (e.g. myfirstmap)"
    exit /b 1
)

pushd ..\modtools
.\tool.exe structure "%dataPath%" %scenarioName%
.\tool.exe lightmaps "%dataPath%\%scenarioName%" %scenarioName% 0 1
popd