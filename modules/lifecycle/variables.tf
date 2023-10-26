#-----------------------------------------------------------------------------
# Required Variables
#-----------------------------------------------------------------------------
variable "storage_account_id" {
  description = "(Required) Specifies the id of the storage account to apply the management policy to. Changing this forces a new resource to be created."
  type        = string
}

variable "rules" {
  description = "(Required) List of Lifecycle rules"
  type        = any
}
