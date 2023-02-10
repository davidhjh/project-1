resource "azuread_user" "david" {
  user_principal_name = "david@email.com"
  display_name        = "David"
  password            = "david.password"
}

resource "azuread_user" "ibrahim" {
  user_principal_name   = "ibrahim@email.com"
  display_name          = "Ibrahim"
  password              = "ibrahim.password"
  force_password_change = true
}



resource "aws_iam_user" "four-users" {
  for_each = toset(var.users)
  name     = each.value
}



resource "aws_s3_bucket" "s3" {
  bucket = var.s3_bucket_name
  count  = 2
}



resource "azurerm_resource_group" "project-resource-group" {
  name     = var.resource_group_name
  location = "East US"
}

resource "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.project-resource-group.location
  resource_group_name = azurerm_resource_group.project-resource-group.name
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.project-resource-group.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "main" {
  name                = var.nic_name
  location            = azurerm_resource_group.project-resource-group.location
  resource_group_name = azurerm_resource_group.project-resource-group.name

  ip_configuration {
    name                          = "primaryconfiguration"
    private_ip_address_allocation = "Static"
  }
}

resource "azurerm_virtual_machine" "primary-vm" {
  name                  = var.virtual_machine_name
  resource_group_name   = azurerm_resource_group.project-resource-group.name
  location              = azurerm_resource_group.project-resource-group.location
  network_interface_ids = [azurerm_network_interface.main.id]
  vm_size               = "Standard_DS1_v2"

  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_os_disk {
    name          = var.os_disk_name
    create_option = "Attach"
  }

  tags = {
    name = "linux-vm"
  }
}

resource "azurerm_storage_account" "storage-account" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.project-resource-group.name
  location                 = azurerm_resource_group.project-resource-group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    name = "primary-sa"
  }
}

