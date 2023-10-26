<!-- BEGIN_AUTOMATIC_TF_DOCS -->




# Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |



# Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_rules"></a> [rules](#input\_rules) | (Required) List of Lifecycle rules | `any` | n/a | yes |
| <a name="input_storage_account_id"></a> [storage\_account\_id](#input\_storage\_account\_id) | (Required) Specifies the id of the storage account to apply the management policy to. Changing this forces a new resource to be created. | `string` | n/a | yes |



# Resources

| Name | Type |
|------|------|
| [azurerm_storage_management_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
<!-- END_AUTOMATIC_TF_DOCS -->