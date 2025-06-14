
rg_name             = "prod-rg"
location            = "East US"
vnet_name           = "prod-vnet"
vnet_cidr           = "10.0.0.0/16"
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"
db_subnet_cidr      = "10.0.3.0/24"
vmss_name           = "web-vmss"
os_type             = "linux"
ssh_key_data        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC..."
db_name             = "mydb"
sku_name            = "Standard_D4s_v3"
ha_enabled          = true
private_access      = true
tags = {
  environment = "prod"
  owner       = "devops-team"
}
