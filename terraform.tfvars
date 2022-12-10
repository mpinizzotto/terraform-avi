#root/.tfvars

#avi vars

controller = "192.168.110.79"
username = "admin"
password = "VMware1!"
cloud = "NSX-Cloud"
tenant = "admin"
se_group = "NSX-Cloud-SEG-01"
vrf = "t1-01"

vs_vip = "172.16.12.204"
vs_name = "terraform-vs"
vs_port = "8080"
default_server_port = "80"
app_profile = "System-HTTP"
health_monitors = "System-HTTP"
network_profile = "System-TCP-Proxy"



#nsxt vars

nsxt_host = "192.168.110.21"
nsxt_username = "admin"
nsxt_password = "VMware1!VMware1!"
nsxt_vms = ["centos7-01","centos7-02"]
