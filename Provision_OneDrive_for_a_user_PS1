# pre-provision OD accounts, from https://learn.microsoft.com/en-us/sharepoint/pre-provision-accounts
# install & open SharePoint Online management shell
# https://learn.microsoft.com/en-us/powershell/sharepoint/sharepoint-online/connect-sharepoint-online

# users.txt is a list of UPNs


Connect-SPOService -Url https://mycompany-admin.sharepoint.com

Get-Content -path "C:\scripts\Users.txt" | ForEach-Object { Update-MgUser -UserPrincipalName $_ -BlockCredential $False }

#verify
$users = Get-Content -path "C:\Users.txt"
Request-SPOPersonalSite -UserEmails $users
