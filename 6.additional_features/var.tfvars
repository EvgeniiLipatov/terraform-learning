vm_name = "test"
image_family = "centos-7"

cidr_blocks = [
  ["10.10.0.0/24"],
  ["10.20.0.0/24"],
  ["10.30.0.0/24"],
]

labels = {
  "team" = "my-team"
  "app"  = "my-app"
}

vm_count = 3
