
variable "rg_name" {}
variable "location" {}
variable "subnet_ids" {
  type = list(string)
}

variable "vnet_name" {}
variable "vnet_cidr" {}
variable "public_subnet_cidr" {}
variable "private_subnet_cidr" {}
variable "db_subnet_cidr" {}
