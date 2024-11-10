locals {
  env = "dev"
  generic_tags = {
    environment = local.env
    project     = var.PROJECT_NAME
    managed_by  = "Terraform"
    owner       = "jgoesser"
  }
  azure_base_config = {
    default_region  = var.AZURE_DEFAULT_REGION
    subscription_id = var.AZURE_SUBSCRIPTION_ID
    generic_tags    = local.generic_tags
  }
}
