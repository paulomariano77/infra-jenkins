# Create virtual network
resource "azurerm_virtual_network" "jenkins_network" {
    name                = "jenkins-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = azurerm_resource_group.jenkins_rg.name

    tags = var.tags
}

# Create subnet
resource "azurerm_subnet" "jenkins_subnet" {
    name                 = "default"
    resource_group_name  = azurerm_resource_group.jenkins_rg.name
    virtual_network_name = azurerm_virtual_network.jenkins_network.name
    address_prefix       = "10.0.1.0/24"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "jenkins_nsg" {
    name                = "jenkins-nsg"
    location            = var.location
    resource_group_name = azurerm_resource_group.jenkins_rg.name

    security_rule {
        name                       = "AllowSSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    security_rule {
        name                       = "AllowJenkinsHTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = var.tags
}
