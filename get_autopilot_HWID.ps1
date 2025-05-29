md c:\HWID
set-location c:\HWID
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force
Install-Script -name Get-WindowsAutopilotInfo -force 
$env:Path += ";C:\Program Files\WindowsPowerShell\Scripts"
Get-WindowsAutopilotInfo.ps1 -OutputFile AutopilotHWID.csv 
