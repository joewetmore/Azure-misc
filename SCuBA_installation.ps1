# Install ScubaGear
Install-Module -Name ScubaGear

# Install the minimum required dependencies
Initialize-SCuBA 

# Check the version
Invoke-SCuBA -Version

# Assess all products
Invoke-SCuBA -ProductNames *

# Specific products
Invoke-SCuBA -ProductNames aad
Invoke-SCuBA -ProductNames defender
Invoke-SCuBA -ProductNames exo
Invoke-SCuBA -ProductNames sharepoint
Invoke-SCuBA -ProductNames teams
Invoke-SCuBA -ProductNames powerplatform

# Delete all tokens
Disconnect-SCuBATenant

# Upgrade your installed version
Update-Module -Name ScubaGear

# Uninstall & verify
Uninstall-Module -Name ScubaGear
Get-Module -Name ScubaGear -ListAvailabile
