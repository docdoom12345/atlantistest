terraform {
  backend "azurerm" {
    storage_account_name = "sai124storage"
    container_name       = "rg-container"
    key                  = "terraform.tfstate"
    resource_group_name  = "rg-storage"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.59.0"
    }
  }
  required_version = ">=1.1.0"
}

provider "azurerm" {
  # Configuration options
  features {}
  alias           = "dev"
  client_id       = "2a4873e4-d416-4675-a782-070d0b7ad24a"     #appid
  client_secret   = "Vnq8Q~i5YTRCfqz7iGjw6yvPKhO_5pqXc50p-bBj" #password
  tenant_id       = "cea297cb-9bde-428d-9a6e-48fa9c582ed6"     #tenant
  subscription_id = "2a79f2da-f098-4c8a-8e2a-f426682b1eac"
}
resource "azurerm_resource_group" "example" {
  provider = azurerm.dev #alias reference
  name     = "example-resources"
  location = "West Europe"
}
resource "azurerm_virtual_network" "example" {
  provider            = azurerm.dev #alias reference
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}
