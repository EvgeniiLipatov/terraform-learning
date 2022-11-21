data "yandex_compute_image" "this" {
  family = var.image_family
}

resource "yandex_compute_instance" "this" {
  count = var.vm_count

  name        = "${var.vm_name}-${count.index}"
  platform_id = "standard-v1"
  zone        = var.az[count.index % 3]

  resources {
    cores  = 2
    memory = 4
  }

  labels = var.labels

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.this.id
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this[var.az[count.index % 3]].id
    nat = true
  }

  metadata = {
    ssh-keys = "yc-user:${file("~/.ssh/id_rsa.pub")}"
  }

  provisioner "remote-exec" {
      inline = ["echo It is alive!"]

      connection {
        host        = self.network_interface.0.nat_ip_address
        type        = "ssh"
        user        = "centos"
        # private_key = file("~/.ssh/id_rsa")
        agent       = true
      }
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u centos -i '${self.network_interface.0.nat_ip_address},' ansible/playbook.yml"

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
    }

  }
}

resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "ansible-playbook -u centos -i $HOSTS ansible/playbook.yml"

    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      HOSTS = join(",", yandex_compute_instance.this.*.network_interface.0.nat_ip_address)
    }
  }
}
