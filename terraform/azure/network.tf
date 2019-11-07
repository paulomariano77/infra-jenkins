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

# Create public IPs
resource "azurerm_public_ip" "jenkins_publicip" {
    name                         = "jenkins-pip"
    location                     = var.location
    resource_group_name          = azurerm_resource_group.jenkins_rg.name
    allocation_method            = "Dynamic"

    tags = var.tags
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "jenkins_nsg" {
    name                = "jenkins-nsg"
    location            = var.location
    resource_group_name = azurerm_resource_group.jenkins_rg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = var.tags
}

# Create network interface
resource "azurerm_network_interface" "jenkins_nic" {
    name                      = "jenkins-master-nic"
    location                  = var.location
    resource_group_name       = azurerm_resource_group.jenkins_rg.name
    network_security_group_id = azurerm_network_security_group.jenkins_nsg.id

    ip_configuration {
        name                          = "jenkins-master-nic-config"
        subnet_id                     = azurerm_subnet.jenkins_subnet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.jenkins_publicip.id
    }

    tags = var.tags
}
