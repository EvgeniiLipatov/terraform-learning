resource "yandex_lb_network_load_balancer" "my-lb-test" {
  name = "my-lb-test"

  listener {
    name = "my-listener"
    port = var.port
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
      target_group_id = "${yandex_lb_target_group.my-test-target-group.id}"
      healthcheck {
        name = var.nlb_healthcheck.name
        http_options {
          port = var.nlb_healthcheck.port
          path = var.nlb_healthcheck.path
        }
      }
  }

}

resource "yandex_lb_target_group" "my-test-target-group" {
  name      = "my-target-group"

  target {
    subnet_id = "${yandex_vpc_subnet.test-subnet-1.id}"
    address   = "${yandex_compute_instance.vm1.network_interface.0.ip_address}"
  }


  target {
    subnet_id = "${yandex_vpc_subnet.test-subnet-2.id}"
    address   = "${yandex_compute_instance.vm2.network_interface.0.ip_address}"
  }

  target {
    subnet_id = "${yandex_vpc_subnet.test-subnet-3.id}"
    address   = "${yandex_compute_instance.vm3.network_interface.0.ip_address}"
  }
}

output "ext_ip_lb" {
 value =  "${[for s in yandex_lb_network_load_balancer.my-lb-test.listener: s.external_address_spec.*.address].0[0]}"
}