function Write-Green {
    param([string]$Message)
    Write-Host $Message -ForegroundColor Green
}

function Write-White {
    param([string]$Message)
    Write-Host $Message -ForegroundColor White
}

# Check if NuGet provider is installed, install if not
$nugetProvider = Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue

if ($nugetProvider) {
    Write-Green "NuGet provider is installed. Version: $($nugetProvider.Version)"
} else {
    Write-Green "NuGet provider is NOT installed."

    # Prompt to install
    $response = Read-Host "Do you want to install the NuGet provider now? (Y/N)"
    if ($response -match '^[Yy]$') {
        Write-Green "Attempting to install NuGet provider..."
        try {
            Install-PackageProvider -Name NuGet -Force -Scope CurrentUser -ErrorAction Stop
            Write-Green "NuGet provider installation attempted. Please restart PowerShell if needed."
        } catch {
            Write-White "NuGet provider installation failed. The HWID file was not collected."
            exit
        }
    } else {
        Write-White "NuGet provider was not installed. The HWID file was not collected."
        exit
    }
}

# Create an HWID for this machine and save on a fileserver
Write-Green "Setting location to \\cthulhu\HWIDs"
Set-Location \\cthulhu\HWIDs

$computerName = $env:COMPUTERNAME

Write-Green "Setting temporary execution policy"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force

Write-Green "Installing Get-WindowsAutopilotInfo script"
Install-Script -Name Get-WindowsAutopilotInfo -Force 

$env:Path += ";C:\Program Files\WindowsPowerShell\Scripts"

Write-Green "Generating Autopilot HWID file..."
Get-WindowsAutopilotInfo.ps1 -OutputFile "${computerName}_AutopilotHWID.csv"

Write-White "HWID file successfully created: ${computerName}_AutopilotHWID.csv"
