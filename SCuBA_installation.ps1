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
