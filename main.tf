provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "test" {
  name     = "test-resource-grp"
  location = "East US"
}

resource "azurerm_app_service_plan" "test" {
  name                = "test-appserviceplan"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  kind                = "App"
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "test" {
  name                = "test-appservice"
  location            = azurerm_resource_group.test.location
  resource_group_name = azurerm_resource_group.test.name
  app_service_plan_id = azurerm_app_service_plan.test.id

  site_config {
    always_on = true
  }
}