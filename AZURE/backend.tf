terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
  #   backend "azurerm" {
  #     resource_group_name  = "storage_resource"
  #     storage_account_name = "storagekeybucket"
  #     container_name       = "storagecontainer"
  #     key                  = "terraform.tfstate"

  #       //lifecycle { prevent_destroy = true }
  # }
}


provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}