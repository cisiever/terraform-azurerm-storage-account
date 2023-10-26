################################################################################################
# Terraform requirements and versions
################################################################################################
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.58.0"
    }

    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = ">= 1.0.0, < 2.0.0"
    }
  }

  required_version = ">= 1.0.0, < 2.0.0"
}