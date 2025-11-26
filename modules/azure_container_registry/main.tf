resource "azurerm_container_registry" "ACR" {
  for_each            = var.container_registries
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku
  tags                = var.tags
}
