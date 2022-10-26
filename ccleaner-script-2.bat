@echo off

Title 'Script para eliminacao de arquivos temporarios'

echo Confirme para começar limpeza. && pause



REM ***** Verificando se CCleaner está instalado *****
reg.exe query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\ccleaner.exe" /v Path
if %ERRORLEVEL% EQU 1 GOTO windows
taskkill /F /IM "ccleaner64.exe"
taskkill /F /IM "ccleaner.exe"


:windows
REM ******************** WINDOWS ********************

REM Apaga todas as pastas temporárias e arquivos temporários do usuário
takeown /A /R /D Y /F C:\Users\%USERNAME%\AppData\Local\Temp\
icacls C:\Users\%USERNAME%\AppData\Local\Temp\ /grant administradores:F /T /C
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Temp\
md C:\Users\%USERNAME%\AppData\Local\Temp\

REM Apaga os arquivos de \Windows\Temp
takeown /A /R /D Y /F C:\windows\temp
icacls C:\windows\temp /grant administradores:F /T /C
rmdir /q /s c:\windows\temp
md c:\windows\temp

REM Apaga arquivos de log
del c:\windows\logs\cbs\*.log
del C:\Windows\Logs\MoSetup\*.log
del C:\Windows\Panther\*.log /s /q
del C:\Windows\inf\*.log /s /q
del C:\Windows\logs\*.log /s /q
del C:\Windows\SoftwareDistribution\*.log /s /q
del C:\Windows\Microsoft.NET\*.log /s /q
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\SettingSync\*.log /s /q
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.tmp /s /q
del C:\Users\%USERNAME%\AppData\Local\Microsoft\"Terminal Server Client"\Cache\*.bin /s /q
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCache\



:brave
REM ******************** BRAVE ********************

REM Verificando se Edge está instalado *****
reg.exe query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\brave.exe" /v Path
if %ERRORLEVEL% EQU 1 GOTO chrome

REM Verificando se navegador está aberto
tasklist /fi "ImageName eq brave.exe" /fo csv 2>NUL | find /I "brave.exe">NUL
if %ERRORLEVEL% EQU 0 (
	echo Brave precisa ser fechado para limpar cache.
	echo Fechar Brave [S]/[N]?
	choice /c SN /n
	if !ERRORLEVEL! EQU 2 GOTO chrome
	taskkill /F /IM "brave.exe"
)

REM Limpeza de perfil default
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\User Data\Default\JumpListIconsRecentClosed
REM Limpeza de perfil 1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\JumpListIconsRecentClosed
REM Limpeza de perfil 2 
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\JumpListIconsRecentClosed



:chrome
REM ******************** CHROME ********************

REM Verificando se Google Chrome está instalado
reg.exe query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe" /v Path
if %ERRORLEVEL% EQU 1 GOTO edge

REM ***** Verificando se navegador está aberto
tasklist /fi "ImageName eq chrome.exe" /fo csv 2>NUL | find /I "chrome.exe">NUL
if %ERRORLEVEL% EQU 0 (
	echo Google Chrome precisa ser fechado para limpar cache.
	echo Fechar Google Chrome [S]/[N]?
	choice /c SN /n
	if !ERRORLEVEL! EQU 2 GOTO edge
	taskkill /F /IM "chrome.exe"
)

REM Limpeza de perfil default 
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\Default\JumpListIconsRecentClosed
REM Limpeza de perfil 1 
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\JumpListIconsRecentClosed
REM Limpeza de perfil 2 
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\JumpListIconsRecentClosed



:edge
REM ******************** EDGE ********************

REM Verificando se Microsoft Edge está instalado
reg.exe query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\edge.exe" /v Path
if %ERRORLEVEL% EQU 1 GOTO firefox

REM Verificando se navegador está aberto
tasklist /fi "ImageName eq edge.exe" /fo csv 2>NUL | find /I "edge.exe">NUL
if %ERRORLEVEL% EQU 0 (
	echo Microsoft Edge precisa ser fechado para limpar cache.
	echo Fechar Microsoft Edge [S]/[N]?
	choice /c SN /n
	if !ERRORLEVEL! EQU 2 GOTO firefox
	taskkill /F /IM "edge.exe"
)

REM Limpeza de perfil default 
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\User Data\Default\JumpListIconsRecentClosed
REM Limpeza de perfil 1 
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\JumpListIconsRecentClosed
REM Limpeza de perfil 2 
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\"Service Worker"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Cache
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\"Code Cache"
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\JumpListIconsRecentClosed



:firefox
REM ******************** FIREFOX ********************

REM Verificando se Firefox está instalado 
reg.exe query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe" /v Path
if %ERRORLEVEL% EQU 1 GOTO end

REM Verificando se navegador está aberto
tasklist /fi "ImageName eq chrome.exe" /fo csv 2>NUL | find /I "firefox.exe">NUL
if %ERRORLEVEL% EQU 0 (
	echo Firefox precisa ser fechado para limpar cache.
	echo Fechar Firefox [S]/[N]?
	choice /c SN /n
	if !ERRORLEVEL! EQU 2 GOTO end
	taskkill /F /IM "firefox.exe"
)

REM define qual é a pasta Profile do usuário e apaga os arquivos temporários dali
set parentfolder=C:\Users\%USERNAME%\AppData\Local\Mozilla\Firefox\Profiles\
for /f "tokens=*" %%a in ('"dir /b "%parentfolder%"|findstr ".*\.default-release""') do set folder=%%a
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\entries\*.
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.bin
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.lz*
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\index*.*
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.little
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\*.log /s /q


:end
pause
