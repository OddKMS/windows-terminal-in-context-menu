@echo off

REM First get admin rights, then run the main script
CALL %~dp0helpers/adminPrompt.bat %~dp0addRegistryKeys.bat