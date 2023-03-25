vm_name_1 = "vm1"
imageid = "fd82tb3u07rkdkfte3dn"
image_family = "centos-7"

labels = {
    "project" = "slurm"
    "env" = "lab"
}
resources = {
  cpu = 2
  disk = 10
  memory = 2
}

healthcheck = {
    name   = "test"
    port   = 80
    path   = "/"
}
cidr_blocks = [ 
    ["10.10.0.0/24"],
    ["10.11.0.0/24"], 
    ["10.12.0.0/24"]
]
nat = true

port = 8080

nlb_healthcheck = {
  name = "test"
  path = "/"
  port = 8080
}

public_ssh_key_path = "/home/lipatovea/.ssh/id_rsa_ctrl2go.pub"

vm_count = 4

disk_count = 1
