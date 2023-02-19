vm_name_1 = "vm1"
imageid = "fd82tb3u07rkdkfte3dn"

labels = {
    "project" = "slurm"
    "env" = "lab"
}
resources = {
  cpu = 2
  disk = 10
  memory = 2
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

public_ssh_key_path = "~/.ssh/id_rsa.pub"