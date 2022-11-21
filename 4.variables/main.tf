resource "yandex_compute_instance" "this" {
  name        = var.vm_name
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

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

  network_interface {
    subnet_id = yandex_vpc_subnet.this.id
  }

  metadata = {
    ssh-keys = "yc-user:${file("~/.ssh/id_rsa.pub")}"
  }
}
