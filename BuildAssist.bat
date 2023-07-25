@echo off

REM Set the path to your Unreal Engine installation
set "UnrealEnginePath=C:\Program Files\Epic Games\UE_5.2"

REM Get the command line parameters for ProjectPath and OutputDirectory
set "ProjectPath=%~1"
set "OutputDirectory=%~2"

REM Check if the required parameters are provided
if "%ProjectPath%"=="" (
    echo Error: ProjectPath not specified.
    echo Usage: BuildProject.bat ^<ProjectPath^> ^<OutputDirectory^>
    exit /b 1
)

if "%OutputDirectory%"=="" (
    echo Error: OutputDirectory not specified.
    echo Usage: BuildProject.bat ^<ProjectPath^> ^<OutputDirectory^>
    exit /b 1
)

REM Save the current directory path
set "CurrentDirectory=%cd%"

REM Generate project files (only required for C++ projects, skip for Blueprint-only projects)
"%UnrealEnginePath%\Engine\Binaries\DotNET\UnrealBuildTool\UnrealBuildTool.exe" -projectfiles -project="%ProjectPath%"

REM Build the project using the Unreal Automation Tool (UAT)
"%UnrealEnginePath%\Engine\Build\BatchFiles\RunUAT.bat" BuildCookRun -project="%ProjectPath%" -noP4 -platform=Win64 -clientconfig=Development -serverconfig=Development -cook -allmaps -build -stage -pak -archive -archivedirectory="%OutputDirectory%"

