resource "yandex_lb_network_load_balancer" "my-yc-lb" {
  name = "${local.prefix}-my-yc-load-balancer"
  labels = var.labels
  listener {
    name = "my-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
      target_group_id = "${yandex_lb_target_group.my-yc-target.id}"
      healthcheck {
        name = var.nlb_healthcheck.name
        http_options {
          port = var.nlb_healthcheck.port
          path = var.nlb_healthcheck.path
        }
      }
  }

}


resource "yandex_lb_target_group" "my-yc-target" {
  name      = "${local.prefix}-my-yc-target-group"
  labels = var.labels

  dynamic "target" {
    for_each  = yandex_compute_instance.vm
    content {
      subnet_id =  target.value.network_interface.0.subnet_id
      address = target.value.network_interface.0.ip_address
    }
  }
}

output "ext_ip_lb" {
 value =  "${[for s in yandex_lb_network_load_balancer.my-yc-lb.listener: s.external_address_spec.*.address].0[0]}"
}
