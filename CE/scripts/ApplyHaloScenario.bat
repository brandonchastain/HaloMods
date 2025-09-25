@echo on

REM take in parameters moddedScenarioPath and originalMapName
set moddedScenarioPath=%1
set originalMapName=%2

REM validate the parameters are provided, throw error if not
if "%moddedScenarioPath%"=="" (
    echo "Error: moddedScenarioPath parameter is required (e.g. levels/test/bloodgulch/bloodgulchModded)"
    exit /b 1
)
REM if moddedScenarioPath does not exist, throw error
if not exist "%~dp0..\modtools\tags\%moddedScenarioPath%.scenario" (
    echo "Error: The specified moddedScenarioPath does not exist: %~dp0..\modtools\%moddedScenarioPath%.scenario"
    exit /b 1
)

REM if gameConfig\maps\{originalMapName}.map does not exist, throw error
if not exist "%~dp0..\gameConfig\maps\%originalMapName%.map" (
    echo "Error: The specified originalMapName does not exist in gameConfig\maps: %~dp0..\gameConfig\maps\%originalMapName%.map"
    exit /b 1
)

REM warn the user that they should run BackupHaloMaps first
echo "Warning: Make sure you have backed up your halo maps before running this with BackupHaloMaps.bat. Press any key to continue..."
pause >nul

REM compile the map with modtools/tool.exe build_cache_map moddedScenarioPath classic
pushd "%~dp0..\modtools"
"tool.exe" build-cache-file "%moddedScenarioPath%" classic
if errorlevel 1 (
    echo "Error: Failed to compile the modded map. Please check the moddedScenarioPath and try again."
    exit /b 1
)
popd

for %%F in (%moddedScenarioPath:/= %) do set moddedMapName=%%~nxF

REM copy the map from modtools\maps\{moddedMapName}.map to gameConfig\maps\{originalMapName}.map
xcopy /E /I /Y "%~dp0..\modtools\maps\%moddedMapName%.map" "%~dp0..\gameConfig\maps\%originalMapName%.map"

echo "Successfully updated %originalMapName%.map with %moddedMapName%.map"