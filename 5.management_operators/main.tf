resource "yandex_compute_disk" "this" {
  count = var.disk_count

  name     = "data-${count.index}"
  type     = "network-ssd"
  zone     = var.az[0]
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
      image_id = "fd82tb3u07rkdkfte3dn"
      size     = 10
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.this
    content {
      disk_id = secondary_disk.value.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.this[var.az[count.index % 3]].id
  }

  metadata = {
    ssh-keys = "yc-user:${file("~/.ssh/id_rsa.pub")}"
  }
}
