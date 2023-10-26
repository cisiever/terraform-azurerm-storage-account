<!-- BEGIN_AUTOMATIC_TF_DOCS -->


# Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_azurecaf"></a> [azurecaf](#requirement\_azurecaf) | >= 1.0.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.58.0 |

# Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.58.0 |



# Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | (Optional) The access tier of the storage blob. Possible values are Archive, Cool and Hot | `string` | `null` | no |
| <a name="input_blob_metadata"></a> [blob\_metadata](#input\_blob\_metadata) | (Optional) A mapping of MetaData for this Blob. All metadata keys should be lowercase. | `any` | `null` | no |
| <a name="input_blob_name"></a> [blob\_name](#input\_blob\_name) | (Required) The name of the storage blob. Must be unique within the storage container the blob is located. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_blob_source"></a> [blob\_source](#input\_blob\_source) | (Optional) An absolute path to a file on the local system. This field cannot be specified for Append blobs and cannot be specified if source\_content or source\_uri is specified. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_cache_control"></a> [cache\_control](#input\_cache\_control) | (Optional) Controls the cache control header content of the response when blob is requested. | `any` | `null` | no |
| <a name="input_container_access_type"></a> [container\_access\_type](#input\_container\_access\_type) | (Optional) The Access Level configured for this Container. Possible values are blob, container or private. | `string` | `"private"` | no |
| <a name="input_container_metadata"></a> [container\_metadata](#input\_container\_metadata) | (Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase. | `any` | `null` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | (Required) Name of Container | `string` | n/a | yes |
| <a name="input_content_md5"></a> [content\_md5](#input\_content\_md5) | (Optional) The MD5 sum of the blob contents. Cannot be defined if source\_uri is defined, or if blob type is Append or Page. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_content_type"></a> [content\_type](#input\_content\_type) | (Optional) The content type of the storage blob. Cannot be defined if source\_uri is defined. | `string` | `"application/octet-stream"` | no |
| <a name="input_create_container"></a> [create\_container](#input\_create\_container) | (Required) Create Storage Account Container | `bool` | n/a | yes |
| <a name="input_parallelism"></a> [parallelism](#input\_parallelism) | (Optional) The number of workers per CPU core to run for concurrent uploads. Changing this forces a new resource to be created. | `number` | `8` | no |
| <a name="input_size"></a> [size](#input\_size) | (Optional) Used only for page blobs to specify the size in bytes of the blob to be created. Must be a multiple of 512. Changing this forces a new resource to be created. | `number` | `0` | no |
| <a name="input_source_content"></a> [source\_content](#input\_source\_content) | (Optional) The content for this blob which should be defined inline. This field can only be specified for Block blobs and cannot be specified if source or source\_uri is specified. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_source_uri"></a> [source\_uri](#input\_source\_uri) | (Optional) The URI of an existing blob, or a file in the Azure File service, to use as the source contents for the blob to be created. Changing this forces a new resource to be created. This field cannot be specified for Append blobs and cannot be specified if source or source\_content is specified. | `string` | `null` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Required) The name of the Storage Account where the Container should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_storage_container_name"></a> [storage\_container\_name](#input\_storage\_container\_name) | (Required) The name of the storage container in which this blob should be created. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_type"></a> [type](#input\_type) | (Required) The type of the storage blob to be created. Possible values are Append, Block or Page. Changing this forces a new resource to be created. | `any` | n/a | yes |

# Outputs

| Name | Description |
|------|-------------|
| <a name="output_blob"></a> [blob](#output\_blob) | n/a |
| <a name="output_container"></a> [container](#output\_container) | n/a |

# Resources

| Name | Type |
|------|------|
| [azurerm_storage_blob.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
<!-- END_AUTOMATIC_TF_DOCS -->