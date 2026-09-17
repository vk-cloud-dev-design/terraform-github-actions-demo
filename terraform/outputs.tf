output "resource_group_name" {
  description = "Created Resource Group name"
  value       = azurerm_resource_group.rg.name
}

output "resource_group_location" {
  description = "Resource Group location"
  value       = azurerm_resource_group.rg.location
}
