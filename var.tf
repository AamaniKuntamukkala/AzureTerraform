variable "tags"{
    type = map
}

variable "rg_name" {}
variable "location" {}
variable "subnet_id" {}
variable "backend_pool_ids" {
  type = list(string)
}
variable "enable_waf" {
  type    = bool
  default = false
}



variable "vmss_name" {}
variable "os_type" {}
variable "ssh_key_data" {}

variable "db_name" {}
variable "sku_name" {}
variable "ha_enabled" {
  type = bool
}
variable "private_access" {
  type = bool
}

variable "vnet_name" {}
variable "vnet_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "db_subnet_cidr" {}
