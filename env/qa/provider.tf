terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.51.0"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "e5efa2cd-02a5-4c7b-be99-6e2ae6d5feac"
}
