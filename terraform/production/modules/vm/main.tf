###################/ Linux Virtual Machine /##########################################
resource "azurerm_virtual_machine" "vm" {
  name                             = "vm-${var.vm_name}-westeu-${var.index}"
  location                         = var.location
  resource_group_name              = var.resource_group_name
  vm_size                          = var.vm_size
  network_interface_ids            = [element(azurerm_network_interface.nic.*.id, var.index)]
  availability_set_id              = var.avset_id
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-vm-${var.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "web-server-${var.index}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

# This block defines the network interfaces which are associated with the db virtual machines.
resource "azurerm_network_interface" "nic" {
  name                = "nic-westeu-${var.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "ip_configuration"
    subnet_id                     = var.snet_id
    private_ip_address_allocation = "Dynamic"
  }
}


