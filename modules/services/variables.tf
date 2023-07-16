variable "resource_group_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "services" {
  type = object({
    resource_name = string
    location      = string
    sku           = string
  })
}
