terraform {
  backend "azurerm" {
    resource_group_name   = "nextjsapp-devops"
    storage_account_name  = "tfstatenextjsapp"
    container_name        = "tfstate"
    key                   = "nexjsapp-sandbox.tfstate"
  }
}
