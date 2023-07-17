variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "cluster" {
  type = object({
    resource_name   = string
    location        = string
    vm_size         = string
    node_count      = string
    upgrade_channel = string
  })
}

variable "registry_id" {
  type = string
}
