output "virtual_machine_id" {
  value       = resource.azurerm_virtual_machine.primary-vm.id
  description = "Virtual machine ID"
}

output "resource_group_location" {
  value       = resource.azurerm_resource_group.project-resource-group.location
  description = "Resource group location"
}
