################################################################################################
# Azure Storage Account Variables
################################################################################################

variable "storage_accounts" {
  description = "Storage Accounts to create"
  type        = any
  default     = {}
}

variable "blobs" {
  description = "Blobs to create"
  type        = any
  default     = {}
}

variable "management_policies" {
  description = "Management Policies to create"
  type        = any
  default     = {}
}

