resource "azurerm_private_endpoint" "this" {
  for_each = { for k, v in var.storage_account : k => var.storage_account[k] if v.create_private_endpoint }

  name                = "${each.key}-private-endpoint"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  subnet_id           = each.value.private_endpoint.private_endpoint_subnet_id

  private_service_connection {
    name                           = "storageaccountPrivateEndpoint"
    private_connection_resource_id = module.this[each.key].id
    is_manual_connection           = false
    subresource_names              = each.value.private_endpoint.subresource_names
  }

  private_dns_zone_group {
    name                 = each.value.private_endpoint.private_dns_zone_group_name
    private_dns_zone_ids = [each.value.private_endpoint.private_dns_zone_ids]
  }
}
