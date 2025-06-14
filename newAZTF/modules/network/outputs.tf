
output "public_subnet_id" {
  value = azurerm_subnet.public.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private.id
}

output "db_subnet_id" {
  value = azurerm_subnet.db.id
}

output "subnet_ids" {
  value = [azurerm_subnet.public.id, azurerm_subnet.private.id, azurerm_subnet.db.id]
}
