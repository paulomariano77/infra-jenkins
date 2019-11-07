# Create a resource group if it doesn’t exist
resource "azurerm_resource_group" "jenkins_rg" {
    name     = var.resource_group
    location = var.location

    tags = var.tags
}
