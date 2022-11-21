resource "yandex_vpc_network" "this" {
  name   = "test"
  labels = var.labels
}

resource "yandex_vpc_subnet" "this" {
  name           = "test-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.this.id
  v4_cidr_blocks = var.cidr_blocks
  labels         = var.labels
}
