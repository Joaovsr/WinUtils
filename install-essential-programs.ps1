<#
.NOTES
Author      : João Vinicius Rodrigues    
GitHub      : https://github.com/Joaovsr
Version 0.0.1
#>

#Normal Use
$wingetinstall = New-Object System.Collections.Generic.List[System.Object]
$wingetinstall.Add("Google.Chrome")
$wingetinstall.Add("7zip.7zip")
$wingetinstall.Add("VideoLAN.VLC")
#$wingetinstall.Add("9N41MSQ1WNM8") #Okular PDF reader
$wingetinstall.Add("LibreOffice.LibreOffice.PreRelease")

#Gamers
#$wingetinstall.Add("EpicGames.EpicGamesLauncher")
#$wingetinstall.Add("Discord.Discord")
#$wingetinstall.Add("Valve.Steam")

#Others Programs
#$wingetinstall.Add("Spotify.Spotify")

foreach ( $node in $wingetinstall )
{
	winget install -e --accept-source-agreements --accept-package-agreements --silent $node | Out-Host
}
