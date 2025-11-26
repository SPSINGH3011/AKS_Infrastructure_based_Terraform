data "azurerm_application_gateway" "dataappgateway" {
  for_each = var.kubernetes_clusters
  name                = each.value.ingress_application_gateway_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_container_registry" "datacontainerregistry" {
  for_each = var.kubernetes_clusters
  name                = each.value.container_registry_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_kubernetes_cluster" "AKS" {
  for_each            = var.kubernetes_clusters
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix
  kubernetes_version = each.value.kubernetes_version

  default_node_pool {
    name       = each.value.default_node_pool.name
    node_count = each.value.default_node_pool.node_count
    vm_size    = each.value.default_node_pool.vm_size
    max_pods   = each.value.default_node_pool.max_pods
    auto_scaling_enabled = each.value.default_node_pool.auto_scaling_enabled
    min_count = each.value.default_node_pool.min_count
    max_count = each.value.default_node_pool.max_count
  }

  identity {
    type = each.value.identity.type
  }

  network_profile {
    network_plugin = each.value.network_profile.network_plugin
    network_policy = each.value.network_profile.network_policy
  }

  ingress_application_gateway {
    gateway_id = data.azurerm_application_gateway.dataappgateway[each.key].id
  }

  tags = var.tags
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  for_each = var.kubernetes_clusters
  principal_id                     = azurerm_kubernetes_cluster.AKS[each.key].kubelet_identity[0].object_id
  role_definition_name             = each.value.acr_pull_role_name
  scope                            = data.azurerm_container_registry.datacontainerregistry[each.key].id
  skip_service_principal_aad_check = each.value.skip_aad_check
}