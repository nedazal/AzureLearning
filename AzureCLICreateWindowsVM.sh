## Create Windows VM on Azule CLI in Powershell

## 1. Create resource group

az group create --name "demo" --location "westeurope"
az group list -o table

## 2. Create virtual network (vnet) and Subnet

az network vnet create --resource-group "demo" --name "demo-vnet-1" --address-prefix "10.1.0.0/16" --subnet-name "demo-subnet-1" --subnet-prefix "10.1.1.0/24"
az network vnet list -o table

## 3. Create public IP address

az network public-ip create --resource-group "demo" --name "demo-win-1-pip-1"

## 4. Create network security group

az network nsg create --resource-group "demo" --name "demo-win-nsg-1"
az network nsg list --output table

## 5. Create a virtual network interface and associate with public IP address and NSG

az network nic create --resource-group "demo" --name "demo-win-1-nic-1" --vnet-name "demo-vnet-1" --subnet "demo-subnet-1" --network-security-group "demo-win-nsg-1" --public-ip-address "demo-win-1-pip-1"
az network nic list --output table

## 6. Create a virtual machine

az vm create --resource-group "demo" --name "demo-win-1" --location "westeurope" --nics "demo-win-1-nic-1" --image "win2016datacenter" --admin-username "demoadmin" --admin-password "Informatika.503"

## 7. Open port 3389 to allow RDP traffic to host

az vm open-port --port "3389" --resource-group "demo" --name "demo-win-1"

## 8. List ip addresss and connect through rdp

az vm list-ip-addresses --name "demo-win-1"  --output table

