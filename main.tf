terraform {
  required_providers { 
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  rg_name             = azurerm_resource_group.rg.name
  location            = var.location
  vnet_name           = "prod-vnet"
  vnet_cidr           = "10.0.0.0/16"
  public_subnet_cidr  = cidrsubnet("10.0.0.0/16", 8, 1) # 10.0.1.0/24
  private_subnet_cidr = cidrsubnet("10.0.0.0/16", 8, 2) # 10.0.2.0/24
  db_subnet_cidr      = cidrsubnet("10.0.0.0/16", 8, 3) # 10.0.3.0/24
}

module "nsg" {
  source     = "./modules/nsg"
  rg_name    = azurerm_resource_group.rg.name
  location   = var.location
  subnet_ids = module.network.subnet_ids
}

module "compute" {
  source       = "./modules/compute"
  rg_name      = azurerm_resource_group.rg.name
  location     = var.location
  subnet_id    = module.network.private_subnet_id
  vmss_name    = "app-vmss"
  os_type      = "ubuntu"
  ssh_key_data = file("~/.ssh/id_rsa.pub")
}

module "appgw" {
  source           = "./modules/appgw"
  rg_name         = azurerm_resource_group.rg.name
  location        = var.location
  subnet_id       = module.network.public_subnet_id
  backend_pool_ids = [module.compute.vmss_backend_pool_id]
  enable_waf      = true
}

module "database" {
  source         = "./modules/database"
  rg_name        = azurerm_resource_group.rg.name
  location       = var.location
  subnet_id      = module.network.db_subnet_id
  db_name        = "appdb"
  sku_name       = "Standard_B1ms"
  ha_enabled     = true
  private_access = true
}
