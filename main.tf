################################################################################################
# Azure Storge Account Module
################################################################################################

#-----------------------------------------------------------------------------
# Storage Account
#-----------------------------------------------------------------------------
module "storage_account" {
  source   = "./modules/storage_account"
  for_each = var.storage_accounts

  name                              = each.value.name
  resource_group_name               = each.value.resource_group_name
  create_resource_group             = each.value.create_resource_group
  location                          = each.value.location
  account_kind                      = try(each.value.account_kind, "StorageV2")
  account_replication_type          = try(each.value.account_replication_type, "LRS")
  account_tier                      = try(each.value.account_tier, "Standard")
  public_network_access_enabled     = try(each.value.public_network_access_enabled, false)
  allow_nested_items_to_be_public   = try(each.value.allow_nested_items_to_be_public, false)
  cross_tenant_replication_enabled  = try(each.value.cross_tenant_replication_enabled, false)
  enable_https_traffic_only         = try(each.value.enable_https_traffic_only, true)
  infrastructure_encryption_enabled = try(each.value.infrastructure_encryption_enabled, false)
  is_hns_enabled                    = try(each.value.is_hns_enabled, false)
  large_file_share_enabled          = try(each.value.large_file_share_enabled, false)
  min_tls_version                   = try(each.value.min_tls_version, "TLS1_2")
  nfsv3_enabled                     = try(each.value.nfsv3_enabled, false)
  queue_encryption_key_type         = try(each.value.queue_encryption_key_type, null)
  sftp_enabled                      = try(each.value.sftp_enabled, false)
  table_encryption_key_type         = try(each.value.table_encryption_key_type, null)
  tags                              = try(each.value.tags, {})
  access_tier                       = try(each.value.access_tier, "Hot")
  blob_properties                   = try(each.value.blob_properities, {})
  queue_properties                  = try(each.value.queue_properities, {})
  static_website                    = try(each.value.static_website, {})
  azure_files_authentication        = try(each.value.azure_files_authentication, {})
  identity                          = try(each.value.identity, {})
  routing                           = try(each.value.routing, {})
  custom_domain                     = try(each.value.custom_domain, {})
  private_endpoint                  = try(each.value.private_endpoint, {})
}


#-----------------------------------------------------------------------------
# Blob Storage
#-----------------------------------------------------------------------------
module "blob" {
  source = "./modules/blob"

  for_each = var.blobs

  storage_account_name = each.value.storage_account_name
  # Container Creation Variables
  create_container      = each.value.create_container
  container_name        = each.value.container_name
  container_metadata    = try(each.value.container_metadata, null)
  container_access_type = try(each.value.container_access_type, "private")

  # Blob Creation Variables
  blob_name              = each.value.blob_name
  type                   = each.value.type
  storage_container_name = each.value.container_name
  size                   = try(each.value.size, 0)
  blob_metadata          = try(each.value.blob_metadata, null)
  access_tier            = try(each.value.access_tier, "Hot")
  cache_control          = try(each.value.cache_control, null)
  content_type           = try(each.value.content_type, "application/octet-stream")
  blob_source            = try(each.value.blob_source, null)
  source_content         = try(each.value.source_content, null)
  source_uri             = try(each.value.source_uri, null)
  parallelism            = try(each.value.parallelism, 8)
}

#-----------------------------------------------------------------------------
# LifeCycle
#-----------------------------------------------------------------------------
module "management_policy" {
  source   = "./modules/lifecycle"
  for_each = var.management_policies

  storage_account_id = each.value.storage_account_id
  rules              = each.value.rules

}
#-----------------------------------------------------------------------------
# Private Endpoint
#-----------------------------------------------------------------------------
