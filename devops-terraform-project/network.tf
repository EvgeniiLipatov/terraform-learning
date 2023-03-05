resource "yandex_vpc_network" "testnet" {
  name           = "test"
}

resource "yandex_vpc_subnet" "test-subnet" {
  for_each       = toset(var.az)
  name           = "test-${each.value}"
  zone           = each.value
  network_id     = yandex_vpc_network.testnet.id
  v4_cidr_blocks = var.cidr_blocks[index(var.az, each.value)]
}

