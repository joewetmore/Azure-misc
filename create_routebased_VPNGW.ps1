# Variables
$rgName = "Temenos_PE"
$location = "centralus"
$vnetName = "VNet_Temenos_PE"
$subnetName = "GatewaySubnet"
$gatewayName = "VNGW_Temenos_01"
$sku = "VpnGw2"
$gatewayType = "Vpn"
$vpnType = "RouteBased"
$ipName = "VGW_Temenos_1_publicIP1"  # One public IP

# Create public IP address
$publicIp = New-AzPublicIpAddress -Name $ipName -ResourceGroupName $rgName -Location $location `
    -AllocationMethod Static -Sku Standard
	
# Get the virtual network and subnet
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $rgName
$subnet = Get-AzVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet

# Create IP configuration
$ipConfig = New-AzVirtualNetworkGatewayIpConfig -Name "ipconfig1" `
    -SubnetId $subnet.Id -PublicIpAddressId $publicIp.Id

# Create the virtual network gateway
New-AzVirtualNetworkGateway -Name $gatewayName -ResourceGroupName $rgName -Location $location `
    -IpConfigurations $ipConfig -GatewayType $gatewayType -VpnType $vpnType -GatewaySku $sku
