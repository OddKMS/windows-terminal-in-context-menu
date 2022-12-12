@echo on
setlocal EnableDelayedExpansion

:findWindowsTerminal
    ECHO. 
    SET _outputText = "Checking for Windows Terminal installation"
    ECHO Checking for Windows Terminal installation
    ECHO **************************************
    IF NOT EXIST "%LocalAppData%\Microsoft\WindowsApps\wt.exe" GOTO :windowsTerminalNotFound
    REM The variable terminalPath needs its quotes escaped so REG.exe will accept it
    SET terminalPath=%LocalAppData%\Microsoft\WindowsApps\wt.exe sp -p \"Command Prompt\" -d \".\"

:windowsTerminalNotFound
    ECHO.
    ECHO Windows Terminal not found - it can be downloaded
    ECHO here: https://aka.ms/terminal

:copyIcon
    ECHO.
    ECHO Copy Icon into Windows Terminal folder
    ECHO **************************************
    SET icon=%~dp0images\wt.ico
    SET appFolder=%LocalAppData%\Microsoft\WindowsApps\
    SET iconPath=%appFolder%wt.ico

    IF NOT EXIST "%appFolder%" mkdir "%appFolder%"
    xcopy "%icon%" "%appFolder%" /Y
    IF %errorlevel%==0 (ECHO "Icon copy succeeded.") ELSE (GOTO :copyIconFailed)
    GOTO :addRegistryKeys

:copyIconFailed
    ECHO.
    ECHO Icon copy failed - you will be missing out on some polish.
    GOTO :addRegistryKeys

:addRegistryKeys
    ECHO.
    ECHO Adding Registry Keys
    ECHO **************************************
    REG ADD HKCR\Directory\background\shell\wt /d "Open Windows Terminal Here" /F
    REG ADD HKCR\Directory\background\shell\wt /v Icon /d "%iconPath%" /F
    REG ADD HKCR\Directory\background\shell\wt\command /d "%terminalPath%" /F
    SET _outputText = "Done"