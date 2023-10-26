#-----------------------------------------------------------------------------
# Required Variables
#-----------------------------------------------------------------------------
variable "create_container" {
  description = "(Required) Create Storage Account Container"
  type        = bool
}
variable "blob_name" {
  description = "(Required) The name of the storage blob. Must be unique within the storage container the blob is located. Changing this forces a new resource to be created."
  type        = string
}
variable "container_name" {
  description = "(Required) Name of Container"
  type        = string
}
variable "storage_container_name" {
  description = "(Required) The name of the storage container in which this blob should be created. Changing this forces a new resource to be created."
  type        = string
}
variable "storage_account_name" {
  description = "(Required) The name of the Storage Account where the Container should be created. Changing this forces a new resource to be created."
  type        = string
}
variable "type" {
  description = "(Required) The type of the storage blob to be created. Possible values are Append, Block or Page. Changing this forces a new resource to be created."
}
#-----------------------------------------------------------------------------
# Optional Variables
#-----------------------------------------------------------------------------
variable "container_access_type" {
  description = "(Optional) The Access Level configured for this Container. Possible values are blob, container or private."
  type        = string
  default     = "private"
}
variable "container_metadata" {
  description = "(Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase."
  type        = any
  default     = null
}
variable "blob_metadata" {
  description = "(Optional) A mapping of MetaData for this Blob. All metadata keys should be lowercase."
  type        = any
  default     = null
}
variable "size" {
  description = "(Optional) Used only for page blobs to specify the size in bytes of the blob to be created. Must be a multiple of 512. Changing this forces a new resource to be created."
  type        = number
  default     = 0
}
variable "access_tier" {
  description = "(Optional) The access tier of the storage blob. Possible values are Archive, Cool and Hot"
  type        = string
  default     = null
}
variable "cache_control" {
  description = "(Optional) Controls the cache control header content of the response when blob is requested."
  type        = any
  default     = null
}
variable "content_type" {
  description = "(Optional) The content type of the storage blob. Cannot be defined if source_uri is defined. "
  type        = string
  default     = "application/octet-stream"
}
variable "blob_source" {
  description = "(Optional) An absolute path to a file on the local system. This field cannot be specified for Append blobs and cannot be specified if source_content or source_uri is specified. Changing this forces a new resource to be created."
  type        = string
  default     = null
}
variable "source_content" {
  description = "(Optional) The content for this blob which should be defined inline. This field can only be specified for Block blobs and cannot be specified if source or source_uri is specified. Changing this forces a new resource to be created."
  type        = any
  default     = null
}
variable "source_uri" {
  description = "(Optional) The URI of an existing blob, or a file in the Azure File service, to use as the source contents for the blob to be created. Changing this forces a new resource to be created. This field cannot be specified for Append blobs and cannot be specified if source or source_content is specified."
  type        = string
  default     = null
}
variable "parallelism" {
  description = "(Optional) The number of workers per CPU core to run for concurrent uploads. Changing this forces a new resource to be created."
  type        = number
  default     = 8
}
variable "content_md5" {
  description = "(Optional) The MD5 sum of the blob contents. Cannot be defined if source_uri is defined, or if blob type is Append or Page. Changing this forces a new resource to be created"
  type        = string
  default     = null

}
