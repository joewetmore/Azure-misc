# Connect to Microsoft Graph
Connect-MgGraph -Scopes ("Application.Read.All")
# Get all Service Principals (Enterprise applications)
$servicePrincipals = Get-MgServicePrincipal -All
foreach ($sp in $servicePrincipals) {
    
    # Get Application Owners
    $appOwners = [System.Collections.ArrayList]@()
    $ofs = ";"
    $appOwnersIds = Get-MgServicePrincipalOwner -ServicePrincipalId $sp.Id -ErrorAction SilentlyContinue
    if ( $appOwnersIds.count -gt 0 ) {
        $appOwnersIds | ForEach-Object {
            try {
                $ownerDisplayName = (Get-MgUser -UserId $_.Id -ErrorAction SilentlyContinue).DisplayName
                $appOwners.add($ownerDisplayName) | Out-Null
            }
            catch {
                $appOwners.add("Invalid Owner") | Out-Null
            }
            
        }
    }
    Else {
        $appOwners.add("None") | Out-Null
    }
    # Get Application Users
    $appRoleAssignments = Get-MgServicePrincipalAppRoleAssignedTo -ServicePrincipalId $sp.Id -ErrorAction SilentlyContinue
    # Construct report data
    $reportData = [PSCustomObject]@{
        "Application Name"  = $sp.DisplayName
        "Application ID"    = $sp.AppId
        "Created Date"      = [String]$sp.AdditionalProperties.createdDateTime
        "Owners"            = [String]$appOwners
        "Users"             = ($appRoleAssignments | ForEach-Object { $_.PrincipalDisplayName }) -join ", "
    }
# Output or append to a CSV file
$reportData | Export-Csv -Path "C:\temp\service-principals-report.csv" -Append -NoTypeInformation
}
