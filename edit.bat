@echo off

REM Place this file in any of %PATH% entries
REM Edit any file from cmd typing "edit ./diary.txt"

REM start       - run in a different process
REM ""          - empty cmd window title, not sure if it is needed with /B option
REM /B          - no window
REM <path>      - path to exe file. Any editor you like.
REM %*          - pass all arguments of this bat file to the program that is called.
start "" /B "C:\Program Files\Notepad++\Notepad++.exe" %*