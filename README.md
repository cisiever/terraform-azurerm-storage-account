# terraform-azurerm-storage-account
<!-- BEGIN_AUTOMATIC_TF_DOCS -->


# Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.58.0 |



# Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_blob"></a> [blob](#module\_blob) | ./modules/blob | n/a |
| <a name="module_management_policy"></a> [management\_policy](#module\_management\_policy) | ./modules/lifecycle | n/a |
| <a name="module_storage_account"></a> [storage\_account](#module\_storage\_account) | ./modules/storage_account | n/a |

# Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_blobs"></a> [blobs](#input\_blobs) | Blobs to create | `any` | `{}` | no |
| <a name="input_management_policies"></a> [management\_policies](#input\_management\_policies) | Management Policies to create | `any` | `{}` | no |
| <a name="input_storage_accounts"></a> [storage\_accounts](#input\_storage\_accounts) | Storage Accounts to create | `any` | `{}` | no |

# Outputs

| Name | Description |
|------|-------------|
| <a name="output_blobs"></a> [blobs](#output\_blobs) | Storage Account outputs |
| <a name="output_storage_account"></a> [storage\_account](#output\_storage\_account) | Storage Account outputs |


<!-- END_AUTOMATIC_TF_DOCS -->