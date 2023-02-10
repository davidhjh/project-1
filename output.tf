output "virtual_machine_id" {
    value = resource.azurerm_virtual_machine.primary-vm.id
    description = "Virtual machine ID"
}