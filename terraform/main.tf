provider "azurerm" {
    version = "=1.22.0"
}

variable "container_id" {
  type = "string"
}

data "azurerm_resource_group" "general" {
  name = "ListApp-General"
}

data "azurerm_container_registry" "general" {
  name = "ListAppRegistry"
  resource_group_name = "${data.azurerm_resource_group.general.name}"
}

data "azurerm_app_service_plan" "general" {
  name = "PreProd-ConsumptionPlan"
  resource_group_name = "${data.azurerm_resource_group.general.name}"
}

resource "azurerm_resource_group" "feed" {
    name = "ListApp-FeedService"
    location = "Central  US"
}

resource "azurerm_app_service" "feed" {
  name                = "feedservice-dev"
  location            = "${azurerm_resource_group.feed.location}"
  resource_group_name = "${azurerm_resource_group.feed.name}"
  app_service_plan_id = "${data.azurerm_app_service_plan.general.id}"

  app_settings {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    DOCKER_REGISTRY_SERVER_URL = "${data.azurerm_container_registry.general.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = "${data.azurerm_container_registry.general.admin_username}"
    DOCKER_REGISTRY_SERVER_PASSWORD = "${data.azurerm_container_registry.general.admin_password}"
    ASPNETCORE_ENVIRONMENT = "Development"
  }

  site_config {
    linux_fx_version = "DOCKER|${data.azurerm_container_registry.general.login_server}/feedservice:${var.container_id}"
    always_on = "true"
  }

  identity {
    type = "SystemAssigned"
  }

}