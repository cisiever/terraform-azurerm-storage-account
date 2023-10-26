#-----------------------------------------------------------------------------
# Required Variables
#-----------------------------------------------------------------------------

variable "name" {
  description = "(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "account_tier" {
  description = "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
  type        = string
}

variable "account_replication_type" {
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  type        = string

}

#-----------------------------------------------------------------------------
# Optional Variables
#-----------------------------------------------------------------------------

variable "account_kind" {
  description = "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2"
  type        = string
  default     = "StorageV2"
}

variable "allow_nested_items_to_be_public" {
  description = "(Optional) Allow or disallow nested items within this Account to opt into being public."
  type        = bool
  default     = true
}

variable "create_resource_group" {
  description = "(Optional) Whether to create resource group"
  type        = bool
  default     = false
}

variable "cross_tenant_replication_enabled" {
  description = " (Optional) Should cross Tenant replication be enabled?"
  default     = true
}

variable "default_to_oauth_authentication" {
  description = "(Optional) Default to Azure Active Directory authorization in the Azure portal when accessing the Storage Account."
  type        = bool
  default     = false
}

variable "edge_zone" {
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Storage Account should exist. Changing this forces a new Storage Account to be created."
  type        = string
  default     = null
}

variable "enable_https_traffic_only" {
  description = "(Optional) Boolean flag which forces HTTPS if enabled, see here for more information."
  type        = bool
  default     = true

}

variable "is_hns_enabled" {
  description = "(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2. Changing this forces a new resource to be created. This can only be true when account_tier is Standard or when account_tier is Premium and account_kind is BlockBlobStorage"
  type        = bool
  default     = false
}

variable "min_tls_version" {
  description = "(Optional) The minimum supported TLS version for the storage account"
  type        = string
  default     = "TLS1_2"
}

variable "nfsv3_enabled" {
  description = "(Optional) Is NFSv3 protocol enabled? Changing this forces a new resource to be created"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "(Optional) Whether the public network access is enabled?"
  type        = bool
  default     = true
}

variable "shared_access_key_enabled" {
  description = " (Optional) Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key. If false, then all requests, including shared access signatures, must be authorized with Azure Active Directory (Azure AD)."
  type        = bool
  default     = true
}

variable "managed_identity_type" {
  description = "(Optional) Specifies the type of Managed Service Identity that should be configured on this Storage Account. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)."
  type        = string
  default     = null
}

variable "managed_identity_ids" {
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Storage Account."
  type        = list(string)
  default     = null
}

variable "custom_domain" {
  description = "(Optional) Configure a custom domain for the storage account"
  type        = any
  default     = {}
}

variable "infrastructure_encryption_enabled" {
  description = "(Optional) Is infrastructure encryption enabled? Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  description = "(Optional) Is Large File Share Enabled?"
  type        = bool
  default     = false
}

variable "queue_encryption_key_type" {
  description = " The encryption type of the queue service. Possible values are Service and Account. Changing this forces a new resource to be created."
  type        = string
  default     = "Service"
}

variable "table_encryption_key_type" {
  description = "(Optional) The encryption type of the table service. Possible values are Service and Account."
  type        = string
  default     = "Service"
}

variable "sftp_enabled" {
  description = " (Optional) Boolean, enable SFTP for the storage account"
  type        = bool
  default     = false
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

variable "access_tier" {
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool"
  type        = string
  default     = "Hot"
}

variable "passthrough" {
  description = "(Optional) Prefixes are not appended to resource name"
  default     = false
  type        = bool
}

variable "prefixes" {
  default     = []
  description = "(Optional) Prefix used in naming"
  type        = list(string)
}

variable "blob_properties" {
  description = "(Optional) Settings for blobs in storage account"
  type        = any
  default     = {}
}

variable "queue_properties" {
  description = "(Optional) Settings for queues in storage account"
  type        = any
  default     = {}
}

variable "static_website" {
  description = "(Optional) You can serve static content (HTML, CSS, JavaScript, and image files) directly from a storage container,can only be set when the account_kind is set to StorageV2 or BlockBlobStorage."
  type        = any
  default     = null
}

variable "azure_files_authentication" {
  description = "(Optional) Authentication Settings for Azure Files"
  type        = any
  default     = null
}

variable "routing" {
  description = "(Optional) Routing Settings for Storage Account"
  type        = any
  default     = null
}

variable "network_rules" {
  description = "(Optional) Network Access Rules"
  type        = any
  default     = null
}

variable "identity" {
  description = "(Optional) Assign an Identity to Storage Account"
  type        = any
  default     = null
}

variable "advanced_threat_protection_enabled" {
  description = "(Optional) Enable Advanced Threat Protection for Storage Account"
  type        = bool
  default     = false
}

variable "private_endpoint" {
  description = "Map of private endpoint configurations"
  type = map(object({
    private_endpoint_subnet_id  = optional(string)
    private_dns_zone_group_name = optional(string)
    private_dns_zone_ids        = optional(string)
    subresource_names           = optional(list(string))
  }))
  default = {}
}
