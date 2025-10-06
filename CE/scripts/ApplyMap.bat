@echo off

REM take in parameters moddedMapName and originalMapName
set moddedMapName=%1
set originalMapName=%2

REM validate the parameters are provided, throw error if not
if "%moddedMapName%"=="" (
    echo "Error: moddedMapName parameter is required (e.g. levels/test/bloodgulch/bloodgulchModded)"
    exit /b 1
)
REM if moddedMapName does not exist, throw error
if not exist "%~dp0..\modtools\maps\%moddedMapName%.map" (
    echo "Error: The specified moddedMapName does not exist: %~dp0..\modtools\maps\%moddedMapName%.map"
    exit /b 1
)

REM if gameConfig\maps\{originalMapName}.map does not exist, throw error
if not exist "%~dp0..\gameConfig\maps\%originalMapName%.map" (
    echo "Error: The specified originalMapName does not exist in gameConfig\maps: %~dp0..\gameConfig\maps\%originalMapName%.map"
    exit /b 1
)

REM copy the map from modtools\maps\{moddedMapName}.map to gameConfig\maps\{originalMapName}.map
xcopy /E /I /Y "%~dp0..\modtools\maps\%moddedMapName%.map" "%~dp0..\gameConfig\maps\%originalMapName%.map"

echo "Successfully updated %originalMapName%.map with %moddedMapName%.map"