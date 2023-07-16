#
# Container Registry
#

resource "azurerm_container_registry" "main" {
  name                = var.services.resource_name
  location            = var.services.location
  resource_group_name = var.resource_group_name

  sku           = var.services.sku
  admin_enabled = false

  tags = var.tags
}
