
resource "azurerm_postgresql_flexible_server" "db" {
  name                = var.db_name
  resource_group_name = var.rg_name
  location            = var.location
  version             = "13"
  sku_name            = var.sku_name
  storage_mb          = 32768
  administrator_login          = "psqladminun"
  administrator_password       = "H@Sh1CoR3!"
  delegated_subnet_id          = var.subnet_id
}
