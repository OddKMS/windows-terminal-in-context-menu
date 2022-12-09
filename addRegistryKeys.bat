@echo off

SET icon=%~dp0images\terminal.ico
SET appFolder=%LocalAppData%\WTerminal\
SET iconPath=%appFolder%terminal.ico

IF NOT EXIST "%appFolder%" mkdir "%appFolder%"
xcopy "%icon%" "%appFolder%" /Y

REM The variable terminalPath needs its quotes escaped so REG.exe will accept it
SET terminalPath=%LocalAppData%\Microsoft\WindowsApps\wt.exe sp -p \"Command Prompt\" -d \".\"

REG ADD HKCR\Directory\background\shell\wt /d "Open Windows Terminal Here" /F
REG ADD HKCR\Directory\background\shell\wt /v Icon /d "%iconPath%" /F
REG ADD HKCR\Directory\background\shell\wt\command /d "%terminalPath%" /F
