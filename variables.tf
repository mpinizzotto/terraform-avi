#root/variables.tf

variable "controller" {
  description = "avi controller IP"
}

variable "username" {
  description = "avi username"
}
variable "password" {
  description = "avi password"
}

variable "cloud" {
  description = "avi cloud"
}

variable "tenant" {
  description = "avi tenant"
}

variable "se_group" {
  description = "avi service engine group"
}
variable "vrf" {
  description = "avi vrf context and/or nsx-t cloud t1_lr"
}
variable "vs_vip" {
  description = "virtual service IP address"
}
variable "vs_name" {
  description = "virtual service name"
}
variable "vs_port" {
  description = "virtual service listening port"
}
variable "app_profile" {
  description = "application profile"
}
variable "health_monitors" {
  description = "avi pool health monitor"
}
variable "network_profile" {
  description = "network profile (TCP/UDP profile)"
}
variable "default_server_port" {
  description = "default port for server pool"
}

variable "nsxt_host" {
  description = "nsxt manager IP address"
}
variable "nsxt_username" {
  description = "nsxt manager username"
}
variable "nsxt_password" {
  description = "nxt manager password"
}
variable "nsxt_vms" {
  description = "avi pool members"
  type = list
}
