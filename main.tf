#root/main.tf

terraform {
  required_providers {
    avi = {
      source  = "vmware/avi"
    }
    nsxt = {
      source = "vmware/nsxt"
    }
  }
}

module "avi" {
  source = "./avi"
  username =  var.username
  password = var.password
  controller = var.controller
  tenant = var.tenant
  cloud = var.cloud
  se_group = var.se_group
  vrf = var.vrf
  vs_vip = var.vs_vip
  vs_name = var.vs_name
  vs_port = var.vs_port
  default_server_port = var.default_server_port
  app_profile = var.app_profile
  network_profile = var.network_profile
  health_monitors = var.health_monitors
}

module "nsxt" {
  source = "./nsxt"
  nsxt_host = var.nsxt_host
  nsxt_username = var.nsxt_username
  nsxt_password = var.nsxt_password
  nsxt_vms = var.nsxt_vms
  nsxt_vs_name = module.avi.vs_name

}
