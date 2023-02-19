resource "yandex_vpc_network" "testnet" {
  name           = "test"
}

resource "yandex_vpc_subnet" "test-subnet-1" {
  name           = "test-ru-central1-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.testnet.id
  v4_cidr_blocks = var.cidr_blocks[0]
}

resource "yandex_vpc_subnet" "test-subnet-2" {
  name           = "test-ru-central1-b"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.testnet.id
  v4_cidr_blocks = var.cidr_blocks[1]
}

resource "yandex_vpc_subnet" "test-subnet-3" {
  name           = "test-ru-central1-c"
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.testnet.id
  v4_cidr_blocks = var.cidr_blocks[2]
}

