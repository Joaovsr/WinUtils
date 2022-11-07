Write-Host "Creating Restore Point incase something bad happens"
Enable-ComputerRestore -Drive "C:\"
Checkpoint-Computer -Description "RestorePoint1" -RestorePointType "MODIFY_SETTINGS"

Write-Host "Running O&O Shutup with Recommended Settings"
Import-Module BitsTransfer
Start-BitsTransfer -Source "https://raw.githubusercontent.com/ChrisTitusTech/win10script/master/ooshutup10.cfg" -Destination ooshutup10.cfg
Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
./OOSU10.exe ooshutup10.cfg /quiet

Write-Host "Showing known file extensions..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 0

Write-Host "Set Services to Manual ..."

$services = @(
		"ALG"                                          # Application Layer Gateway Service(Provides support for 3rd party protocol plug-ins for Internet Connection Sharing)
		"AJRouter"                                     # Needed for AllJoyn Router Service
		"BcastDVRUserService_48486de"                  # GameDVR and Broadcast is used for Game Recordings and Live Broadcasts
		#"BDESVC"                                      # Bitlocker Drive Encryption Service
		#"BFE"                                         # Base Filtering Engine (Manages Firewall and Internet Protocol security)
		#"BluetoothUserService_48486de"                # Bluetooth user service supports proper functionality of Bluetooth features relevant to each user session.
		#"BrokerInfrastructure"                        # Windows Infrastructure Service (Controls which background tasks can run on the system)
		"Browser"                                      # Let users browse and locate shared resources in neighboring computers
		"BthAvctpSvc"                                  # AVCTP service (needed for Bluetooth Audio Devices or Wireless Headphones)
		"CaptureService_48486de"                       # Optional screen capture functionality for applications that call the Windows.Graphics.Capture API.
		"cbdhsvc_48486de"                              # Clipboard Service
		"diagnosticshub.standardcollector.service"     # Microsoft (R) Diagnostics Hub Standard Collector Service
		"DiagTrack"                                    # Diagnostics Tracking Service
		"dmwappushservice"                             # WAP Push Message Routing Service
		"DPS"                                          # Diagnostic Policy Service (Detects and Troubleshoots Potential Problems)
		"edgeupdate"                                   # Edge Update Service
		"edgeupdatem"                                  # Another Update Service
		"EntAppSvc"                                    # Enterprise Application Management.
		"Fax"                                          # Fax Service
		"fhsvc"                                        # Fax History
		"FontCache"                                    # Windows font cache
		#"FrameServer"                                 # Windows Camera Frame Server (Allows multiple clients to access video frames from camera devices)
		"gupdate"                                      # Google Update
		"gupdatem"                                     # Another Google Update Service
		"iphlpsvc"                                     # ipv6(Most websites use ipv4 instead)
		"lfsvc"                                        # Geolocation Service
		#"LicenseManager"                              # Disable LicenseManager (Windows Store may not work properly)
		"lmhosts"                                      # TCP/IP NetBIOS Helper
		"MapsBroker"                                   # Downloaded Maps Manager
		"MicrosoftEdgeElevationService"                # Another Edge Update Service
		"MSDTC"                                        # Distributed Transaction Coordinator
		"ndu"                                          # Windows Network Data Usage Monitor (Disabling Breaks Task Manager Per-Process Network Monitoring)
		"NetTcpPortSharing"                            # Net.Tcp Port Sharing Service
		"PcaSvc"                                       # Program Compatibility Assistant Service
		"PerfHost"                                     # Remote users and 64-bit processes to query performance.
		"PhoneSvc"                                     # Phone Service(Manages the telephony state on the device)
		#"PNRPsvc"                                     # Peer Name Resolution Protocol (Some peer-to-peer and collaborative applications, such as Remote Assistance, may not function, Discord will still work)
		#"p2psvc"                                      # Peer Name Resolution Protocol(Enables multi-party communication using Peer-to-Peer Grouping.  If disabled, some applications, such as HomeGroup, may not function. Discord will still work)iscord will still work)
		#"p2pimsvc"                                    # Peer Networking Identity Manager (Peer-to-Peer Grouping services may not function, and some applications, such as HomeGroup and Remote Assistance, may not function correctly. Discord will still work)
		"PrintNotify"                                  # Windows printer notifications and extentions
		"QWAVE"                                        # Quality Windows Audio Video Experience (audio and video might sound worse)
		"RemoteAccess"                                 # Routing and Remote Access
		"RemoteRegistry"                               # Remote Registry
		"RetailDemo"                                   # Demo Mode for Store Display
		"RtkBtManServ"                                 # Realtek Bluetooth Device Manager Service
		"SCardSvr"                                     # Windows Smart Card Service
		"seclogon"                                     # Secondary Logon (Disables other credentials only password will work)
		"SEMgrSvc"                                     # Payments and NFC/SE Manager (Manages payments and Near Field Communication (NFC) based secure elements)
		"SharedAccess"                                 # Internet Connection Sharing (ICS)
		#"Spooler"                                     # Printing
		"stisvc"                                       # Windows Image Acquisition (WIA)
		#"StorSvc"                                     # StorSvc (usb external hard drive will not be reconized by windows)
		"SysMain"                                      # Analyses System Usage and Improves Performance
		"TrkWks"                                       # Distributed Link Tracking Client
		#"WbioSrvc"                                    # Windows Biometric Service (required for Fingerprint reader / facial detection)
		"WerSvc"                                       # Windows error reporting
		"wisvc"                                        # Windows Insider program(Windows Insider will not work if Disabled)
		#"WlanSvc"                                     # WLAN AutoConfig
		"WMPNetworkSvc"                                # Windows Media Player Network Sharing Service
		"WpcMonSvc"                                    # Parental Controls
		"WPDBusEnum"                                   # Portable Device Enumerator Service
		"WpnService"                                   # WpnService (Push Notifications may not work)
		#"wscsvc"                                      # Windows Security Center Service
		"WSearch"                                      # Windows Search
		"XblAuthManager"                               # Xbox Live Auth Manager (Disabling Breaks Xbox Live Games)
		"XblGameSave"                                  # Xbox Live Game Save Service (Disabling Breaks Xbox Live Games)
		"XboxNetApiSvc"                                # Xbox Live Networking Service (Disabling Breaks Xbox Live Games)
		"XboxGipSvc"                                   # Xbox Accessory Management Service
		# Hp services
		"HPAppHelperCap"
		"HPDiagsCap"
		"HPNetworkCap"
		"HPSysInfoCap"
		"HpTouchpointAnalyticsService"
		# Hyper-V services
		"HvHost"
		"vmicguestinterface"
		"vmicheartbeat"
		"vmickvpexchange"
		"vmicrdv"
		"vmicshutdown"
		"vmictimesync"
		"vmicvmsession"
		# Services that cannot be disabled
		#"WdNisSvc"
)
		
foreach ($service in $services) {
	# -ErrorAction SilentlyContinue is so it doesn't write an error to stdout if a service doesn't exist
	# Write-Host "Setting $service StartupType to Manual"
	Get-Service -Name $service -ErrorAction SilentlyContinue | Set-Service -StartupType Manual
}

$Bloatware = @(
		#Unnecessary Windows 10 AppX Apps
		"Microsoft.3DBuilder"
		"Microsoft.Microsoft3DViewer"
		"Microsoft.AppConnector"
		"Microsoft.BingFinance"
		"Microsoft.BingNews"
		"Microsoft.BingSports"
		"Microsoft.BingTranslator"
		"Microsoft.BingWeather"
		"Microsoft.BingFoodAndDrink"
		"Microsoft.BingHealthAndFitness"
		"Microsoft.BingTravel"
		"Microsoft.MinecraftUWP"
		"Microsoft.GamingServices"
		# "Microsoft.WindowsReadingList"
		"Microsoft.GetHelp"
		"Microsoft.Getstarted"
		"Microsoft.Messaging"
		"Microsoft.Microsoft3DViewer"
		"Microsoft.MicrosoftSolitaireCollection"
		"Microsoft.NetworkSpeedTest"
		"Microsoft.News"
		"Microsoft.Office.Lens"
		"Microsoft.Office.Sway"
		"Microsoft.Office.OneNote"
		"Microsoft.OneConnect"
		"Microsoft.People"
		"Microsoft.Print3D"
		"Microsoft.SkypeApp"
		"Microsoft.Wallet"
		"Microsoft.Whiteboard"
		"Microsoft.WindowsAlarms"
		"microsoft.windowscommunicationsapps"
		"Microsoft.WindowsFeedbackHub"
		"Microsoft.WindowsMaps"
		"Microsoft.WindowsPhone"
		"Microsoft.WindowsSoundRecorder"
		"Microsoft.XboxApp"
		"Microsoft.ConnectivityStore"
		"Microsoft.CommsPhone"
		"Microsoft.ScreenSketch"
		"Microsoft.Xbox.TCUI"
		"Microsoft.XboxGameOverlay"
		"Microsoft.XboxGameCallableUI"
		"Microsoft.XboxSpeechToTextOverlay"
		"Microsoft.MixedReality.Portal"
		"Microsoft.XboxIdentityProvider"
		"Microsoft.ZuneMusic"
		"Microsoft.ZuneVideo"
		#"Microsoft.YourPhone"
		"Microsoft.Getstarted"
		"Microsoft.MicrosoftOfficeHub"
		
		#Sponsored Windows 10 AppX Apps
		#Add sponsored/featured apps to remove in the "*AppName*" format
		"*EclipseManager*"
		"*ActiproSoftwareLLC*"
		"*AdobeSystemsIncorporated.AdobePhotoshopExpress*"
		"*Duolingo-LearnLanguagesforFree*"
		"*PandoraMediaInc*"
		"*CandyCrush*"
		"*BubbleWitch3Saga*"
		"*Wunderlist*"
		"*Flipboard*"
		"*Twitter*"
		"*Facebook*"
		"*Royal Revolt*"
		"*Sway*"
		"*Speed Test*"
		"*Dolby*"
		"*Viber*"
		"*ACGMediaPlayer*"
		"*Netflix*"
		"*OneCalendar*"
		"*LinkedInforWindows*"
		"*HiddenCityMysteryofShadows*"
		"*Hulu*"
		"*HiddenCity*"
		"*AdobePhotoshopExpress*"
		"*HotspotShieldFreeVPN*"
		
		#Optional: Typically not removed but you can if you need to
		"*Microsoft.Advertising.Xaml*"
		#"*Microsoft.MSPaint*"
		#"*Microsoft.MicrosoftStickyNotes*"
		#"*Microsoft.Windows.Photos*"
		#"*Microsoft.WindowsCalculator*"
		#"*Microsoft.WindowsStore*"
)

Write-Host "Removing Bloatware"
foreach ($Bloat in $Bloatware) {
	Get-AppxPackage -Name $Bloat| Remove-AppxPackage
		Get-AppxProvisionedPackage -Online | Where-Object DisplayName -like $Bloat | Remove-AppxProvisionedPackage -Online
		Write-Host "Trying to remove $Bloat."
}
Write-Host "Finished Removing Bloatware Apps"
