variable "AZURE_DEFAULT_REGION" {
  description = "Azure default region"
  default     = "germanywestcentral"
}

variable "AZURE_SUBSCRIPTION_ID" {
  description = "Azure subscription ID"
}

variable "PROJECT_NAME" {
  description = "Project name"
  type        = string
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.PROJECT_NAME))
    error_message = "Project-Name must be lowercase and hyphen-separated"
  }
}

variable "AZURE_SERVICE_PLAN__SKU_NAME" {
  description = "Service Plan SKU name"
  type        = string
  default     = "B1"
}

variable "DOCKER_CONTAINER_REGISTRY_URI" {
  description = "Docker container registry URI"
  type        = string
}

variable "DOCKER_CONTAINER_REGISTRY_USERNAME" {
  description = "Docker container registry username"
  type        = string
}

variable "DOCKER_CONTAINER_REGISTRY_PASSWORD" {
  description = "Docker container registry password"
  type        = string
}

variable "DJANGO_CONTAINER_REGISTRY_NAME" {
  description = "Django container registry name"
  type        = string
}

variable "DJANGO_CONTAINER_REGISTRY_TAG" {
  description = "Django container registry tag"
  type        = string
  default     = "latest"
}
