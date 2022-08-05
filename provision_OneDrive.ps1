#get module
Get-Module -Name Microsoft.Online.SharePoint.PowerShell -ListAvailable | Select Name,Version

#install module
Install-Module -Name Microsoft.Online.SharePoint.PowerShell
Install-Module MSOnline


#login to SPO and MSOL
$Msolcred = Get-credential
Connect-SPOService -Url https://apcisg-admin.sharepoint.com -Credential $MsolCred
Connect-MsolService -Credential $MsolCred

#provision OneDrive container for new user accounts
Get-Content -path ".\users.csv" | ForEach-Object { Set-MsolUser -UserPrincipalName $_ -BlockCredential $False }
$users = Get-Content -path ".\users.csv"
Request-SPOPersonalSite -UserEmails $users

