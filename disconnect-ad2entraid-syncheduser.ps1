#procedure to disconnect an AD>EntraID synced cloud user, make cloud only

#Move to unsynced OU
Install-Module Microsoft.Graph
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All", "User.DeleteRestore.All"
Get-MgDirectoryDeletedUser | Where-Object { $_.DisplayName -like "*username*" }
$user = Get-MgDirectoryDeletedUser | Where-Object { $_.DisplayName -like "*username*" }
Restore-MgDirectoryDeletedItem -DirectoryObjectId $user.Id
Get-ADSyncToolsOnPremisesAttribute -Identity username@yourdomain.com
Clear-ADSyncToolsOnPremisesAttribute -Identity 'username@yourdomain.com' -onPremisesImmutableId
