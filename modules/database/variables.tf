
variable "rg_name" {}
variable "location" {}
variable "subnet_id" {}
variable "db_name" {}
variable "sku_name" {}
variable "ha_enabled" {
  type = bool
}
variable "private_access" {
  type = bool
}
