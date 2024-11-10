resource "azurerm_service_plan" "this" {
  name                = "${var.group_name}-service-plan"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  os_type             = "Linux"
  sku_name            = var.service_plan__sku_name

  tags = var.azure_base_config.generic_tags
}


resource "azurerm_linux_web_app" "web_app" {
  name                = "${var.group_name}-${var.env}-web-app"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true

  tags = var.azure_base_config.generic_tags

  site_config {
    health_check_path                 = "/health"
    health_check_eviction_time_in_min = 10
    websockets_enabled                = true

    application_stack {
      docker_image_name        = "${var.docker_config.repository}:${var.docker_config.tag}"
      docker_registry_url      = "https://${var.docker_config.container_registry_uri}"
      docker_registry_username = var.docker_config.container_registry_username
      docker_registry_password = var.docker_config.container_registry_password
    }
  }

  identity {
    type = "SystemAssigned"
  }

  app_settings = {
    DJANGO_SETTINGS_MODULE                = "config.settings"
    SECRET_KEY                            = "django-insecure-!ubx^gst_jv3)u5&&f1g_e_5(#y93o5!obj$5r1^0ebkt)&vxa"
    ALLOWED_HOSTS                         = "${var.group_name}-${var.env}-web-app.azurewebsites.net"
    APPINSIGHTS_INSTRUMENTATIONKEY        = azurerm_application_insights.this.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING = azurerm_application_insights.this.connection_string
  }
}
