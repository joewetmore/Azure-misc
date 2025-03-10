Import-Module AzureAD

# Connect to Azure AD
Connect-AzureAD

# Get all devices with no registered owner
$devices = Get-AzureADDevice | Where-Object {
    (Get-AzureADDeviceRegisteredOwner -ObjectId $_.ObjectId) -eq $null
}

# Get all users
$users = Get-AzureADUser | Select-Object ObjectId, UserPrincipalName

foreach ($device in $devices) {ring(0, [Math]::Min(5, $device.DisplayName.Length))
    
    # Extract the first five characters of the device name
    $deviceNameFragment = $device.DisplayName.Subst
    # Try to find a matching user
    $matchedUser = $users | Where-Object {
        $_.UserPrincipalName -match "^$deviceNameFragment"
    }
    
    if ($matchedUser) {
        # Assign the first matched user as the owner of the device
        try {
            Add-AzureADDeviceRegisteredOwner -ObjectId $device.ObjectId -RefObjectId $matchedUser.ObjectId
            Write-Host "Added $($matchedUser.UserPrincipalName) as owner for device $($device.DisplayName)"
        } catch {
            Write-Host "Failed to add owner for device $($device.DisplayName): $_"
        }
    } else {
        Write-Host "No matching owner found for device $($device.DisplayName)"
    }
}
