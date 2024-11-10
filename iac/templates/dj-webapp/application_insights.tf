resource "azurerm_application_insights" "this" {
  name                = "${var.group_name}-appinsights"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  application_type    = "other"
  retention_in_days   = 30
  tags                = var.azure_base_config.generic_tags
}
