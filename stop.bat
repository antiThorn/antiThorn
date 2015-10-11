sc config "Thorn" start= disabled
net stop "Thorn"
taskkill /f /im Thorn.exe
taskkill /f /im ThornHelper.exe
sc delete "Thorn"
del /s /q %LOCALAPPDATA%\THORN