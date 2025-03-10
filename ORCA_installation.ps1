Install-Module ExchangeOnlineManagement

Import-Module ExchangeOnlineManagement
Connect-ExchangeOnline -UserPrincipalName joe@wetmore-consulting.com

Install-Module ORCA -Force

Get-InstalledModule -Name ORCA | ft -AutoSize

Get-ORCAReport
