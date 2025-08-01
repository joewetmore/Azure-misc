# Check if NuGet provider is installed, install if not

$nugetProvider = Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue

if ($nugetProvider) {
    Write-Output "NuGet provider is installed. Version: $($nugetProvider.Version)"
} else {
    Write-Output "NuGet provider is NOT installed."

    # Prompt to install
    $response = Read-Host "Do you want to install the NuGet provider now? (Y/N)"
    if ($response -match '^[Yy]$') {
        Install-PackageProvider -Name NuGet -Force -Scope CurrentUser
        Write-Output "NuGet provider installation attempted. Please restart PowerShell if needed."
    } else {
        Write-Output "NuGet provider was not installed."
    }
}


# create an HWID for this machine and save on a fileserver

set-location \\cthulhu\HWIDs
$computerName = $env:COMPUTERNAME
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force
Install-Script -name Get-WindowsAutopilotInfo -force 
$env:Path += ";C:\Program Files\WindowsPowerShell\Scripts"
Get-WindowsAutopilotInfo.ps1 -OutputFile ${computerName}_AutopilotHWID.csv 
