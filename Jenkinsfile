node('windows') {

    // Unreal Paths
    def UnrealEnginePath         = 'C:\\Program Files\\Epic Games\\UE_5.2'
    def UnrealBuildToolPath      = UnrealEnginePath + "Engine\\Binaries\\DotNET\\UnrealBuildTool\\UnrealBuildTool.exe"
    def UnrealAutomationToolPath = UnrealEnginePath + "Engine\\Build\\BatchFiles\\RunUAT.bat"

    // 7Zip Paths
    def PathToZipExe = 'C:\\Program Files\\7-Zip\\7z.exe'

    // Project Name & Paths
    def ProjectName = 'UITests'
    def ProjectUProjectPath = '${WORKSPACE}\\${ProjectName}.uproject'
    
    // Temp Paths
    def TempDir                   = '${WORKSPACE}\\temp';
    def TempBuildOutputDir        = '${TempDir}\\Development\\x64';
    def TempBuildOutputDirByUE    = '${TempArchiveDirectory}\\Windows'

    // Output
    def ArchiveName = '${ProjectName}_${GIT_COMMIT}_Development_x64'
    def ArchiveSourcePath = '${TempBuildOutputDir}\\${ArchiveName}'
    def ArchiveTargetPath = 'ZippedBuilds\\Development\\${ProjectName}\\${ArchiveName}.rar'

    // The Code

    stage('Clean Workspace') {
        echo ''
        echo '----------------------------'
        echo 'Cleaning up workspace..'
        echo '----------------------------'

        dir('${TempDir}') {
            deleteDir()
        }
    }
    
    stage('Checkout from SCM') {
        echo ''
        echo '----------------------------'
        echo 'Checkout from SCM..'
        echo '----------------------------'

	    checkout scm
    }

    stage('Running Unreal Build Tool') {
        echo ''
        echo '----------------------------'
        echo 'Running Unreal Build Tool...'
        echo '----------------------------'

        dir ('${WORKSPACE}') {
            '${UnrealBuildToolPath}' -projectfiles -project='${ProjectUProjectPath}' -game -rocket -progress
        }
    }

    stage('Running Unreal Automation Tool') {
        echo ''
        echo '----------------------------'
        echo 'Running Unreal Automation Tool...'
        echo '----------------------------'

        '${UnrealAutomationToolPath}' BuildCookRun -rocket -compile -compileeditor -installed -nop4 -project='${ProjectUProjectPath}' -cook -stage -archive -archivedirectory='${TempBuildOutputDir}' -package -clientconfig=Development -clean -pak -prereqs -distribution -nodebuginfo -targetplatform=Win64 -build -utf8output 
    }

    stage('Rename Build Directory') {
        echo ''
        echo '----------------------------'
        echo 'Renaming Build Directory...'
        echo '----------------------------'

        sh 'rename ${TempBuildOutputDirByUE} ${ArchiveName}'
    }

    stage('Zipping the result') {
        echo ''
        echo '----------------------------'
        echo 'Zipping the result...'
        echo '----------------------------'

        sh '${PathToZipExe} a -t7z ${ArchiveTargetPath} ${ArchiveSourcePath}'
    }

}