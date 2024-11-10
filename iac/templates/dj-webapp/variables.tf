variable "azure_base_config" {
  description = "Azure base configuration"
  type = object({
    subscription_id = string
    default_region  = string
    generic_tags    = map(string)
  })
}

variable "group_name" {
  description = "Resource group name"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.group_name))
    error_message = "Group name must be lowercase and hyphen-separated"
  }
}

variable "env" {
  description = "Environment"
  type        = string
  validation {
    condition     = var.env == "dev" || var.env == "prod"
    error_message = "Environment must be either dev or prod"
  }
}

variable "service_plan__sku_name" {
  description = "Service Plan SKU name"
  type        = string
}

variable "docker_config" {
  description = "Docker configuration"
  type = object({
    container_registry_uri      = string
    container_registry_username = string
    container_registry_password = string
    repository                  = string
    tag                         = string
  })
}
