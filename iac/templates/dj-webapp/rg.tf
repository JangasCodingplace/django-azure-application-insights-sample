resource "azurerm_resource_group" "this" {
  name     = "${var.group_name}-${var.env}-rg"
  location = var.azure_base_config.default_region
  tags     = var.azure_base_config.generic_tags
}
