## Create linux machine via azure cli in powershell
## 1. Create resource group

az group create --name "demo" --location "westeurope"
az group list -o table

## 2. Create virtual network (vnet) and Subnet

az network vnet create --resource-group "demo" --name "demo-vnet-1" --address-prefix "10.1.0.0/16" --subnet-name "demo-subnet-1" --subnet-prefix "10.1.1.0/24"
az network vnet list -o table

## 3. Create public IP address

az network public-ip create --resource-group "demo" --name "demo-linux-1-pip-1"

## 4. Create network security group

az network nsg create --resource-group "demo" --name "psdemo-linux-nsg-1"
az network nsg list --output table

## 5. Create a virtual network interface and associate with public IP address and NSG

az network nic create --resource-group "demo" --name "demo-linux-1-nic-1" --vnet-name "demo-vnet-1" --subnet "demo-subnet-1" --network-security-group "psdemo-linux-nsg-1" --public-ip-address "demo-linux-1-pip-1"
az network nic list --output table

## 6. Create a virtual machine (with generated ssh key)

az vm create --resource-group "demo" --location "westeurope" --name "demo-linux-1" --nics "demo-linux-1-nic-1" --image "rhel" --admin-username "nedaza" --authentication-type "ssh" --generate-ssh-keys

## 7. Open port 22 to allow SSH traffic to host

az vm open-port --resource-group "demo" --name "demo-linux-1" --port "22"

## 8. Grab the public IP of the virtual machine

az vm list-ip-addresses --name "demo-linux-1" --output table

## 9. Connect

ssh -l nedaza (place that ip)

or

ssh nedaza@13.95.210.40
