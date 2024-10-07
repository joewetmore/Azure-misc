
# https://learn.microsoft.com/en-us/azure/virtual-network/manage-subnet-delegation?tabs=manage-subnet-delegation-powershell#code-try-4

#install module
Install-Module AzureAD
Import-Module AzureAD
Connect-AzureAD

# Check delegation
$sub = @{
    Name = 'CentralUS_DC1_vNet'
    ResourceGroupName = 'CentralUS_DC1'
}  
$subnet = Get-AzVirtualNetwork @sub | Get-AzVirtualNetworkSubnetConfig -Name 'public'

$dg = @{
    Name ='myDelegation'
    Subnet = $subnet
}
Get-AzDelegation @dg



# add delegation on the DATA subnet for 'Microsoft.DBforMySQL/flexibleServers'
$net = @{
    Name = 'CentralUS_DC1_vNet'
    ResourceGroupName = 'CentralUS_DC1'
}
$vnet = Get-AzVirtualNetwork @net

$sub = @{
    Name = 'data'
    VirtualNetwork = $vnet
}
$subnet = Get-AzVirtualNetworkSubnetConfig @sub

$del = @{
    Name = 'myDelegation'
    ServiceName = 'Microsoft.DBforMySQL/flexibleServers'
    Subnet = $subnet
}
$subnet = Add-AzDelegation @del

Set-AzVirtualNetwork -VirtualNetwork $vnet


# add delegation on the PUBLIC subnet for 'Microsoft.Web/serverFarms'
$net = @{
    Name = 'CentralUS_DC1_vNet'
    ResourceGroupName = 'CentralUS_DC1'
}
$vnet = Get-AzVirtualNetwork @net

$sub = @{
    Name = 'public'
    VirtualNetwork = $vnet
}
$subnet = Get-AzVirtualNetworkSubnetConfig @sub

$del = @{
    Name = 'myDelegation'
    ServiceName = 'Microsoft.Web/serverFarms'
    Subnet = $subnet
}
$subnet = Add-AzDelegation @del

Set-AzVirtualNetwork -VirtualNetwork $vnet




# add delegation on the PUBLIC subnet for 'Microsoft.DBforMySQL/flexibleServers'
$net = @{
    Name = 'CentralUS_DC1_vNet'
    ResourceGroupName = 'CentralUS_DC1'
}
$vnet = Get-AzVirtualNetwork @net

$sub = @{
    Name = 'public'
    VirtualNetwork = $vnet
}
$subnet = get-AzVirtualNetworkSubnetConfig @sub

$del = @{
    Name = 'myDelegation'
    # ServiceName = 'Microsoft.DBforMySQL/flexibleServers'
    Subnet = $subnet
}
$subnet = remove-AzDelegation @del

Set-AzVirtualNetwork -VirtualNetwork $vnet
