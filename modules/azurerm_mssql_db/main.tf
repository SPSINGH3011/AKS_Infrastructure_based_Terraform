data "azurerm_mssql_server" "data-mssql-server" {
  for_each            = var.mssql_databases
  name                = each.value.server_name
  resource_group_name = each.value.resource_group_name
}


resource "azurerm_mssql_database" "MSSQL-DB" {
  for_each     = var.mssql_databases
  name         = each.value.name
  server_id    = data.azurerm_mssql_server.data-mssql-server[each.key].id
  collation    = each.value.collation
  license_type = each.value.license_type
  max_size_gb  = each.value.max_size_gb
  sku_name     = each.value.sku_name
  enclave_type = each.value.enclave_type

  tags = var.tags
  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}
