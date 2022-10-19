#########################################################
# Variables
#########################################################

variable "azure_location" {
  type = string
  default = "westeurope"
  description = "Azure resources location"
}

variable "admin_username" {
    description = ""
    type = string
    default = "adminuser"
}

variable "admin_password" {
  description = "Password for all VMs deployed in this MicroHack"
  type        = string
  default = "Microsoft=1Microsoft=1"
}

variable "vm_size" {
  type = string
  default = "Standard_DS1_v2"
  description = "VM Size"
}

variable "vm_os_type" {
  type = string
  default = "Linux"
  description = "VM OS Type"
}

variable "vm_os_publisher" {
  type = string
  default = "canonical"
  description = "VM OS Publisher"
}

variable "vm_os_offer" {
  type = string
  #default = "UbuntuServer"
  default = "0001-com-ubuntu-server-jammy"
  description = "VM OS Offer"
}

variable "vm_os_sku" {
  type = string
  default = "22_04-lts-gen2"
  description = "VM OS Sku"
}

variable "vm_os_version" {
  type = string
  default = "latest"
  description = "VM OS Version"
}

variable "site1_bgp_asn" {
    type = number
    default = 61000
    description = "On-premise Site1 BGP ASN"
}

variable "site2_bgp_asn" {
    type = number
    default = 62000
    description = "On-premise Site2 BGP ASN"
}

variable "azure_bgp_asn" {
    type = number
    default = 65000
    description = "Azure BGP ASN"
}

#########################################################
# Locals
#########################################################

locals {
  shared-key = "microhack-shared-key"
}

#######################
# Application Gateway #
#######################

variable "backend_address_pool_name" {
    default = "myBackendPool"
}

variable "frontend_port_name" {
    default = "myFrontendPort"
}

variable "frontend_ip_configuration_private_name" {
    default = "myAGIPConfig-private"
}

variable "frontend_ip_configuration_public_name" {
    default = "myAGIPConfig-public"
}

variable "http_setting_name" {
    default = "myHTTPsetting"
}

variable "listener_name" {
    default = "myListener"
}

variable "request_routing_rule_name" {
    default = "myRoutingRule"
}

variable "redirect_configuration_name" {
    default = "myRedirectConfig"
}

locals {
  custom_data = <<CUSTOM_DATA
  #cloud-config
  package_upgrade: true
  packages:
    - apache2
  runcmd:
    - echo "Hello World from $(hostname)" > /var/www/html/index.html
    - systemctl enable apache2
    - systemctl start apache2
    - wget https://raw.githubusercontent.com/dmauser/azure-vm-net-tools/main/script/nettools.sh
    - chmod +x nettools.sh
    - ./nettools.sh
  CUSTOM_DATA
}
