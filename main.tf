provider "azurerm" {
  version = "2.26"
  features {}
}

resource "azurerm_resource_group" "remote_state_rg" {
  name     = "${var.resource_group_name}-rg"
  location = var.resource_group_location
}

resource "azurerm_storage_account" "remote_state_storage" {
  name                     = "remotestatestor001"
  resource_group_name      = azurerm_resource_group.remote_state_rg.name
  location                 = azurerm_resource_group.remote_state_rg.location
  account_tier             = "standard"
  account_replication_type = var.tags["Environment"] == "Production" ? "GRS" : "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "remote_state_storage_container" {
  name                  = "remotestate"
  storage_account_name  = azurerm_storage_account.remote_state_storage.name
  container_access_type = "private"
}
