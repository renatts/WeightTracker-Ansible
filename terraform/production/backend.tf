## Insert the storage name after storage account is created!!! 
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-weighttracker-production"
    storage_account_name = "<storage-account-name>" 
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}
