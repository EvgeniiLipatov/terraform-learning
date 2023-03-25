data "yandex_compute_image" "this" {
  family = var.image_family
}

resource "yandex_compute_disk" "this" {
  count         = var.disk_count
  name          = "${local.prefix}-data-${count.index}"
  type          = "network-ssd"
  zone          = var.az[count.index % length(var.az)]
}

resource "yandex_compute_instance" "vm" {
    count       = var.vm_count
    name        = "${local.prefix}${var.vm_name_1}-${count.index}"
    platform_id = "standard-v1"
    zone        = var.az[count.index % length(var.az)]
    resources {
      cores     = var.resources.cpu
      memory    = var.resources.memory
    }
    labels = var.labels
    
    boot_disk {
      initialize_params {
        image_id = data.yandex_compute_image.this.id
        size     = var.resources.disk
      }
    }
    dynamic "secondary_disk" {
      for_each    = yandex_compute_disk.this
      content  {
        disk_id   = secondary_disk.value.id
      }
    }
    network_interface {
        subnet_id   = yandex_vpc_subnet.test-subnet[var.az[count.index % length(var.az)]].id
        nat         = var.nat  
    }
    metadata = {
        ssh-keys = var.public_ssh_key_path != "" ? "yc-user:${file("${var.public_ssh_key_path}")}" : "yc-user:tls_private_key.my-test-key[0].public_key_pem"
    }
    provisioner "remote-exec" {
      script = "./script.sh"
      connection {
        host = self.network_interface.0.nat_ip_address
        type = "ssh"
        user = "centos"
        agent = true
      }
    }
}


output "private_ip_vm1" {
  value = yandex_compute_instance.vm[0].network_interface.0.ip_address
}
output "private_ip_vm2" {
  value = yandex_compute_instance.vm[1].network_interface.0.ip_address
} 
output "private_ip_vm3" {
  value = yandex_compute_instance.vm[2].network_interface.0.ip_address
}

output "ext_ip_vm1" {
  value = yandex_compute_instance.vm[0].network_interface.0.nat_ip_address
}
output "ext_ip_vm2" {
  value = yandex_compute_instance.vm[1].network_interface.0.nat_ip_address 
} 
output "ext_ip_vm3" {
  value = yandex_compute_instance.vm[2].network_interface.0.nat_ip_address
}

output "priv_ssh_key" {
  value = var.public_ssh_key_path == "" ?  one(tls_private_key.my-test-key[*].private_key_openssh) : ""
  sensitive = true
}

output "pub_ssh_key" {
  value = var.public_ssh_key_path == "" ?  one(tls_private_key.my-test-key[*].public_key_pem) : ""

}






