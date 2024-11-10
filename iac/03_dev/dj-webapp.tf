module "dj-webapp" {
  source = "../templates/dj-webapp"

  azure_base_config      = local.azure_base_config
  group_name             = var.PROJECT_NAME
  env                    = local.env
  service_plan__sku_name = var.AZURE_SERVICE_PLAN__SKU_NAME
  docker_config = {
    container_registry_uri      = var.DOCKER_CONTAINER_REGISTRY_URI
    container_registry_username = var.DOCKER_CONTAINER_REGISTRY_USERNAME
    container_registry_password = var.DOCKER_CONTAINER_REGISTRY_PASSWORD
    repository                  = var.DJANGO_CONTAINER_REGISTRY_NAME
    tag                         = var.DJANGO_CONTAINER_REGISTRY_TAG
  }
}
