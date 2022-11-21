output "private_ip" {
  value = yandex_compute_instance.this.network_interface.0.ip_address
}
