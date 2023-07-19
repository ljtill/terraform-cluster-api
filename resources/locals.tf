locals {
  services = {
    resource_group = "Services"
    resource_name  = ""
    location       = "uksouth"
    sku            = "Premium"
  }
  cluster = {
    resource_group  = "Clusters"
    resource_name   = ""
    location        = "uksouth"
    vm_size         = "standard_d4s_v5"
    node_count      = 3
    upgrade_channel = "patch"
  }
  tags = {}
}
