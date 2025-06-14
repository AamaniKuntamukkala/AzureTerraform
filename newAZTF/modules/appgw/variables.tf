
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
