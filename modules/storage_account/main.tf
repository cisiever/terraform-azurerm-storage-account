################################################################################################
# Azure Storge Account Module
################################################################################################

#-----------------------------------------------------------------------------
# Create Resource Group if create_resource_group is flagged true
#-----------------------------------------------------------------------------
resource "azurecaf_name" "this" {
  count = var.create_resource_group ? 1 : 0

  name          = var.resource_group_name
  prefixes      = var.prefixes
  resource_type = "azurerm_resource_group"
  passthrough   = var.passthrough
}


resource "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 1 : 0

  location = var.location
  name     = azurecaf_name.this[count.index].result
  tags     = var.tags
}
#-----------------------------------------------------------------------------
# Storage Account
#-----------------------------------------------------------------------------
resource "azurerm_storage_account" "this" {
  location                          = try(data.azurerm_resource_group.this[0].location, azurerm_resource_group.this[0].location)
  name                              = var.name
  resource_group_name               = try(data.azurerm_resource_group.this[0].name, azurerm_resource_group.this[0].name)
  access_tier                       = try(var.access_tier, "Hot")
  account_kind                      = try(var.account_kind, "StorageV2")
  account_replication_type          = try(var.account_replication_type, "LRS")
  account_tier                      = try(var.account_tier, "Standard")
  public_network_access_enabled     = try(var.public_network_access_enabled, false)
  allow_nested_items_to_be_public   = try(var.allow_nested_items_to_be_public, null)
  cross_tenant_replication_enabled  = try(var.cross_tenant_replication_enabled, null)
  enable_https_traffic_only         = try(var.enable_https_traffic_only, true)
  infrastructure_encryption_enabled = try(var.infrastructure_encryption_enabled, null)
  is_hns_enabled                    = try(var.is_hns_enabled, false)
  large_file_share_enabled          = try(var.large_file_share_enabled, null)
  min_tls_version                   = try(var.min_tls_version, "TLS1_2")
  nfsv3_enabled                     = try(var.nfsv3_enabled, false)
  queue_encryption_key_type         = try(var.queue_encryption_key_type, null)
  sftp_enabled                      = try(var.sftp_enabled, false)
  table_encryption_key_type         = try(var.table_encryption_key_type, null)
  tags                              = try(var.tags, {})

  dynamic "custom_domain" {
    for_each = var.custom_domain != null ? var.custom_domain : {}

    content {
      name          = can(custom_domain.value.name) ? custom_domain.value.name : null
      use_subdomain = try(custom_domain.value.use_subdomain, null)
    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? var.identity : {}
    content {
      type         = try(identity.value.managed_identity_type, "SystemAssigned")
      identity_ids = identity.value.managed_identity_type == "UserAssigned" || identity.value.managed_identity_type == "SystemAssigned, UserAssigned" ? identity.value.managed_identity_ids : null
    }
  }

  dynamic "blob_properties" {
    for_each = try(var.blob_properties.*, {})

    content {
      versioning_enabled       = try(blob_properties.value.versioning_enabled, false)
      change_feed_enabled      = try(blob_properties.value.change_feed_enabled, false)
      default_service_version  = try(blob_properties.value.default_service_version, "2020-06-12")
      last_access_time_enabled = try(blob_properties.value.last_access_time_enabled, false)

      dynamic "cors_rule" {
        for_each = try(blob_properties.value.cors_rules.*, {})

        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = try(blob_properties.value.delete_retention_policy.*, {})

        content {
          days = try(delete_retention_policy.value.days, 7)
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = try(blob_properties.value.container_delete_retention_policy.*, {})

        content {
          days = try(container_delete_retention_policy.value.days, 7)
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = try(var.queue_properties.*, {})

    content {
      dynamic "cors_rule" {
        for_each = try(queue_properties.value.cors_rules.*, {})

        content {
          allowed_headers    = cors_rule.value.allowed_headers
          allowed_methods    = cors_rule.value.allowed_methods
          allowed_origins    = cors_rule.value.allowed_origins
          exposed_headers    = cors_rule.value.exposed_headers
          max_age_in_seconds = cors_rule.value.max_age_in_seconds
        }
      }
      dynamic "logging" {

        for_each = try(queue_properties.value.logging.*, {})

        content {
          delete                = logging.value.logging.delete
          read                  = logging.value.logging.read
          write                 = logging.value.logging.write
          version               = logging.value.logging.version
          retention_policy_days = try(logging.value.retention_policy_days, 7)
        }
      }

      dynamic "minute_metrics" {
        for_each = try(queue_properties.value.minute_metrics.*, {})
        content {
          enabled               = minute_metrics.value.enabled
          version               = minute_metrics.value.version
          include_apis          = try(minute_metrics.value.include_apis, null)
          retention_policy_days = try(minute_metrics.value.retention_policy_days, 7)
        }
      }

      dynamic "hour_metrics" {
        for_each = try(queue_properties.value.hour_metrics.*, {})

        content {
          enabled               = hour_metrics.value.enabled
          version               = hour_metrics.value.version
          include_apis          = try(hour_metrics.value.include_apis, null)
          retention_policy_days = try(hour_metrics.value.retention_policy_days, 7)
        }
      }
    }
  }
  dynamic "static_website" {
    for_each = try(var.static_website.*, {})

    content {
      index_document     = try(static_website.value.index_document, null)
      error_404_document = try(static_website.value.error_404_document, null)
    }
  }

  # dynamic "network_rules" {
  #   for_each = can(var.network_rules) != null ? [1] : []
  #   content {
  #     bypass         = try(var.network_rules.network.bypass, [])
  #     default_action = try(var.network_rules.default_action, "Deny")
  #     ip_rules       = try(var.network_rules.ip_rules, [])
  #     virtual_network_subnet_ids = try(var.network_rules.subnets, null) == null ? null : [
  #       for key, value in var.network_rules.subnets : can(value.remote_subnet_id) ? value.remote_subnet_id :
  #      ]
  #   }
  # }

  dynamic "azure_files_authentication" {

    for_each = var.azure_files_authentication != null ? var.azure_files_authentication : {}
    content {
      directory_type = try(azure_files_authentication.value.directory_type, "AD")

      dynamic "active_directory" {
        for_each = try(var.azure_files_authentication.active_directory.*, {})
        content {
          storage_sid         = active_directory.value.storage_sid
          domain_name         = active_directory.value.domain_name
          domain_sid          = active_directory.value.domain_sid
          domain_guid         = active_directory.value.domain_guid
          forest_name         = active_directory.value.forest_name
          netbios_domain_name = active_directory.value.netbios_domain_name
        }
      }
    }
  }

  dynamic "routing" {
    for_each = try(var.routing.*, {})
    content {
      publish_internet_endpoints  = try(routing.value.publish_internet_endpoints, false)
      publish_microsoft_endpoints = try(routing.value.publish_microsoft_endpoints, false)
      choice                      = try(routing.value.choice, "MicrosoftRouting")
    }
  }
}
#-----------------------------------------------------------------------------
# Advanced Threat Protection
#-----------------------------------------------------------------------------
resource "azurerm_advanced_threat_protection" "this" {
  target_resource_id = azurerm_storage_account.this.id
  enabled            = try(var.advanced_threat_protection_enabled, false)
}
#-----------------------------------------------------------------------------
# Private Endpoint
#-----------------------------------------------------------------------------
resource "azurerm_private_endpoint" "this" {
  for_each = var.private_endpoint

  name                = "${azurerm_storage_account.this.name}-private-endpoint"
  location            = azurerm_storage_account.this.location
  resource_group_name = azurerm_storage_account.this.resource_group_name
  subnet_id           = each.value.private_endpoint_subnet_id

  private_service_connection {
    name                           = "storageaccountPrivateEndpoint"
    private_connection_resource_id = azurerm_storage_account.this.id
    is_manual_connection           = false
    subresource_names              = each.value.subresource_names
  }

  private_dns_zone_group {
    name                 = each.value.private_dns_zone_group_name
    private_dns_zone_ids = [each.value.private_dns_zone_ids]
  }
}
