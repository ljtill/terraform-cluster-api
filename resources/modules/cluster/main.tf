#
# Kubernetes Cluster
#

resource "azurerm_kubernetes_cluster" "main" {
  name                = var.cluster.resource_name
  location            = var.cluster.location
  resource_group_name = var.resource_group_name

  dns_prefix                = var.cluster.resource_name
  sku_tier                  = "Standard"
  automatic_channel_upgrade = var.cluster.upgrade_channel
  workload_identity_enabled = true

  default_node_pool {
    name                        = "nodepool1"
    vm_size                     = var.cluster.vm_size
    temporary_name_for_rotation = "nodepool"
    node_count                  = var.cluster.node_count
    zones                       = ["1", "2", "3"]
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

#
# Role Assignment
#

resource "azurerm_role_assignment" "main" {
  principal_id         = azurerm_kubernetes_cluster.main.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope                = var.registry_id
}
