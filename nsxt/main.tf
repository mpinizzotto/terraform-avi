#nsxt/main.tf

terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
    }
  }
}

provider "nsxt" {
  host                 = var.nsxt_host
  username             = var.nsxt_username
  password             = var.nsxt_password
  allow_unverified_ssl = true
  max_retries          = 2
}

data "nsxt_policy_vm" "nsxt_vms" {
  count = length(var.nsxt_vms)
  display_name = var.nsxt_vms[count.index]
}

resource "nsxt_policy_vm_tags" "vm_tags" {
  count = length(var.nsxt_vms)
  instance_id = data.nsxt_policy_vm.nsxt_vms.*.id[count.index]

  tag {
    scope = "avi"
    tag   = "${var.nsxt_vs_name}-pool"
  }
}

resource "nsxt_policy_group" "nsxt_sg" {
  display_name = "sg-${var.nsxt_vs_name}"
  criteria {
    condition {
      operator = "EQUALS"
      key         = "Tag"
      value = "avi|${var.nsxt_vs_name}-pool"
      member_type = "VirtualMachine"
    }
  }
}


