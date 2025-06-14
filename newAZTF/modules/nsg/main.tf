
# NSGs with rules for public, private, and db subnets
resource "azurerm_network_security_group" "public_nsg" {
  name                = "public-nsg"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow-http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
