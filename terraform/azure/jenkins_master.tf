# Create virtual machine
resource "azurerm_virtual_machine" "jenkins_master_vm" {
    count                 = 1
    name                  = "jks-master-vm${count.index+1}"
    location              = var.location
    resource_group_name   = azurerm_resource_group.jenkins_rg.name
    network_interface_ids = [azurerm_network_interface.jenkins_nic.id]
    vm_size               = "Standard_B2s"

    storage_os_disk {
        name              = "jenkinsMasterOsDisk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }

    storage_image_reference {
        publisher = "OpenLogic"
        offer     = "CentOS"
        sku       = "7.7"
        version   = "latest"
    }

    os_profile {
        computer_name  = "jks-master-vm${count.index}"
        admin_username = "jenkins"
    }

    os_profile_linux_config {
        disable_password_authentication = true
        ssh_keys {
            path     = "/home/jenkins/.ssh/authorized_keys"
            key_data = file("../../.ssh/id_rsa.pub")
        }
    }

    tags = merge(var.tags, { ansibleGroup = "jenkins_master" })
}
