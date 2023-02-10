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
  name     = "project-resource-group"
  location = "East US"
}

resource "azurerm_virtual_machine" "primary-vm" {
  name                = "primary-vm"
  resource_group_name = azurerm_resource_group.project-resource-group.name
  location            = azurerm_resource_group.project-resource-group.location
}

resource "azurerm_storage_account" "storage-account" {
  name                     = "storage-account"
  resource_group_name      = azurerm_resource_group.project-resource-group.name
  location                 = azurerm_resource_group.project-resource-group.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    name = "primary-sa"
  }
}

