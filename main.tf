#
# Services
#

resource "azurerm_resource_group" "main_services" {
  name     = "Services"
  location = local.services.location

  tags = {}
}

module "services" {
  source = "./modules/services"

  resource_group_name = azurerm_resource_group.main_services.name
  services            = local.services

  tags = merge(local.tags, {})
}

#
# Cluster
#

resource "azurerm_resource_group" "main_cluster" {
  name     = "Cluster"
  location = local.cluster.location

  tags = {}
}

module "cluster" {
  source = "./modules/cluster"

  resource_group_name = azurerm_resource_group.main_cluster.name
  cluster             = local.cluster

  registry_id = module.services.registry_id

  tags = merge(local.tags, {})
}

module "bootstrap" {
  source = "./modules/bootstrap"

  depends_on = [
    module.cluster
  ]
}
