################################################################################################
# Azure Storge Account Blob Module
################################################################################################
#-----------------------------------------------------------------------------
# Create container if create_container is flagged true
#-----------------------------------------------------------------------------
resource "azurerm_storage_container" "this" {
  count = var.create_container ? 1 : 0

  name                  = var.container_name
  storage_account_name  = var.storage_account_name
  container_access_type = try(var.container_access_type, "private")
  metadata              = try(var.container_metadata, null)
}
#-----------------------------------------------------------------------------
# Blob Creation
#-----------------------------------------------------------------------------
resource "azurerm_storage_blob" "this" {
  name                   = var.blob_name
  storage_account_name   = var.storage_account_name
  storage_container_name = try(azurerm_storage_container.this[0].name, var.container_name, )
  type                   = var.type
  size                   = try(var.size, 0)
  access_tier            = try(var.access_tier, "Hot")
  cache_control          = try(var.cache_control, null)
  content_type           = try(var.content_type, "application/octect-stream")
  content_md5            = try(var.content_md5, null)
  source                 = try(var.blob_source, null)
  source_content         = try(var.source_content, null)
  source_uri             = try(var.source_uri, null)
  parallelism            = try(var.parallelism, 8)
  metadata               = try(var.blob_metadata, null)
}
