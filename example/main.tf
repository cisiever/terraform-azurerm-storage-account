resource "azurecaf_name" "this" {
  name = "sa-example"
  prefixes = [
    "siev",
  ]
  resource_type = "azurerm_resource_group"
  passthrough   = false
}
resource "azurerm_resource_group" "this" {
  location = "North Europe"
  name     = azurecaf_name.this.result
  tags = {
    Environment = "azure=non-production"
    Terraform   = "true"
    managedBy   = "Platform Delivery"
  }
}

module "storage_account" {
  source = "../"

  storage_accounts = {
    sa1 = {
      name                          = "pdsaexample"
      resource_group_name           = azurerm_resource_group.this.name
      location                      = azurerm_resource_group.this.location
      create_resource_group         = false
      public_network_access_enabled = true
      blob_properities = {
        versioning_enabled       = true
        last_access_time_enabled = true
        delete_retention_policy = {
          days = 10
        }
      }
      private_endpoint = {
        endpoint1 = {
          private_endpoint_subnet_id  = "/subscriptions/a428f8d4-175a-443c-9ef2-738fc85acdb8/resourceGroups/deca-rg-devops-vnet/providers/Microsoft.Network/virtualNetworks/deca-vnet-devops/subnets/private_endpoints"
          private_dns_zone_group_name = "privatelink.vaultcore.azure.net"
          private_dns_zone_ids        = "/subscriptions/a428f8d4-175a-443c-9ef2-738fc85acdb8/resourceGroups/deca-rg-dns-zones/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
          subresource_names           = ["blob"]
        }
      }
    }
  }
  blobs = {
    blob1 = {
      storage_account_name = module.storage_account.storage_account["sa1"].name

      # Set true to create container
      create_container      = true
      container_name        = "tfs"
      container_access_type = "private"
      blob_name             = "terraform.tfstate"
      type                  = "Block"
      content_type          = "application/json"
      blob_source           = "./terraform.tfstate"
    }
    blob2 = {
      storage_account_name = module.storage_account.storage_account["sa1"].name

      # Set true to create container
      create_container      = false
      container_name        = "tfs"
      container_access_type = "private"
      blob_name             = "main.tf"
      type                  = "Block"
      blob_source           = "/home/csievering/main.tf"
    }
  }

  management_policies = {
    policy1 = {
      storage_account_id = module.storage_account.storage_account["sa1"].id
      rules = {
        rule_2 = {
          name    = "rule2"
          enabled = true
          filters = {
            filter_specs = {
              blob_types = ["blockBlob"]
              # This code can only be used if enable `BlobIndex`
              # https://azure.microsoft.com/en-us/blog/manage-and-find-data-with-blob-index-for-azure-storage-now-in-preview/
              #match_blob_index_tag = {
              #match_blob_index_tag_specs = {
              #  name      = "tag1"
              #  operation = "=="
              #  value     = "val1"
              #}
              #}
            }
          }
          actions = {
            base_blob = {
              blob_specs = {
                tier_to_cool_after_days_since_modification_greater_than    = 11
                tier_to_archive_after_days_since_modification_greater_than = 51
                delete_after_days_since_modification_greater_than          = 101
              }
            }
            snapshot = {
              snapshot_specs = {
                change_tier_to_archive_after_days_since_creation = 90
                change_tier_to_cool_after_days_since_creation    = 23
                delete_after_days_since_creation_greater_than    = 31
              }
            }
            version = {
              version_specs = {
                change_tier_to_archive_after_days_since_creation = 9
                change_tier_to_cool_after_days_since_creation    = 90
                delete_after_days_since_creation                 = 3
              }
            }
          }
        }
      }
    }
  }
}


