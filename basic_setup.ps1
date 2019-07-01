# Please run this scripy in powershell (administrator mode)

# -----------------------------------------------------------------------------
# Rename computer
# -----------------------------------------------------------------------------
$computerName = Read-Host 'Enter New Computer Name'
Write-Host "Renaming this computer to: " $computerName  -ForegroundColor Yellow
Rename-Computer -NewName $computerName

# -----------------------------------------------------------------------------
# Disable automatic hop-up at AC
# -----------------------------------------------------------------------------
Powercfg /Change monitor-timeout-ac 20
Powercfg /Change standby-timeout-ac 0

# -----------------------------------------------------------------------------
# Remove Edge desktop shortcut
# -----------------------------------------------------------------------------
$edgeLink = $env:USERPROFILE + "\Desktop\Microsoft Edge.lnk"
Remove-Item $edgeLink

# -----------------------------------------------------------------------------
# Install choco package manager
# -----------------------------------------------------------------------------
Set-ExecutionPolicy AllSigned
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# -----------------------------------------------------------------------------
# Remove unused UWP apps
# -----------------------------------------------------------------------------
$uwpRubbishApps = @(
"Microsoft.Messaging",
"king.com.CandyCrushSaga",
"Microsoft.BingNews",
"Microsoft.MicrosoftSolitaireCollection",
"Microsoft.People",
"Microsoft.WindowsFeedbackHub",
"Microsoft.YourPhone",
"Microsoft.MicrosoftOfficeHub",
"Fitbit.FitbitCoach",
"4DF9E0F8.Netflix")

foreach ($uwp in $uwpRubbishApps) {
    Get-AppxPackage -Name $uwp | Remove-AppxPackage
}

# -----------------------------------------------------------------------------
# Finally, reboot the system
# -----------------------------------------------------------------------------
Read-Host -Prompt "Configuration is done, restart is needed, press [ENTER] to restart computer."
Restart-Computer

