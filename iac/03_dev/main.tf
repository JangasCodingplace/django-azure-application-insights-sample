terraform {
  required_version = ">= 1.7.1"
}

terraform {
  required_providers {
    azurerm = {
      # docs:
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }
}
