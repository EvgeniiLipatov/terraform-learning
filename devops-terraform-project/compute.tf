resource "yandex_compute_instance" "vm1" {
    name        = "${local.prefix}${var.vm_name_1}"
    platform_id = "standard-v1"
    zone        = "ru-central1-a"
    resources {
      cores     = var.resources.cpu
      memory    = var.resources.memory
    }
    labels = var.labels

    boot_disk {
      initialize_params {
        image_id = var.imageid
        size     = var.resources.disk
      }
    }
    network_interface {
        subnet_id = yandex_vpc_subnet.test-subnet-1.id
        nat = var.nat 
    }
    metadata = {
        ssh-keys = var.public_ssh_key_path != "" ? "yc-user:${file("${var.public_ssh_key_path}")}" : "yc-user:${file(tls_private_key.my-test-key.public_key_pem)}"
    }
}

resource "yandex_compute_instance" "vm2" {
    name        = "vm-test-2"
    platform_id = "standard-v1"
    zone        = "ru-central1-b"
    resources {
      cores     = var.resources.cpu
      memory    = var.resources.memory
    }
    labels = var.labels

    boot_disk {
      initialize_params {
        image_id = "fd82tb3u07rkdkfte3dn"
        size     = var.resources.disk
      }
    }
    network_interface {
       subnet_id = yandex_vpc_subnet.test-subnet-2.id
       nat = var.nat
    }
    metadata = {
       ssh-keys = "yc-user:${file("~/.ssh/id_yc.pub")} yc-user"
    }
}

resource "yandex_compute_instance" "vm3" {
    name        = "vm-test-3"
    platform_id = "standard-v1"
    zone        = "ru-central1-c"
    resources {
      cores     = var.resources.cpu
      memory    = var.resources.memory
    }
    labels = var.labels
    allow_stopping_for_update = true
    boot_disk {
      initialize_params {
        image_id = "fd82tb3u07rkdkfte3dn"
        size     = var.resources.disk
      }
    }
    network_interface {
        subnet_id = yandex_vpc_subnet.test-subnet-3.id
        nat = var.nat
    }
    metadata = {
      ssh-keys = "yc-user:${file("~/.ssh/id_yc.pub")}"
    }
}
output "private_ip_vm1" {
  value = yandex_compute_instance.vm1.network_interface.0.ip_address
}
output "private_ip_vm2" {
  value = yandex_compute_instance.vm2.network_interface.0.ip_address
} 
output "private_ip_vm3" {
  value = yandex_compute_instance.vm3.network_interface.0.ip_address
}

output "ext_ip_vm1" {
  value = yandex_compute_instance.vm1.network_interface.0.nat_ip_address
}
output "ext_ip_vm2" {
  value = yandex_compute_instance.vm2.network_interface.0.nat_ip_address 
} 
output "ext_ip_vm3" {
  value = yandex_compute_instance.vm3.network_interface.0.nat_ip_address
  
}

output "priv_ssh_key" {
  value = var.public_ssh_key_path == "" ?  tls_private_key.my-test-key.private_key_openssh : ""
  sensitive = true
}





