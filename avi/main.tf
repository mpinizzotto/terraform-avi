#avi/main.tf

terraform {
  required_providers {
    avi = {
      source  = "vmware/avi"
    }
  }
}
  
provider "avi" {
  avi_username = var.username
  avi_tenant = var.tenant
  avi_password = var.password
  avi_controller = var.controller
  avi_version = "21.1.4"
}

data "avi_tenant" "tenant" {
  name = var.tenant
 }

output "tenant_uuid" {
  value = data.avi_tenant.tenant.uuid
 }

data "avi_cloud" "cloud" {
  name = var.cloud
 }

data "avi_serviceenginegroup" "se_group" {
 name = var.se_group
}

data "avi_vrfcontext" "vrf" {
 name = var.vrf
}

output "vrf" {
  value = data.avi_vrfcontext.vrf.id
} 

data "avi_applicationprofile" "http_profile" {
  name= var.app_profile
 }

data "avi_networkprofile" "tcp_proxy" {
  name = var.network_profile
 }

data "avi_healthmonitor" "http-healthmonitor" {
  name = var.health_monitors
 }

resource "avi_vsvip" "vsvip" {
  name = "${var.vs_name}-vsvip"
  vip {
    vip_id = "0"
    ip_address {
      type = "V4"
      addr = var.vs_vip
    }
  }
  cloud_ref = data.avi_cloud.cloud.id
  tenant_ref = data.avi_tenant.tenant.id
  tier1_lr = var.vrf
}

resource "avi_pool" "pool" {
    name = "${var.vs_name}-pool"     
    cloud_ref = data.avi_cloud.cloud.id
    tenant_ref = data.avi_tenant.tenant.id
    tier1_lr = var.vrf
    health_monitor_refs = [data.avi_healthmonitor.http-healthmonitor.id]
    nsx_securitygroup = ["sg-${var.vs_name}"]
    default_server_port = var.default_server_port
    #servers {
    #ip {
    #  type= "V4"
    #  addr= "172.16.45.11"
    #}
    #port = 80   
  #}
  fail_action {
    type= "FAIL_ACTION_CLOSE_CONN"
  }
}

resource "avi_virtualservice" "virutalservice" {
    name = var.vs_name
    cloud_ref = data.avi_cloud.cloud.id
    tenant_ref = data.avi_tenant.tenant.id
    vrf_context_ref = data.avi_vrfcontext.vrf.id
    services {
      port = var.vs_port
      enable_ssl = false
    }
    application_profile_ref = data.avi_applicationprofile.http_profile.id
    network_profile_ref = data.avi_networkprofile.tcp_proxy.id
    pool_ref = avi_pool.pool.id
    vsvip_ref = avi_vsvip.vsvip.id
    se_group_ref = data.avi_serviceenginegroup.se_group.id
}
